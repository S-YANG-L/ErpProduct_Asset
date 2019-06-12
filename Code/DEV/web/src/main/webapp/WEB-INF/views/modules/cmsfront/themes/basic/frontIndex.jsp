<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>首页</title>
	<%@include file="include/head.jsp" %>
	<meta name="description" content="JeeSite ${site.description}" />
	<meta name="keywords" content="JeeSite ${site.keywords}" />
</head>
<body>
	<%@ include file="include/header.jsp" %>
    <div class="hero-unit" style="padding:30px 50px;margin:10px 0">
<%--       <c:set var="topArticle" value="${fnc:getArticle('512614175457779712')}"/> --%>
      <c:set var="topArticle" value="${fnc:getArticleList(site.siteCode, '0', 1, 'isQueryArticleData: true, orderBy: \"hits desc\"')[0]}"/>
      <h2>${fns:abbr(topArticle.title,28)}</h2><p></p>
      <p style="text-indent:2em;">${fns:abbr(fns:replaceHtml(topArticle.articleData.content),260)}</p>
      <p><a href="${topArticle.url}" class="btn btn-primary btn-large">&nbsp;&nbsp;&nbsp;查看详情 &raquo;&nbsp;&nbsp;&nbsp;</a></p>
    </div>
    <%-- <div class="row">
      <div class="span4">
        <h4><small><a href="${ctx}/list-tzgg${urlSuffix}" class="pull-right">更多&gt;&gt;</a></small>通知公告</h4>
		<ul><c:forEach items="${fnc:getArticleList(site.siteCode, 'tzgg', 8, '')}" var="article">
			<li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,28)}</a></li>
		</c:forEach></ul>
      </div>
      <div class="span4">
        <h4> <small><a href="${ctx}/list-zcfg${urlSuffix}" class="pull-right">更多&gt;&gt;</a></small>政策法规</h4>
		<ul><c:forEach items="${fnc:getArticleList(site.siteCode, 'zcfg', 8, '')}" var="article">
			<li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,28)}</a></li>
		</c:forEach></ul>
      </div>
      <div class="span4">
        <h4><small><a href="${ctx}/list-zwgk${urlSuffix}" class="pull-right">更多&gt;&gt;</a></small>政务公开</h4>
		<ul><c:forEach items="${fnc:getArticleList('wike', 'zwgk', 8, '')}" var="article">
			<li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,28)}</a></li>
		</c:forEach></ul>
      </div>
    </div> --%>
	<c:set var="index" value="1"/>
	<c:forEach items="${fnc:getCategoryList(site.siteCode, '0', 16, '')}" var="category">
		<c:if test="${category.inList eq '1' && category.module ne ''}">
			<c:set var="index" value="${index+1}"/>
			${index % 2 eq 0 ? '<div class="row">':''}
			<div class="span6">
				<h4><small><a href="${category.url}" class="pull-right">更多&gt;&gt;</a></small>${category.categoryName}</h4>
				<c:if test="${category.module eq 'article'}">
					<ul><c:forEach items="${fnc:getArticleList(site.siteCode, category.categoryCode, 15, '')}" var="article">
						<li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,49)}</a></li>
					</c:forEach></ul>
				</c:if>
				<c:if test="${category.module eq 'link'}">
					<ul><c:forEach items="${fnc:getLinkList(site.siteCode, category.categoryCode, 15, '')}" var="link">
						<li><span class="pull-right"><fmt:formatDate value="${link.updateDate}" pattern="yyyy.MM.dd"/></span><a target="_blank" href="${link.url}" style="color:${link.color}">${fns:abbr(link.title,49)}</a></li>
					</c:forEach></ul>
				</c:if>
			</div>
			${index % 2 ne 0 ? '</div>':''}
		</c:if>
	</c:forEach>
	<%@ include file="include/footer.jsp" %>
</body>
</html>