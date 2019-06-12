<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>站点地图</title>
	<%@include file="include/head.jsp" %>
	<meta name="description" content="${site.description}" />
	<meta name="keywords" content="${site.keywords}" />
	<style type="text/css">
		h5.map-title {padding:3px 5px;margin:10px 8px 8px;}
		dl.map{border:1px solid #ddd;border-top:0;margin:10px 8px 8px;}
		dl.map dt{border-top:1px solid #ddd;padding:10px 15px;}
		dl.map dd{margin:10px 30px 20px;}
		dl.map span{border:1px solid #ddd;padding:8px 10px;}
		dl.map span:hover{border:1px solid #bbb;background:#f1f1f1;}
		dl.map span a:hover{text-decoration:none;color:#333;}
	</style>
</head>
<body>
	<%@ include file="include/header.jsp" %>
	<c:forEach items="${fnc:getSiteList()}" var="site">
		<h5 class="map-title">${site.siteName}</h5>
		<dl class="map"><c:forEach items="${fnc:getMainNavList(site.siteCode)}" var="category">
			<dt>
	    		<a href="${category.url}" target="_blank">${category.categoryName}</a>
	    	</dt>
			<dd>
				<c:forEach items="${fnc:getCategoryList(site.siteCode, category.categoryCode, -1, '')}" var="category">
		    		<span><a href="${category.url}" target="_blank">${category.categoryName}</a></span>
				</c:forEach>
			</dd>
		</c:forEach></dl>
	</c:forEach>
	<%@ include file="include/footer.jsp" %>
</body>
</html>