<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Đăng nhập</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">
  <style>
    body { background: #f8f9fa; }
    .login-card {
      max-width: 400px; margin: 80px auto; padding: 30px;
      background: white; border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body>
  <div class="login-card">
    <h2 class="text-center mb-4">Đăng nhập</h2>

    <!-- Hiển thị lỗi nếu có -->
    <c:if test="${not empty error}">
      <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
      <div class="mb-3">
        <label for="username" class="form-label">Email</label>
        <input type="text"
               class="form-control"
               id="username"
               name="username"
               value="${cookie.username.value}" 
               required />
      </div>

      <div class="mb-3">
        <label for="password" class="form-label">Mật khẩu</label>
        <input type="password"
               class="form-control"
               id="password"
               name="password"
               value="${cookie.password.value}" 
               required />
      </div>

      <div class="form-check mb-4">
        <input type="checkbox"
               class="form-check-input"
               id="remember"
               name="remember"
               <c:if test="${cookie.remember.value == 'on'}">checked</c:if> />
        <label class="form-check-label" for="remember">Ghi nhớ đăng nhập</label>
      </div>

      <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
    </form>

    <p class="text-center mt-3">
      <a href="${pageContext.request.contextPath}/news/trangchu">&larr; Quay về trang chủ</a>
    </p>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
