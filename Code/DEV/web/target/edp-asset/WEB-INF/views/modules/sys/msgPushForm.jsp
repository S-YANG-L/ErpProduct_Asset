<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="消息管理 - ${msgPush.isNewRecord ? '新增' : '编辑'}消息" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${msgPush.isNewRecord ? '新增' : '编辑'}消息</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="sys:msgPush:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="msgPush" action="${ctx}/sys/msgPush/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<form:hidden path="pushed"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 消息类型：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:select path="msgType" class="form-control required">
									<form:option value="" label=""/>
									<form:options items="${fns:getDictList('sys_msg_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 消息标题：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="msgTitle" htmlEscape="false" maxlength="200" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required">*</span> 消息内容：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="msgContent" htmlEscape="true" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								业务主键：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="bizKey" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								业务类型：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="bizType" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">接受者信息</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 接受者账号：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="receiveCode" htmlEscape="false" maxlength="64" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 接受者用户编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="receiveUserCode" htmlEscape="false" maxlength="64" class="form-control required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 接受者用户姓名：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="receiveUserName" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">发送者信息</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 发送者用户编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="sendUserCode" htmlEscape="false" maxlength="64" class="form-control required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 发送者用户姓名：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="sendUserName" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 发送时间：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input name="sendDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate required"
									value="<fmt:formatDate value="${msgPush.sendDate}" pattern="yyyy-MM-dd HH:mm"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								是否合并推送：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:select path="isMergePush" class="form-control required">
									<form:option value="" label=""/>
									<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">推送状态信息</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								计划推送时间：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input name="planPushDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate "
									value="<fmt:formatDate value="${msgPush.planPushDate}" pattern="yyyy-MM-dd HH:mm"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								推送尝试次数：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="pushNumber" htmlEscape="false" maxlength="10" class="form-control digits"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								推送返回结果码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="pushReturnCode" htmlEscape="false" maxlength="200" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								推送返回消息编号：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="pushReturnMsgId" htmlEscape="false" maxlength="200" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								推送返回的内容：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="pushReturnContent" htmlEscape="false" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								推送状态：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:select path="pushStatus" class="form-control required">
									<form:option value="" label="待推送"/>
									<form:options items="${fns:getDictList('sys_msg_push_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								推送时间：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input name="pushDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate "
									value="<fmt:formatDate value="${msgPush.pushDate}" pattern="yyyy-MM-dd HH:mm"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">读取状态信息</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								读取状态：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:select path="readStatus" class="form-control required">
									<form:option value="" label=""/>
									<form:options items="${fns:getDictList('sys_msg_read_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								读取时间：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input name="readDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate "
									value="<fmt:formatDate value="${msgPush.readDate}" pattern="yyyy-MM-dd HH:mm"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:msgPush:edit">
<!-- 							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp; -->
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
					});
				}
			}, "json");
	    }
	});
</script>
