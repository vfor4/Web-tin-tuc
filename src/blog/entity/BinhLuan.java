package blog.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "BINHLUAN")
public class BinhLuan {
	@Id
	@GeneratedValue
	@Column(name = "IDBL")
	private Integer idBinhLuan;
	
	@ManyToOne
	@JoinColumn(name="MABAIVIET")
	private BaiViet baiViet;

	@JoinColumn(name="EMAIL")
	private String email;

	@Column(name = "TENNGUOIBL")
	private String tenNguoiBinhLuan;

	@Column(name = "THOIGIAN")
	@Temporal(TemporalType.TIMESTAMP)
	@CreationTimestamp
	private Date thoiGian;

	@Column(name = "NOIDUNG")
	private String noiDung;

	public Integer getIdBinhLuan() {
		return idBinhLuan;
	}

	public void setIdBinhLuan(Integer idBinhLuan) {
		this.idBinhLuan = idBinhLuan;
	}

	public BaiViet getBaiViet() {
		return baiViet;
	}

	public void setBaiViet(BaiViet baiViet) {
		this.baiViet = baiViet;
	}

	public String getTenNguoiBinhLuan() {
		return tenNguoiBinhLuan;
	}

	public void setTenNguoiBinhLuan(String tenNguoiBinhLuan) {
		this.tenNguoiBinhLuan = tenNguoiBinhLuan;
	}

	public Date getThoiGian() {
		return thoiGian;
	}

	public void setThoiGian(Date thoiGian) {
		this.thoiGian = thoiGian;
	}

	public String getNoiDung() {
		return noiDung;
	}

	public void setNoiDung(String noiDung) {
		this.noiDung = noiDung;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
