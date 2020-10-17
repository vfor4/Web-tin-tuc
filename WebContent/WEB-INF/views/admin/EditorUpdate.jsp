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
					tin</a><a class="list-group-item list-group-item-action active"
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
					<form:form action="admin/editor-info.htm?update"
						modelAttribute="editor" method="post">

						<h1>Cập nhật thông tin</h1>

						<fieldset>
							<legend>
								<span class="number">*</span>Nhập thông tin cần thay đổi
							</legend>
							<label>Tên đăng nhập:</label>
							<form:input path="username" type="text" id="name"
								placeholder="Tên đăng nhập" class="disable-name" />
							<form:errors path="username" element="div"></form:errors>

							<label>Họ và tên:</label>
							<form:input path="fullname" type="text" name="fullname" id=""
								placeholder="Họ và tên" required="required" />

							<label>email:</label>
							<form:input path="email" type="email" id="mail"
								placeholder="Email" required="required" />
							<div class="error">${error_e }</div>
							<label>Số điện thoại:</label>
							<form:input path="phone" type="tel" id="phone"
								placeholder="Số điện thoại" pattern="^[0]\d{9,10}$"
								title="ví dụ: 0369xxx567" required="required" />
							<div class="error">${error_ph }</div>

							<label>Ngày sinh:</label> <input name="birthday" type="date"
								id="mail" placeholder="Ngày sinh" required="required"
								value="<fmt:formatDate pattern="yyyy-MM-dd"
										value="${editor.birthday }" />" />

							<label>Địa chỉ:</label>
							<form:input path="address" type="text" placeholder="Địa chỉ" />

							<span style="padding-right: 30px;">Giới
								Tính:</span>
							<form:radiobutton value="nam" path="gender" required="required" />
							<label style="padding-right: 30px;" under_13" class="light">Nam</label>
							<form:radiobutton value="nu" path="gender" />
							<label for="over_13" class="light">Nữ</label>

							<div class="error">${error }</div>
						</fieldset>
						<button type="submit">Cập nhật</button>
						<a href="admin/editor-info/${editor.username}.htm" type="button"
							class="btn btn-secondary btn-lg btn-block">Hủy</a>
					</form:form>
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