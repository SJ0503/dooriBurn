package dooriburn.com.model;

import java.util.Date;

public class ContestDTO {

	private int c_num;
	private String c_title;
	private Date c_create_date;
	private String c_img;
	private String c_content;
	private Date c_delete_date;
	  
	public ContestDTO() { 
	}
	
	public ContestDTO(int c_num, String c_title) { 
		this.c_num = c_num;
		this.c_title = c_title;
	}
	
	
	
	public ContestDTO(int c_num, String c_title, String c_img, String c_content) {
		super();
		this.c_num = c_num;
		this.c_title = c_title;
		this.c_img = c_img;
		this.c_content = c_content;
	}

	public ContestDTO(String c_title, String c_img, String c_content) { 
		this.c_title = c_title;
		this.c_img = c_img;
		this.c_content = c_content;
	}
	public ContestDTO(int c_num, String c_title, Date c_create_date, String c_img, String c_content, Date c_delete_date) {
		super();
		this.c_num = c_num;
		this.c_title = c_title;
		this.c_create_date = c_create_date;
		this.c_img = c_img;
		this.c_content = c_content;
		this.c_delete_date = c_delete_date;
	}
	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
	}
	public String getC_title() {
		return c_title;
	}
	public void setC_title(String c_title) {
		this.c_title = c_title;
	}
	public Date getC_create_date() {
		return c_create_date;
	}
	public void setC_create_date(Date c_create_date) {
		this.c_create_date = c_create_date;
	}
	public String getC_img() {
		return c_img;
	}
	public void setC_img(String c_img) {
		this.c_img = c_img;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public Date getC_delete_date() {
		return c_delete_date;
	}
	public void setC_delete_date(Date c_delete_date) {
		this.c_delete_date = c_delete_date;
	}
  
 
}
