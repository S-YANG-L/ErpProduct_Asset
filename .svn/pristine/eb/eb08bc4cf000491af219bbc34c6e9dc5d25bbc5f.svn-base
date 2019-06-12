<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${article.title} - Powered By Heracles</title>
	<%@include file="include/head.jsp" %>
	<!-- Baidu tongji analytics --><script>var _hmt=_hmt||[];(function(){var hm=document.createElement("script");hm.src="//hm.baidu.com/hm.js?82116c626a8d504a5c0675073362ef6f";var s=document.getElementsByTagName("script")[0];s.parentNode.insertBefore(hm,s);})();</script>
	<meta name="description" content="JeeSite ${site.description}" />
	<meta name="keywords" content="JeeSite ${site.keywords}" />
</head>
<body>
	<%@ include file="include/header.jsp" %>
	<!-- content -->
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
					<c:forEach items="${fnc:getCategoryList(site.siteCode, category.parentCode, 16, '')}" var="category">
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
					<h2>${article.title}</h2>
					<p class="news_tt">
						发布者：<em>${article.createBy.userName}</em>&nbsp;&nbsp;&nbsp;点击数：<em>${article.hits}</em>&nbsp;&nbsp;&nbsp;发布时间：<em><fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</em>&nbsp;&nbsp;&nbsp;更新时间：<em><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></em>
					</p>
					<c:if test="${not empty article.description}">
						<div class="news">
							摘要：${article.description}
							<br/><br/>
						</div>
					</c:if>
					<div class="news">
						${article.articleData.content}
					</div>
					<div id="comment" style="display: none;">
						正在加载评论...
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //content -->
		<script type="text/javascript">
		$(document).ready(function() {
			if ("${category.allowComment}"=="1" && "${article.articleData.allowComment}"=="1"){
				$("#comment").show();
				page(1);
			}
		});
		function page(n,s){
			$.get("${ctx}/comment",{theme: '${site.theme}', 'category.categoryCode': '${category.categoryCode}',
				contentId: '${article.id}', title: '${article.title}', pageNo: n, pageSize: s, date: new Date().getTime()
			},function(data){
				$("#comment").html(data);
			});
		}
	</script>
	<%@ include file="include/footer.jsp" %>
</body>
</html>