<%
response.setStatus(400);

// 提示的错误信息
StringBuilder message = new StringBuilder();

// 编译错误信息串
Throwable ex = Exceptions.getThrowable(request);
if (ex != null && ex instanceof BindException){
	for (ObjectError e : ((BindException)ex).getGlobalErrors()){
		message.append("☆" + e.getDefaultMessage() + "(" + e.getObjectName() + ")\n");
	}
	for (FieldError e : ((BindException)ex).getFieldErrors()){
		message.append("☆" + e.getDefaultMessage() + "(" + e.getField() + ")\n");
	}
	LoggerFactory.getLogger("400.jsp").warn(ex.getMessage(), ex);
}else if (ex != null && ex instanceof ConstraintViolationException){
	for (ConstraintViolation<?> v : ((ConstraintViolationException)ex).getConstraintViolations()) {
		message.append("☆" + v.getMessage() + "(" + v.getPropertyPath() + ")\n");
	}
}else if (ex != null){
	//message.append(Exceptions.getStackTraceAsString(ex));
	message.append("☆" + ex.getMessage());
} else {
	message.append("未知参数错误.\n\n");
}

// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	out.print(message);
}

// 输出异常信息页面
else {
%>
<%@page import="javax.validation.ConstraintViolation"%>
<%@page import="javax.validation.ConstraintViolationException"%>
<%@page import="org.springframework.validation.BindException"%>
<%@page import="org.springframework.validation.ObjectError"%>
<%@page import="org.springframework.validation.FieldError"%>
<%@page import="org.slf4j.Logger,org.slf4j.LoggerFactory"%>
<%@page import="cn.net.ecode.common.web.Servlets"%>
<%@page import="cn.net.ecode.common.utils.Exceptions"%>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<c:set var="extHead">
<link href="${ctxStatic}/assets/admin/pages/css/error.css" rel="stylesheet" type="text/css">
</c:set>
<sys:header title="400 - 请求参数错误" extLibs="${extLibs}" extHead="${extHead}"/>
<div class="row">
	<div class="col-md-12 page-error page-400">
		<div class="number">400</div>
		<div class="details">
			<h3>请求参数有误, 服务器无法解析.</h3>
			<p><%=message %></p>
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