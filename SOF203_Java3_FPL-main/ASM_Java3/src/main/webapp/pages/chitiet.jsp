<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết bài viết</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-4">
    <h2 class="mb-3 text-primary">${news.title}</h2>
    <p class="text-muted">
        Ngày đăng: ${news.postedDate} | Tác giả: ${news.author} | Lượt xem: ${news.viewCount}
    </p>

    <img src="${pageContext.request.contextPath}/img/${news.image}" 
         alt="Ảnh bài viết" class="img-fluid rounded mb-3" style="max-height: 400px;">

    <div class="content">
        <p style="text-align: justify;">
            ${news.content}
        </p>
    </div>

    <a href="${pageContext.request.contextPath}/news/trangchu" class="btn btn-secondary mt-3">← Quay về trang chủ</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
