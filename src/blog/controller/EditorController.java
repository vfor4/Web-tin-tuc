package blog.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import blog.entity.BienTapVien;
import blog.entity.DanhMuc;

@Transactional
@Controller
public class EditorController {

	@Autowired
	SessionFactory factory;

	@RequestMapping("register")
	public String viewRegister(ModelMap model) {
		model.addAttribute("editor", new BienTapVien());
		return "editor/register";
	}

	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String Register(@Validated @ModelAttribute("editor") BienTapVien editor, BindingResult errors,
			@RequestParam("password_conform") String password_conform, @RequestParam("birthday") String birthday,
			@RequestParam("captcha") String captcha, HttpServletRequest req, ModelMap model) {
		HttpSession httpSession = req.getSession();
		String captchaSession = String.valueOf(httpSession.getAttribute("captcha"));
		if (captcha.equalsIgnoreCase(captchaSession) == false) {
			model.addAttribute("error", "Sai Captcha");
			return "editor/register";
		}
		if (checkUsername(editor.getUsername())) {
			model.addAttribute("error_u", "Tài khoản đã tồn tại");
			return "editor/register";
		}

		if (errors.hasErrors()) {
			System.out.println(errors.toString());
			return "editor/register";
		}
		if (editor.getPassword().equals(password_conform) == false) {
			model.addAttribute("error_p", "Xác nhận mật khẩu sai");
			return "editor/register";
		}
		if (checkPhoneNumber(editor.getPhone())) {
			model.addAttribute("error_ph", "Số điện thoại đã tồn tại");
			return "editor/register";
		}
		if (checkEmail(editor.getPhone())) {
			model.addAttribute("error_e", "Email đã tồn tại");
			return "editor/register";
		}
		try {
			Date date = new SimpleDateFormat("yyyy-MM-dd").parse(birthday);
			editor.setBirthday(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());

		}
		editor.setRole(false);
		editor.setBlock(false);
		editor.setEditor(false);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(editor);
			t.commit();
			System.out.println("luu editor tc");
		} catch (Exception e) {
			t.rollback();
			e.printStackTrace();
			System.out.println("luu editor tb");
		} finally {
			session.close();
		}
		return "editor/thank";
	}

	// xem thông tin biên tập viên
	@RequestMapping(value = "admin/editor-info/{username}.htm")
	public String EditorInfo(ModelMap model, @PathVariable("username") String username) {
		Session session = factory.getCurrentSession();
		BienTapVien editor = (BienTapVien) session.get(BienTapVien.class, username);
		model.addAttribute("username", editor.getUsername());
		model.addAttribute("active", "info");
		model.addAttribute("EditorInfo", editor);
		return "admin/EditorInfo";
	}

	// xem thông tin trước khi update
	@RequestMapping(value = "admin/editor-info/{username}.htm", params = "update")
	public String EditorInfoUpdate(ModelMap model, @PathVariable("username") String username) {
		Session session = factory.getCurrentSession();
		BienTapVien editor = (BienTapVien) session.get(BienTapVien.class, username);
		model.addAttribute("username", editor.getUsername());
		model.addAttribute("active", "update");
		model.addAttribute("editor", editor);
		return "admin/EditorUpdate";
	}

	// update cho biên tập viên
	@RequestMapping(value = "admin/editor-info.htm", params = "update", method = RequestMethod.POST)
	public String EditorInfoUpdatePost(ModelMap model, @Validated @ModelAttribute("editor") BienTapVien editorUpdate,
			@RequestParam("birthday") String birthday, BindingResult errors) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		BienTapVien editor = (BienTapVien) session.get(BienTapVien.class, editorUpdate.getUsername());

		if (errors.hasErrors()) {
			System.out.println(errors.toString());
			return "admin/EditorUpdate";
		}
		if (checkEmail(editorUpdate.getEmail()) && (editorUpdate.getEmail().equals(editor.getEmail()) == false)) {
			model.addAttribute("error_e", "Email đã tồn tại");
			return "admin/EditorUpdate";
		}

		if (checkPhoneNumber(editorUpdate.getPhone()) && (editorUpdate.getPhone().equals(editor.getPhone())) == false) {
			model.addAttribute("error_ph", "Số điện thoại đã tồn tại");
			return "admin/EditorUpdate";
		}

		try {
			Date date = new SimpleDateFormat("yyyy-MM-dd").parse(birthday);
			editorUpdate.setBirthday(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());

		}
		if (editorUpdate.equals(editor)) {
			model.addAttribute("mode", "show");
			model.addAttribute("message", "Bạn chưa chỉnh sửa gì cả");
			return "admin/EditorUpdate";
		}
		editorUpdate.setPassword(editor.getPassword());
		editorUpdate.setRole(editor.isRole());
		editorUpdate.setBlock(editor.isBlock());
		editorUpdate.setEditor(editor.isEditor());
		model.addAttribute("mode", "show");
		try {
			session.merge(editorUpdate);
			t.commit();
			model.addAttribute("message", "cập nhật thành công");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", e.getMessage());
			// TODO: handle exception
		} finally {
			session.close();
		}
		return "admin/EditorUpdate";
	}

	// xem thông tin trước khi sửa mật khẩu
	@RequestMapping(value = "admin/editor-info.htm", params = "pwd")
	public String EditorInfoChangePassword(ModelMap model) {
		model.addAttribute("active", "changePwd");
		return "admin/EditorChangePassword";
	}

	// sửa mật khẩu
	@RequestMapping(value = "admin/editor-info/{username}.htm", params = "pwd", method = RequestMethod.POST)
	public String editorChangePassword(ModelMap model, @PathVariable("username") String username,
			@RequestParam("old_password") String oldPwd, @RequestParam("new_password") String newPwd,
			@RequestParam("conform_password") String conformPwd) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		BienTapVien editor = (BienTapVien) session.load(BienTapVien.class, username);

		if (editor.getPassword().equals(oldPwd) == false) {
			model.addAttribute("error_o", "Mật khẩu cũ không chính xác");
			return "admin/EditorChangePassword";
		}
		String regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$";
		if (newPwd.matches(regex) == false) {
			model.addAttribute("error_n", "Mật khẩu không đủ mạnh");
			return "admin/EditorChangePassword";
		}

		if (newPwd.equals(conformPwd) == false) {
			model.addAttribute("error_cp", "Nhập lại mật khẩu không đúng");
			return "admin/EditorChangePassword";
		}
		if (editor.getPassword().equals(oldPwd) == true && newPwd.equals(conformPwd) == true) {
			editor.setPassword(newPwd);
		}
		model.addAttribute("mode", "show");
		try {
			session.update(editor);
			t.commit();
			model.addAttribute("message", "Thay đổi mật khẩu thành công");
			System.out.println("Thay đổi mật khẩu thành công");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", e.getMessage());
		} finally {
			session.close();
		}
		return "admin/EditorChangePassword";
	}

	//
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

	public boolean checkPhoneNumber(String phone) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT phone FROM BienTapVien btv WHERE btv.phone = :phone";
		Query query = session.createQuery(hql);
		query.setParameter("phone", phone);
		if (query.list().isEmpty()) {
			return false;
		}
		return true;
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

	// model
	@ModelAttribute("categoryItem")
	public List<DanhMuc> getCategoryItem() {
		Session session = factory.getCurrentSession();
		String hql = "FROM DanhMuc";
		Query query = session.createQuery(hql);
		List<DanhMuc> list = query.list();
		return list;
	}
}
