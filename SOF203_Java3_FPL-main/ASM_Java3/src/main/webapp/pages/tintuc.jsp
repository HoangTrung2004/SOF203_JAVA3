<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page import="Model.News" %>

<h2>Quản lý Tin tức</h2>
<table class="table table-striped table-bordered">
    <thead>
        <tr>
            <th>ID</th>
            <th>Tiêu đề</th>
            <th>Nội dung</th>
            <th>Ảnh</th>
            <th>Ngày đăng</th>
            <th>Tác giả</th>
            <th>Lượt xem</th>
            <th>Chuyên mục</th>
            <th>Home</th>
            <th>Hành động</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="n" items="${listNews}">
            <tr>
                <td>${n.id}</td>
                <td>${n.title}</td>
                <td style="max-width:300px; white-space:pre-wrap;">
                   <c:choose>
					    <c:when test="${fn:length(n.content) > 100}">
					      ${fn:substring(n.content, 0, 30)}...
					    </c:when>
					    <c:otherwise>
					      ${n.content}
					    </c:otherwise>
  					</c:choose>
                </td>
                <td>
                    <c:if test="${not empty n.image}">
                        <img src="${pageContext.request.contextPath}/img/${n.image}"
                             alt="ảnh tin" width="80" height="80"/>
                    </c:if>
                </td>
                <td>
                    <fmt:formatDate value="${n.postedDate}" pattern="dd/MM/yyyy"/>
                </td>
                <td>${n.author}</td>
                <td>${n.viewCount}</td>
                <td>${n.categoryId}</td>
                <td>
                    <c:choose>
                        <c:when test="${n.home}">✔</c:when>
                        <c:otherwise>✘</c:otherwise>
                    </c:choose>
                </td>
                <td>
                     | 
                    <a href="${pageContext.request.contextPath}/admin/editnews?id=${n.id}">Sửa</a>
                     | 
                    <a href="${pageContext.request.contextPath}/admin/deletenews?id=${n.id}" 
                       onclick="return confirm('Bạn có chắc muốn xóa tin này không?');">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
