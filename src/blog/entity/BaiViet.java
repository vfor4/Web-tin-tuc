package blog.entity;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import com.sun.istack.internal.NotNull;

@Entity
@Table(name = "BAIVIET")
public class BaiViet {
	@Id
	@GeneratedValue
	@Column(name = "MABAIVIET")
	private Integer maBaiViet;

	@ManyToOne
	@JoinColumn(name = "MADANHMUC")
	private DanhMuc danhMuc;

	@NotNull()
	@Column(name = "TIEUDE")
	private String tieuDe;

	@Column(name = "MOTA")
	private String moTa;

	@Column(name = "HINHMT")
	private String hinhMoTa;

	@Column(name = "THOIGIAN")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	
	private Date thoiGian;
	@Column(name = "NOIDUNG")
	private String noiDung;
	
	@ManyToOne
	@JoinColumn(name = "TAIKHOAN")
	private BienTapVien bienTapVien;

	@OneToMany(mappedBy = "baiViet", fetch = FetchType.LAZY)
	private Collection<BinhLuan> nhieuBinhLuan;

	public BienTapVien getBienTapVien() {
		return bienTapVien;
	}

	public void setBienTapVien(BienTapVien bienTapVien) {
		this.bienTapVien = bienTapVien;
	}

	public Collection<BinhLuan> getNhieuBinhLuan() {
		return nhieuBinhLuan;
	}

	public void setNhieuBinhLuan(Collection<BinhLuan> nhieuBinhLuan) {
		this.nhieuBinhLuan = nhieuBinhLuan;
	}

	public Integer getMaBaiViet() {
		return maBaiViet;
	}

	public void setMaBaiViet(Integer maBaiViet) {
		this.maBaiViet = maBaiViet;
	}

	public DanhMuc getDanhMuc() {
		return danhMuc;
	}

	public void setDanhMuc(DanhMuc danhMuc) {
		this.danhMuc = danhMuc;
	}

	public String getTieuDe() {
		return tieuDe;
	}

	public void setTieuDe(String tieuDe) {
		this.tieuDe = tieuDe;
	}

	public String getMoTa() {
		return moTa;
	}

	public void setMoTa(String moTa) {
		this.moTa = moTa;
	}

	public String getHinhMoTa() {
		return hinhMoTa;
	}

	public void setHinhMoTa(String hinhMoTa) {
		this.hinhMoTa = hinhMoTa;
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

}
