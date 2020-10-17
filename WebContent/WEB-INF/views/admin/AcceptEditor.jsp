<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-2">
				<div class="list-group" id="list-tab" role="tablist">
					<a class="list-group-item list-group-item-action"
						href="admin/home.htm" role="tab" aria-controls="home">Admin</a>
				</div>
			</div>
			<div class="col-10 rounded">
				<table class="table table-hover ">
					<thead>
						<tr>
							<th scope="col">Tài khoản</th>
							<th scope="col">Họ và tên</th>
							<th scope="col">Email</th>
							<th scope="col">Số điện thoại</th>
							<th scope="col">Ngày sinh</th>
							<th scope="col">Giới tính</th>
							<th scope="col">Địa chỉ</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="user">
							<tr>
								<td>${user.username }</td>
								<td>${user.fullname }</td>
								<td>${user.email }</td>
								<td>${user.phone }</td>
								<td><fmt:formatDate pattern="dd-MM-yyyy"
										value="${user.birthday }" /></td>
								<td>${user.gender }</td>
								<td>${user.address }</td>
								<td><a href="admin/accept-editor/${user.username }.htm"
									onclick="return confirm('Duyệt biên tập viên?')"
									class="btn btn-success">Duyệt</a></td>
							</tr>
						</c:forEach>
				</table>
			</div>
		</div>
	</div>
	<!-- show modal -->
    <div class="modal fade" id="myModal" role="dialog" tabindex="-2" aria-hidden="true">
		<div class="modal-dialog">
		
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
		$("#myModal").modal("${mode}");
	</script>
</body>
</html>