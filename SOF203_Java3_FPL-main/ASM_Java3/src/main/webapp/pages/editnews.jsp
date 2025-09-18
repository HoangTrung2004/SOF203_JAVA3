<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="Model.News" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    News n = (News) request.getAttribute("n");
%>

<h2 class="mb-4">Sửa Tin tức</h2>
<form action="${pageContext.request.contextPath}/admin/editnews"
      method="post"
      enctype="multipart/form-data">
    <!-- Khóa chính -->
    <input type="hidden" name="id" value="${n.id}"/>
    <!-- Lưu tên file cũ nếu không upload mới -->
    <input type="hidden" name="existingImage" value="${n.image}"/>

    <!-- Tiêu đề -->
    <div class="mb-3">
        <label for="title" class="form-label">Tiêu đề</label>
        <input type="text" id="title" name="title"
               value="${n.title}" class="form-control" required/>
    </div>

    <!-- Nội dung -->
    <div class="mb-3">
        <label for="content" class="form-label">Nội dung</label>
        <textarea id="content" name="content"
                  class="form-control" rows="5" required>${n.content}</textarea>
    </div>

    <!-- Ảnh -->
    <div class="mb-3">
        <label class="form-label">Ảnh hiện tại</label><br/>
        <c:if test="${not empty n.image}">
            <img src="${pageContext.request.contextPath}/img/${n.image}"
                 alt="Current Image" width="150" class="mb-2"/>
        </c:if>
        <label for="image" class="form-label">Chọn file ảnh mới (nếu muốn thay)</label>
        <input type="file" id="image" name="image"
               accept="image/*" class="form-control"/>
    </div>

    <!-- Ngày đăng -->
    <div class="mb-3">
        <label for="postedDate" class="form-label">Ngày đăng</label>
        <input type="date" id="postedDate" name="postedDate"
               value="<fmt:formatDate value='${n.postedDate}' pattern='yyyy-MM-dd'/>"
               class="form-control" required/>
    </div>

    <!-- Tác giả -->
    <div class="mb-3">
        <label for="author" class="form-label">Tác giả</label>
        <input type="text" id="author" name="author"
               value="${n.author}" class="form-control" required/>
    </div>

    <!-- Lượt xem -->
    <div class="mb-3">
        <label for="viewCount" class="form-label">Lượt xem</label>
        <input type="number" id="viewCount" name="viewCount"
               value="${n.viewCount}" min="0" class="form-control"/>
    </div>

    <!-- Chuyên mục -->
    <div class="mb-3">
        <label for="categoryId" class="form-label">Chuyên mục (Mã)</label>
        <input type="text" id="categoryId" name="categoryId"
               value="${n.categoryId}" class="form-control" required/>
    </div>

    <!-- Hiển thị Home -->
    <div class="form-check mb-4">
        <input type="checkbox" id="home" name="home"
               class="form-check-input"
               ${n.home ? "checked" : ""}/>
        <label for="home" class="form-check-label">Hiển thị trên Trang chủ</label>
    </div>

    <!-- Nút hành động -->
    <button type="submit" class="btn btn-primary">Lưu</button>
    <a href="${pageContext.request.contextPath}/admin/tintuc"
       class="btn btn-secondary ms-2">Hủy</a>
</form>
