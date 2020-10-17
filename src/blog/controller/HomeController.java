package blog.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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

import blog.bean.BlogInfor;
import blog.entity.BaiViet;
import blog.entity.DanhMuc;
import blog.entity.NguoiDangKi;

@Transactional
@Controller
@RequestMapping("home")
public class HomeController {
	@Autowired
	SessionFactory factory;

	@Autowired
	BlogInfor footer;
	
	@RequestMapping()
	public String homePage(ModelMap model, HttpServletRequest req) {
		model.addAttribute("registration", new NguoiDangKi());
		HttpSession session = req.getSession();
		session.setAttribute("footer", footer);
		return "home/HomePage";
	}

	@RequestMapping(value = "page")
	public String pagination(ModelMap model, @RequestParam("pageId") int page) {
		int total = 7;
		model.addAttribute("PostList", postList(page, total));
		return "home/Pagination";
	}

	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String register(ModelMap model, @Validated @ModelAttribute("registration") NguoiDangKi ngDangKi,
			BindingResult errors) {
		if (errors.hasErrors()) {
			return "home/HomePage";
		}
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(ngDangKi);
			t.commit();
			model.addAttribute("message", "Đã đăng kí thành công");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Đăng kí thất bại");
		} finally {
			session.close();
		}
		return "home/ThankYou";
	}
	
	
	@RequestMapping(value = "category/{maDanhMuc}")
	public String category(ModelMap model, @PathVariable("maDanhMuc") String maDanhMuc) {
		// System.out.println(maDanhMuc);
		model.addAttribute("registration", new NguoiDangKi());
		model.addAttribute("postByCategory", postByCategory(maDanhMuc));
		return "home/Category";
	}
	
	@RequestMapping(value = "author")
	public String author(ModelMap model){
		model.addAttribute("registration", new NguoiDangKi());
		return "home/Author";
	}
	// hàm 
	public List<BaiViet> postByCategory(String maDanhMuc) {
		Session session = factory.getCurrentSession();
		String hql = "FROM BaiViet WHERE maDanhMuc = :maDanhMuc ORDER BY thoiGian DESC";
		Query query = session.createQuery(hql);
		query.setParameter("maDanhMuc", maDanhMuc);
		@SuppressWarnings("unchecked")
		List<BaiViet> list = query.list();
		return list;
	}

	public List<BaiViet> postList(int pageId, int total) {
		Session session = factory.getCurrentSession();
		String hql = "FROM BaiViet bv ORDER BY bv.maBaiViet DESC";
		Query query = session.createQuery(hql);
		if (pageId == 1) {
			query.setFirstResult(0);
			query.setMaxResults(7);
		}else{
			query.setFirstResult((pageId - 1)*total);
			query.setMaxResults(total);
		}
		@SuppressWarnings("unchecked")
		List<BaiViet> list = query.list();

		return list;
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

	@ModelAttribute("count")
	public Integer count() {
		Integer count = getCategoryItem().size();
		return count;
	}
	@ModelAttribute("countPagination")
	public Integer getCountPagination(){
		Session session = factory.getCurrentSession();
		String hql = "FROM BaiViet";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<BaiViet> list = query.list();
		Integer countPagination = list.size()/7+1;
		return countPagination;
	}
	@ModelAttribute("top3Post")
	public List<BaiViet> getTop3Post(){
		Session session = factory.getCurrentSession();
		String hql = "FROM BaiViet bv ORDER BY bv.maBaiViet DESC";
		Query query = session.createQuery(hql);
		query.setFirstResult(0);
		query.setMaxResults(3);
		@SuppressWarnings("unchecked")
		List<BaiViet> list = query.list();
		return list;
	}
}
