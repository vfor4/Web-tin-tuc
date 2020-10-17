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
<title>Lấy lại mật khẩu</title>
<style type="text/css">
.error {
	color: red;
}
</style>
</head>
<body>
	<div
		style="background-color: gray; padding: 50px; display: inline-block; margin-left: 560px;">
		<form action="forgotPassword.htm" method="post">
			<h3>Lấy Lại mật khẩu</h3>
			<label>Nhập tài khoản:</label> <input name="username" type="text"
				required="required" />
			<div class="error">${error_u}</div>
			<br> <label>Nhập vào email:</label> <input name="email"
				type="email" required="required" /> <br>
			<div class="error">${ error_e}</div>
			<div class="error">${ error_both}</div>
			<br>
			<button class="btn btn-success btn-block">Lấy lại mật khẩu</button>
		</form>
	</div>
	<!-- show modal -->
	<div class="modal fade" id="myModal" role="dialog" tabindex="-2"
		aria-hidden="true">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">THÔNG BÁO</h4>
				</div>
				<div class="modal-body">
					<p>${message }</p>
				</div>
				<div class="modal-footer">
					<a href="admin.htm" class="btn btn-success"> Đăng nhập</a>
					<button type="button" class="btn btn-info" data-dismiss="modal">Đóng</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$("#myModal").modal("${mode}");
	</script>
</body>
</html>