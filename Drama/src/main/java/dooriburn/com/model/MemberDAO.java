package dooriburn.com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberDAO {

	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;

	private void getConnection() {

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String Userid = "Insa5_SpringB_hacksim_1";
			String Userpw = "aishcool1";
			String url = "jdbc:oracle:thin:@project-db-stu3.smhrd.com:1524:xe";

			conn = DriverManager.getConnection(url, Userid, Userpw);

		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 연결 실패");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("db연결 실패");
			e.printStackTrace();
		}

	}

	private void close() {

		try {
			if (rs != null)
				rs.close();
			if (psmt != null)
				psmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public int join(MemberDTO dto) {

		int cnt = 0;

		getConnection();

		try {

			String sql = "INSERT INTO TB_MEMBER VALUES(?,?,?,?,?,?)";
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, dto.getEmail());
			psmt.setString(2, dto.getPw());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getPhone());
			psmt.setString(5, dto.getAddr());
			psmt.setString(6, dto.getNick());

			cnt = psmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("연결 실패");
			e.printStackTrace();
		} finally {
			close();
		}

		return cnt;
	}

	public int checkEmail(String email) {
		int cnt = 0;

		getConnection();

		try {
			String sql = "SELECT * FROM TB_MEMBER WHERE EMAIL = ?";

			psmt = conn.prepareStatement(sql);

			psmt.setString(1, email);

			rs = psmt.executeQuery();

			if (rs.next() || email.equals("")) { 
				cnt = 0;
			} else { 
				cnt = 1;
			}

		} catch (SQLException e) { 
			e.printStackTrace();
		} finally {
			close();
		}

		return cnt;
	}

	public MemberDTO login(MemberDTO dto) {

		MemberDTO info = null;

		getConnection();

		try {
			String sql = "SELECT * FROM TB_MEMBER WHERE EMAIL = ?";
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, dto.getEmail());
			

			rs = psmt.executeQuery();

			if (rs.next()) {
				String email = rs.getString("EMAIL");
				String pw = rs.getString("PW");
				String name = rs.getString("NAME");
				String phone = rs.getString("PHONE");
				String addr = rs.getString("ADDR");
				String nick = rs.getString("NICK");

				info = new MemberDTO(email, pw, nick, name, phone, addr);
			}

		} catch (SQLException e) { 
			e.printStackTrace();
		} finally {
			close();
		}

		return info;
	}

	public String findNickByEmail(String email) {
		String nick = null;
		getConnection();
		try {
			String sql = "SELECT NICK FROM TB_MEMBER WHERE EMAIL = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			rs = psmt.executeQuery();

			if (rs.next()) {
				nick = rs.getString("NICK");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return nick;
	}
	
	
	public int update(MemberDTO dto) {
		int cnt = 0;
		getConnection();

		String sql = "UPDATE TB_MEMBER SET PW = ?, NAME =?, PHONE = ?, ADDR = ?, NICK = ? WHERE EMAIL = ?";
		try {
			psmt = conn.prepareStatement(sql); 
			psmt.setString(1, dto.getPw());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getPhone());
			psmt.setString(4, dto.getAddr()); 
			psmt.setString(5, dto.getNick());
			psmt.setString(6, dto.getEmail());
			cnt = psmt.executeUpdate();  
		} catch (SQLException e) { 
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
 
	}

	public int checkNick(String nick) {

		int cnt = 0;
		
		getConnection();
		
		
		try {
			String sql = "SELECT NICK FROM TB_MEMBER WHERE NICK = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, nick);
			
			rs = psmt.executeQuery();

			if (rs.next() || nick.equals("")) { 
				cnt = 0;
			} else { 
				cnt = 1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close();
		}
		
		
		return cnt;
	}
	
	// 공모전 게시판 페이징 위한 List 생성
		public ArrayList<MemberDTO> getMemberList(int startRow, int pageSize){
			ArrayList<MemberDTO> memberList = new ArrayList<>();
		    
			getConnection();
			try { 
				// 글 re_ref 최신글 위쪽(내림차순), re_seq (오름차순)
				// DB 데이터를 원하는만큼씩 잘라내기 : 
				 String sql = "SELECT * FROM (SELECT ROWNUM AS RNUM, EMAIL, NAME, NICK " +
	                     "FROM (SELECT * FROM TB_MEMBER ORDER BY EMAIL DESC)) " +
	                     "WHERE RNUM BETWEEN ? AND ?";
		        
				psmt = conn.prepareStatement(sql); 
				psmt.setInt(1, startRow); //시작행 (시작 row 인덱스 번호)
				psmt.setInt(2, startRow + pageSize - 1); // 끝행
					
				// 4. sql 실행
				rs = psmt.executeQuery();
				// 5. 데이터처리 ( 글1개의 정보 -> DTO 1개에 담음 -> ArrayList 1칸 )
				while(rs.next()) {
				// 데이터가 있을때마다 글 1개의 정보를 저장하는 객체 생성
					MemberDTO dto = new MemberDTO();
						
					dto.setEmail(rs.getString("EMAIL")); 
					dto.setName(rs.getString("NAME")); 
					dto.setNick(rs.getString("NICK")); 
						   
					memberList.add(dto);	
				} 
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}		
			return memberList;
		}
		
		// 게시판 글 개수 카운트
		public int getCount() {
			int cnt = 0; 
			getConnection();
			try { 
				String sql = "SELECT COUNT(*) FROM TB_MEMBER";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				if (rs.next()) {
					cnt = rs.getInt(1); 
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return cnt;
		}

		public int delete(String email) {
		    int cnt = 0; 
		    getConnection();
		    try { 
		        String sql = "DELETE FROM TB_MEMBER WHERE EMAIL = ?";
		        psmt = conn.prepareStatement(sql);
		        psmt.setString(1, email);
		        
		        cnt = psmt.executeUpdate();  // executeUpdate()는 삭제된 행의 수를 반환합니다
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        close();
		    }
		    return cnt;
		}

		

}
