<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ page import="java.util.List" %>
<%@ page import="Model.Newsletters" %>
<%@ page import="DAO.NewslettersDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body>
    <c:url var="adminPath" value="/admin"/>
    <div class="container-fluid">

        <!-- HEADER -->
        <div class="row bg-dark text-white" style="height:80px; line-height:80px;">
            <div class="col-1">
                <img alt="logo"
                     src="${pageContext.request.contextPath}/img/logo.jpg"
                     height="60">
            </div>

            <div class="col-10 text-center fs-4">
                <a class="px-3 text-decoration-none text-white"
                   href="${adminPath}/tintuc">Tin tức</a>
                <a class="px-3 text-decoration-none text-white"
                   href="${adminPath}/loaitin">Đăng tin</a>
                <a class="px-3 text-decoration-none text-white"
                   href="${adminPath}/nguoidung">Người dùng</a>
            </div>

            <!-- LOGIN / LOGOUT AREA -->
            <div class="col-1 d-flex justify-content-end align-items-center gap-2">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="text-white small">
                            Xin chào: ${sessionScope.user.fullname}
                        </span>
                        <a href="${pageContext.request.contextPath}/logout">
                            <img src="${pageContext.request.contextPath}/img/logout.png"
                                 width="32" title="Đăng xuất" />
                        </a>
                    </c:when>
                    <c:otherwise>
                        <!-- Gọi LoginServlet thay vì tới JSP trực tiếp -->
                        <a href="${pageContext.request.contextPath}/LoginServlet">
                            <img src="${pageContext.request.contextPath}/img/login.png"
                                 width="32" title="Đăng nhập" />
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- CONTENT -->
        <div class="row" style="min-height:700px;">
            <div class="col-9 p-3">
                <jsp:include page="/pages/${menu}" />
            </div>
        </div>

        <!-- FOOTER -->
        <div class="row bg-dark text-white" style="height:80px; line-height:80px;">
            <div class="col-12 text-center fs-5">
                Welcome: Lê Nguyễn Hoàng Trung
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
