package blog.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="THONGBAO")
public class ThongBao {
	@Id
	@GeneratedValue
	@Column(name= "MATHONGBAO")
	private Integer maThongBao;
	
	@ManyToOne
	@JoinColumn(name="MAMAIL")
	private MailForm mailForm;
	
	@ManyToOne
	@JoinColumn(name="MANGUOIDANGKI")
	private NguoiDangKi nguoiDangKi;

	public Integer getMaThongBao() {
		return maThongBao;
	}

	public void setMaThongBao(Integer maThongBao) {
		this.maThongBao = maThongBao;
	}

	public MailForm getMailForm() {
		return mailForm;
	}

	public void setMailForm(MailForm mailForm) {
		this.mailForm = mailForm;
	}

	public NguoiDangKi getNguoiDangKi() {
		return nguoiDangKi;
	}

	public void setNguoiDangKi(NguoiDangKi nguoiDangKi) {
		this.nguoiDangKi = nguoiDangKi;
	}
}
