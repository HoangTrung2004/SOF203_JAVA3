<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
</head>
<style>
	.news-item {
    display: flex;
    margin-bottom: 15px;
    align-items: center;
    min-height: 100px; /* Đảm bảo các phần tử có cùng chiều cao */
}

.news-item .image-box {
    width: 80px;
    height: 80px;
    background-color: #6699cc;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
}

.news-item .text-box {
    margin-left: 10px;
}

.news-item a {
    color: blue;
    font-weight: bold;
    font-size: 16px;
    text-decoration: none;
}
</style>
<body>
	  <h3>Trang chủ</h3>
	Số tin: ${lNews.size()} <br>
	
	 <c:forEach var="news" items="${lNews}">
	<jsp:include page="/pages/trangmoi.jsp">
		<jsp:param value="${news.id}" name="id"/>
		<jsp:param value="${news.title}" name="title"/>
		<jsp:param value="${news.content}" name="content"/>
		<jsp:param value="${news.image}" name="image"/>
		<jsp:param value="${news.postedDate}" name="postedDate"/>
		<jsp:param value="${news.author}" name="author"/>
		<jsp:param value="${news.viewCount}" name="viewCount"/>
		<jsp:param value="${news.categoryId}" name="categoryId"/>
		<jsp:param value="${news.home}" name="home"/>
	</jsp:include>
</c:forEach>

       
</body>
</html>