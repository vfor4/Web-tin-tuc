package blog.entity;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "DANHMUC")
public class DanhMuc {
	@Id
	@Column(name = "MADANHMUC")
	private String maDanhMuc;

	@Column(name = "TENDANHMUC")
	private String tenDanhMuc;

	public BienTapVien getBienTapVien() {
		return bienTapVien;
	}

	public void setBienTapVien(BienTapVien bienTapVien) {
		this.bienTapVien = bienTapVien;
	}

	@ManyToOne
	@JoinColumn(name = "TAIKHOAN")
	private BienTapVien bienTapVien;
	
	@OneToMany(mappedBy = "danhMuc", fetch = FetchType.LAZY)
	private Collection<BaiViet> nhieuBaiViet;

	public Collection<BaiViet> getNhieuBaiViet() {
		return nhieuBaiViet;
	}

	public void setNhieuBaiViet(Collection<BaiViet> nhieuBaiViet) {
		this.nhieuBaiViet = nhieuBaiViet;
	}

	public String getMaDanhMuc() {
		return maDanhMuc;
	}

	public void setMaDanhMuc(String maDanhMuc) {
		this.maDanhMuc = maDanhMuc;
	}

	public String getTenDanhMuc() {
		return tenDanhMuc;
	}

	public void setTenDanhMuc(String tenDanhMuc) {
		this.tenDanhMuc = tenDanhMuc;
	}

}
