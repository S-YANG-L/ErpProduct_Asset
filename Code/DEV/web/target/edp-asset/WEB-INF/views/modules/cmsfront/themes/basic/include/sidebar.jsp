<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<h4>栏目列表</h4>
<ul>
	<%-- 只显示当前栏目  --%>
	<c:if test="${empty categoryList}">
		<c:set var="categoryList" value="${fnc:getCategoryList(site.siteCode, category.parentCode, -1, '')}"/>
	</c:if>
	<c:forEach items="${categoryList}" var="category">
		<li class="${requestScope.category.categoryCode eq category.categoryCode ?'active':''}">
		<c:choose><c:when test="${fn:length(category.categoryName) gt 12}">
			<a href="${category.url}" target="${category.target}" style="line-height:16px;padding-top:3px;">${category.categoryName}</a>
		</c:when><c:otherwise>
			<a href="${category.url}" target="${category.target}" ${fn:length(category.categoryName) gt 10?'style="font-size:12px;"':''}>${category.categoryName}</a>
		</c:otherwise></c:choose></li>
	</c:forEach>
	<%-- 显示顶级栏目下的两级栏目 
	<c:set var="topCategoryCode" value="${category.isRoot ? category.categoryCode : fn:split(category.parentCodes, ',')[1]}"/>
	<c:set var="sidebarCategoryList" value="${fnc:getCategoryList(site.siteCode, topCategoryCode, -1, 'sortGrades:\"1,2\", isTreeSort:1')}"/>
	<c:forEach items="${sidebarCategoryList}" var="category">
		<li class="${requestScope.category.categoryCode eq category.categoryCode ?'active':''}" style="text-indent:${category.sortGrade - 1}em;">
		<c:choose><c:when test="${fn:length(category.categoryName) gt 12}">
			<a href="${category.url}" target="${category.target}" style="line-height:16px;padding-top:3px;">${category.categoryName}</a>
		</c:when><c:otherwise>
			<a href="${category.url}" target="${category.target}" ${fn:length(category.categoryName) gt 10?'style="font-size:12px;"':''}>${category.categoryName}</a>
		</c:otherwise></c:choose></li>
	</c:forEach> --%>
</ul>
<h4>推荐阅读</h4>
<ol>
	<c:forEach items="${fnc:getArticleList(category.site.siteCode, category.categoryCode, 8, 'posid:2, orderBy: \"hits desc\"')}" var="article">
		<li><a href="${ctx}/view-${article.category.categoryCode}-${article.id}${urlSuffix}" style="color:${article.color}" title="${article.title}">${fns:abbr(article.title,16)}</a></li>
	</c:forEach>
</ol>