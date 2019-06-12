<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<footer>
	<div class="row " style="margin-top: 15px; background: #045fae">
		<div class="container" style="">
			<div class="column col-xs-12" style="">
				<div class="skin_blue_05 ">
					<div class="footer_nav">
						<a href="${ctx}/guestbook" target="_blank">公共留言</a> &nbsp; | &nbsp;
						<a href="${ctx}/search" target="_blank">全站搜索</a> &nbsp; | &nbsp;
						<a href="${ctx}/map-${site.siteCode}${fns:getUrlSuffix()}" target="_blank">站点地图</a> &nbsp; | &nbsp;
						<a href="mailto:thinkgem@163.com">技术支持</a>  &nbsp; <br/>
						${fns:getDate('yyyy年MM月dd日 E')} &nbsp; <a href="${pageContext.request.contextPath}${fns:getAdminPath()}"
							target="_blank">进入管理系统</a> ${site.copyright}
					</div>
				</div>
			</div>
		</div>
	</div>
</footer>
<script src="${ctxStatic}/ueditor/1.4.3/ueditor.parse.min.js" type="text/javascript"></script>
<script>uParse('.uparse', {ctxStatic: '${ctxStatic}', rootPath: '${ctxStatic}/ueditor/1.4.3/',
	chartContainerHeight:500,'liiconpath':'${ctxStatic}/ueditor/1.4.3/themes/ueditor-list/'})</script>
<script src="${ctxStatic}/modules/cms/front/common/visitLog.min.js" type="text/javascript"></script>
<script>(function(){visitLogRecord('${pageContext.request.contextPath}${fns:getFrontPath()}','${site.siteCode}','${site.siteName}',
		'${category.categoryCode}','${category.categoryName}','${article.id}','${article.corpCode}','${article.corpName}')})()</script>