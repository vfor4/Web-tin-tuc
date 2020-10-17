package blog.entity;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "BIENTAPVIEN")
public class BienTapVien {

	@Column(name = "HOVATEN")
	private String fullname;

	@Id
	@Column(name = "TAIKHOAN")
	@Pattern(regexp = "^\\S*$", message = "Tài khoản không chứa khoảng trắng")
	private String username;

	@Column(name = "MATKHAU")
	@Pattern(regexp = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$", message = "Mật khẩu phải có ký tự chữ số, chữ hoa và chữ thường và độ dài lớn hơn 5")
	private String password;

	@Column(name = "EMAIL")
	private String email;

	@Column(name = "SODIENTHOAI")
	private String phone;

	@Column(name = "NGAYSINH")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthday;

	@Column(name = "GIOITINH")
	private String gender;

	@Column(name = "DIACHI")
	private String address;

	@Column(name = "QUYEN")
	private boolean role;

	@Column(name = "BIKHOA")
	private boolean isBlock;

	@Column(name = "LABIENTAPVIEN")
	private boolean isEditor;

	@OneToMany(mappedBy = "bienTapVien", fetch = FetchType.LAZY)
	private Collection<BaiViet> nhieuBaiViet;

	@OneToMany(mappedBy = "bienTapVien", fetch = FetchType.LAZY)
	private Collection<DanhMuc> nhieuDanhMuc;

	public boolean isEditor() {
		return isEditor;
	}

	public void setEditor(boolean isEditor) {
		this.isEditor = isEditor;
	}

	public Collection<DanhMuc> getNhieuDanhMuc() {
		return nhieuDanhMuc;
	}

	public void setNhieuDanhMuc(Collection<DanhMuc> nhieuDanhMuc) {
		this.nhieuDanhMuc = nhieuDanhMuc;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public boolean isRole() {
		return role;
	}

	public void setRole(boolean role) {
		this.role = role;
	}

	public boolean isBlock() {
		return isBlock;
	}

	public void setBlock(boolean isBlock) {
		this.isBlock = isBlock;
	}

	public Collection<BaiViet> getNhieuBaiViet() {
		return nhieuBaiViet;
	}

	public void setNhieuBaiViet(Collection<BaiViet> nhieuBaiViet) {
		this.nhieuBaiViet = nhieuBaiViet;
	}

	@Override
	public boolean equals(Object obj){
		if(obj instanceof BienTapVien){
			BienTapVien btv2 = ((BienTapVien)obj);
			boolean checkUser = btv2.getUsername().equalsIgnoreCase(this.username);
			boolean checkFullname = btv2.getFullname().equalsIgnoreCase(this.fullname);
			boolean checkEmail = btv2.getEmail().equalsIgnoreCase(this.email);
			boolean checkPhone = btv2.getPhone().equalsIgnoreCase(this.phone);
			int checkBirthday = btv2.getBirthday().compareTo(this.birthday);
			boolean checkAddress = btv2.getAddress().equalsIgnoreCase(this.address);
			if( (checkAddress && checkEmail && checkFullname && checkPhone && checkUser) && checkBirthday == 0){
				return true;
			}else{
				return false;
			}
		}else {
			return false;
		}
	}
}
