package dooriburn.com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CommentLikeDAO {

   private Connection conn;
   private PreparedStatement psmt;
   private ResultSet rs;
   int cnt = 0;

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
   
   // 댓 좋아요 추가
   public int addLike( int cmt_num, String email) {
      
      dbOpen();

      try {
         
         String sql = "INSERT INTO TB_COMMENT_LIKE (EMAIL, CMT_NUM) VALUES (?, ?)";
         psmt = conn.prepareStatement(sql);
         psmt.setString(1, email);
         psmt.setInt(2, cmt_num);
         cnt = psmt.executeUpdate();

      } catch (SQLException e) {
         System.out.println("좋아요 추가 오류: " + e.getMessage()); // 7/26 14:26 좋아요 추가 오류 메시지 출력
         // e.printStackTrace();
      } finally {
         dbClose();
      
      
   }
      return cnt;
      }
   
   
   // 댓 좋아요 삭제
      public int removeLike( int cmt_num, String email) {
         int cnt = 0;
         dbOpen();

         try {
            String sql = "DELETE FROM TB_COMMENT_LIKE WHERE EMAIL= ? AND CMT_NUM = ? ";
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            psmt.setInt(2, cmt_num);

            cnt = psmt.executeUpdate();
            
         } catch (SQLException e) {
            System.out.println("좋아요 삭제 오류: " + e.getMessage()); // 7/26 14:26 좋아요 삭제 오류 메시지 출력
            // e.printStackTrace();
         } finally {
            dbClose();
         }
         return cnt;
      }
   
   // 사용자의 댓글 좋아요 리스트 
   public List<CommentLikeDTO> getCommentLike(String memEmail) {
       List<CommentLikeDTO> list = new ArrayList<>();
       dbOpen(); 
       try {
           String sql = "SELECT * FROM TB_COMMENT_LIKE WHERE EMAIL=?";
           psmt = conn.prepareStatement(sql);
           psmt.setString(1, memEmail);
           rs = psmt.executeQuery();
           
           while (rs.next()) {
               int cmt_like = rs.getInt("CMT_LIKE"); 
               String email = rs.getString("EMAIL");
               int cmt_num = rs.getInt("CMT_NUM"); 
               
               CommentLikeDTO dto = new CommentLikeDTO(cmt_like, email, cmt_num);
               list.add(dto);
           }    
       } catch (SQLException e) { 
           e.printStackTrace();
       } finally {
           dbClose();
       } 
       return list;
   }

   
    
   // 댓글 좋아요 수 전체 조회 
   public int commentLikeCount(int cmt_num) {
	   int cnt = 0;
       dbOpen();
       try {
           String sql = "SELECT COUNT(*) FROM TB_COMMENT_LIKE WHERE CMT_NUM = ?";
           psmt = conn.prepareStatement(sql);
           psmt.setInt(1, cmt_num);
           rs = psmt.executeQuery();
 
           if (rs.next()) {
               cnt = rs.getInt(1);
               
           }
       } catch (SQLException e) {
           e.printStackTrace();
       } finally {
           dbClose();
       }
       return cnt;
   }


   
 

   // 특정 사용자가 특정 댓글 좋아요 했는지 확인
      public boolean userLiked(String email, int cmt_num) {
         boolean liked = false;
         dbOpen();

         try {
            String sql = "SELECT * FROM TB_COMMENT_LIKE WHERE EMAIL = ? AND CMT_NUM = ?";
            psmt = conn.prepareStatement(sql);
            psmt.setString(1,email);
            psmt.setInt(2, cmt_num);

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

      // 댓 좋아요 전체~! 삭제
      public int removeAllLike(int cmt_num) {
         int cnt = 0;
         dbOpen();

         try {
            String sql = "DELETE FROM TB_COMMENT_LIKE WHERE CMT_NUM = ? ";
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, cmt_num);

            cnt = psmt.executeUpdate();
            
         } catch (SQLException e) { 
        	 e.printStackTrace(); 
         } finally {
            dbClose();
         }
         return cnt;
      }
   
}
