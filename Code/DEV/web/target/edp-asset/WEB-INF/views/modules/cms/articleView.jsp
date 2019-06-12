<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value=""/>
<sys:header title="${article.title} - ${category.categoryName}" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<!-- <div class="portlet-title">
		<div class="caption"><i class="fa fa-file-text-o"></i>文章详情</div>
	</div> -->
	<div class="portlet-body form">
		<div id="inputForm" class="form-horizontal">
			<div class="form-body content-view">
				<h2 class="title">${article.title}</h2>
				<c:if test="${not empty article.description}">
					<blockquote>${fns:text('摘要')}：${article.description}</blockquote>
				</c:if>
				<div id="article-content" class="content-text uparse">
					<c:if test="${not empty article.href}">&nbsp;&nbsp;&nbsp;&nbsp;${fns:text('外部链接')}：<a href="${article.href}">${article.href}</a><br/></c:if>
					${not empty article.articleData.content ? article.articleData.content : '&nbsp;&nbsp;&nbsp;&nbsp;暂无内容，请稍后再试！'}
				</div>
				<ul class="content-info">
					<li><i class="fa fa-list-alt"></i>${fns:text('栏目')}：${article.category.categoryName}</li>
					<li><i class="fa fa-user"></i>${fns:text('创建者')}：${article.createByName} &nbsp;<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm"/></li>
<%-- 					<li><i class="fa fa-calendar"></i>创建时间： <fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm"/></li> --%>
					<li><i class="fa fa-user"></i>${fns:text('更新者')}：${article.updateByName} &nbsp;<fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd HH:mm"/></li>
<%-- 					<li><i class="fa fa-calendar"></i>更新时间： <fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd HH:mm"/></li> --%>
					<li title="${not empty article.copyfrom ? '转自：' : ''}${article.copyfrom}"><i class="fa fa-comments"></i>${fns:text('来源')}：${fns:getDictLabel(article.source, 'cms_source', '')}</li>
					<li><i class="fa fa-tags"></i>${fns:text('关键词')}：${not empty article.keywords ? article.keywords : '无'}</li>
				</ul>
				<div id="comment" class="span10" style="display:none;">
					正在加载评论...
				</div>
				<script type="text/javascript">
					$(document).ready(function() {
						if ("${article.category.allowComment}"=="1" && "${article.articleData.allowComment}"=="1"){
							$("#comment").show();
							commentPage(1);
						}
					});
					function commentPage(n,s){
						$.get("${ctxPath}${fns:getFrontPath()}/comment",{theme: 'basic', 'category.categoryCode': '${article.category.categoryCode}',
							contentId: '${article.id}', title: '${article.title}', corpCode: '${article.corpCode}', corpName: '${article.corpName}', pageNo: n, pageSize: s, date: new Date().getTime()
						},function(data){
							$("#comment").html(data);
						});
					}
				</script>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-xs-12">
						<div class="col-sm-offset-2 col-sm-10">
							<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> ${fns:text('关 闭')}</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<c:if test="${param.outlineView eq 'true'}">
<link type="text/css" href="${ctxStatic}/jquery-toc/0.3/toc.min.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctxStatic}/jquery-toc/0.3/toc.min.js"></script>
<script type="text/javascript">
$('<div class="toc" id="toc"><div class="toc-tab" id="toc-tab">目录导航</div>'
	+' <div class="toc-content" id="toc-content" style="display:none;"></div></div>')
.appendTo(document.body)
.mouseenter(function(){
	$('#toc-content').show();
})
.mouseleave(function(){
	$('#toc-content').hide();
})
.find('#toc-content').toc({
   'selectors': 'h1,h2,h3,h4,h5,h6', //elements to use as headings
   'container': '#article-content' //element to find all selectors in
});
</script>
</c:if>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/ueditor/1.4.3/ueditor.parse.min.js" type="text/javascript"></script>
<script>uParse('.uparse', {ctxStatic: '${ctxStatic}', rootPath: '${ctxStatic}/ueditor/1.4.3/',
	chartContainerHeight:500,'liiconpath':'${ctxStatic}/ueditor/1.4.3/themes/ueditor-list/'})</script>
<script src="${ctxStatic}/modules/cms/front/common/visitLog.min.js" type="text/javascript"></script>
<script>(function(){visitLogRecord('${pageContext.request.contextPath}${fns:getFrontPath()}','${site.siteCode}','${site.siteName}',
		'${category.categoryCode}','${category.categoryName}','${article.id}','${article.corpCode}','${article.corpName}')})()</script>