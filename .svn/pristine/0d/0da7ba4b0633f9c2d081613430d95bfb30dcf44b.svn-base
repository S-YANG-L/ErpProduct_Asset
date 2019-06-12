<%
response.setStatus(404);

String message = (String)request.getAttribute("message");

if (message == null || "".equals(message)){
	message = "您访问的页面不存在.";
}

// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	out.print(message);
}

// 输出异常信息页面
else {
	
	if ("文件已丢失或不存在！".equals(message)){
		response.setStatus(200);
	}
	
%>
<%@page import="cn.net.ecode.common.web.Servlets"%>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<c:set var="extHead">
<link href="${ctxStatic}/assets/admin/pages/css/error.css" rel="stylesheet" type="text/css">
</c:set>
<sys:header title="404 - 页面不存在" extLibs="${extLibs}" extHead="${extHead}"/>
<div class="row">
	<div class="col-md-12 page-error page-404">
		<div class="number">404</div>
		<div class="details">
			<h3><%=message %></h3>
			<p>可能是如下原因引起的这个错误：</p>
			<ul>
				<li>地址输入错误，链接已经失效过期.</li>
				<li style="word-break:break-all;word-wrap:break-word;">
					您访问的地址为：<c:out value="${requestScope['javax.servlet.forward.request_uri']}"/></li>
				<li>若有疑问请联系管理员.</li>
				<li>......</li>
			</ul>
			<button type="button" class="btn btn-info" onclick="history.go(-1);"><i class="fa fa-reply-all"></i> 返回上一页</button>
		</div>
	</div>
</div>
<div class="page-copyright">
	<p>Copyright &copy; 2013-${fns:getConfig('copyrightYear')}&nbsp;${fns:getConfig('companyName')}.</p>
	<script>try{top.$.jBox.closeTip();}catch(e){}</script>
</div>
<%
} out = pageContext.pushBody();
%>