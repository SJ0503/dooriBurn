package dooriburn.com.model;

public class MemberDTO {

	private String email;
	private String pw;
	private String nick;
	private String name;
	private String phone;
	private String addr; 
	
	public MemberDTO() { 
	}

	public MemberDTO(String email) { 
		this.email = email;
	}
	
	 
	public MemberDTO(String email, String pw) {
		super();
		this.email = email;
		this.pw = pw;
	}

	 
	public MemberDTO(String email, String pw, String nick, String phone, String addr) {
		super();
		this.email = email;
		this.pw = pw;
		this.nick = nick;
		this.phone = phone;
		this.addr = addr;
	}

	public MemberDTO(String email, String pw, String nick, String name, String phone, String addr) {
		super();
		this.email = email;
		this.pw = pw;
		this.nick = nick;
		this.name = name;
		this.phone = phone;
		this.addr = addr;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
 

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
 
	
	
	
	
}
