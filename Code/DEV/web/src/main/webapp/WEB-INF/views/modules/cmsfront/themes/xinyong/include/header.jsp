<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<header class="">
	<div class="row clearfix">
		<div class="column container-fluid">
			<div class="skin_blue_05 ">
				<script>
					$(function() {
						$("#slider_3").responSlides({
							auto: true,
							nav: false,
							speed: 500,
							namespace: "callbacks_3",
							before: function() {
								$('.events').append("<li>before event fired.</li>");
							},
							after: function() {
								$('.events').append("<li>after event fired.</li>");
							}
						});

					});
				</script>
				<!-- Slideshow-->
				<div class="callbacks_container_3">
					<ul id="slider_3">
						<li>
							<img src="${ctxStaticTheme}/image/aph.gif" height="160" width="100%" style="background-image: url(${ctxStaticTheme}/image/topbg2.jpg)" alt="" />
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="row clearfix">
		<div class="container">
			<div class="column col-xs-12">
				<div class="skin_blue_05">
					<div class="top_logo">
						<c:choose>
							<c:when test="${not empty site.logo}">
								<img alt="${site.title}" src="${site.logo}" class="container" onclick="location='${ctx}/index-${site.siteCode}${fns:getUrlSuffix()}'" border="0"/>
							</c:when>
							<c:otherwise>
								<h2><a class="brand" href="${ctx}/index-${site.siteCode}${fns:getUrlSuffix()}">${site.title}</a></h2>
							</c:otherwise>
						</c:choose>
						<div class="top_user">
							<a href="#">登录</a> | <a href="#">注册</a></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row nav-bg">
		<div class="container">
			<div class="column col-xs-12">
				<div class="skin_blue_05 ">
					<!--多级导航菜单start-------------------->
					<div class="widget-header">
						<nav id="widget-menu" class="widget-pcmenu">
							<div class="widget-nav clearfix nav-tow">
								<div class="col-xs-2 column ${not empty isIndex && isIndex ? 'active' : ''}">
									<c:set var="mainSiteCode" value="${fns:getConfigDefault('cms.mainSiteCode', '1')}"></c:set>
									<a href="${ctx}/index-${mainSiteCode}${fns:getUrlSuffix()}">${site.siteCode eq mainSiteCode?'首页':'返回主站'}</a>
								</div>
								<c:forEach items="${fnc:getMainNavList(site.siteCode)}" var="category" varStatus="status">
									<c:if test="${status.index lt 6}">
										<c:set var="menuCategoryCode" value=",${category.categoryCode},"/>
										<c:set var="isCurrentMenu" value="${requestScope.category.categoryCode eq category.categoryCode || fn:indexOf(requestScope.category.parentCodes, menuCategoryCode) ge 1}"/>
										<div class="col-xs-2 column ${isCurrentMenu ? 'active' : ''}">
											<a href="${category.url}" target="${category.target}">${category.categoryName}</a>
										</div>
									</c:if>
								</c:forEach>
								<div id="siteSwitch" class="col-xs-2 column ${not empty isIndex && isIndex ? 'active' : ''} dropdown">
									<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="站点">切换站点</a>
									<ul class="dropdown-menu">
										<c:forEach items="${fnc:getSiteList()}" var="site">
											<li><a href="#" onclick="location='${ctx}/index-${site.siteCode}${urlSuffix}'">${site.title}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</nav>
					</div>
					<!--多级导航菜单end-------------------->
				</div>
			</div>
		</div>
	</div>
</header>