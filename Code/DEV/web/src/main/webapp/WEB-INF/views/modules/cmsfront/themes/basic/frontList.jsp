<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${category.categoryName}</title>
	<%@include file="include/head.jsp" %>
	<meta name="description" content="${category.description}" />
	<meta name="keywords" content="${category.keywords}" />
</head>
<body>
	<%@ include file="include/header.jsp" %>
	<div class="row">
	   <div class="span2">
		  <%@ include file="include/sidebar.jsp" %>
	   </div>
	   <div class="span10">
		  <%@ include file="include/position.jsp" %>
	   </div>
       <div class="span10">
		  <h4>${category.categoryName}</h4>
		  <c:if test="${category.module eq 'article'}">
			<ul><c:forEach items="${page.list}" var="article">
				<li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,96)}</a></li>
			</c:forEach></ul>
		  </c:if>
		  <c:if test="${category.module eq 'link'}">
			<ul><c:forEach items="${page.list}" var="link">
				<li><span class="pull-right"><fmt:formatDate value="${link.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${link.url}" target="_blank" style="color:${link.color}">${fns:abbr(link.title,96)}</a></li>
			</c:forEach></ul>
		  </c:if>
		  <div class="pagination">${page}</div>
		  <script type="text/javascript">
			function page(n,s){
				location="${ctx}/list-${category.categoryCode}${urlSuffix}?pageNo="+n+"&pageSize="+s;
			}
		  </script>
  	  </div>
	</div>
	<%@ include file="include/footer.jsp" %>
</body>
</html>