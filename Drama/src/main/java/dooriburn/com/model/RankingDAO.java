package dooriburn.com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

public class RankingDAO {
	
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
	         if(rs != null)
	            rs.close();
	         if(psmt != null)
	            psmt.close();
	         if(conn != null)
	            conn.close();
		      } catch (SQLException e) {
		         e.printStackTrace();
		      }
			
		}

	public void Update(String indexnum) {
		
		int index = Integer.parseInt(indexnum);
		
		getConnection();
		
		
		try {
			String sql = "UPDATE TB_FILM_LOCATION SET F_CLICK = COALESCE(F_CLICK, 0) + 1 WHERE F_NUM = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setInt(1, index);
			
			int cnt = psmt.executeUpdate();
			
//			if(cnt > 0) {
//				System.out.println("카운팅 성공");
//			}else {
//				System.out.println("카운팅 실패");
//			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close();
		}
	}
	
	public ArrayList<RanKingDTO> Ranking() {
		
		
		 ArrayList<RanKingDTO> ranking = new ArrayList<>();
		 
		 getConnection();
		 
		 try { String sql =
		 "SELECT F_NAME, DRAMA, F_NUM FROM tb_film_location WHERE F_CLICK IS NOT NULL ORDER BY F_CLICK DESC"; 
		 psmt = conn.prepareStatement(sql);
		 
		 rs = psmt.executeQuery();
		 
		 for(int i = 0;i < 5; i++) {
			 rs.next(); 
			 String drama = rs.getString("DRAMA");
			 String f_name = rs.getString("F_NAME"); 
			 int f_num = rs.getInt("F_NUM");
			 RanKingDTO dto = new RanKingDTO(drama, f_name, f_num);
			 ranking.add(dto);
		 
		 }
		 
		 
		 } catch (SQLException e) { // TODO Auto-generated catch block
		 e.printStackTrace(); 
		 }finally { close(); }
		 
		 return ranking;
		 
	}
	
	
	
	
}
