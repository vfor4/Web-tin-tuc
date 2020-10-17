<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
	<div class="media mb-4">
		<img class="d-flex mr-3 rounded-circle" src="resources/images/cmt.png"
			alt="people" style="height: 60px; width: 60px;">
		<div class="media-body">
			<h5 class="mt-0">${cmt.tenNguoiBinhLuan }
				<b>Lúc</b> <fmt:formatDate pattern = "dd-MM-yyyy" 
         value = "${cmt.thoiGian }"/>
			</h5>
			<div>${cmt.noiDung }</div>
		</div>
	</div>
</body>
</html>