<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<title>Spring MVC</title>
<style type="text/css">
.logo_title {
	color: white;
	font-size: 20px;
}

.card {
	width: 50%;
	margin-top: 150px;
	outline: 3px solid green !important;
}

.card-header, .card {
	background-color: #3b4855 !important;
}

.message {
	color: red;
	font-style: italic;
}

body {
	background-image: url('resources/images/background.jpg');
	/* 	background-color: gray !important; */
}

.btn {
	margin: auto;
	width: 50%;
	border: 3px solid green;
	padding: 10px
}

input:focus {
	outline: 3px solid green !important;
	box-shadow: 0 0 0 0 !important;
}
</style>
</head>
<body>

	<div class="container">
		<div class="card card-login mx-auto text-center bg-dark">
			<div class="card-header mx-auto bg-dark">
				<span> <img src="resources/images/administrator.png"
					class="w-75" alt="Logo">
				</span><br /> <span class="logo_title mt-5"><b>ĐĂNG NHẬP</b>
				</span>

			</div>
			<div class="card-body">
				<form action="admin.htm" method="POST">
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-user"></i></span>
						</div>
						<input type="text" name="username"
							class="form-control" placeholder="Tài khoản" required="required"></input>
					</div>
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-key"></i></span>
						</div>
						<input name="password" type="password" id="myPwd" class="form-control" placeholder="Mật khẩu" required="required"></input>
					<div style="position:relative; margin-top:0px; ">
					 </div>
					</div>
					 <div class="input-group form-group">			
					 	<input  type="checkbox" onclick="myFunction()"/>
					 	<label>Xem mật khẩu</label>
					 </div>
					</div>
					<div class="message">${error_b }</div>
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><img alt="captcha"
								src="captcha.htm"></span>
						</div>
						<input type="number" name="captcha" placeholder="Nhập captcha"
							class="form-control" required="required"></input>
					</div>
					<div class="message">${error_c }</div>
					
					<div class="form-group">
						<button type="submit" class="btn btn-success">ĐĂNG NHẬP</button>
					</div>

				</form>
				<a href="forgotPassword.htm">Quên mật khẩu?</a>
			</div>
		</div>
	</div>
	<!-- Modal thông báo lỗi -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">THÔNG BÁO</h4>
				</div>
				<div class="modal-body">
					<p>${message }</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$("#myModal").modal("${method}");
	</script>
	<script>
function myFunction() {
  var x = document.getElementById("myPwd");
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
}
</script>
</body>
</html>