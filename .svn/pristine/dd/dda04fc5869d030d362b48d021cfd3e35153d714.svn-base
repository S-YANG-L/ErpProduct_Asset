<%
response.setStatus(402);

String message = (String)request.getAttribute("message");

if (message == null || "".equals(message)){
	message = "对不起, 系统已限制您的进入, 如有需要请联系经销商获取许可.";
}

// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	out.print(message);
}

// 输出异常信息页面
else {
	
	pageContext.setAttribute("message", message);
	
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
<sys:header title="${message}" extLibs="${extLibs}" extHead="${extHead}"/>
<div class="row">
	<div class="col-md-12 page-error page-402">
		<div class="number fa icon-key"></div>
		<div class="details">
			<h3><%=message %></h3>
			<p>
				<c:set var="loadMessage">${__info_loadMessage}</c:set>
				<%=StringUtils.toHtml((String)pageContext.getAttribute("loadMessage")) %>
			</p>
			<button type="button" class="btn green" id="licSelect"><i class="fa fa-upload"></i> 上传许可(*.lic)</button> &nbsp;
			<button type="button" class="btn btn-info" onclick="closeCurrentTabPage()"><i class="fa fa-reply-all"></i> 关闭页面</button>
		</div>
	</div>
</div>
<div class="page-copyright">
	<p>Copyright &copy; 2013-${fns:getConfig('copyrightYear')}&nbsp;${fns:getConfig('companyName')}.</p>
	<script>try{top.$.jBox.closeTip();}catch(e){}</script>
</div>
<sys:footer extLibs="${extLibs}"/>
<script id="licUpload" type="text/template">
	<form id="inputForm" action="${ctxPath}/licence/save" method="post" enctype="multipart/form-data"
		class="form-horizontal" style="margin-top:15px;">
		<c:if test="${!fns:getUser().admin}">
		<div class="row">
			<div class="col-xs-12">
				<div class="form-group">
					<label class="control-label col-xs-4"><span class="required">*</span> 管理员账号：</label>
					<div class="col-xs-7">
						<input type="text" id="username" name="username" maxlength="100" class="form-control required"/>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<div class="form-group">
					<label class="control-label col-xs-4"><span class="required">*</span> 管理员密码：</label>
					<div class="col-xs-7">
						<input type="password" id="password" name="password" maxlength="100" class="form-control required"/>
					</div>
				</div>
			</div>
		</div>
		</c:if>
		<div class="row">
			<div class="col-xs-12">
				<div class="form-group">
					<label class="control-label col-xs-4"><span class="required">*</span> 许可文件(.lic)：</label>
					<div class="col-xs-7">
						<style>.no-skin #licFile{padding-top:6px;}</style>
						<input type="file" id="licFile" name="licFile"/>
					</div>
				</div>
			</div>
		</div>
	</form>
</script>
<script type="text/javascript">
	$('#licSelect').click(function(){
		getJBox().open("html:"+$('#licUpload').html(), "上传许可文件",
				400, ${!fns:getUser().admin ? 210 : 115}, {
			buttons:{"<i class=\"glyphicon glyphicon-ok\"></i>&nbsp;上传":"ok",
				"<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;取消":true}, 
			submit: function (v, h, f){
				if (v == 'ok'){//<c:if test="${!fns:getUser().admin}">
					if (f.username == '') {
				    	showMessage("请填写管理员账号.", null, 'warning');
				        return false;
				    }else if (f.password == '') {
				    	showMessage("请填写管理员账号.", null, 'warning');
				        return false;
				    }//</c:if>
				    f.licFile = h.find('#licFile').val();
				    if (f.licFile == '' || !f.licFile.endWith('.lic')){
				    	showMessage("许可文件不正确，请选择后缀为 .lic 的文件。", null, 'warning');
				        return false;
				    }
					ajaxSubmitForm(h.find('#inputForm'), function(data){
						if(data.result == Global.TRUE){
							getJBox().close();
							alertx(data.message);
						}else{
							showMessage(data.message);
						}
					}, "json");
				    return false;
				}
			}
		});
	});
</script>
<%
} out = pageContext.pushBody();
%>