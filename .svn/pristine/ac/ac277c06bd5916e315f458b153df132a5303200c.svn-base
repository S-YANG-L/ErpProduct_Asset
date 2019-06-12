<%
response.setStatus(500);

String message = (String)request.getAttribute("message");

if (message == null || "".equals(message)){
	Throwable ex = Exceptions.getThrowable(request);
	if (ex != null){
		if (ex instanceof ServiceException){
			message = ex.getMessage();
		}else if (ex.getCause() instanceof ServiceException){
			message = ex.getCause().getMessage();
		}
		LoggerFactory.getLogger("500.jsp").error(ex.getMessage(), ex);
	}
}

if (message == null || "".equals(message)){
	message = "您访问的页面出错啦.";
}

// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	out.print(message);
}

// 输出异常信息页面
else {

%>
<%@page import="org.slf4j.Logger,org.slf4j.LoggerFactory"%>
<%@page import="cn.net.ecode.common.web.Servlets"%>
<%@page import="cn.net.ecode.common.utils.Exceptions"%>
<%@page import="cn.net.ecode.common.utils.StringUtils"%>
<%@page import="cn.net.ecode.common.service.ServiceException"%>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<c:set var="extHead">
<link href="${ctxStatic}/assets/admin/pages/css/error.css" rel="stylesheet" type="text/css">
</c:set>
<sys:header title="500 - 系统内部错误" extLibs="${extLibs}" extHead="${extHead}"/>
<div class="row">
	<div class="col-md-12 page-error page-500">
		<div class="number">500</div>
		<div class="details">
			<h3><%=message %></h3>
			<p>对不起，你访问的页面出现了一点问题，请及时联系管理员解决！</p>
			<button type="button" class="btn btn-info" onclick="history.go(-1);"><i class="fa fa-reply-all"></i> 返回上一页</button>
		</div>
	</div>
</div>
<div class="page-copyright">
	<p>Copyright &copy; 2013-${fns:getConfig('copyrightYear')}&nbsp;${fns:getConfig('companyName')}.</p>
	<script>try{top.$.jBox.closeTip();}catch(e){}</script>
</div>
<%--
// 编译详细错误信息
StringBuilder sb = new StringBuilder("错误信息：\n");
if (ex != null) {
	sb.append(Exceptions.getStackTraceAsString(ex));
} else {
	sb.append("未知错误.\n\n");
}
out.println(StringUtils.toHtml(sb.toString()));
--%>
<%
} out = pageContext.pushBody();
%>