package blog.controller;

import org.apache.commons.lang3.RandomStringUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import blog.bean.Mailer;
import blog.entity.BienTapVien;

@Transactional
@Controller
public class PwdRecover {
	@Autowired
	SessionFactory factory;

	@Autowired
	Mailer mailer;

	@RequestMapping("forgotPassword")
	public String getPassword() {
		return "PwdRecover/FormPwd";
	}

	@RequestMapping(value = "forgotPassword", method = RequestMethod.POST)
	public String getPassword(ModelMap model, @RequestParam("username") String username,
			@RequestParam("email") String email) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		if (checkUsername(username) == false) {
			model.addAttribute("error_u", "Tài khoản không hợp lệ");
			return "PwdRecover/FormPwd";
		}
		if (checkUsernameByEmail(username, email) == false) {
			model.addAttribute("error_both", "Email đăng kí của tài khoản không đúng");
			return "PwdRecover/FormPwd";
		}

		if (checkUsernameByEmail(username, email)) {
			BienTapVien editor = (BienTapVien) session.load(BienTapVien.class, username);
			if (editor.isBlock()) {
				model.addAttribute("error_both", "Tài khoản đã bị khóa");
				return "PwdRecover/FormPwd";
			}
			if (editor.isEditor() == false && editor.isRole() == false) {
				model.addAttribute("error_both", "Tài khoản chưa được kích hoạt");
				return "PwdRecover/FormPwd";
			}
			String newPwd = passwdGenerator();
			mailer.send("Blog Mango", email, "ĐỔI MẬT KHẨU", "Mật khẩu của bạn đã được thay đổi thành: <b><i>" + newPwd
					+ "</b></i><br> Hãy tiến hành đăng nhập và đổi lại mật khẩu mới của bạn để tăng cường bảo mật <br> Cảm ơn bạn tin tưởng Blog Mango!");
			editor.setPassword(newPwd);
			try {
				session.update(editor);
				t.commit();
			} catch (Exception e) {
				t.rollback();
			} finally {
				session.close();
			}
			model.addAttribute("mode", "show");
			model.addAttribute("message", "Đổi mật khẩu thành công! Hãy kiểm tra email");
			return "PwdRecover/FormPwd";
		}
		model.addAttribute("mode", "show");
		model.addAttribute("message", "Đổi mật khẩu thất bại");
		return "PwdRecover/FormPwd";
	}

	public boolean checkEmail(String email) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT email FROM BienTapVien btv WHERE btv.email = :email";
		Query query = session.createQuery(hql);
		query.setParameter("email", email);
		if (query.list().isEmpty()) {
			return false;
		}
		return true;
	}

	public boolean checkUsername(String username) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT username FROM BienTapVien btv WHERE btv.username = :username";
		Query query = session.createQuery(hql);
		query.setParameter("username", username);
		if (query.list().isEmpty()) {
			return false;
		}
		return true;
	}

	public boolean checkUsernameByEmail(String username, String email) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT email FROM BienTapVien btv WHERE btv.username = :username";
		Query query = session.createQuery(hql);
		query.setParameter("username", username);
		String result = (String) query.uniqueResult();
		if (result.equals(email)) {
			return true;
		}
		return false;
	}

	// tạo mật khẩu ngẫu nhiên
	private String passwdGenerator() {
		String characters1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String characters2 = "abcdefghijklmnopqrstuvwxyz";
		String characters3 = "0123456789";
		String characters4 = "!@#$%^&*";
		String pwd = RandomStringUtils.random(2, characters1) + RandomStringUtils.random(2, characters2)
				+ RandomStringUtils.random(2, characters3)+RandomStringUtils.random(2, characters4);
		System.out.println(pwd);
		return pwd;

	}
}
