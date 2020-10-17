<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
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
<style type="text/css">
.disable {
	pointer-events: none;
	background: grey;
}

.hinhMoTa {
	height: 300px;
	width: 700px;
}

.btn-hinhMoTa {
	display: block;
}
</style>
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
			<div class="col-10">
				<div class="col-10 bg-dark text-white p-5">
					<form action="admin/update.htm" method="post"
						enctype="multipart/form-data">
						<div>Mã bài viết</div>
						<input name="maBaiViet" value="${baiVietTheoMa.maBaiViet }"
							readonly="readonly">
						<div>Tên danh mục</div>
						<select name="maDanhMuc" class="form-control">
							<c:forEach items="${danhMuc }" var="muc">
								<c:choose>
									<c:when test="${muc.maDanhMuc.equals(maDanhMucBaiViet)}">
										<option label="${muc.tenDanhMuc }" value="${muc.maDanhMuc }"
											selected="selected">
									</c:when>
									<c:otherwise>
										<option label="${muc.tenDanhMuc }" value="${muc.maDanhMuc }">
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>

						<div>Tiêu đề</div>
						<input name="tieuDe" value="${baiVietTheoMa.tieuDe }"
							class="form-control">
						<div>Mô tả</div>
						<textarea class="form-control" name="moTa" rows="5" cols="20">${baiVietTheoMa.moTa }</textarea>
						<div class="hinh">
							<h2 style="display: block;">Hình mô tả</h2>
							<img alt="hình mô tả"
								src="resources/images/${baiVietTheoMa.hinhMoTa }"
								class="hinhMoTa"> <input type="file" name="hinhMoTa"
								class="btn-hinhMoTa">
						</div>
						<div>Nội dung</div>
						<textarea name="noiDung" id="editor" rows="15" cols="80">${baiVietTheoMa.noiDung }</textarea>

						<button class="btn btn-info btn-block">Cập Nhật</button>
					</form>
				</div>
			</div>
		</div>
	</div>
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