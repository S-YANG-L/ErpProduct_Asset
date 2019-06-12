<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="流程委托管理 - ${flowAgent.isNewRecord ? '新增' : '编辑'}流程委托" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${flowAgent.isNewRecord ? '新增' : '编辑'}流程委托</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="eflow:flowAgent:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="flowAgent" action="${ctx}/eflow/flowAgent/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								受委托人：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<sys:treeselect url="/sys/office/treeData?type=4" id="agentUser" name="agentUserCode" 
								value="${flowAgent.agentUserCode}" labelName="agentUserName" labelValue="${flowAgent.agentUserName}" 
								title="受委托人" isAll="true"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 委托开始时间：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input name="agentStartDate" id="agentStartDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate required"
									value="<fmt:formatDate value="${flowAgent.agentStartDate}" pattern="yyyy-MM-dd HH:mm"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false,maxDate:'#F{$dp.$D(\'agentEndDate\')}'})"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 委托结束时间：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input name="agentEndDate" id="agentEndDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate required "
									value="<fmt:formatDate value="${flowAgent.agentEndDate}" pattern="yyyy-MM-dd HH:mm"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false,minDate:'#F{$dp.$D(\'agentStartDate\')}'});"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								委托原因：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="eflow:flowAgent:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
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
