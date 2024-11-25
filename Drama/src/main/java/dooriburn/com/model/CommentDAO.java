package dooriburn.com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class CommentDAO {

	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;
	
	// DBUtil로 DB연결하는 클래스만들어서 하시면 코드가짧아져서 가독성짱!!!
	private void dbOpen() {		
		try { 
			Class.forName("oracle.jdbc.driver.OracleDriver");	  
			String db_id = "Insa5_SpringB_hacksim_1";
			String db_pw = "aishcool1";
			String db_url = "jdbc:oracle:thin:@project-db-stu3.smhrd.com:1524:xe";
 
			conn = DriverManager.getConnection(db_url, db_id, db_pw);			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
		
	private void dbClose() {
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

	// 댓글 업로드
	public int commentPost(CommentDTO dto) {		
		int cnt = 0; 
		dbOpen();
		 
		try { 
			
			String sql = "INSERT INTO TB_C_COMMENT (cmt_img, cmt_date, c_num, email) VALUES (?, SYSDATE, ?, ?)"; 
			psmt = conn.prepareStatement(sql); 
			psmt.setString(1, dto.getCmt_img());
			psmt.setInt(2, dto.getC_num());
			psmt.setString(3, dto.getEmail());
			
			cnt = psmt.executeUpdate();
			 
		} catch (SQLException e) { 
			e.printStackTrace();
		} finally {
			dbClose();
		} 
		return cnt; 
	} 
	
	
	
	
	// 해당 게시글의 댓글 가져오기 ! 
	public ArrayList<CommentDTO> getComment(int cNum) { 
		ArrayList<CommentDTO> list = new ArrayList<CommentDTO>(); 
		dbOpen(); 
		try { 
			String sql = "SELECT c.* FROM TB_C_COMMENT c WHERE c.C_NUM = ? ORDER BY (SELECT COUNT(*)  FROM TB_COMMENT_LIKE cl  WHERE cl.CMT_NUM = c.CMT_NUM) DESC";
			psmt = conn.prepareStatement(sql); 
	        psmt.setInt(1, cNum);
	        rs = psmt.executeQuery();
	        
	        while(rs.next()) {
	            int cmtNum = rs.getInt("CMT_NUM"); 
	            String img = rs.getString("CMT_IMG");
	            Date date = rs.getDate("CMT_DATE");
	            String email = rs.getString("EMAIL");   
	            
	            CommentDTO comDto = new CommentDTO(cmtNum, img, date, cNum, email);
	            list.add(comDto); 
			}  
		} catch (SQLException e) { 
			e.printStackTrace();
		} finally {
			dbClose();
		} 
		return list; 
	}


	// 댓글 개별 삭제 
	public int commentDelete(int num) { 		
		int cnt = 0;
		dbOpen();
		 
		try {
			String sql = "DELETE FROM TB_C_COMMENT WHERE CMT_NUM = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, num);
			cnt = psmt.executeUpdate();
			
		} catch (SQLException e) { 
			e.printStackTrace();
		} finally {
			dbClose();
		} 
		return cnt;
	}
	
	// 댓글 전체 삭제
	public int commentAllDelete(int num) {
		int cnt = 0;
		dbOpen();
		 
		try {
			String sql = "DELETE FROM TB_C_COMMENT WHERE C_NUM = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, num);
			cnt = psmt.executeUpdate();
			
		} catch (SQLException e) { 
			e.printStackTrace();
		} finally {
			dbClose();
		}  
		return cnt;
	}
}
