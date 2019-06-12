<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
	<div id="wrap">
		<!-- header -->
		<div id="header">
			<div class="header_in">
				<!-- logo start -->
				<c:choose>
					<c:when test="${not empty site.logo}">
						<img alt="${site.title}" src="${site.logo}" class="logo"
							onclick="location='${ctx}/index-${site.siteCode}${fns:getUrlSuffix()}'">
					</c:when>
					<c:otherwise>
						<h1> &nbsp; <a class="brand"
							href="${ctx}/index-${site.siteCode}${fns:getUrlSuffix()}">${site.title}</a></h1>
					</c:otherwise>
				</c:choose>
				<!-- logo end -->
				<div class="nav">
					<a class="${not empty isIndex && isIndex ? 'nav_act' : ''}" href="${ctx}/index-1${fns:getUrlSuffix()}"><span>${site.siteCode eq '1'?'首　 页':'返回主站'}</span></a>
					<c:forEach items="${fnc:getMainNavList(site.siteCode)}"
						var="category" varStatus="status">
						<c:if test="${status.index lt 6}">
							<c:set var="menuCategoryCode" value=",${category.categoryCode}," />
							<a class="${requestScope.category.categoryCode eq category.categoryCode || fn:indexOf(requestScope.category.parentCodes, menuCategoryCode) ge 1 ? 'nav_act' : ''}"
							 href="${category.url}" target="${category.target}"><span>${category.categoryName}</span></a>
						</c:if>
					</c:forEach>
				</div>
				<form class="top_search" action="${ctx}/search" method="get">
	              	<input type="text" name="q" placeholder="" value="${empty q ? '请填写搜索关键字' : q}" 
	              		onfocus="if(this.value='请填写搜索关键字') this.value=''">
	            </form>
				<!--/.nav-collapse -->
			</div>
		</div>
		<!-- header end -->
		
		<!-- banner -->
		<!-- 只允许首页显示banner -->
		<c:if test="${isIndex}">
		<div id="banner">
          <div class="banner_in">
              <div class="banner_box">
                    <p class="banner_ft_1">Ecode JUDP平台</p>
                    <p class="banner_ft_2">让开发平台更智能</p>
                    <p class="banner_ft_3">专注政务软件开发领导者</p>
                    <p class="banner_ft_4">The focus of software development leader</p>
              </div>
              <a href="${pageContext.request.contextPath}${fns:getAdminPath()}" class="banner_box_btn">立即体验</a>
              <em class="banner_img"><img src="${ctxStaticTheme}/img/img_03.png" width="516" height="294"></em>
           </div> 
		</div>
		</c:if>
		<!-- banner end -->