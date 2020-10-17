<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<base href="${pageContext.servletContext.contextPath}/">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css">
<script type="text/javascript" src="resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<title>Spring MVC</title>
</head>
<body>
<!-- Button trigger modal -->

  <!-- Modal -->
  
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLongTitle">Gửi mail</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form class="was-validated" action="admin/send-mail.htm" method ="POST">
            <label for="select-form">Hình thức gửi:<span style="margin-left:490px;">Trường có <img alt="" src="resources/images/alert.png"> là bắt buộc</span></label>
            <select id="select-form" class="custom-select"  name="form" onchange="formFunction()" required>
              <option value="">Chọn...</option>
              <option value="everyone">Tất cả</option>
              <option value="individual">Cá nhân</option>
            </select>

            <br>

            <label for="select-to">Đến</label>
            <select id="select-to" class="custom-select" name="mailAdress" required>
              <option value="">Chọn...</option>
              <c:forEach items="${listUser }" var="user">
              	<option value="${user.email }">${user.email }</option>
              </c:forEach>
            </select>

            <label for="validationInput">Nhập định danh</label>
            <input class="form-control is-invalid" id="validationInput" name="name"  required></input>

			<label for="validationInput">Nhập tiêu đề</label>
            <input class="form-control is-invalid" id="validationInput" name="subject"  required></input>	
				
            <label for="validationTextarea">Textarea</label>
            <textarea class="form-control is-invalid" id="validationTextarea" rows="10" name="body" required></textarea>
			
            <br>
            <div class="row">
              <div class="col-8 col-sm-6">
                <button class="btn btn-info btn-lg btn-block">Gửi</button>
              </div>
              <div class="col-8 col-sm-6">
                <button type="button" class="btn btn-secondary btn-lg btn-block" data-dismiss="modal" style="float: right;">Đóng</button>
              </div>
            </div>       
          </form>      
        </div>
      </div>
    </div>
<script type="text/javascript">
function formFunction() {
    var str1 = document.getElementById("select-form").value;
    if (str1.localeCompare("everyone") == 0) {
      document.getElementById("select-to").disabled = true;
      document.getElementById("select-to").required = false;
    }
    if (str1.localeCompare("individual") == 0){
    	document.getElementById("select-to").disabled = false;  	
    }
  }</script>
</body>
</html>