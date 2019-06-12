<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${article.title} - ${category.categoryName}</title>
	<%@include file="include/head.jsp" %>
	<meta name="description" content="${article.description} ${category.description}" />
	<meta name="keywords" content="${article.keywords} ${category.keywords}" />
</head>
<body>
	<%@ include file="include/header.jsp" %>
	<div class="row">
	   <div class="span2">
		  <%@ include file="include/sidebar.jsp" %>
	   </div>
	   <div class="span10">
		  <%@ include file="include/position.jsp" %>
	   </div>
	   <div class="span10">
	     <div class="row">
	       <div class="span10">
			<h3 style="color:#555555;font-size:20px;text-align:center;border-bottom:1px solid #ddd;padding:15px 20px 20px 20px;margin-bottom:30px;">${article.title}</h3>
			<c:if test="${not empty article.description}"><blockquote style="padding:8px 10px 8px;margin:10px 20px 20px 35px;font-size:13px;">摘要：${article.description}</blockquote></c:if>
			<div class="uparse">${article.articleData.content}</div>
			<div style="border-top:1px solid #ddd;padding:10px;margin:25px 0 0;">发布者：${article.createBy.userName} &nbsp; 点击数：${article.hits} &nbsp; 发布时间：<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp; 更新时间：<fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
  	       </div>
  	     </div>
	     <div class="row">
			<div id="comment" class="span10" style="display:none;">
				正在加载评论...
			</div>
			<script type="text/javascript">
				$(document).ready(function() {
					if ("${category.allowComment}"=="1" && "${article.articleData.allowComment}"=="1"){
						$("#comment").show();
						commentPage(1);
					}
				});
				function commentPage(n,s){
					$.get("${ctx}/comment",{theme: '${site.theme}', 'category.categoryCode': '${category.categoryCode}',
						contentId: '${article.id}', title: '${article.title}', corpCode: '${article.corpCode}', corpName: '${article.corpName}', pageNo: n, pageSize: s, date: new Date().getTime()
					},function(data){
						$("#comment").html(data);
					});
				}
			</script>
	     </div>
	     <%-- <div class="row">
	       <div class="span10">
			<h5>相关文章</h5>
			<ol><c:forEach items="${relationList}" var="relation">
				<li style="float:left;width:230px;"><a href="${ctx}/view-${relation[0]}-${relation[1]}${urlSuffix}">${fns:abbr(relation[2],30)}</a></li>
			</c:forEach></ol>
	  	  </div> --%>
  	    </div>
  	</div>
    <div class="hero-unit" style="padding-bottom:35px;margin:10px 0;">
      <h1>这是一个自定义文章内容页</h1><br/>
      <p>自定义配置参数：aaa = ${viewConfig_aaa} &nbsp; aa = ${viewConfig_aa}</p>
    </div>
    <div class="row">
      <div class="span6">
        <h4><small><a href="${ctx}/list-tzgg${urlSuffix}" class="pull-right">更多&gt;&gt;</a></small>通知公告</h4>
		<ul><c:forEach items="${fnc:getArticleList(site.siteCode, 'tzgg', 8, '')}" var="article">
			<li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,28)}</a></li>
		</c:forEach></ul>
      </div>
      <div class="span6">
        <h4> <small><a href="${ctx}/list-zcfg${urlSuffix}" class="pull-right">更多&gt;&gt;</a></small>政策法规</h4>
		<ul><c:forEach items="${fnc:getArticleList(site.siteCode, 'zcfg', 8, '')}" var="article">
			<li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,28)}</a></li>
		</c:forEach></ul>
      </div>
    </div>
	<%@ include file="include/footer.jsp" %>
</body>
</html>