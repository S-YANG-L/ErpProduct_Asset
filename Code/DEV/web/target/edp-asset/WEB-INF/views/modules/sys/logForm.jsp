<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="系统日志管理 - 系统访问日志详情" extLibs="${extLibs}" htmlClass="scroll" />
<style>
<!--
.compare_result{width: 99%;border-collapse: collapse;margin: 0 auto;}
.compare_result tr td{height: 27px;width:30%;border-bottom:1px dashed #dedede;padding-left: 3px;padding-bottom: 5px;padding-top: 5px;}

-->
</style>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-coffee"></i>系统访问日志详情
		</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="sysLog" action="${ctx}/sys/log/save" method="post" class="form-horizontal">
			<form:hidden path="id" />
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">操作菜单</label>
							<div class="col-sm-8">
								<form:input path="title" htmlEscape="false" maxlength="500" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">日志状态</label>
							<div class="col-sm-8">
								<input type="text" class="form-control required" maxlength="2" value="${sysLog.type==1?'成功':'异常' }" />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">访问地址</label>
							<div class="col-sm-10">
								<input type="text" value="${log.serverAddr}${log.requestUri}" maxlength="255" class="form-control" />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">提交数据</label>
							<div class="col-sm-10">
								<form:input path="params" htmlEscape="false" class="form-control" />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">操作用户</label>
							<div class="col-sm-8">
								<form:input path="createByName" htmlEscape="false" maxlength="100" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">操作者IP</label>
							<div class="col-sm-8">
								<form:input path="remoteAddr" htmlEscape="false" maxlength="255" class="form-control" />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">操作方式</label>
							<div class="col-sm-8">
								<form:input path="method" htmlEscape="false" maxlength="5" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">访问时间</label>
							<div class="col-sm-8">
								<input name="createDate" type="text" maxlength="20" class="form-control "
									value="<fmt:formatDate value="${sysLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${not empty log.exception}">
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">异常信息</label>
							<div class="col-sm-10">
								<form:textarea path="exception" htmlEscape="false" class="form-control" rows="20" />
							</div>
						</div>
					</div>
				</div>
				</c:if>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">设备名称</label>
							<div class="col-sm-8">
								<form:input path="deviceName" htmlEscape="false" maxlength="100" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">浏览器名称</label>
							<div class="col-sm-8">
								<form:input path="browserName" htmlEscape="false" maxlength="100" class="form-control" />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">用户信息</label>
							<div class="col-sm-8">
								<form:input path="userAgent" htmlEscape="false" maxlength="255" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">响应时间</label>
							<div class="col-sm-8">
								<form:input path="executeTimeFormat" htmlEscape="false" maxlength="255" class="form-control" />
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">数据操作日志</h4>
				<div class="ml10 mr10 mb10">
					${sysLog.diffModifyData}
				</div>
				<div class="form-actions fluid">
					<div class="row">
						<div class="col-sm-offset-2 col-sm-10">
							<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')">
								<i class="fa fa-reply-all"></i> 关 闭 </button>&nbsp; 
							<a href="javascript:void(0);" class="btn default" onclick="relatedLog('${sysLog.bizKey}','${sysLog.bizType}')">
								<i class="fa fa-search"></i> 查询相关操作日志</a>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	$("#inputForm").validate({
		submitHandler : function(form) {
			ajaxSubmitForm($(form), function(data) {
				showMessage(data.message);
				if (data.result == Global.TRUE) {
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow) {
						contentWindow.page();
					});
				}
			}, "json");
		}
	});
	
	// 查看相关日志
	function relatedLog(bizKey,bizType){
		top.addTabPage(top.$(this), '系统访问日志','${ctx}/sys/log/list?bizKey='+bizKey+'&bizType='+bizType);
	}
</script>