<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page pageEncoding="utf-8"%>
<table class="table table-dark table-hover ">
            <thead>
              <tr>
                <th scope="col">ID</th>
                <th scope="col">Email</th>
                <th scope="col">Số điện thoại</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach items="${listUser }" var="user">
            <tr>
                <td>${user.maNguoiDangKi }</td>
                <td>${user.email }</td>
                <td>${user.sdt }</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>