<%
response.setStatus(403);

String message = (String)request.getAttribute("message");

if (message == null || "".equals(message)){
	Throwable ex = Exceptions.getThrowable(request);
	if (ex != null && StringUtils.startsWith(ex.getMessage(), "msg:")){
		message = StringUtils.replace(ex.getMessage(), "msg:", "");
	}
}

if (message == null || "".equals(message)){
	message = "您的操作权限不足.";
}

// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	out.print(message);
}

// 输出异常信息页面
else {
	
%>
<%@page import="cn.net.ecode.common.web.Servlets"%>
<%@page import="cn.net.ecode.common.utils.Exceptions"%>
<%@page import="cn.net.ecode.common.utils.StringUtils"%>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<c:set var="extHead">
<link href="${ctxStatic}/assets/admin/pages/css/error.css" rel="stylesheet" type="text/css">
</c:set>
<sys:header title="403 - 操作权限不足" extLibs="${extLibs}" extHead="${extHead}"/>
<div class="row">
	<div class="col-md-12 page-error page-403">
		<div class="number">403</div>
		<div class="details">
			<h3><%=message %></h3>
			<p>很抱歉，您没有权限访问此页面，若有疑问请联系管理员。</p>
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