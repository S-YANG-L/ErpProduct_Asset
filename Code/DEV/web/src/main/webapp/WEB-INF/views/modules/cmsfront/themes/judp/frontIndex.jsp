<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>首页 - Powered By Heracles</title>
	<%@include file="include/head.jsp" %>
	<!-- Baidu tongji analytics --><script>var _hmt=_hmt||[];(function(){var hm=document.createElement("script");hm.src="//hm.baidu.com/hm.js?82116c626a8d504a5c0675073362ef6f";var s=document.getElementsByTagName("script")[0];s.parentNode.insertBefore(hm,s);})();</script>
	<meta name="description" content="JeeSite ${site.description}" />
	<meta name="keywords" content="JeeSite ${site.keywords}" />
</head>
<body>
	<%@ include file="include/header.jsp" %>
	<div id="container">
		<c:forEach items="${fnc:getCategoryList(site.siteCode, '0', 16, '')}" var="category">
     	<div class="content">
	     	<div class="content_in">
	     		<h2 style="text-align:center;">
		     		<c:choose>
						<c:when test="${not empty category.image}">
							<img src="${category.image}" width="327" height="82" alt="${category.categoryName}" class="img_tt">
						</c:when>
						<c:otherwise>
							<a class="brand" href="${ctx}/index-${site.siteCode}${fns:getUrlSuffix()}">${category.categoryName}</a>
						</c:otherwise>
					</c:choose>
				</h2>
				<div class="con_bot">
					<c:set var="index" value="0"/>
					<c:forEach items="${fnc:getCategoryList(site.siteCode, category.categoryCode, 16, '')}" var="categorylist">
						<c:set var="index" value="${index+1}"/>
						<div class="con_notice ${index % 2 eq 0 ? 'notice_none':''}">
							<p style="border-bottom: #e0dfdf 2px dashed;">
								<em>${categorylist.categoryName}</em><a href="${ctx}/list-${categorylist.categoryCode}${urlSuffix}" class="more">更多&gt;&gt;</a>
							</p>
							<ul class="content_box">
								<c:if test="${categorylist.module eq 'article'}">
									<c:forEach items="${fnc:getArticleList(site.siteCode, categorylist.categoryCode, 3, '')}" var="article">
										<li><a href="${ctx}/view-${article.category.categoryCode}-${article.id}${urlSuffix}">${fns:abbr(article.title,52)}</a><span><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/></span></li>
									</c:forEach>
								</c:if>
								<c:if test="${categorylist.module eq 'link'}">
									<c:forEach items="${fnc:getLinkList(site.siteCode, categorylist.categoryCode, 3, '')}" var="link">
										<li><a href="${link.href}">${fns:abbr(link.title,52)}</a><span><fmt:formatDate value="${link.updateDate}" pattern="yyyy-MM-dd"/></span></li>
									</c:forEach>
								</c:if>
							</ul>
						</div>
						${index % 2 eq 0 ? '<div style="clear: both;"></div>':''}
					</c:forEach>
				</div>
			</div>
     	</div>
		</c:forEach>
	</div>
	<%@ include file="include/footer.jsp" %>
</body>
</html>