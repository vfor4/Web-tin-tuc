<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-2">
				<div class="list-group" id="list-tab" role="tablist">
					<a class="list-group-item list-group-item-action"
						href="admin/home.htm" role="tab" aria-controls="home">Quản trị</a>
					<a class="list-group-item list-group-item-action active"
						href="admin/category.htm" >Danh Mục</a>
				</div>
			</div>
			<div class="col-6 bg-dark text-white rounded">
				<h2 class="text-center">Danh Mục</h2>
				<form:form action="admin/add-category.htm" class="form-group"
					modelAttribute="danhMuc" method="POST">
					<div class="form-group">
						<label for="idCate">Mã danh mục:</label>
						<form:input path="maDanhMuc" type="text" class="form-control"
							id="maDanhMuc" placeholder="Nhập mã danh mục" name="maDanhMuc"
							required="required" />

					</div>
					<div class="form-group">
						<label for="pwd">Tên danh mục:</label>
						<form:input path="tenDanhMuc" type="text" class="form-control"
							id="tenDanhMuc" placeholder="Nhập tên danh mục" name="tenDanhMuc"
							required="required" />
					</div>
					<button type="submit" class="btn btn-primary">Thêm</button>
				</form:form>
				 <table class="table table-dark table-hover">
          	<thead>
				<tr>
					<th>Mã danh mục</th>
					<th>Tên danh mục</th>
					<th>Tạo bởi</th>
					<th></th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${categoryList }" var="dm">
					<c:if test="${sessionScope.user.role == false }">
						<c:if test="${sessionScope.user.username == dm.bienTapVien.username }">
					<tr>
						<td>${dm.maDanhMuc}</td>
						<td>${dm.tenDanhMuc }</td>
						<td>${dm.bienTapVien.username }</td>
						<td><a href="admin/del-category/${dm.maDanhMuc}.htm"
							onclick="return confirm('Bạn có chắc muốn xóa?')" class="btn btn-danger">Xóa</a></td>
						<!-- Button trigger modal -->
						<td><button data-idCategory="${dm.maDanhMuc}" value="${dm.maDanhMuc}" class="btn btn-info text-nowrap buttonUpdate">Cập nhật</button></td>
					</tr>
					</c:if>
					</c:if>
					<c:if test="${sessionScope.user.role == true }">
						
					<tr>
						<tr>
						<td>${dm.maDanhMuc}</td>
						<td>${dm.tenDanhMuc }</td>
						<td>${dm.bienTapVien.username }</td>
						<td><a href="admin/del-category/${dm.maDanhMuc}.htm"
							onclick="return confirm('Bạn có chắc muốn xóa?')" class="btn btn-danger">Xóa</a></td>
						<!-- Button trigger modal -->
						<td><td><button data-idCategory="${dm.maDanhMuc}" value="${dm.maDanhMuc}" class="btn btn-info text-nowrap buttonUpdate">Cập nhật</button></td></td>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
			</table>
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
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- modal cập nhật -->
	<div class="modal fade " id="updateModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">

		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">CẬP NHẬT</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="" id="myForm" method="POST">

						<div class="form-row">
							<label for="id" class="col-form-label"><b>Mã Danh
									Mục:</b></label> <input type="text" class="form-control-plaintext ml-2"
								id="id" readonly> <label for="oldName"
								class="col-form-label"><b>Tên Danh Mục:</b> </label> <input
								type="text" class="form-control-plaintext ml-2" id="oldName"
								readonly> <label for="message-text"
								class="col-form-label"><b>Tên Danh Mục Mới:</b></label> <input
								type="text" class="form-control" name="newName" required>
						</div>

						<div class="mt-4">
							<button type="submit" class="btn btn-info btn-lg btn-block">Cập
								Nhật</button>
							<button type="button" class="btn btn-dark btn-lg btn-block"
								data-dismiss="modal">Hủy</button>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Phần script -->
	<script type="text/javascript">
		$("#myModal").modal("${mode}");
	</script>
	<script type="text/javascript">
		$("button.buttonUpdate")
				.click(
						function() {
							$("#updateModal").modal("show");
							var tenDanhMuc = $(this).val();
							var maDanhMuc = $(this).attr('data-idCategory');
							document.getElementById("oldName").value = tenDanhMuc;
							document.getElementById("id").value = maDanhMuc;
							document.getElementById("myForm").action = 'admin/update-category/'
									+ maDanhMuc + '.htm';
						});
	</script>
</body>
</html>
