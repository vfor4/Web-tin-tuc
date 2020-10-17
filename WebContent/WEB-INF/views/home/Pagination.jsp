<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
<style type="text/css">
a:hover, a:focus {
  color: #ee4266;
}
</style>
<title>Spring MVC</title>
</head>
<body>
	<h1 class="my-4">
		<b>BLOG MANGO</b> <small style="font-size: 2vw;"></small>
	</h1>

	<!-- Blog Post -->

	<c:forEach items="${PostList }" var="post">
	<c:if test="${post.bienTapVien.block == false }">
		<div class="card mb-3 bg-light">
			<div class="row no-gutters">
				<div class="col-lg-4">
					<a href="post/${post.maBaiViet }.htm"><img style="height: 238px;"
						src="resources/images/${post.hinhMoTa }" class="card-img"
						alt="cargo-cult"></a>
				</div>
				<div class="col-lg-8">
					<div class="card-body">
						<h5 class="card-title">
							<a href="post/${post.maBaiViet }.htm">${post.tieuDe }</a>
						</h5>
						<p class="card-text">${post.moTa}</p>
						<br> <br>

					</div>
					<div class="card-footer text-muted">
						Đăng lúc <fmt:formatDate pattern = "dd-MM-yyyy" 
         value = "${post.thoiGian}" />  bởi <a href=" #"> ${post.bienTapVien.username }</a>
					</div>
				</div>
			</div>
		</div>
		</c:if>
	</c:forEach>
</body>
</html>