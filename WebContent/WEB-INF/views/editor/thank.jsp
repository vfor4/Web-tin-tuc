<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<base href="${pageContext.servletContext.contextPath}/">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/blog-home.css">
<script type="text/javascript"
	src="resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
.icon a {
	padding-right: 10px;
	margin-left: 20px;
}

.footer {
	position: absolute;
	bottom: 0;
	width: 100%;
	height: 88px;
	padding: 0;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="alert alert-success" role="alert">
				<h2 class="alert-heading">Blog Mango cảm ơn bạn đã đăng kí</h2>
				<p style="font-size: 25px;">Thông tin của bạn đã được gửi đến
					quản trị viên để duyệt. Chúng tôi sẽ sớm liên hệ với bạn! Cảm ơn
					bạn đã dành thời gian của mình để đăng kí làm biên tập viên</p>
				<hr>
				<p class="mb-0 icon">
					Bạn đọc có thể theo dõi chúng tôi qua các kênh: <a href="#"><img
						alt="youtube" src="resources/images/youtube.png"></a> <a
						href="#"><img alt="facebook"
						src="resources/images/facebook.png"></a><a href="#"><img
						alt="instagram.png" src="resources/images/instagram.png"></a>
				</p>
			</div>
		</div>

		<div class="row">
			<a href="home.htm" type="button"
				class="btn-success text-decoration-none p-3">Quay về trang chủ
				<< </a>
		</div>

	</div>
	<div class="footer container-fluid">
		<jsp:include page="/WEB-INF/views/home/Footer.jsp"></jsp:include>
	</div>
</body>
</html>