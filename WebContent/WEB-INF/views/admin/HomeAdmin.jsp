<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<base href="${pageContext.servletContext.contextPath}/">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css">
<script type="text/javascript" src="resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<style type="text/css">
.tieu-de a:link {
  color: rgb(75, 237, 243);
}
.tieu-de a:visited {
  color: rgb(75, 237, 243);
}
.tieu-de a:hover{ 
	color: rgb(140, 241, 245);
}
</style>
<title>Spring MVC</title>
</head>
<body>
 <div class="container-fluid">
    <div class="row">
      <div class="col-2">
        <div class="list-group" id="list-tab" role="tablist">
        
          <a class="list-group-item list-group-item-action active"
            href="admin/home.htm" role="tab" aria-controls="home">Bài Viết</a>  
          <a class="list-group-item list-group-item-action" id="list-profile-list" data-toggle="list"
            href="#list-profile" role="tab" aria-controls="profile">Thêm Bài Viết</a>
                 <c:if test="${sessionScope.user.role == true }">
          <a class="list-group-item list-group-item-action" id="list-messages-list" data-toggle="list"
            href="#list-messages" role="tab" aria-controls="messages">Danh sách đăng kí mail</a>
            </c:if>
            <c:if test="${sessionScope.user.role == true }">
          <a class="list-group-item list-group-item-action" id="list-settings-list" data-toggle="modal"
            href="#sendMail" role="tab" aria-controls="settings">Gửi mail</a>  
              </c:if>
          <a class="list-group-item list-group-item-action"
        	 href="admin/category.htm">Quản lý danh mục</a>
      		<c:if test="${sessionScope.user.role == true }">
        	 <a class="list-group-item list-group-item-action"
        	 href="admin/editor-manager.htm">Danh sách biên tập viên</a>
        	 </c:if>
        	 
        	 <a class="list-group-item list-group-item-action"
        	 href="admin/editor-info/${sessionScope.user.username }.htm">Thông tin tài khoản</a>

          <a class="list-group-item list-group-item-action" id="list-comment-list" data-toggle="list"
        	 href="#list-comment" role="tab" aria-controls="comment">Nhận xét</a> 
          <a class="list-group-item list-group-item-action" 
        	 href="admin/logout.htm" role="tab" aria-controls="comment" onclick="return confirm('Bạn muốn đăng xuất?')">Đăng xuất</a>
        	 
        </div>
      </div>
      
      <div class="col-10">
       <div class="col-10 bg-dark text-white p-2">
        <div class="tab-content" id="nav-tabContent">
          <div class="tab-pane fade show  active" id="list-post" role="tabpanel" aria-labelledby="list-post-list">
          <table class="table table-dark table-hover">
          	<thead>
				<tr>
					<th>Mã Bài Viết</th>
					<th>Danh Mục</th>
					<th>Tiêu Đề</th>
					<th>Thời Gian</th>
					<th>Tạo Bởi </th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${danhSachBaiViet }" var="bv">
					<c:if test="${sessionScope.user.role == false }">
						<c:if test="${sessionScope.user.username == bv.bienTapVien.username }">
					<tr>
						<td>${bv.maBaiViet}</td>
						<td>${bv.danhMuc.tenDanhMuc }</td>
						<td class="tieu-de"><a target="_blank" class="text-decoration-none" href="post/${bv.maBaiViet}.htm">${bv.tieuDe }</a></td>
						<td style="width: 100px;"><fmt:formatDate pattern = "dd-MM-yyyy" 
         value = "${bv.thoiGian }"/></td>
         				<td class="tieu-de"><a href="#">${bv.bienTapVien.username}</a> </td>
						<!-- Button trigger modal -->
						<td><a href="admin/delete/${bv.maBaiViet}.htm"
							onclick="return confirm('Bạn có chắc muốn xóa?')" class="btn btn-danger">Xóa</a></td>
						<!-- Button trigger modal -->
						<td><a href="admin/update/${bv.maBaiViet}.htm" class="btn btn-info text-nowrap">Cập nhật</a></td>
					</tr>
					</c:if>
					</c:if>
					<c:if test="${sessionScope.user.role == true }">
						
					<tr>
						<td>${bv.maBaiViet}</td>
						<td>${bv.danhMuc.tenDanhMuc }</td>
						<td class="tieu-de"><a target="_blank" class="text-decoration-none" href="post/${bv.maBaiViet}.htm">${bv.tieuDe }</a></td>
						<td style="width: 100px;"><fmt:formatDate pattern = "dd-MM-yyyy" 
         value = "${bv.thoiGian }"/></td>
         				<td class="tieu-de"><a href="#">${bv.bienTapVien.username}</a> </td>
						<!-- Button trigger modal -->
						<td><a href="admin/delete/${bv.maBaiViet}.htm"
							onclick="return confirm('Bạn có chắc muốn xóa?')" class="btn btn-danger">Xóa</a></td>
						<!-- Button trigger modal -->
						<td><a href="admin/update/${bv.maBaiViet}.htm" class="btn btn-info text-nowrap">Cập nhật</a></td>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
			</table>
          </div>
          
          <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">
          	<jsp:include page="AddPost.jsp"></jsp:include>
          </div>
          
          <div class="modal fade text-dark"id="sendMail" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle"
    		aria-hidden="true" >
    		<jsp:include page="FormSendMail.jsp"></jsp:include>
    	  </div>
         	
          <div class="tab-pane fade" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">
          	<jsp:include page="ListUser.jsp"></jsp:include>
          </div>
          
          <div class="tab-pane fade" id="list-comment" role="tabpanel" aria-labelledby="list-comment-list">
             <jsp:include page="Comment.jsp"></jsp:include>
 		  </div>
 		  

        </div>
        </div>
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
	 <!-- Phần script -->
	<script type="text/javascript">
		$(".list-group a:eq(3)").click(function() {
			$(this).addClass('active').siblings().removeClass('active');
		});
	</script>
	<script type="text/javascript">
		$("#myModal").modal("${mode}");
	</script>
	<script type="text/javascript">
		(function() {
			'use strict';
			window.addEventListener('load',
					function() {
						// Get the forms we want to add validation styles to
						var forms = document
								.getElementsByClassName('needs-validation');
						// Loop over them and prevent submission
						var validation = Array.prototype.filter.call(forms,
								function(form) {
									form.addEventListener('submit', function(
											event) {
										if (form.checkValidity() === false) {
											event.preventDefault();
											event.stopPropagation();
										}
										form.classList.add('was-validated');
									}, false);
								});
					}, false);
		})();
	</script>

</body>
</html>