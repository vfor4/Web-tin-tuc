<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<base href="${pageContext.servletContext.contextPath}/">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.min.css">
<script type="text/javascript"
	src="resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<link href="resources/css/blog-post.css" rel="stylesheet">
<style type="text/css">
[id$=".errors"] {
	color: red;
	font-style: italic;
}

.pointer {
	cursor: pointer;
}
</style>
<title>Blog Mango</title>
</head>
<body>
	<!-- Navigation -->
	<a class="myAnchor" href="#"></a>
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
					<li class="nav-item "><a class="nav-link" href="#">TÁC GIẢ</a>
					</li>

				</ul>
			</div>
		</div>
	</nav>
	<!-- Modal đăng kí -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">ĐĂNG KÍ</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form:form modelAttribute="registration" action="home/register.htm">
						<div class="form-group">
							<label for="exampleInputEmail1">Email</label>
							<form:input path="email" type="email" class="form-control"
								id="exampleInputEmail1" aria-describedby="emailHelp"
								placeholder="Nhập email..." required="required" />

						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Số điện thoại</label>
							<form:input path="sdt" type="tel" pattern="^[0]\d{9,10}$"
								class="form-control" id="exampleInputPassword1"
								placeholder="Nhập số điện thoại...." title="ví dụ: 03696xx567"
								required="required" />

						</div>
						<br>
						<button type="submit" class="btn btn-success">ĐĂNG KÍ</button>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<!-- Page Content -->
	<div class="container">

		<div class="row">

			<!-- Post Content Column -->
			<div class="col-lg-8 mt-5">

				<!-- Title -->
				<h1 class="mt-4">${post.tieuDe }</h1>

				<!-- Author -->
				<p class="lead">
					Đăng bởi <a href="#">${post.bienTapVien.username}</a>
				</p>

				<hr>

				<!-- Date/Time -->
				<p>
					<i>Vào lúc</i> ${post.thoiGian }
				</p>

				<hr>

				<!-- Preview Image -->
				<hr>

				<!-- Post Content -->
				<div class="lead" id="content">${post.noiDung }</div>

				<hr>

				<!-- Comments Form -->
				<div class="card my-4">
					<h5 class="card-header">BÌNH LUẬN</h5>
					<div class="card-body">
						<form:form modelAttribute="comment"
							action="post/comment/${post.maBaiViet }.htm" method="POST"
							class="submit-form">
							<div class="row">
								<div class="col">
									<label for="inputName">Tên</label>
									<form:input path="tenNguoiBinhLuan" type="text"
										class="form-control" id="inputName" placeholder="Nhập tên"
										required="required"></form:input>

								</div>
								<div class="col">
									<label for="inputEmail1">Email</label>
									<form:input path="email" type="email" class="form-control"
										id="inputEmail1" aria-describedby="emailHelp"
										placeholder="Nhập email" required="required"></form:input>
									<small id="emailHelp" class="form-text text-muted">Cam
										kết sẽ không tiết lộ email</small>

								</div>
							</div>
							<label for="inputlTextarea1">Bình Luận</label>
							<form:textarea path="noiDung" class="form-control"
								id="inputlTextarea1" rows="3" required="required"></form:textarea>

							<button type="submit" class="btn btn-primary mt-3 float-right"
								onclick="loadNewCmt()">Đăng</button>
						</form:form>
					</div>
				</div>

				<!-- Single Comment -->
				<div class="divComment">
					<c:forEach items="${comments }" var="cmt">
						<div class="media mb-4">
							<img class="d-flex mr-3 rounded-circle"
								src="resources/images/cmt.png" alt="people"
								style="height: 60px; width: 60px;">
							<div class="media-body">
								<h5 class="mt-0">${cmt.tenNguoiBinhLuan }
									<i><small> vào lúc</small></i>
									<fmt:formatDate pattern="dd-MM-yyyy  hh:mm:ss aa"
										value="${cmt.thoiGian }" />
								</h5>
								<div>${cmt.noiDung }</div>
							</div>
						</div>
						<hr>
					</c:forEach>
				</div>
			</div>

			<!-- Sidebar Widgets Column -->
			<div class="col-lg-4" style="margin-top: 75px;">

				<!-- FANPAGE -->

				<div class="fb-page" data-tabs="timeline,events,messages"
					data-href="https://www.facebook.com/Blog-Mango-114772216924139"
					data-width="380" data-hide-cover="false"></div>
				<div id="fb-root"></div>
				<script async defer crossorigin="anonymous"
					src="https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v7.0"></script>

				<!-- Categories Widget -->
				<div class="card my-4 bg-light">
					<h5 class="card-header">Danh mục</h5>
					<div class="card-body">
						<div class="row">
							<c:forEach items="${categoryItem }" var="category" varStatus="i">
								<c:if test="${i.index <= count }">
									<div class="col-lg-6">
										<ul class="list-unstyled mb-0">
											<li><a href="home/category/${category.maDanhMuc }.htm">${category.tenDanhMuc }</a></li>
										</ul>
									</div>
								</c:if>
								<c:if test="${i.index >= count }">
									<div class="col-lg-6">
										<ul class="list-unstyled mb-0">
											<li><a href="home/category/${category.maDanhMuc }.htm">${category.tenDanhMuc }</a></li>
										</ul>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>

				<!-- Side Widget -->
				<div class="card my-4 bg-light">
					<img class="card-img" alt="image about author"
						src="resources/images/zYPFO2tM.jpg"
						style="height: 300px; width: 100%;">
					<h5 class="card-header">Tác giả</h5>
					<div class="card-body" style="font-size: 20px;">Hiện đang
						theo học tại Học viện công nghệ bưu chính viễn thông chuyên ngành
						an toàn thông tin.Là một người thích viết, tác giả muốn chia sẻ
						với mọi người những bài học những góc nhìn của mình về học tập,
						những suy nghĩ, cuộc sống tại học viện, các hoạt động tại học
						viện.</div>
				</div>
				<!--  -->

				<!-- Search Widget -->
				<div class="card my-4 bg-light">
					<h5 class="card-header">Điền email để nhận thông báo về bài
						viết mới</h5>
					<div class="card-body">
						<form:form modelAttribute="registration"
							action="home/register.htm" method="POST" class="form-group">
							<form:input path="email" type="text" class="form-control d-block"
								placeholder="Nhập email" />
							<form:errors path="email" element="div"></form:errors>
							<form:input path="sdt" type="text" class="form-control"
								placeholder="Nhập số điện thoại" />
							<form:errors path="sdt" element="div"></form:errors>
							<form:button class="btn btn-success btn-block">Đăng kí</form:button>
						</form:form>
					</div>
				</div>


			</div>
		</div>
	</div>
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/home/Footer.jsp"></jsp:include>

	<!-- Bootstrap core JavaScript -->
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
		$(document).ready(function() {
			// $("#img-fluid").removeAttr("style").addClass("my-images");
			$("#content img").width("100%").height("100%");
		});
	</script>
</body>
</html>