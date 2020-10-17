package blog.controller;

import java.io.File;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import blog.bean.BlogInfor;
import blog.bean.Mailer;
import blog.entity.BaiViet;
import blog.entity.BienTapVien;
import blog.entity.BinhLuan;
import blog.entity.DanhMuc;
import blog.entity.NguoiDangKi;

@Transactional
@Controller
@RequestMapping("admin")
public class AdminController {
	@Autowired
	SessionFactory factory;

	@Autowired
	ServletContext context;

	@Autowired
	Mailer mailer;
	
	@Autowired
	BlogInfor footer;
	
	@Autowired
	ServletContext servlet;

	@RequestMapping()
	public String pageLogin(ModelMap model, @RequestParam(value = "method", required = false) String method,
			@RequestParam(value = "message", required = false) String message, HttpServletRequest request,
			RedirectAttributes redirect) {
		HttpSession session = request.getSession();
		if (session.getAttribute("user") != null) {
			redirect.addAttribute("message", "Hãy đăng xuất nếu muốn !");
			redirect.addAttribute("mode", "show");
			return "redirect:/admin/home.htm";
		}
		
		model.addAttribute("message", message);
		model.addAttribute("method", method);
		return "admin/LoginWithCaptcha";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String loginCaptcha(ModelMap model, @RequestParam("username") String username,
			@RequestParam("password") String password, @RequestParam("captcha") String captcha, HttpServletRequest req,
			HttpServletResponse resp) {
		HttpSession session = req.getSession();
		String captchaSession = String.valueOf(session.getAttribute("captcha"));
		System.out.println("captcha: " + captchaSession);
		if (captcha.equalsIgnoreCase(captchaSession) == false) {
			model.addAttribute("error_c", "Sai Captcha");
			return "admin/LoginWithCaptcha";
		}	
		List<BienTapVien> list = checkUsername(username, password);
		if (list.isEmpty()) {
			model.addAttribute("error_b", "Thông tin đăng nhập không chính xác");
			return "admin/LoginWithCaptcha";
		}
		if (list.get(0).isBlock() == true) {
			model.addAttribute("error_b", "Tài khoản đã bị khóa");
			return "admin/LoginWithCaptcha";
		}
		if (list.get(0).isEditor() == false && list.get(0).isRole() != true) {
			model.addAttribute("error_b", "Tài khoản chưa được kích hoạt");
			return "admin/LoginWithCaptcha";
		}
		if (list.isEmpty() == false) {
			session.setAttribute("user", list.get(0));
			System.out.println("dang nhap thanh cong");
			return "redirect:/admin/home.htm";
		}
		model.addAttribute("error_c", "Sai thông tin đăng nhập");
		return "admin/LoginWithCaptcha";

	}

	@RequestMapping("home")
	public String listMail(ModelMap model, @RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "message", required = false) String message) {
		model.addAttribute("mode", mode);
		model.addAttribute("message", message);
		return "admin/HomeAdmin";
	}

	@RequestMapping(value = "add-post")
	public String themBaiViet(ModelMap model) {
		return "admin/AddPost";
	}

	@RequestMapping(value = "add-post", method = RequestMethod.POST)
	public String themBaiViet(@RequestParam("hinhAnh") MultipartFile hinhAnh,
			@RequestParam("maDanhMuc") String maDanhMuc, @RequestParam("tieuDe") String tieuDe,
			@RequestParam("moTa") String moTa, @RequestParam("noiDung") String noiDung, RedirectAttributes redirect,
			HttpServletRequest req) {
		HttpSession httpSession = req.getSession();
		BienTapVien editor = (BienTapVien) httpSession.getAttribute("user");
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		BaiViet baiViet = new BaiViet();
		Date date = java.sql.Date.valueOf(java.time.LocalDateTime.now().toLocalDate());
		// lưu hình ảnh vào folder:resources/images
		saveImage(hinhAnh);
		// set thông tin cho object
		baiViet.setDanhMuc(chonDanhMuc(maDanhMuc));
		baiViet.setTieuDe(tieuDe);
		baiViet.setMoTa(moTa);
		baiViet.setHinhMoTa(hinhAnh.getOriginalFilename());
		baiViet.setThoiGian(date);
		baiViet.setNoiDung(noiDung);
		baiViet.setBienTapVien(editor);
		// cài đặt biến redirect để hiện thông báo
		redirect.addAttribute("mode", "show");
		try {
			session.save(baiViet);
			t.commit();
			redirect.addAttribute("message", "Thêm thành công!");
		} catch (Exception e) {
			t.rollback();
			redirect.addAttribute("message", "Thêm thất bại!");
		} finally {
			session.close();
		}
		return "redirect:/admin/home.htm";
	}

	@RequestMapping(value = "delete/{maBaiViet}")
	public String xoaBaiViet(ModelMap model, @PathVariable("maBaiViet") String maBaiViet, BaiViet baiViet,
			RedirectAttributes redirect) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		redirect.addAttribute("mode", "show");
		try {
			session.delete(maBaiViet, baiViet);
			t.commit();
			redirect.addAttribute("message", "Xóa thành công!");
		} catch (Exception e) {
			t.rollback();
			redirect.addAttribute("message", "Xóa thất bại!");
		} finally {
			session.close();

		}
		return "redirect:/admin/home.htm";
	}

	@RequestMapping(value = "update/{maBaiViet}", method = RequestMethod.GET)
	public String capNhatBaiViet(ModelMap model, @PathVariable("maBaiViet") Integer maBaiViet) {
		Session session = factory.getCurrentSession();
		BaiViet baiVietTheoMa = (BaiViet) session.get(BaiViet.class, maBaiViet);
		model.addAttribute("baiVietTheoMa", baiVietTheoMa);
		model.addAttribute("maDanhMucBaiViet", baiVietTheoMa.getDanhMuc().getMaDanhMuc());
		return "admin/UpdatePost";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String capNhatBaiViet(ModelMap model, @RequestParam("maBaiViet") Integer idArticles,
			@RequestParam(value = "maDanhMuc") String idCategory, @RequestParam("tieuDe") String title,
			@RequestParam("moTa") String description, @RequestParam("hinhMoTa") MultipartFile image,
			@RequestParam("noiDung") String content, RedirectAttributes redirect, HttpServletRequest req) {
		HttpSession httpSession = req.getSession();
		BienTapVien editor = (BienTapVien) httpSession.getAttribute("user");
		
		BaiViet articles = new BaiViet();
		BaiViet oldArticles = getArticleById(idArticles);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		// Lưu Ảnh
		model.addAttribute("messageImage", saveImage(image));
		// Lấy thời gian hiện tại
		Date date = java.sql.Date.valueOf(java.time.LocalDateTime.now().toLocalDate());
		// Lưu bài viết
		articles.setMaBaiViet(idArticles);
		articles.setDanhMuc(chonDanhMuc(idCategory));
		articles.setTieuDe(title);
		articles.setMoTa(description);
		if (image.isEmpty()) {
			String oldImage = oldArticles.getHinhMoTa();
			articles.setHinhMoTa(oldImage);
		} else {
			articles.setHinhMoTa(image.getOriginalFilename());
		}

		articles.setNoiDung(content);
		articles.setThoiGian(date);
		articles.setBienTapVien(editor);
		redirect.addAttribute("mode", "show");
		try {
			session.update(articles);
			t.commit();
			redirect.addAttribute("message", "Cập nhật thành công");
		} catch (Exception e) {
			t.rollback();
			redirect.addAttribute("message", e.getMessage());
		} finally {
			session.close();
		}
		return "redirect:/admin/home.htm";
	}

	@RequestMapping(value = "user-list")
	public String userList() {
		return "";
	}

	@RequestMapping(value = "send-mail", method = RequestMethod.POST)
	public String sendMail(ModelMap model, @RequestParam("form") String form,
			@RequestParam(required = false, value = "mailAdress") String to, @RequestParam("name") String name,
			@RequestParam("subject") String subject, @RequestParam("body") String body, RedirectAttributes redirect) {
		redirect.addAttribute("mode", "show");
		if (form.equals("everyone")) {
			mailer.sendAll(name, getListMailUser(), subject, body);
			redirect.addAttribute("message", "Đã gửi mail đến mọi người");
		} else if (form.equals("individual")) {
			mailer.send(name, to, subject, body);
			redirect.addAttribute("message", "Đã gửi mail đến:" + to);
		} else {
			redirect.addAttribute("message", "Gửi mail thất bại");
		}

		return "redirect:/admin/home.htm";
	}

	// xem danh sách tất cả tài khoản
	@RequestMapping(value = "editor-manager")
	public String EditorManager(ModelMap model) {
		return "admin/EditorManager";
	}

	@RequestMapping(value = "editor-list")
	public String EditorList(ModelMap model) {
		model.addAttribute("listEditor", EditorList());
		return "admin/ListEditor";
	}

	// xem danh sách tất cả tài khoản active
	@RequestMapping(value = "editor-active")
	public String EditorActive(ModelMap model) {
		model.addAttribute("EditorActive", EditorActive());
		return "admin/ListEditorActive";
	}

	// xem danh sách tất cả tài khoản block
	@RequestMapping(value = "editor-block")
	public String EditorBlock(ModelMap model) {
		model.addAttribute("LockedlistEditor", LockedlistEditor());
		return "admin/ListEditorBlock";
	}

	// xem danh sách tất cả tài khoản đang chờ
	@RequestMapping(value = "editor-waiting")
	public String EditorWaiting(ModelMap model) {
		model.addAttribute("listWaiting", listWaiting());
		return "admin/ListEditorWaiting";
	}

	// xử lý duyệt biên tập viên
	@RequestMapping(value = "editor-list/{username}", params = "accept")
	public String acceptEditor(@PathVariable("username") String username, ModelMap model) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		BienTapVien editor = (BienTapVien) session.load(BienTapVien.class, username);
		editor.setEditor(true);
		model.addAttribute("mode", "show");
		try {
			session.update(username, editor);
			t.commit();
			model.addAttribute("message", "Duyệt thành công");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Duyệt thất bại");
		} finally {
			session.close();
		}
		return "admin/EditorManager";
	}

	// xử lý khóa biên tập viên
	@RequestMapping(value = "editor-list/{username}", params = "block")
	public String blockEditor(ModelMap model, @PathVariable("username") String username) {

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		BienTapVien editor = (BienTapVien) session.load(BienTapVien.class, username);
		editor.setBlock(true);
		model.addAttribute("mode", "show");
		try {
			session.update(username, editor);
			t.commit();
			model.addAttribute("message", "Khóa thành công");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Khóa thất bại");
		} finally {
			session.close();
		}
		return "admin/EditorManager";
	}

	// xử lý mở khóa biên tập viên
	@RequestMapping(value = "editor-list/{username}", params = "unlock")
	public String UnlookEditor(ModelMap model, @PathVariable("username") String username) {

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		BienTapVien editor = (BienTapVien) session.load(BienTapVien.class, username);
		editor.setBlock(false);
		model.addAttribute("mode", "show");
		try {
			session.update(username, editor);
			t.commit();
			model.addAttribute("message", "Bỏ khóa thành công");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Bỏ khóa");
		} finally {
			session.close();
		}
		return "admin/EditorManager";
	}

	// xử lý xóa biên tập viên
	@RequestMapping(value = "editor-list/{username}", params = "del")
	public String DelEditor(ModelMap model, @PathVariable("username") String username) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		BienTapVien editor = new BienTapVien();
		editor.setUsername(username);
		model.addAttribute("mode", "show");
		try {
			session.delete(editor);
			t.commit();
			model.addAttribute("message", "Xóa thành công");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Xóa thất bại");
		} finally {
			session.close();
		}
		return "admin/ListEditor";
	}


	@RequestMapping(value = "delete-comment/{id}")
	public String deleteComment(ModelMap model, @PathVariable("id") Integer id, BinhLuan binhLuan,
			RedirectAttributes redirect) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		binhLuan.setIdBinhLuan(id);
		redirect.addAttribute("mode", "show");
		try {
			session.delete(binhLuan);
			t.commit();
			redirect.addAttribute("message", "Đã xóa");
		} catch (Exception e) {
			t.rollback();
			redirect.addAttribute("message", "Xóa thất bại");
		} finally {
			session.close();
		}

		return "redirect:/admin/home.htm";
	}

	@RequestMapping(value = "delete-spam/{mail}")
	public String deleteSpam(ModelMap model, @PathVariable("mail") String mail, BinhLuan binhLuan,
			RedirectAttributes redirect) {
		List<Integer> listSpam = listSpam(mail);
		redirect.addAttribute("mode", "show");
		for (Integer i : listSpam) {
			binhLuan.setIdBinhLuan(i);
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				session.delete(binhLuan);
				t.commit();
				redirect.addAttribute("message", "Xóa spam thành công! email:" + mail);
			} catch (Exception e) {
				t.commit();
				redirect.addAttribute("message", "Xóa spam thất bại");
			} finally {
				session.close();
			}
		}
		return "redirect:/admin/home.htm";

	}

	@RequestMapping("logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/admin.htm";
	}
	
	// ----------- Hàm -------------

	// Lưu ảnh vào forder
	public String saveImage(MultipartFile image) {
		String message = "";
		if (image.isEmpty()) {
			message = "Image is empty ";
		} else {
			try {
				String photoPath = context.getRealPath("resources/images/" + image.getOriginalFilename());
				image.transferTo(new File(photoPath));
				message = "Image saved  ";
			} catch (Exception e) {
				message = "Unable to save  image";
			}
		}
		return "Image saved";
	}

	public DanhMuc chonDanhMuc(String maDanhMuc) {
		Session session = factory.getCurrentSession();
		DanhMuc danhMuc = (DanhMuc) session.get(DanhMuc.class, maDanhMuc);
		return danhMuc;
	}

	// danh sách mail để gửi đến tất cả
	public List<String> getListMailUser() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT email FROM NguoiDangKi";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<String> list = query.list();
		return list;
	}

	// lấy bài viêt theo id
	public BaiViet getArticleById(Integer id) {
		Session session = factory.getCurrentSession();
		BaiViet article = (BaiViet) session.get(BaiViet.class, id);
		return article;
	}
	// ---- model--------------

	// modal danh sách bai viet
	@ModelAttribute("danhSachBaiViet")
	public List<BaiViet> getDanhSachBaiViet() {
		Session session = factory.getCurrentSession();
		String hql = "FROM BaiViet";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<BaiViet> list = query.list();
		Collections.sort(list, new Comparator<BaiViet>() {
			@Override
			public int compare(BaiViet o1, BaiViet o2) {
				if (o1.getMaBaiViet() > o2.getMaBaiViet())
					return -1;
				return 1;
			}
		});
		return list;
	}

	// modal danh mục
	@ModelAttribute("danhMuc")
	public List<DanhMuc> getDanhMuc() {
		Session session = factory.getCurrentSession();
		String hql = "FROM DanhMuc";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<DanhMuc> list = query.list();
		return list;
	}

	// modal người đăng kí
	@ModelAttribute("listUser")
	public List<NguoiDangKi> getListUser() {
		Session session = factory.getCurrentSession();
		String hql = "FROM NguoiDangKi";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<NguoiDangKi> list = query.list();
		return list;
	}

	// modal danh sách comment
	@ModelAttribute("listComment")
	public List<BinhLuan> getListComment() {
		Session session = factory.getCurrentSession();
		String hql = "FROM BinhLuan ORDER BY thoiGian DESC";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<BinhLuan> list = query.list();
		return list;
	}

	// load id các bình luận spam
	public List<Integer> listSpam(String mail) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT idBinhLuan FROM BinhLuan WHERE  email = :mailcase ";
		Query query = session.createQuery(hql);
		query.setParameter("mailcase", mail);
		@SuppressWarnings("unchecked")
		List<Integer> list = query.list();
		return list;
	}

	// đăng nhập cộng tác viên
	public List<BienTapVien> checkUsername(String username, String password) {
		Session session = factory.getCurrentSession();
		String hql = "FROM BienTapVien btv WHERE btv.username = :username AND btv.password = :password";
		Query query = session.createQuery(hql);
		query.setParameter("username", username);
		query.setParameter("password", password);
		@SuppressWarnings("unchecked")
		List<BienTapVien> editor = query.list();
		return editor;
	}

	// load tài khoản chờ kích hoạt
	public List<BienTapVien> listWaiting() {
		Session session = factory.getCurrentSession();
		String hql = "FROM BienTapVien btv WHERE btv.isEditor = false AND btv.role != true";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<BienTapVien> editor = query.list();
		return editor;
	}

	// load tài khoản đã được kích hoạt
	public List<BienTapVien> EditorActive() {
		Session session = factory.getCurrentSession();
		String hql = "FROM BienTapVien btv WHERE btv.isEditor = true AND btv.isBlock != true";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<BienTapVien> editor = query.list();
		return editor;
	}

	// load tài khoản đã bị khóa
	public List<BienTapVien> LockedlistEditor() {
		Session session = factory.getCurrentSession();
		String hql = "FROM BienTapVien btv WHERE btv.isBlock = true";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<BienTapVien> editor = query.list();
		return editor;
	}

	// load tất cả tài khoản
	public List<BienTapVien> EditorList() {
		Session session = factory.getCurrentSession();
		String hql = "FROM BienTapVien btv WHERE btv.role != true";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<BienTapVien> editor = query.list();
		return editor;
	}

}
