package blog.entity;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="MAILFORM")
public class MailForm {
	@Id
	@GeneratedValue
	@Column(name="MAMAIL")
	private Integer maMail;
	
	@Column(name = "MAILFORM")
	private String mailForm;
	
	@Column(name = "MAILSUBJECT")
	private String mailSubject;
	
	@Column(name = "MAILBODY")
	private String mailBody;
	
	@Column(name = "THOIGIAN")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	private Date thoiGian;

	@OneToMany(mappedBy="mailForm", fetch=FetchType.LAZY)
	private Collection<ThongBao> nhieuThongBao;
	public Integer getMaMail() {
		return maMail;
	}

	public void setMaMail(Integer maMail) {
		this.maMail = maMail;
	}

	public String getMailForm() {
		return mailForm;
	}

	public void setMailForm(String mailForm) {
		this.mailForm = mailForm;
	}

	public String getMailSubject() {
		return mailSubject;
	}

	public void setMailSubject(String mailSubject) {
		this.mailSubject = mailSubject;
	}

	public String getMailBody() {
		return mailBody;
	}

	public void setMailBody(String mailBody) {
		this.mailBody = mailBody;
	}

	public Date getThoiGian() {
		return thoiGian;
	}

	public void setThoiGian(Date thoiGian) {
		this.thoiGian = thoiGian;
	}
	
}
