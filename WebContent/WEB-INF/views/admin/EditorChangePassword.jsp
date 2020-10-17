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
<script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>

<link href='https://fonts.googleapis.com/css?family=Nunito:400,300'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="resources/css/register.css">
<style type="text/css">
.row {
  margin-top: 70px;
}
.error {
	color: red;
	font-style: italic;
}

.disable-name {
	pointer-events: none;
	background: grey;
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
				<a class="list-group-item list-group-item-action "
					href="admin/editor-info/${sessionScope.user.username }.htm">Thông
					tin</a><a class="list-group-item list-group-item-action"
					href="admin/editor-info/${sessionScope.user.username }.htm?update">Cập
					nhật thông tin</a> <a
					class="list-group-item list-group-item-action active"
					href="admin/editor-info.htm?pwd">Sửa
					mật khẩu</a>
			</div>
		</div>
		<div class="col-8">
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="list-home"
					role="tabpanel" aria-labelledby="list-home-list">
					<form action="admin/editor-info/${sessionScope.user.username }.htm?pwd"
						 method="post">

						<h1>Cập nhật thông tin</h1>

						<fieldset>
							<legend>
								<span class="number">*</span>Đổi mật khẩu
							</legend>
							<label>Mật khẩu cũ: </label> <input type="password"
								name="old_password" 
								required="required">
							<div class="error">${error_o }</div>
							
							<label>Mật khẩu mới: </label>
							<input type="password" name="new_password"
								 required="required" />
							<div class="error">${error_n }</div>
							<span style="font-size: 12px;">Mật khẩu phải có ký tự chữ
								số, chữ hoa và chữ thường và độ dài lớn hơn 5</span> 
								
							<label>Nhập lại mật khẩu mới: </label> 
							<input type="password"
								name="conform_password" 
								required="required">
							<div class="error">${error_cp }</div>
						</fieldset>
						<button type="submit">Đổi mật khẩu</button>
						<a href="admin/editor-info/${sessionScope.user.username }.htm" type="button"
							class="btn btn-secondary btn-lg btn-block">Hủy</a>
					</form>
				</div>
			</div>
		</div>
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
					<button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Phần script -->
	<script type="text/javascript">
		$("#myModal").modal("${mode}");
	</script>
</body>
</html>