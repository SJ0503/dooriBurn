package dooriburn.com.model;

public class RanKingDTO {

	private String drama;
	private String f_name;
	private int f_num;
	
	
	

	public RanKingDTO(String drama, String f_name, int f_num) {
		super();
		this.drama = drama;
		this.f_name = f_name;
		this.f_num = f_num;
	}

	public String getDrama() {
		return drama;
	}

	public void setDrama(String drama) {
		this.drama = drama;
	}

	public String getF_name() {
		return f_name;
	}

	public void setF_name(String f_name) {
		this.f_name = f_name;
	}

	public int getF_num() {
		return f_num;
	}

	public void setF_num(int f_num) {
		this.f_num = f_num;
	}
	
	
	
}
