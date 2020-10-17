package blog.entity;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;


@Entity
@Table(name = "NGUOIDANGKI")
public class NguoiDangKi {
	@Id
	@GeneratedValue
	@Column(name = "MANGUOIDANGKI")
	private Integer maNguoiDangKi;
	
	
	@Column(name = "EMAIL")
	@Email(message="Định dạng email không chính xác")
	@NotBlank(message="Email không được bỏ trống")
	@NotNull(message="Email không được bỏ trống")
	private String email;
	
	@Column(name = "SDT")
	@Pattern(regexp="^[0]\\d{9,10}$", message="Định dạng số điện thoại sai") 
	private String sdt;

	@OneToMany(mappedBy = "nguoiDangKi", fetch = FetchType.LAZY)
	private Collection<ThongBao> nhieuThongBao;

	public Collection<ThongBao> getNhieuThongBao() {
		return nhieuThongBao;
	}

	public void setNhieuThongBao(Collection<ThongBao> nhieuThongBao) {
		this.nhieuThongBao = nhieuThongBao;
	}

	public Integer getMaNguoiDangKi() {
		return maNguoiDangKi;
	}

	public void setMaNguoiDangKi(Integer maNguoiDangKi) {
		this.maNguoiDangKi = maNguoiDangKi;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSdt() {
		return sdt;
	}

	public void setSdt(String sdt) {
		this.sdt = sdt;
	}

}
