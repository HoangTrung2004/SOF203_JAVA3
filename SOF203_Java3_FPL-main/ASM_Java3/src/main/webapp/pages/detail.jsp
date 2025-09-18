<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <title>${detail.title}</title>
  <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
  <!-- Nếu bạn có header/footer riêng, include ở đây -->
  <%-- <jsp:include page="/WEB-INF/views/header.jsp"/> --%>

  <div class="container mt-4">
    <div class="row">
      <!-- Nội dung chính -->
      <div class="col-lg-9">
        <h1>${detail.title}</h1>
        <p class="text-muted">
          Đăng ngày: ${detail.postedDate}
          &nbsp;|&nbsp;
          Lượt xem: ${detail.viewCount}
        </p>
        <img src="${pageContext.request.contextPath}/${detail.image}"
             class="img-fluid mb-3" alt="${detail.title}"/>
        <div>${detail.content}</div>
      </div>

      <!-- Sidebar -->
      <div class="col-lg-3">
        <div class="mb-3 p-3 bg-success text-white rounded shadow-sm">
          <jsp:include page="/pages/top5viewcount.jsp"/>
        </div>
        <div class="mb-3 p-3 bg-secondary text-white rounded shadow-sm">
          <jsp:include page="/pages/top5tinmoinhat.jsp"/>
        </div>
        <div class="mb-3 p-3 bg-warning text-dark rounded shadow-sm">
          <jsp:include page="/pages/5bangtindaxem.jsp"/>
        </div>
      </div>
    </div>
  </div>

  <%-- <jsp:include page="/WEB-INF/views/footer.jsp"/> --%>
  <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
