package dooriburn.com.model;

import java.sql.Array;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.lang.model.element.Element;

public class ReviewDAO {

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

	// 리뷰 db insert
	public int Insert(ReviewDTO dto) {

		int cnt = 0;
		
		getConnection();
		
		// System.out.println(Arrays.toString(dto.getMood()));
		
		try {
			String sql = "INSERT INTO tb_review (EMAIL, F_NUM, R_RATING, R_CONTENT, R_DATE, MOOD) VALUES(?,?,?,?,SYSDATE, ?)";
			psmt = conn.prepareStatement(sql);
			
			// Array sqlArray = conn.createArrayOf("Mood", dto.getMood());
			
			psmt.setString(1, dto.getEmail());
			psmt.setDouble(2, dto.getF_num());
			psmt.setInt(3, dto.getRating());
			psmt.setString(4, dto.getContent());
			psmt.setString(5, Arrays.toString(dto.getMood()));
			
			cnt = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close();
		}
		
		return cnt;
	}
	
public ArrayList<ReviewDTO> selectReview(String index) {
		
		ArrayList<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
		int n_index = Integer.parseInt(index);
		try {
			getConnection();

			String sql = "SELECT l.*, m.nick FROM TB_REVIEW l JOIN TB_MEMBER m ON l.email = m.email WHERE l.F_NUM = ? ORDER BY l.R_NUM ASC";

			psmt = conn.prepareStatement(sql);

			psmt.setInt(1,n_index);

			rs = psmt.executeQuery();

			while (rs.next()) {
				
	            int rating = rs.getInt("R_RATING");
	            String content = rs.getString("R_CONTENT");
	            String date = rs.getString("R_DATE");
	            String moodStr = rs.getString("MOOD");
	            String nick = rs.getString("NICK");
	            

	            // mood를 배열로 변환 (쉼표로 구분된 문자열을 배열로 변환)
	            
	            
	            String[] moodArray = moodStr.replace("[", "").replace("]", "").split(", ");

	            // ReviewDTO 객체 생성
	            ReviewDTO dto = new ReviewDTO(rating, content, date, moodArray, nick);

	            reviewList.add(dto);
	            System.out.println(reviewList.get(0).getContent());
	        }


		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("권한 확인 실패");

		} finally {
			close();
		}
		return reviewList;
	}


	// 상세페이지 태그 상위top3
	public  ArrayList<String> moodRanking(int f_num) {
		
		List<String> moodList = new ArrayList<String>();
		
		Map<String, Integer> moodMap = new HashMap<String, Integer>();
		
		getConnection();
		
		try {
			String sql ="SELECT SUBSTR(MOOD,2,LENGTH(MOOD)-2) AS MOOD FROM tb_review WHERE f_num = ?";
			psmt = conn.prepareStatement(sql);
			
			psmt.setInt(1, f_num);
			
			rs = psmt.executeQuery();
			while(rs.next()){
				String moods = rs.getString("MOOD");
				String[] moodsArray = moods.split(",");
				
				for(int i = 0; i < moodsArray.length; i++) {
					moodList.add(moodsArray[i]);
				}		
			}
			
			for(String str : moodList) {
				Integer cnt = moodMap.get(str);
				if(cnt == null) {
					moodMap.put(str, 1);
				}else {
					 moodMap.put(str, cnt+1);
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close();
		}
		
//		List<String> newList = moodList.stream().distinct().collect(Collectors.toList());
//		List<Integer> moodMapList = new ArrayList<>(moodMap.values());
//		 moodMapList.sort((o1, o2) -> moodMapList.get(o2).compareTo(moodMapList.get(o1)));

		 List<Map.Entry<String, Integer>> sortedMoods = new ArrayList<>(moodMap.entrySet());
         sortedMoods.sort((entry1, entry2) -> entry2.getValue().compareTo(entry1.getValue()));
		 
         ArrayList<String> moodtop = new ArrayList<String>();
		 for (int i = 0; i < Math.min(4, sortedMoods.size()); i++) {
             Map.Entry<String, Integer> entry = sortedMoods.get(i);
             moodtop.add(entry.getKey());
         }
		 return moodtop;
	}

	
}
