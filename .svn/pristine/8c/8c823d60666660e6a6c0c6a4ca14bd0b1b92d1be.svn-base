<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>站点地图 - Powered By Heracles</title>
	<%@include file="include/head.jsp" %>
	<!-- Baidu tongji analytics --><script>var _hmt=_hmt||[];(function(){var hm=document.createElement("script");hm.src="//hm.baidu.com/hm.js?82116c626a8d504a5c0675073362ef6f";var s=document.getElementsByTagName("script")[0];s.parentNode.insertBefore(hm,s);})();</script>
	
	<meta name="description" content="JeeSite ${site.description}" />
	<meta name="keywords" content="JeeSite ${site.keywords}" />
</head>
<body>
	<%@ include file="include/header.jsp" %>
	<style type="text/css">
		dl.map{border:1px solid #efefef;border-top:0;margin:10px 8px 8px;}
		dl.map dt{border-top:1px solid #efefef;padding:10px 15px;}
		dl.map dd{margin:10px 30px 20px;}
		dl.map span{border:1px solid #efefef;padding:8px 10px;}
		dl.map span:hover{border:1px solid #bbb;}
		dl.map span a:hover{text-decoration:none;color:#333;}
	</style>

	<dl class="map"><c:forEach items="${fnc:getMainNavList(site.siteCode)}" var="category">
		<dt>
			<c:choose>
    			<c:when test="${not empty category.href}">
	    			<c:choose>
		    			<c:when test="${fn:indexOf(category.href, '://') eq -1}"><c:set var="url" value="${ctx}${category.href}"/></c:when>
		    			<c:otherwise><c:set var="url" value="${category.href}"/></c:otherwise>
		    		</c:choose>
    			</c:when>
    			<c:otherwise><c:set var="url" value="${ctx}/list-${category.categoryCode}${urlSuffix}"/></c:otherwise>
    		</c:choose>
    		<a href="${url}" target="_blank">${category.categoryName}</a>
		<dd>
			<c:forEach items="${fnc:getCategoryList(site.siteCode, category.categoryCode, -1, '')}" var="category">
				<c:choose>
	    			<c:when test="${not empty category.href}">
		    			<c:choose>
			    			<c:when test="${fn:indexOf(category.href, '://') eq -1}"><c:set var="url" value="${ctx}${category.href}"/></c:when>
			    			<c:otherwise><c:set var="url" value="${category.href}"/></c:otherwise>
			    		</c:choose>
	    			</c:when>
	    			<c:otherwise><c:set var="url" value="${ctx}/list-${category.categoryCode}${urlSuffix}"/></c:otherwise>
	    		</c:choose>
	    		<span><a href="${url}" target="_blank">${category.categoryName}</a></span>
			</c:forEach>
		</dd>
	</c:forEach></dl>
	<%@ include file="include/footer.jsp" %>
</body>
</html>