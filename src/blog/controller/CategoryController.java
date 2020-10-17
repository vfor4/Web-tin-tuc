package blog.controller;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import blog.entity.BaiViet;
import blog.entity.BienTapVien;
import blog.entity.DanhMuc;

@Transactional
@Controller
public class CategoryController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("admin/category")
	public String categoryList(ModelMap model, @RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "message", required = false) String message) {
		model.addAttribute("danhMuc", new DanhMuc());
		model.addAttribute("mode", mode);
		model.addAttribute("message", message);
		return "category/list";
	}

	@RequestMapping("admin/add-category")
	public String addCategory(RedirectAttributes redirect, @ModelAttribute("danhMuc") DanhMuc danhMuc,
			HttpServletRequest req) {

		HttpSession httpSession = req.getSession();
		BienTapVien editor = (BienTapVien) httpSession.getAttribute("user");

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		redirect.addAttribute("mode", "show");
		danhMuc.setBienTapVien(editor);
		try {
			session.save(danhMuc);
			t.commit();
			redirect.addAttribute("message", "Thêm danh mục thành công");
		} catch (Exception e) {
			t.rollback();
			redirect.addAttribute("message", "Thêm danh mục thất bại");
		} finally {
			session.close();
		}

		return "redirect:/admin/category.htm";
	}

	@RequestMapping("admin/del-category/{id}")
	public String delCategory(RedirectAttributes redirect, @PathVariable("id") String maDanhMuc, DanhMuc danhMuc) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		if(getPostByCategory(maDanhMuc) == false){
			redirect.addAttribute("mode", "show");
			redirect.addAttribute("message", "Không xóa được! Vẫn còn bài viết thuộc danh mục");
			return "redirect:/admin/category.htm";
		}
		danhMuc.setMaDanhMuc(maDanhMuc);
		redirect.addAttribute("mode", "show");
		try {
			session.delete(danhMuc);
			t.commit();
			redirect.addAttribute("message", "Xóa danh mục thành công");
		} catch (Exception e) {
			t.rollback();
			redirect.addAttribute("message", "Xóa danh mục thất bại");
		} finally {
			session.close();
		}
		return "redirect:/admin/category.htm";
	}

	
	@RequestMapping(value = "admin/update-category/{id}", method = RequestMethod.POST)
	public String updateCategory(RedirectAttributes redirect, @PathVariable("id") String maDanhMuc,
			@RequestParam(value = "newName") String tenDanhMuc, DanhMuc danhMuc, HttpServletRequest req) {
		HttpSession httpSession = req.getSession();
		BienTapVien editor = (BienTapVien) httpSession.getAttribute("user");
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		danhMuc.setMaDanhMuc(maDanhMuc);
		danhMuc.setTenDanhMuc(tenDanhMuc);
		danhMuc.setBienTapVien(editor);
		redirect.addAttribute("mode", "show");
		try {
			session.update(danhMuc);
			t.commit();
			redirect.addAttribute("message", "Cập nhật thành công");
		} catch (Exception e) {
			t.rollback();
			redirect.addAttribute("message", e.getMessage());
		} finally {

			session.close();
		}

		return "redirect:/admin/category.htm";
	}

	// -- model---
	// danh sách danh mục
	@ModelAttribute("categoryList")
	public List<DanhMuc> getCategoryList() {
		Session session = factory.getCurrentSession();
		String hql = "FROM DanhMuc";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<DanhMuc> list = query.list();
		return list;
	}

	// ---- hàm ----
	public DanhMuc getCategoryById(String id) {
		Session session = factory.getCurrentSession();
		DanhMuc danhMuc = (DanhMuc) session.get(DanhMuc.class, id);
		return danhMuc;
	}
	
	public boolean getPostByCategory(String maDanhMuc){
		Session session = factory.getCurrentSession();
		String hql = "FROM BaiViet bv WHERE bv.danhMuc.maDanhMuc = :maDanhMuc";
		Query query = session.createQuery(hql);
		query.setParameter("maDanhMuc", maDanhMuc);
		List<BaiViet> list = query.list();
		if(list.isEmpty())
			return true;
		return false;
	}
}
