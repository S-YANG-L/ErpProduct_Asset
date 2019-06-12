<%@page import="cn.net.ecode.common.mapper.JsonMapper"%>
<%@page import="cn.net.ecode.common.utils.DateUtils"%>
<%@page import="org.apache.commons.lang3.time.DateFormatUtils"%>
<%@page import="java.util.Date"%>
<%@page import="cn.net.ecode.common.utils.ByteSizeUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.ehcache.Element"%>
<%@page import="net.sf.ehcache.Cache"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="cn.net.ecode.common.utils.SpringContextHolder"%>
<%@page import="net.sf.ehcache.CacheManager"%>
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

<%
	CacheManager cacheManager = SpringContextHolder.getBean(CacheManager.class);

	String op = request.getParameter("op");
	
	if ("view".equals(op)){

		String cacheName = request.getParameter("cacheName");
		String key = request.getParameter("key");
        out.println("<br/>名称：" + cacheName + "<br/>");
        out.println("<br/>键名：" + key + "<br/>");
		
		Element element = cacheManager.getCache(cacheName).get(key);
        String dataPattern = "yyyy-MM-dd hh:mm:ss";
        Map<String, Object> data = new HashMap<String, Object>();
        if (element != null){

            out.println("<br/>命中次数：" + element.getHitCount());
            out.println("<br/>缓存大小：" + ByteSizeUtils.byteSize(element.getSerializedSize()));

            Date latestOfCreationAndUpdateTime = new Date(element.getLatestOfCreationAndUpdateTime());
            out.println("<br/>最后更新时间：" + DateUtils.formatDate(latestOfCreationAndUpdateTime, dataPattern));
            Date lastAccessTime = new Date(element.getLastAccessTime());
            out.println("<br/>最后访问时间：" + DateFormatUtils.format(lastAccessTime, dataPattern));
            if(element.getExpirationTime() == Long.MAX_VALUE) {
                out.println("<br/>过期时间：" + "不过期");
            } else {
                Date expirationTime = new Date(element.getExpirationTime());
                out.println("<br/>过期时间：" + DateFormatUtils.format(expirationTime, dataPattern));
            }
            out.println("<br/>timeToIdle(秒)：" + element.getTimeToIdle());
            out.println("<br/>timeToLive(秒)：" + element.getTimeToLive());
            
            out.println("<br/>");
            out.println("<br/>版本：" + element.getVersion());
            out.println("<br/>");
            
            out.println("<br/>键值：" +  element.getObjectValue());
        }else{
        	
            out.println("<br/>没有取到该键信息。");
        	
        }
        
	}else{

		String cacheName = request.getParameter("cacheName");
		
		Cache cache = cacheManager.getCache(cacheName);
		
		if ("delete".equals(op)){
			String key = request.getParameter("key");
			if (!"".equals(key)){
		        cache.remove(key);
		        out.print("<br/>删除成功！<br/><br/>");
			}
		}else if ("clear".equals(op)){
	        cache.clearStatistics();
	        cache.removeAll();
	        out.print("<br/>清空成功！<br/><br/>");
		}
		
%>
	<p>
		<b><%=cacheName %> 键列表</b>
	</p>
    <table class="table table-bordered" style="width:500px">
        <tr>
            <td style="min-width:200px">缓存名称</td>
            <td>操作</td>
        </tr>
        <c:forEach items="<%=cache.getKeys()%>" var="key">
            <tr>
                <td><a href="javascript:" onclick="top.addTabPage(top.$(this), '缓存详情',
            	 		'${ctxPath}/monitor/ehcache/info.jsp?op=view&cacheName=<%=cacheName %>&key=${key}')">${key}</a></td>
                <td>
                    <a href="info.jsp?op=delete&cacheName=<%=cacheName %>&key=${key}" onclick="return confirm('确认要删除？')">删除</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <br/>
    <a href="info.jsp?op=clear&cacheName=<%=cacheName %>" onclick="return confirm('确认要清空？')">清空缓存</a> &nbsp;
<!--     <a href="javascript:" onclick="window.opener = null;window.open('','_self');window.close();">关闭窗口</a> -->
    <br/><br/>
	
<%
	}
%>
		<p>
			<br/>Copyright &copy; 2013-${fns:getConfig('copyrightYear')}&nbsp;${fns:getConfig('companyName')}.
		</p>
	</div>
</body>
</html>	