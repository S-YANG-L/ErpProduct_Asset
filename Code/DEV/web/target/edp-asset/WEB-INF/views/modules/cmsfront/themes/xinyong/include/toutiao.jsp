<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<div class="column col-xs-6" style="padding-left: 8px">
	<div class="skin_blue_05 ">
		<!-- Nav tabs -->
		<div class="widget-pills">
			<div class="widget-heading clearfix" style="background: transparent">
				<ul class="tab-title clearfix" role="tablist">
					<li role="presentation" class="active">
						<a class="widget-radius-top" href="#top-tab-1" aria-controls="top-tab-1" role="tab" data-toggle="tab">最新动态</a></li>
					<li role="presentation">
						<a class="widget-radius-top" href="#top-tab-2" aria-controls="top-tab-2" role="tab" data-toggle="tab">通知公告</a></li>
				</ul>
			</div>
			<!-- Tab panes -->
			<div class="widget-body">
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="top-tab-1">
						<a class="widget-more pull-right" href="${ctx}/list-kjxw.html" target="_blank">更多</a>
						<ul class="widget-list">
							<c:forEach items="${fnc:getArticleList(site.siteCode, '0', 6, 'orderBy: \"a.create_date desc\"')}" var="a" varStatus="vs">
								<c:if test="${vs.index eq 0}">
									<div class="widget-first">
										<a href="${a.url}">
											<span class="widget-title-nowrap">${a.title}</span>
										</a>
										<span class="widget-dotted ">${fns:abbr(a.description, 50)}
											<a href="${a.url}"> <font>查看详细</font></a>
										</span>
									</div>
								</c:if>
								<c:if test="${vs.index ne 0}">
									<li class="widget-list-item widget-list-icon widget-lineheight">
										<span class="news_other pull-right hidden-xs">${fns:formatDate(a.updateDate,'yyyy-MM-dd')}</span>
										<a style="padding-right:5%" class="widget-title-nowrap" href="${a.url}" title="${a.title}"
											 alt="${a.title}">${a.title}</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div role="tabpanel" class="tab-pane" id="top-tab-2">
						<a class="widget-more pull-right" href="${ctx}/list-tzgg.html" target="_blank">更多</a>
						<ul class="widget-list" style="height: 260px; overflow: hidden">
							<c:forEach items="${fnc:getArticleList(site.siteCode, 'tzgg', 6, 'orderBy: \"a.create_date desc\"')}" var="a" varStatus="vs">
								<c:if test="${vs.index eq 0}">
									<div class="widget-first">
										<a href="${a.url}">
											<span class="widget-title-nowrap">${a.title}</span>
										</a>
										<span class="widget-dotted ">${fns:abbr(a.description, 50)}
											<a href="${a.url}"> <font>查看详细</font></a>
										</span>
									</div>
								</c:if>
								<c:if test="${vs.index ne 0}">
									<li class="widget-list-item widget-list-icon widget-lineheight">
										<span class="news_other pull-right hidden-xs">${fns:formatDate(a.updateDate,'yyyy-MM-dd')}</span>
										<a style="padding-right:5%" class="widget-title-nowrap" href="${a.url}" title="${a.title}"
											 alt="${a.title}">${a.title}</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>