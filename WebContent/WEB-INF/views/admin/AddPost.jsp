<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script src="resources/ckeditor1/ckeditor.js"></script>
<script type="text/javascript" src="ckfinder/ckfinder.js"></script>
<title>Spring MVC</title>
</head>
<body>
			<form action="admin/add-post.htm" method="POST"
				enctype="multipart/form-data">
				<div>Tên danh mục</div>
				<select class="form-control" name="maDanhMuc" required>
					<c:forEach items="${danhMuc }" var="muc">
		
						<option value="${muc.maDanhMuc }">${muc.tenDanhMuc }</option>
					
					</c:forEach>
				</select>
				<div>Tiêu đề</div>
				<input class="form-control" name="tieuDe" placeholder="Tiêu đề" required>
				<div>Mô tả</div>
				<textarea class="form-control" name="moTa" rows="5" cols="20" placeholder="Mô tả" required></textarea>
				<div>Hình mô tả</div>
				<input type="file" name="hinhAnh">
				<div>Nội dung</div>
				<textarea class="form-control" name="noiDung" id="editor" rows="15" cols="80"
					placeholder="Nội dung bài viết"></textarea>
				<button class="btn btn-info btn-block" type="submit">Thêm</button>
				<a class="btn btn-secondary btn-block" type="button" href="admin/home.htm">Hủy</a>
			</form>
	<!-- Modal thông báo lỗi -->
		<script type="text/javascript">
		config = {};
		config.skin = 'kama';
		//config.filebrowserBrowseUrl = "upload.htm";
		CKEDITOR.replace('editor', config);
		var editor = CKEDITOR.replace('editor');
		CKFinder.setupCKEditor(editor,  '<%=request.getContextPath()%>/ckfinder/');
	</script>
</body>
</html>