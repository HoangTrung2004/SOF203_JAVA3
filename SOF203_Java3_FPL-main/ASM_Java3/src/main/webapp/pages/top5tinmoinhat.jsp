<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h3 class="h6 text-center" style="background-color: green ">5 Latest News</h3>
<ul class="list-group list-group-flush">
  <c:forEach var="n" items="${latest5}">
    <li class="list-group-item ps-0">
      <a href="${pageContext.request.contextPath}/newsDetail?id=${n.id}">
        ${n.title}
      </a>
    </li>
  </c:forEach>
</ul>
