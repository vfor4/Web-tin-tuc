package blog.controller;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import blog.entity.DanhMuc;

@Controller
@Transactional

public class TestController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("admin/test")
	public String testView(ModelMap model) {
		model.addAttribute("danhMuc", new DanhMuc());
		return "admin/test";
	}

	@RequestMapping(value = "admin/test", method = RequestMethod.POST)
	public void testView1(ModelMap model, @RequestParam("maDanhMuc") String maDanhMuc,
			@RequestParam("tenDanhMuc") String tenDanhMuc) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {

			t.commit();
			System.out.print("da luu");
		} catch (Exception e) {
			t.rollback();
			System.out.print("chua luu");
		} finally {
			session.close();
		}
	}

	/*
	 * @RequestMapping(value = "admin/test2") public String test(ModelMap model)
	 * {
	 * 
	 * }
	 */
}
