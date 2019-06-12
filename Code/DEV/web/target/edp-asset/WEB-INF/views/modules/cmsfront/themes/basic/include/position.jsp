<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<ul class="breadcrumb">
	<li><strong>当前位置：</strong><a href="${ctx}/index-${site.siteCode}${urlSuffix}">首页</a></li>
	<c:forEach items="${fnc:getCategoryListByCodes(category.parentCodes)}" var="category">
		<c:if test="${category.categoryCode ne '1'}">
			<li><span class="divider">/</span> <a href="${category.url}">${category.categoryName}</a></li>
		</c:if>
	</c:forEach>
	<c:if test="${not empty category}">
		<li><span class="divider">/</span> <a href="${category.url}">${category.categoryName}</a></li>
	</c:if>
</ul>