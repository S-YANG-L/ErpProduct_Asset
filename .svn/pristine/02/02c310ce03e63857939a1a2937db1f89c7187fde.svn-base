<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<div class="column col-xs-6" style="padding-right: 8px">
	<div class="skin_blue_05 ">
		<div id="69" class="carousel slide" data-ride="carousel">
			<c:set var="topArticle" value="${fnc:getArticleList(site.siteCode, '0', 7, 'image:1, orderBy: \"hits desc\"')}"/>
			<ol class="carousel-indicators">
				<c:forEach items="${topArticle}" var="a" varStatus="vs">
					<li data-target="#69" data-slide-to="${vs.index}" class="${vs.index eq 0 ? 'active' : ''}"></li>
				</c:forEach>
			</ol>
			<div class="carousel-inner" role="listbox">
				<c:forEach items="${topArticle}" var="a" varStatus="vs">
					<div class="item ${vs.index eq 0 ? 'active' : ''}">
						<a href="${a.url}">
							<img class="carousel-img" src="${a.image}" /></a>
						<div class="carousel-bg"></div>
						<div class="carousel-caption">
							<p><a href="${a.url}">${fns:abbr(a.title,50)}</a></p>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- Controls -->
			<a class="left carousel-control" href="#69" role="button" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">上一张</span></a>
			<a class="right carousel-control" href="#69" role="button" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">下一张</span></a>
		</div>
	</div>
</div>