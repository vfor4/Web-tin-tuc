package blog.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import blog.bean.BlogInfor;
import blog.entity.BaiViet;
import blog.entity.BinhLuan;
import blog.entity.DanhMuc;
import blog.entity.NguoiDangKi;

@Controller
@Transactional
public class PostController {
	@Autowired
	SessionFactory factory;

	@Autowired
	BlogInfor footer;
	
	@RequestMapping(value = "post/{id}")
	public String showPostById(ModelMap model, @PathVariable("id") Integer id) {
		model.addAttribute("registration", new NguoiDangKi());
		model.addAttribute("comment", new BinhLuan());
		Session session = factory.getCurrentSession();
		BaiViet post = (BaiViet) session.get(BaiViet.class, id);
		List<BinhLuan> list = post.getNhieuBinhLuan().stream().collect(Collectors.toList());
		Collections.sort(list, new Comparator<BinhLuan>() {
			@Override
			public int compare(BinhLuan o1, BinhLuan o2) {
				if(o1.getIdBinhLuan()> o2.getIdBinhLuan())
					return -1;
				return 1;
			}
		});
		model.addAttribute("comments", list);
		model.addAttribute("post", post);

		return "posts/Post";
	}

	@RequestMapping(value = "post/comment/{id}", method = RequestMethod.POST)
	public String comment(@PathVariable("id") Integer id, @ModelAttribute("comment") BinhLuan binhLuan) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		java.util.Date date =new  java.util.Date(System.currentTimeMillis());
		binhLuan.setBaiViet(getBaiVietById(id));
		binhLuan.setThoiGian(date);
		System.out.println(binhLuan.getEmail());
		System.out.println(binhLuan.getNoiDung());
		System.out.println(binhLuan.getTenNguoiBinhLuan());
		System.out.println(binhLuan.getBaiViet().getMaBaiViet());
		System.out.println(binhLuan.getIdBinhLuan());
		System.out.println(binhLuan.getThoiGian());
		try {
			session.save(binhLuan);
			t.commit();
			System.out.print("đã lưu");
		} catch (Exception e) {
			t.rollback();
			System.out.print(e.getMessage());
		} finally {
			session.close();
		}
		return "redirect:/post/"+id.toString()+".htm";
	}
	// Hàm
	public BaiViet getBaiVietById(Integer id) {
		Session session = factory.getCurrentSession();
		BaiViet post = (BaiViet) session.get(BaiViet.class, id);
		return post;
	}
	
	//model
	@ModelAttribute("count")
	public Integer count() {
		Integer count = getCategoryItem().size();
		return count;
	}
	@ModelAttribute("categoryItem")
	public List<DanhMuc> getCategoryItem() {
		Session session = factory.getCurrentSession();
		String hql = "FROM DanhMuc";
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<DanhMuc> list = query.list();
		return list;
	}
	@ModelAttribute("footer")
	public BlogInfor getFooter(){
		return footer;
	}
}
