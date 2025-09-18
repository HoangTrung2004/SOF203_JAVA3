<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assignment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .nav-link { transition: background-color 0.3s ease, color 0.3s ease; }
        .nav-link:hover { background-color: #007bff; color: white !important; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container-fluid px-0">
        <!-- Header -->
        <div class="row align-items-center bg-light shadow-sm py-3 px-3">
            <!-- Logo dẫn đến LoginServlet -->
            <div class="col-md-1 text-center">
                <a href="${pageContext.request.contextPath}/LoginServlet">
                    <img src="${pageContext.request.contextPath}/img/logo.jpg"
                         alt="logo" class="img-fluid rounded-circle" style="max-height:60px;">
                </a>
            </div>

            <!-- Menu chính -->
            <div class="col-md-10">
                <nav class="nav justify-content-center fs-5">
                    <a class="nav-link text-dark"
                       href="${pageContext.request.contextPath}/news/trangchu">Trang chủ</a>
                    <a class="nav-link text-dark"
                       href="${pageContext.request.contextPath}/news/vanhoa">Văn hóa</a>
                    <a class="nav-link text-dark"
                       href="${pageContext.request.contextPath}/news/phapluat">Pháp luật</a>
                    <a class="nav-link text-dark"
                       href="${pageContext.request.contextPath}/news/thethao">Thể thao</a>
                </nav>
            </div>

            <!-- Login / Logout -->
            <div class="col-md-1 text-end">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="me-2 small text-dark">👤 ${sessionScope.user.fullname}</span>
                        <a href="${pageContext.request.contextPath}/logout" title="Đăng xuất">
                            <img src="${pageContext.request.contextPath}/img/logout.png"
                                 alt="Logout" style="height:30px;" class="me-2"/>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/LoginServlet" title="Đăng nhập">
                            <img src="${pageContext.request.contextPath}/img/user.png"
                                 alt="Login" style="height:30px;" class="me-2"/>
                        </a>
                    </c:otherwise>
                </c:choose>
                
            </div>
        </div>

        <!-- Nội dung chính -->
        <div class="row my-4 px-3">
            <div class="col-lg-9 mb-3">
                <jsp:include page="/pages/${page}" flush="true" />
            </div>
            <div class="col-lg-3">
                <!-- Sidebar -->
                <div class="mb-3 p-3 rounded shadow-sm">
                    <jsp:include page="/pages/top5viewcount.jsp" />
                </div>
                <div class="mb-3 p-3 rounded shadow-sm">
                    <jsp:include page="/pages/top5tinmoinhat.jsp" />
                </div>
                <div class="mb-3 p-3 rounded shadow-sm">
                    <jsp:include page="/pages/5bangtindaxem.jsp" />
                </div>
                <!-- Newsletter -->
                <form action="${pageContext.request.contextPath}/news/trangchu"
                      method="post" class="input-group">
                    <input type="email" name="newsletter"
                           placeholder="Nhập email nhận tin" class="form-control" />
                    <button class="btn btn-primary" type="submit">Đăng ký</button>
                </form>
                <c:if test="${not empty message}">
                    <div class="alert alert-info mt-2">${message}</div>
                </c:if>
            </div>
        </div>

        <!-- Footer -->
        <div class="row bg-dark text-white text-center py-4">
            <div class="col fs-4">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        Welcome: ${sessionScope.user.fullname}
                    </c:when>
                    <c:otherwise>
                        Chào mừng bạn đến với trang tin
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
