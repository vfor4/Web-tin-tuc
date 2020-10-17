<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<base href="${pageContext.servletContext.contextPath}/">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- <link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.min.css"> -->
<link rel="stylesheet" type="text/css"
	href="resources/css/blog-home.css">
<link rel="stylesheet" type="text/css" href="resources/css/style.css">
<script type="text/javascript"
	src="resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="resources/js/jquery.twbsPagination.js"></script>

<style type="text/css">
[id$=".errors"] {
	color: red;
	font-style: italic;
}

.pointer {
	cursor: pointer;
}
</style>
<title>Mango Blog</title>
</head>
<body>


	<!-- Navigation -->

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
	<a class="myAnchor" href="#"></a>
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
	<!-- carousel  -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div id="hot-post" class="row hot-post">
				<div class="col-md-8 hot-post-left">
					<!-- post -->
					<div class="post post-thumb">
						<a class="post-img" href="post/${top3Post[0].maBaiViet }.htm"><img
							src="resources/images/${top3Post[0].hinhMoTa }" alt=""></a>
						<div class="post-body">
							<div class="post-category">
								<a href="home/category/${top3Post[0].danhMuc.maDanhMuc }.htm">${top3Post[0].danhMuc.tenDanhMuc }</a>
							</div>
							<h3 class="post-title title-lg">
								<a href="post/${top3Post[0].maBaiViet }.htm">${top3Post[0].tieuDe }</a>
							</h3>
							<ul class="post-meta">
								<li>Xem nhiều</li>
								<li><fmt:formatDate pattern="dd-MM-yyyy"
										value="${top3Post[0].thoiGian}" /></li>
							</ul>
						</div>
					</div>
					<!-- /post -->
				</div>
				<div class="col-md-4 hot-post-right">
					<!-- post -->
					<div class="post post-thumb">
						<a class="post-img" href="post/${top3Post[1].maBaiViet }.htm"><img
							src="resources/images/${top3Post[1].hinhMoTa }"></a>
						<div class="post-body">
							<div class="post-category">
								<a href="home/category/${top3Post[1].danhMuc.maDanhMuc }.htm">${top3Post[1].danhMuc.tenDanhMuc }</a>
							</div>
							<h3 class="post-title">
								<a href="post/${top3Post[1].maBaiViet }.htm">${top3Post[1].tieuDe }</a>
							</h3>
							<ul class="post-meta">
								<li>Xem nhiều</li>
								<li><fmt:formatDate pattern="dd-MM-yyyy"
										value="${top3Post[1].thoiGian}" /></li>
							</ul>
						</div>
					</div>
					<!-- /post -->

					<!-- post -->
					<div class="post post-thumb">
						<a class="post-img" href="post/${top3Post[2].maBaiViet }.htm"><img
							src="resources/images/${top3Post[2].hinhMoTa }" alt=""
							style="width: 100%; height: 100%;"></a>
						<div class="post-body">
							<div class="post-category">
								<a href="home/category/${top3Post[2].danhMuc.maDanhMuc }.htm">${top3Post[2].danhMuc.tenDanhMuc }</a>
							</div>
							<h3 class="post-title">
								<a href="post/${top3Post[2].maBaiViet }.htm">${top3Post[2].tieuDe }</a>
							</h3>
							<ul class="post-meta">
								<li>Xem nhiều</li>
								<li><fmt:formatDate pattern="dd-MM-yyyy"
										value="${top3Post[2].thoiGian}" /></li>
							</ul>
						</div>
					</div>
					<!-- /post -->
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>

	<!-- Page Content -->
	<div class="container">

		<div class="row">

			<!-- Blog Entries Column -->
			<div class="col-lg-8">
				<div id="page-content"></div>
				<!-- Pagination -->
				<ul id="pagination" class="pagination-sm"></ul>

			</div>

			<!-- Sidebar Widgets Column -->
			<div class="col-lg-4" style="margin-top: 75px;">

				<!-- FANPAGE -->

				<div class="fb-page" data-tabs="timeline,events,messages"
					data-href="https://www.facebook.com/Blog-Mango-114772216924139"
					data-width="350" data-hide-cover="false"></div>
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

				<!-- 				<div class="card my-4 bg-light"> -->
				<!-- 					<a class="weatherwidget-io" -->
				<!-- 						href="https://forecast7.com/en/14d06108d28/vietnam/" -->
				<!-- 						data-label_1="VIETNAM" data-label_2="THỜI TIẾT" -->
				<!-- 						data-theme="original">VIETNAM WEATHER</a> -->
				<!-- 				</div> -->
				<!-- 				 bản tin thời tiết -->
				<!-- 				<script> -->
				<!-- // 					!function(d, s, id) {
// 						var js, fjs = d.getElementsByTagName(s)[0];
// 						if (!d.getElementById(id)) {
// 							js = d.createElement(s);
// 							js.id = id;
// 							js.src = 'https://weatherwidget.io/js/widget.min.js';
// 							fjs.parentNode.insertBefore(js, fjs);
// 						}
// 					}(document, 'script', 'weatherwidget-io-js'); -->
				<!-- 				</script> -->
				<input class="countPagination" type="hidden"
					value="${countPagination }">
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
	<jsp:include page="Footer.jsp"></jsp:include>


	<!-- script -->


	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript">
		var count = $(".countPagination").val();
		$('#pagination').twbsPagination({
			totalPages : count,
			visiblePages : 2,
			onPageClick : function(event, page) {
				$('#page-content').load('home/page.htm?pageId=' + page);
				$('.myAnchor').focus();
			}
		});
	</script>
	<script type="text/javascript">
		$("#exampleModal").modal("${mode}");
	</script>
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
</body>
</html>