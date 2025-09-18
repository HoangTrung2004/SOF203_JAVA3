<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Đăng Tin Mới</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light py-4">
<div class="container">
  <div class="card shadow-sm">
    <div class="card-header bg-primary text-white">
      <h4 class="mb-0">Đăng Tin Mới</h4>
    </div>
    <div class="card-body">

      <form action="${pageContext.request.contextPath}/admin/saveloaitin" method="post" enctype="multipart/form-data">
        <div class="row mb-3">
          <div class="col-md-6">
            <label class="form-label">Tiêu đề</label>
            <input type="text" name="title" class="form-control" required />
          </div>
          <div class="col-md-6">
            <label class="form-label">Ngày đăng</label>
            <input type="date" name="postedDate" class="form-control" required />
          </div>
        </div>

        <div class="mb-3">
          <label class="form-label">Nội dung</label>
          <textarea name="content" rows="5" class="form-control" required></textarea>
        </div>

        <div class="mb-3">
          <label class="form-label">Ảnh</label>
          <input type="file" name="image" accept="image/*" class="form-control" />
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <label class="form-label">Tác giả</label>
            <select name="author" class="form-select" required>
              <option value="">-- Chọn tác giả --</option>
              <c:forEach var="u" items="${userList}">
                <option value="${u.id}">${u.id} - ${u.fullname}</option>
              </c:forEach>
            </select>
          </div>
          <div class="col-md-6">
            <label class="form-label">Lượt xem</label>
            <input type="number" name="viewCount" class="form-control" value="0" min="0" />
          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <label class="form-label">Mã chuyên mục</label>
            <input type="text" name="categoryId" class="form-control" required />
          </div>
          <div class="col-md-6 d-flex align-items-center mt-4">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" name="home" id="homeCheck" />
              <label class="form-check-label" for="homeCheck">
                Hiển thị trên Trang chủ
              </label>
            </div>
          </div>
        </div>

        <div class="d-flex justify-content-between">
          <button type="submit" class="btn btn-success">Đăng bài</button>
          <a href="${pageContext.request.contextPath}/admin/tintuc" class="btn btn-secondary">Hủy</a>
        </div>
      </form>

    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
