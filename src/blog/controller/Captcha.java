package blog.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller

public class Captcha {
	@RequestMapping("captcha.htm")
	public void createCapcha(HttpServletRequest req, HttpServletResponse resp){
		HttpSession session = req.getSession();
		long captcha = 10000+ Math.round(89999*Math.random());
		session.setAttribute("captcha", captcha);
		// tao anh ao
		int w=100, h=40;
		BufferedImage image = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
		// lay moi truong do hoa cua anh de ve len anh
		Graphics2D g = image.createGraphics();
		// dat mau nen
		g.setColor(Color.GRAY);
		g.fillRect(0, 0, w, h);
		// dat mau va fort chu va ve chuoi captcha
		g.setColor(Color.blue);
		g.setFont(Font.decode("Impact-30"));
		g.drawString(String.valueOf(captcha), 10, h-5);
		// gui anh ve client
			resp.setContentType("image/jpeg");
			try {
				ImageIO.write(image, "jpeg", resp.getOutputStream());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			g.dispose();
		
	}
}
