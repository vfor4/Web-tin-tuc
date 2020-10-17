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
						href="admin/home.htm" role="tab" aria-controls="home">Quản Lý</a>
				</div>
			</div>
			<div class="col-10 rounded">
				<span>Lọc theo trạng thái: <select id="mySelect"
					onchange="myFunction()">
						<option value="list">Tất cả</option>
						<option value="active">Hoạt động</option>
						<option value="block">Khóa</option>
						<option value="waiting">Đợi duyệt</option>
						
				</select></span>
				<div id="list"></div>
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
					<button type="button" class="btn btn-default" data-dismiss="modal">ĐÓNG</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$("#myModal").modal("${mode}");
	</script>
	<script type="text/javascript">
	 $(document).ready(function() {
		 $('#list').load('admin/editor-list.htm');
	 });
		function myFunction() {
			var x = document.getElementById("mySelect").value;
			$('#list').load('admin/editor-'+x+'.htm');
		}
	</script>
</body>
</html>