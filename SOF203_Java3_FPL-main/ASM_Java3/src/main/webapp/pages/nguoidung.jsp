<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Quản lý Newsletter</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .btn-green { background-color: #28a745; color: white; }
    .btn-yellow { background-color: #ffc107; color: black; }
    .btn-gray { background-color: #6c757d; color: white; }
  </style>
</head>
<body class="p-4">
<div class="container">
  <h2 class="text-center mb-4">Quản lý Newsletter</h2>

  <!-- Form xử lý -->
  <form action="${pageContext.request.contextPath}/admin/nguoidung" method="post" class="mb-4">
    <div class="mb-3">
      <label for="email" class="form-label">Email:</label>
      <input type="email" class="form-control" name="email" id="email" required />
    </div>
    <div class="mb-3">
      <label for="enabled" class="form-label">Trạng thái:</label>
      <select name="enabled" id="enabled" class="form-select">
        <option value="1">Hoạt động</option>
        <option value="0">Ngừng</option>
      </select>
    </div>
    <div class="d-flex gap-2">
      <button type="submit" name="action" value="add" class="btn btn-green">Thêm</button>
      <button type="submit" name="action" value="edit" class="btn btn-yellow">Sửa</button>
      <button type="submit" name="action" value="delete" class="btn btn-danger">Xoá</button>
      <button type="reset" class="btn btn-gray">Reset</button>
    </div>
  </form>

  <!-- Danh sách đã đăng ký -->
  <table class="table table-hover table-bordered align-middle">
    <thead class="table-light">
      <tr>
        <th>Email</th>
        <th>Trạng thái</th>
        <th>Chọn</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach var="sub" items="${subscribers}">
      <tr>
        <td>${sub.email}</td>
        <td>${sub.enabled ? "Hoạt động" : "Ngừng"}</td>
        <td>
          <button type="button"
                  class="btn btn-primary btn-sm"
                  onclick="editSubscriber('${sub.email}', '${sub.enabled ? 1 : 0}')">
            Edit
          </button>
        </td>
      </tr>
    </c:forEach>
    <c:if test="${empty subscribers}">
      <tr>
        <td colspan="3" class="text-center text-muted">Chưa có người đăng ký.</td>
      </tr>
    </c:if>
    </tbody>
  </table>
</div>

<script>
  // Gán dữ liệu từ bảng lên form khi nhấn nút Edit
  function editSubscriber(email, enabled) {
    document.getElementById("email").value = email;
    document.getElementById("enabled").value = enabled;
  }
</script>
</body>
</html>
