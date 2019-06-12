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
	      <c:set var="index" value="1"/>
		  <c:forEach items="${categoryList}" var="category">
			<c:if test="${category.inList eq '1' && category.module ne ''}">
				<c:set var="index" value="${index+1}"/>
				${index % 2 eq 0 ? '<div class="row">':''}
		    	<div class="span5">
		    		<h4><small><a href="${category.url}" class="pull-right">更多&gt;&gt;</a></small>${category.categoryName}</h4>
					<c:if test="${category.module eq 'article'}">
		    			<ul><c:forEach items="${fnc:getArticleList(site.siteCode, category.categoryCode, 15, '')}" var="article">
							<li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,39)}</a></li>
						</c:forEach></ul>
					</c:if>
					<c:if test="${category.module eq 'link'}">
		    			<ul><c:forEach items="${fnc:getLinkList(site.siteCode, category.categoryCode, 15, '')}" var="link">
							<li><span class="pull-right"><fmt:formatDate value="${link.updateDate}" pattern="yyyy.MM.dd"/></span><a target="_blank" href="${link.url}" style="color:${link.color}">${fns:abbr(link.title,39)}</a></li>
						</c:forEach></ul>
					</c:if>
		    	</div>
		    	${index % 2 ne 0 ? '</div>':''}
			</c:if>
		  </c:forEach>
		  ${index % 2 eq 0 ? '</div>':''}<%-- 如果最后一个索引为基数，则补一个div结束标记 --%>
	   </div>
	</div>
	<%@ include file="include/footer.jsp" %>
</body>
</html>