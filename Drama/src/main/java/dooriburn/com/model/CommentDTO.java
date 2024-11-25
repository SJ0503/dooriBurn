package dooriburn.com.model;

import java.util.Date;

public class CommentDTO {
	
	private int cmt_num; 
	private String cmt_img;
	private Date cmt_date;
	private int c_num;
	private String email; 
	  
	public CommentDTO() { 
	}
	
	 
	public CommentDTO(String cmt_img, int c_num, String email) { 
		this.cmt_img = cmt_img;
		this.c_num = c_num;
		this.email = email;
	}
 

	public CommentDTO(int cmt_num, String cmt_img, Date cmt_date, int c_num, String email) {
		super();
		this.cmt_num = cmt_num;
		this.cmt_img = cmt_img;
		this.cmt_date = cmt_date;
		this.c_num = c_num;
		this.email = email;
	}
 

	public int getCmt_num() {
		return cmt_num;
	}


	public void setCmt_num(int cmt_num) {
		this.cmt_num = cmt_num;
	}


	public String getCmt_img() {
		return cmt_img;
	}


	public void setCmt_img(String cmt_img) {
		this.cmt_img = cmt_img;
	}


	public Date getCmt_date() {
		return cmt_date;
	}


	public void setCmt_date(Date cmt_date) {
		this.cmt_date = cmt_date;
	}


	public int getC_num() {
		return c_num;
	}


	public void setC_num(int c_num) {
		this.c_num = c_num;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}
  
	
	
	
	
	

}
