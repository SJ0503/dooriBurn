package dooriburn.com.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DramaSearchDAO {
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
	
public ArrayList<DramaSearchDTO> film_detail(String index) {
		
		ArrayList<DramaSearchDTO> detail_list = new ArrayList<DramaSearchDTO>();
		int n_index = Integer.parseInt(index);
		try {
			getConnection();

			String sql = "SELECT * FROM TB_FILM_LOCATION WHERE F_NUM = ?";

			psmt = conn.prepareStatement(sql);

			psmt.setInt(1,n_index);

			rs = psmt.executeQuery();

			while(rs.next()) {
				double f_num = rs.getDouble("F_NUM");
				String drama =  rs.getString("DRAMA");
				String f_addr = rs.getString("F_ADDR");
				double lat = rs.getDouble("LAT");
				double lon = rs.getDouble("LON");
				String f_name = rs.getString("F_NAME");
				String f_tel = rs.getString("F_TEL");
				String f_time = rs.getString("F_TIME");
				String scene = rs.getString("SCENE");
				String f_img = rs.getString("F_IMG");
	
				DramaSearchDTO dto = new DramaSearchDTO(f_num, drama, f_addr, lat, lon, f_name, f_tel, f_time, scene, f_img);
				
				detail_list.add(dto);
				System.out.println(detail_list.get(0).getDrama()); 
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("권한 확인 실패");

		} finally {
			close();
		}
		return detail_list;
	}
	




	// 찜 목록 조회
	public List<DramaSearchDTO> getLikes(String email) {
		List<DramaSearchDTO> likes = new ArrayList<>();
		getConnection();
	
		try { 
			
	        String sql = "SELECT DISTINCT li.F_LIKE_NUM, li.F_NUM, li.F_LIKE_DATE, l.DRAMA, l.F_NAME " +
                    "FROM TB_FILM_LOCATION l " +
                    "JOIN TB_FILM_LIKE li ON l.F_NUM = li.F_NUM " +
                    "WHERE li.EMAIL = ?";
	        
	        
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
	
			rs = psmt.executeQuery();
	
			while (rs.next()) {
				Double f_num = rs.getDouble("F_NUM");
				String drama = rs.getString("DRAMA");
				String f_name = rs.getString("F_NAME");
			
	
				DramaSearchDTO like = new DramaSearchDTO(f_num, drama, null, null, null, f_name, null, null, null, null);
				likes.add(like);
			}
	
		} catch (SQLException e) {
			System.out.println("찜 목록 조회 오류: " + e.getMessage());
		} finally {
			close();
		}
		return likes;
	} 

	// 공모전 게시판 페이징 위한 List 생성
	public List<DramaSearchDTO> getSearchList(int startRow, int pageSize){
		List<DramaSearchDTO> SearchList= new ArrayList<>();
	    
		getConnection();
		try { 
			// 글 re_ref 최신글 위쪽(내림차순), re_seq (오름차순)
			// DB 데이터를 원하는만큼씩 잘라내기 : 
	        String sql = "SELECT * FROM (SELECT ROWNUM AS RNUM, F_NUM, DRAMA, F_ADDR, LAT, LON, F_NAME, F_TEL, F_TIME, SCENE, F_IMG, F_CLICK " +
                    "FROM (SELECT * FROM TB_FILM_LOCATION ORDER BY F_NUM DESC)) " +
                    "WHERE RNUM BETWEEN ? AND ?";
	        
			psmt = conn.prepareStatement(sql); 
			psmt.setInt(1, startRow); //시작행 (시작 row 인덱스 번호)
			psmt.setInt(2, startRow + pageSize - 1); // 끝행
				 
			rs = psmt.executeQuery(); 
			while(rs.next()) { 
				DramaSearchDTO dto = new DramaSearchDTO();
					
				dto.setFNum(rs.getDouble("F_NUM"));  
				dto.setDrama(rs.getString("DRAMA"));  
				dto.setFAddr(rs.getString("F_ADDR"));  
				dto.setLat(rs.getDouble("LAT"));  
				dto.setLon(rs.getDouble("LON"));  
				dto.setFName(rs.getString("F_NAME"));  
				dto.setFTel(rs.getString("F_TEL"));  
				dto.setFTime(rs.getString("F_TIME"));  
				dto.setScene(rs.getString("SCENE"));  
				dto.setFimg(rs.getString("F_IMG"));  
 
				SearchList.add(dto);				
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}		
		return SearchList;
	}
	
		
}
 
