<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<style>
.comment-table a:visited {
  color: rgb(75, 237, 243);
}
.comment-table a:hover{ 
	color: rgb(140, 241, 245);
}

</style>
<table class="table table-hover table-dark ">
	<tbody>
		<c:forEach items="${listComment }" var="comment">
			<tr>
				<td class="comment-table">${comment.tenNguoiBinhLuan} đã nhận xét về bài viết: <a class="text-decoration-none" href="post/${comment.baiViet.maBaiViet}.htm" target="_blank">${comment.baiViet.tieuDe }</a>
					<br><fmt:formatDate pattern = "dd-MM-yyyy" 
         value = "${comment.thoiGian }" /> <br> <b>${comment.noiDung }</b>
				</td>
				<td><a class="btn btn-danger d-block"
					href="admin/delete-comment/${comment.idBinhLuan}.htm" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
					<br>
<%-- 				<a class="btn btn-danger d-block" href="admin/delete-spam/${comment.email}.htm" onclick="return confirm('Bạn có chắc muốn xóa tất cả các mail?')">Spam</a> --%>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

