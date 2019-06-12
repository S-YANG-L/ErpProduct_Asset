<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container">
		<c:choose>
			<c:when test="${not empty site.logo}">
				<img alt="${site.title}" src="${site.logo}" class="container" onclick="location='${ctx}/index-${site.siteCode}${fns:getUrlSuffix()}'">
			</c:when>
			<c:otherwise><a class="brand" href="${ctx}/index-${site.siteCode}${fns:getUrlSuffix()}">${site.title}</a></c:otherwise>
		</c:choose>
		<div class="nav-collapse">
			<ul id="main_nav" class="nav nav-pills">
				<li class="${not empty isIndex && isIndex ? 'active' : ''}">
					<c:set var="mainSiteCode" value="${fns:getConfigDefault('cms.mainSiteCode', '1')}"></c:set>
					<a href="${ctx}/index-${mainSiteCode}${fns:getUrlSuffix()}"><span>${site.siteCode eq mainSiteCode?'首　 页':'返回主站'}</span></a>
				</li>
				<c:forEach items="${fnc:getMainNavList(site.siteCode)}" var="category" varStatus="status">
					<c:if test="${status.index lt 6}">
						<c:set var="menuCategoryCode" value=",${category.categoryCode},"/>
						<c:set var="isCurrentMenu" value="${requestScope.category.categoryCode eq category.categoryCode || fn:indexOf(requestScope.category.parentCodes, menuCategoryCode) ge 1}"/>
						<li class="${isCurrentMenu ? 'active' : ''}"><a href="${category.url}" target="${category.target}"><span>${category.categoryName}</span></a></li>
					</c:if>
				</c:forEach>
				<li id="siteSwitch" class="dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="站点"><i class="icon-retweet"></i></a>
					<ul class="dropdown-menu">
						<c:forEach items="${fnc:getSiteList()}" var="site"><li><a href="#" onclick="location='${ctx}/index-${site.siteCode}${urlSuffix}'">${site.title}</a></li></c:forEach>
					</ul>
				</li>
				<li id="themeSwitch" class="dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="主题切换"><i class="icon-th-large"></i></a>
					<ul class="dropdown-menu">
						<li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/default?url='+location.href">默认主题</a></li>
						<li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/cerulean?url='+location.href">天蓝主题</a></li>
						<li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/readable?url='+location.href">橙色主题</a></li>
						<li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/united?url='+location.href">红色主题</a></li>
						<li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/flat?url='+location.href">Flat主题</a></li>
					</ul>
					<!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]-->
				</li>
			</ul>
			<form class="navbar-form pull-right" action="${ctx}/search" method="get">
				<input type="text" name="q" maxlength="20" style="width:70px;" placeholder="全站搜索..." value="${q}">
			</form>
			</div><!--/.nav-collapse -->
		</div>
	</div>
</div>
<div class="container">
	<div class="content">
		<div class="clearfix"></div>