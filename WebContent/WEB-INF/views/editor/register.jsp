<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<base href="${pageContext.servletContext.contextPath}/">
<title>ĐĂNG KÍ</title>
<link rel="stylesheet" type="text/css" href="resources/css/style.css">
<script type="text/javascript"
	src="resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.min.css">
<link href='https://fonts.googleapis.com/css?family=Nunito:400,300'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="resources/css/register.css">
<style type="text/css">
[id$=".errors"], .error {
	color: red;
	font-style: italic;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="home.htm"> <img
				src="resources/images/HomePage.png" style="height: 45px;">
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse " id="navbarResponsive">
				<ul class="navbar-nav ml-auto" style="font-size: 20px;">
					<li class="nav-item active"><a class="nav-link "
						href="home.htm" style="margin-right: 15px;">TRANG CHỦ <span
							class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item dropdown dmenu"><a
						class="nav-link dropdown-toggle" href="#" id="navbardrop"
						data-toggle="dropdown"> Danh Mục </a>
						<div class="dropdown-menu sm-menu">
							<c:forEach items="${categoryItem }" var="category">
								<a class="dropdown-item"
									href="home/category/${category.maDanhMuc }.htm">${category.tenDanhMuc }</a>
							</c:forEach>
						</div></li>
					<li class="nav-item "><a class="nav-link" href="register.htm">ĐĂNG
							KÍ CỘNG TÁC</a></li>
					<li class="nav-item "><a class="nav-link"
						href="home/author.htm">TÁC GIẢ</a></li>

				</ul>
			</div>
		</div>
	</nav>

	<div style="margin-top: 80px;">
		<form:form action="register.htm" modelAttribute="editor" method="post">

			<h1>ĐĂNG KÍ LÀM BIÊN TẬP VIÊN</h1>

			<fieldset>
				<legend>
					<span class="number">*</span>Nhập thông tin của bạn
				</legend>
				<form:input path="fullname" type="text" name="fullname" id=""
					placeholder="Họ và tên" required="required" />
				<div class="error">${error_u }</div>
				<form:input path="username" type="text" id="name"
					placeholder="Tên đăng nhập" required="required" />
				<form:errors path="username" element="div"></form:errors>
				<form:input path="password" type="password" id="password"
					placeholder="Mật khẩu" required="required" />
				<span>Mật khẩu phải có ký tự chữ số, chữ hoa và chữ thường và
					độ dài lớn hơn 5</span>
				<form:errors path="password" element="div"></form:errors>
				<input type="password" name="password_conform"
					placeholder="Xác nhận mật khẩu" required="required" id="password_c"> <span>
					<input type="checkbox" onclick="myFunction()" />Xem mật khẩu
				</span>
				<div class="error">${error_p }</div>
				<form:input path="email" type="email" id="mail" placeholder="Email"
					required="required" />

				<form:input path="phone" type="tel" id="phone"
					placeholder="Số điện thoại" pattern="^[0]\d{9,10}$"
					title="ví dụ: 0369xxx567" required="required" />
				<div class="error">${error_ph }</div>
				<input name="birthday" type="date" id="mail" placeholder="Ngày sinh"
					required="required" />
				<div class="error">${error_e }</div>
				<form:input path="address" type="text" placeholder="Địa chỉ" />

				<span style="padding-right: 30px;">Giới Tính:</span>
				<form:radiobutton value="nam" path="gender" required="required" />
				<label style="padding-right: 30px;" under_13" class="light">Nam</label>
				<form:radiobutton value="nu" path="gender" />
				<label for="over_13" class="light">Nữ</label>
				<div class="row">
					<input style="width: 300px;" type="number" name="captcha"
						placeholder="Nhập vào" required="required" /> <img
						style="height: 54px;" alt="captcha" src="captcha.htm" />
				</div>
				<div class="error">${error }</div>
			</fieldset>
			<button type="submit">ĐĂNG KÍ</button>
			<a href="home.htm" type="button"
				class="btn btn-secondary btn-lg btn-block">Hủy</a>
		</form:form>

	</div>
	<jsp:include page="/WEB-INF/views/home/Footer.jsp"></jsp:include>
	<!--  script -->
	<script type="text/javascript">
		$(document).ready(
				function() {
					$('.navbar-dark .dmenu').hover(
							function() {
								$(this).find('.sm-menu').first().stop(true,
										true).slideDown(150);
							},
							function() {
								$(this).find('.sm-menu').first().stop(true,
										true).slideUp(105)
							});
				});
	</script>
	<script type="text/javascript">
		function myFunction() {
			var x = document.getElementById("password");
			var y = document.getElementById("password_c");
			if (x.type === "password") {
				x.type = "text";
				y.type = "text";
			} else {
				x.type = "password";
				y.type = "password";
			}
		}
	</script>
</body>
</html>