<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tin tức</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-4">
    <div class="card mb-3">
        <div class="row g-0">
            <div class="col-md-2"> 
    <img src="${pageContext.request.contextPath}/img/${param.image}" alt="Ảnh tin tức"
         class="img-fluid rounded" style="max-width: 160px; max-height: 300px; padding: 20px 0 10px 10px">
</div>

            <div class="col-md-9">
                <div class="card-body">
                    <h5 class="card-title">
                        <a href="${pageContext.request.contextPath}/news/chitiet?id=${param.id}" class="text-decoration-none text-primary">
                            ${param.title}
                        </a>
                    </h5>
                    <p class="card-text"><small class="text-muted">Ngày đăng: ${param.postedDate}, Tác giả: ${param.author}</small></p>
                    <p class="card-text">${fn:substring(param.content, 0, 100)}...</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Thêm Bootstrap script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
