package dooriburn.com.model;

import java.util.Date;

public class FilmLikeDTO {

	private int f_like_num; // PK
	private String email;
	private int f_num;
	private Date f_like_date;

	public int getF_like_num() {
		return f_like_num;
	}

	public void setF_like_num(int f_like_num) {
		this.f_like_num = f_like_num;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getF_num() {
		return f_num;
	}

	public void setF_num(int f_num) {
		this.f_num = f_num;
	}

	public Date getF_like_date() {
		return f_like_date;
	}

	public void setF_like_date(Date f_like_date) {
		this.f_like_date = f_like_date;
	}


	public FilmLikeDTO(String email, int f_num) {
		this.email = email;
		this.f_num = f_num;
	}

	public FilmLikeDTO(String email, int f_num, Date f_like_date) {
		this.email = email;
		this.f_num = f_num;
		this.f_like_date = f_like_date;
	}

}
