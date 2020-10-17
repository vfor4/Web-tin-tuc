<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link href='https://fonts.googleapis.com/css?family=Nunito:400,300'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="resources/css/register.css">
<style type="text/css">
[id$=".errors"], .error {
	color: red;
	font-style: italic;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<div class="row">
		<div class="col-4">
			<div class="list-group" id="list-tab" role="tablist">
			<a class="list-group-item list-group-item-action"
            href="admin/home.htm" role="tab" aria-controls="home">Quản trị</a>
				<a class="list-group-item list-group-item-action active"
					href="admin/editor-info/${sessionScope.user.username }.htm">Thông
					tin</a><a class="list-group-item list-group-item-action"
					href="admin/editor-info/${sessionScope.user.username }.htm?update">Cập
					nhật thông tin</a> <a
					class="list-group-item list-group-item-action"
					href="admin/editor-info.htm?pwd">Sửa mật khẩu</a>
			</div>
		</div>
		<div class="col-8">
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="list-home"
					role="tabpanel" aria-labelledby="list-home-list">
					<span class="number">-</span>thông tin cá nhân <br>
					<hr>
					<div class="row ">
						<label>Tài khoản : </label>
						<div>${EditorInfo.username }</div>
					</div>
					<hr>
					<div class="row">
						<label>Họ và tên : </label>
						<div>${EditorInfo.fullname }</div>
					</div>
					<hr>
					<div class="row">
						<label>Email :</label>
						<div>${EditorInfo.email }</div>
					</div>
					<hr>
					<div class="row">
						<label>Số điện thoại :</label>
						<div>${EditorInfo.phone }</div>
					</div>
					<hr>
					<div class="row">
						<label>Ngày sinh :</label>
						<div>
							<fmt:formatDate pattern="dd-MM-yyyy"
								value="${EditorInfo.birthday }" />
						</div>
					</div>
					<hr>
					<div class="row">
						<label>Giới tính :</label>
						<div>
							<c:if test='${EditorInfo.gender == "nu"}'>Nữ</c:if>
							<c:if test='${EditorInfo.gender == "nam"}'>Nam</c:if>
						</div>
					</div>
					<hr>
					<div class="row">
						<label>Địa chỉ :</label>
						<div>${EditorInfo.address }</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>