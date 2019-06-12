<%-- <%@page import="cn.net.ecode.modules.sys.security.AuthorizingRealm"%> --%>
<%@page import="cn.net.ecode.common.utils.SpringContextHolder"%>
<%@ page import="net.sf.ehcache.CacheManager" %>
<%@ page import="net.sf.ehcache.Statistics" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Comparator" %>
<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>EhCache Manage</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<div class="container-fluid">
		<br/>
	<p>
		<a href="?sort=hitPercent">按总命中率排序</a> &nbsp;
		<a href="?sort=objectCount">按内存中对象数排序</a>
	</p>
	<table class="table table-bordered">
        <tr>
            <td>缓存名称</td>
            <td>总命中率</td>
            <td>命中次数</td>
            <td>失效次数</td>
            <td>缓存总对象数</td>
            <td>平均获取时间</td>
        </tr>
<%
    CacheManager cacheManager = SpringContextHolder.getBean(CacheManager.class);
    String[] cacheNames = cacheManager.getCacheNames();
    int length = cacheNames.length;

    sort(cacheNames, cacheManager, request.getParameter("sort"));

    for (int i = 0; i < length; i++) {
        String cacheName = cacheNames[i];
        pageContext.setAttribute("cacheName", cacheName);
        pageContext.setAttribute("cache", cacheManager.getCache(cacheName));
%>
		<c:set var="totalCount" value="${cache.statistics.cacheHits + cache.statistics.cacheMisses}"/>
		<c:set var="totalCount" value="${totalCount > 0 ? totalCount : 1}"/>
		<c:set var="cacheHitPercent" value="${cache.statistics.cacheHits * 1.0 / (totalCount)}"/>
        <tr>
            <td><a href="javascript:" onclick="top.addTabPage(top.$(this), '缓存信息',
            	 '${ctxPath}/monitor/ehcache/info.jsp?cacheName=${cacheName}')">${cacheName}</a></td>
            <td><fmt:formatNumber value="${cacheHitPercent * 100}" pattern="#.##" />%</td>
            <td>${cache.statistics.cacheHits}</td>
            <td>${cache.statistics.cacheMisses}</td>
            <td>${cache.statistics.objectCount}</td>
            <td><fmt:formatNumber value="${cache.statistics.averageGetTime}" />毫秒</td>
        </tr>
<%
	}
%>
   	</table>
   	
		<p>
			<br/>Copyright &copy; 2013-${fns:getConfig('copyrightYear')}&nbsp;${fns:getConfig('companyName')}.
		</p>
	</div>
</body>
</html>	
<%!
	private void sort(final String[] cacheNames, final CacheManager cacheManager, final String sort) {
	    Arrays.sort(cacheNames, new Comparator<String>() {
	        public int compare(String n1, String n2) {
	            Statistics s1 = cacheManager.getCache(n1).getStatistics();
	            Statistics s2 = cacheManager.getCache(n2).getStatistics();
	            if("hitCount".equals(sort)) {
	                double n1HitPercent = 1.0 * s1.getCacheHits() / Math.max(s1.getCacheHits() + s1.getCacheMisses(), 1);
	                double n2HitPercent = 1.0 * s2.getCacheHits() / Math.max(s2.getCacheHits() + s2.getCacheMisses(), 1);
	                return -Double.compare(n1HitPercent, n2HitPercent);
	            } else if("objectCount".equals(sort)) {
	                return -Long.valueOf(s1.getObjectCount()).compareTo(Long.valueOf(s2.getObjectCount()));
	            }
	            return -n1.compareTo(n2);
	        }
	
	    });
	}
%>