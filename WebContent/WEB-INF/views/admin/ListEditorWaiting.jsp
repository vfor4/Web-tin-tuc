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
							<th scope="col">Trạng thái</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listWaiting }" var="user">
							<tr>
								<td>${user.username }</td>
								<td>${user.fullname }</td>
								<td>${user.email }</td>
								<td>${user.phone }</td>
								<td><fmt:formatDate pattern="dd-MM-yyyy"
										value="${user.birthday }" /></td>
								<td>${user.gender }</td>
								<td>${user.address }</td>
								<c:choose>
									<c:when test="${user.editor == true && user.block == false}">
										<td class="alert alert-success" role="alert">Hoạt động</td>
										<td><a
											href="admin/editor-list/${user.username }.htm?block"
											onclick="return confirm('KHÓA biên tập viên này?')"
											class="btn btn-success">Khóa</a></td>
									</c:when>
									<c:when test="${user.editor == false && user.block == false}">
										<td class="alert alert-warning">Chờ kích hoạt</td>
										<td><a
											href="admin/editor-list/${user.username }.htm?accept"
											onclick="return confirm('DUYỆT biên tập viên này?')"
											class="btn btn-success">Duyệt</a></td>
									</c:when>
									<c:when test="${user.editor == true && user.block == true}">
										<td class="alert alert-danger" role="alert">Đã khóa</td>
										<td><a
											href="admin/editor-list/${user.username }.htm?unlock"
											onclick="return confirm('MỞ Khóa biên tập viên này?')"
											class="btn btn-success">Mở khóa</a></td>
									</c:when>
								</c:choose>
<%-- 								<td><a href="admin/editor-list/${user.username }.htm?del" --%>
<!-- 									onclick="return confirm('XÓA biên tập viên này?')" -->
<!-- 									class="btn btn-success">Xóa</a></td> -->

							</tr>
						</c:forEach>
				</table>
</body>
</html>