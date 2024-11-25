package dooriburn.com.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FilmLikeDAO {

	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;
	int cnt;

	private void dbOpen() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String db_id = "Insa5_SpringB_hacksim_1";
			String db_pw = "aishcool1";
			String db_url = "jdbc:oracle:thin:@project-db-stu3.smhrd.com:1524:xe";

			conn = DriverManager.getConnection(db_url, db_id, db_pw);

		} catch (ClassNotFoundException e) {
			System.out.println("JDBC 드라이버 로드 오류: " + e.getMessage()); // 7/26 14:26 JDBC 드라이버 로드 오류 메시지 출력
			// e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB 연결 오류: " + e.getMessage()); // 7/26 14:26 DB 연결 오류 메시지 출력
			// e.printStackTrace();
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
			System.out.println("DB 닫기 오류: " + e.getMessage()); // 7/26 14:26 DB 닫기 오류 메시지 출력
			// e.printStackTrace();
		}
	}

	// 좋아요 추가
	public int addLike(FilmLikeDTO dto) {

		dbOpen();

		try {

			String sql = "INSERT INTO TB_FILM_LIKE (EMAIL, F_NUM, F_LIKE_DATE) VALUES (?, ?, SYSDATE)";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getEmail());
			psmt.setInt(2, dto.getF_num());

			cnt = psmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("좋아요 추가 오류: " + e.getMessage()); // 7/26 14:26 좋아요 추가 오류 메시지 출력
			// e.printStackTrace();
		} finally {
			dbClose();

		}
		return cnt;
	}

// 좋아요 삭제
	public int removeLike(FilmLikeDTO dto) {
		int cnt = 0;
		dbOpen();

		try {
			String sql = "DELETE FROM TB_FILM_LIKE WHERE EMAIL = ? AND F_NUM = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getEmail());
			psmt.setInt(2, dto.getF_num());

			cnt = psmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("좋아요 삭제 오류: " + e.getMessage()); // 7/26 14:26 좋아요 삭제 오류 메시지 출력
			// e.printStackTrace();
		} finally {
			dbClose();
		}
		return cnt;
	}

	// 특정 사용자가 특정 드라마를 좋아요 했는지 확인
	public boolean isLiked(FilmLikeDTO dto) {
		boolean liked = false;
		dbOpen();

		try {
			String sql = "SELECT * FROM TB_FILM_LIKE WHERE EMAIL = ? AND F_NUM = ?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getEmail());
			psmt.setInt(2, dto.getF_num());

			rs = psmt.executeQuery();

			if (rs.next()) {
				liked = true;
			}

		} catch (SQLException e) {
			System.out.println("좋아요 확인 오류: " + e.getMessage()); // 7/26 14:26 좋아요 확인 오류 메시지 출력
			// e.printStackTrace();
		} finally {
			dbClose();
		}
		return liked;
	}

	// 찜 목록 조회
//	public List<FilmLikeDTO> getLikes(String email) {
//		List<FilmLikeDTO> likes = new ArrayList<>();
//		dbOpen();
//
//		try {
//			String sql = "SELECT * FROM TB_FILM_LIKE WHERE EMAIL = ? AND F_NUM = ?";
//			
//			
//			psmt = conn.prepareStatement(sql);
//			psmt.setString(1, email);
//
//			rs = psmt.executeQuery();
//
//			while (rs.next()) {
//				int likeNum = rs.getInt("F_LIKE_NUM");
//				int filmNum = rs.getInt("F_NUM");
//				Date likeDate = rs.getDate("F_LIKE_DATE");
//			
//
//				FilmLikeDTO like = new FilmLikeDTO(email, filmNum, likeDate);
//				likes.add(like);
//			}
//
//		} catch (SQLException e) {
//			System.out.println("찜 목록 조회 오류: " + e.getMessage());
//		} finally {
//			dbClose();
//		}
//		return likes;
//	}
}
