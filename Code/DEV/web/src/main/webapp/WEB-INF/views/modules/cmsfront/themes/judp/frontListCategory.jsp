<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${category.categoryName} - Powered By Heracles</title>
	<%@include file="include/head.jsp" %>
	<!-- Baidu tongji analytics --><script>var _hmt=_hmt||[];(function(){var hm=document.createElement("script");hm.src="//hm.baidu.com/hm.js?82116c626a8d504a5c0675073362ef6f";var s=document.getElementsByTagName("script")[0];s.parentNode.insertBefore(hm,s);})();</script>
	<meta name="description" content="JeeSite ${site.description}" />
	<meta name="keywords" content="JeeSite ${site.keywords}" />
</head>
<body>
	<%@ include file="include/header.jsp" %>
	<div class="content">
		<div class="content_in">
			<%-- <h2>
				<c:set var="index" value="${fn:length(fnc:getCategoryListByCodes(category.parentCodes))}" />
				<c:set var="num" value="0" />
				<c:forEach items="${fnc:getCategoryListByCodes(category.parentCodes)}" var="category" >
					<c:set var="num" value="${num+1}" />
					<c:if test="${index eq num}">
						<img src="${category.image}" width="327" height="82" alt="${category.categoryName}"
						class="img_tt">
					</c:if>
				</c:forEach>
			</h2> --%>
			<p class="pos">
				当前位置：<a href="${ctx}/index-${site.siteCode}${urlSuffix}">首页</a>
				<c:forEach items="${fnc:getCategoryListByCodes(category.parentCodes)}" var="category">
					&gt;&gt;<a href="${ctx}/list-${category.categoryCode}${urlSuffix}">${category.categoryName}</a>
				</c:forEach>
				<c:if test="${not empty category}">&gt;&gt;<a href="${ctx}/list-${category.categoryCode}${urlSuffix}">${category.categoryName}</a></c:if>
			</p>
			<div class="con_box">
				<div class="con_box_left">
					<h2>栏目列表</h2>
					<c:forEach items="${categoryList}" var="category">
					  	<c:if test="${category.site.siteCode eq site.siteCode}">
							<c:choose><c:when test="${fn:length(category.categoryName) gt 12}">
								<a href="${category.url}" class="${requestScope.category.categoryCode eq category.categoryCode ?'notice_act':''}" style="line-height:16px;padding-top:3px;">${category.categoryName}</a>
							</c:when><c:otherwise>
								<a href="${category.url}" class="${requestScope.category.categoryCode eq category.categoryCode ?'notice_act':''}" ${fn:length(category.categoryName) gt 10?'style="font-size:12px;"':''}>${category.categoryName}</a>
							</c:otherwise></c:choose>
						</c:if>
					</c:forEach>
				</div>
				<div class="con_box_right">
				<p style="border-bottom: #e0dfdf 2px dashed;" class="tit">${category.categoryName}</p>
					
				  <ul class="notice_list">
					<c:if test="${category.site.siteCode eq site.siteCode && category.inList eq '1' && category.module ne ''}">
						<c:if test="${category.module eq 'article'}">
			    			<c:forEach items="${fnc:getArticleList(site.siteCode, category.categoryCode, 10, '')}" var="article">
								<li><a href="${ctx}/view-${article.category.categoryCode}-${article.id}${urlSuffix}" style="color:${article.color}">${fns:abbr(article.title,40)}</a><span><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/></span></li>
							</c:forEach>
						</c:if>
						<c:if test="${category.module eq 'link'}">
			    			<c:forEach items="${fnc:getLinkList(site.siteCode, category.categoryCode, 10, '')}" var="link">
			    				<li><a href="${link.href}" style="color:${link.color}" target="_blank">${fns:abbr(link.title,40)}</a><span><fmt:formatDate value="${link.updateDate}" pattern="yyyy-MM-dd"/></span></li>
							</c:forEach>
						</c:if>
					</c:if>
				</ul>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="include/footer.jsp" %>
</body>
</html>