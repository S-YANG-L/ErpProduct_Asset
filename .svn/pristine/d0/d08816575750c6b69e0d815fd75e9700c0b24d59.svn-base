<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,fileupload,inputmask"/>
<sys:header title="单表管理 - ${testData.isNewRecord ? '新增' : '编辑'}单表" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${testData.isNewRecord ? '新增' : '编辑'}单表</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="test:testData:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="testData" action="${ctx}/test/testData/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">归属用户：</label>
							<div class="col-sm-8">
								<sys:treeselect id="user" name="user.userCode" value="${testData.user.userCode}" labelName="user.userName" labelValue="${testData.user.userName}"
 									title="用户" url="/sys/office/treeData?type=4" cssClass="" allowClear="true" notAllowSelectParent="true" isAll="true"/>
								 <%--<sys:listselect id="user" name="user.userCode" value="${testData.user.userCode}" labelName="user.userName" labelValue="${testData.user.userName}"
 									title="用户" url="/sys/user/userSelect" returnCodeAttr="userCode" returnNameAttr="userName" multiple="false" cssClass="form-control" isAll="true"/>
								--%><span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">归属部门：</label>
							<div class="col-sm-8">
								<sys:treeselect id="office" name="office.officeCode" value="${testData.office.officeCode}" labelName="office.officeName" labelValue="${testData.office.officeName}"
									title="机构" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">表单名称：</label>
							<div class="col-sm-8">
								<form:input path="name" htmlEscape="false" maxlength="100" class="form-control required2 moneyMask"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">归属区域：</label>
							<div class="col-sm-8">
								<sys:treeselect id="area" name="area.areaCode" value="${testData.area.areaCode}" labelName="area.areaName" labelValue="${testData.area.areaName}"
									title="区域" url="/sys/area/treeData" isShowCode="true" cssClass="" allowClear="true" notAllowSelectParent="true"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">性别：</label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control"/>
<%-- 									<form:select path="sex" class="form-control required"> --%>
<%-- 									    <form:option  value="">&nbsp;</form:option> --%>
<%-- 										<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
<%-- 									</form:select> --%>
								</div>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">加入日期：</label>
							<div class="col-sm-8">
								<input name="inDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate "
									value="<fmt:formatDate value="${testData.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">备注信息：</label>
							<div class="col-sm-10">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">处理意见：</label>
							<div class="col-sm-10">
								<flow:taskComment />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">上传附件1：</label>
							<div class="col-sm-10">
								<sys:fileupload id="fileupload1" bizCategory="testData1" bizKey="${testData.id}" readonly="false" preview="ntko"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">上传附件2：</label>
							<div class="col-sm-10">
								<sys:fileupload id="fileupload2" bizCategory="testData2" bizKey="${testData.id}" uploadType="image" readonly="false" maxUploadNum="5" preview="ntko"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
<%-- 						<shiro:hasPermission name="test:testData:edit"> --%>
							<flow:commandList />
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
<%-- 						</shiro:hasPermission> --%>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
			<%-- 乐观锁，前台提交时间戳作为该表单的版本号，后台更新数据前只要调用baseValidator即可验证版本。 --%>
			<input type="hidden" name="lastUpdateDateTime" value="${testData.updateDate.time}" />
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">

 	$("#inputForm .moneyMask").inputmask({alias:"money", autoUnmask:true}); // 金额数据格式（表单提交之前自动恢复）
//  $("#inputForm .moneyMask").inputmask({alias:"money", removeMaskOnSubmit:true}); // 金额数据格式（表单提交之前自动恢复）
// 	$('#inputForm .moneyMask').inputmask('remove').removeClass('moneyMask');  // 金额数据格式化恢复（一般不用，特殊情况下使用）

	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				<%-- 乐观锁，提醒是否执行页面刷新操作  Begin --%>
				if (data.message == '表单已被其它用户修改'){
					confirmx(data.message + '，是否刷新页面再试？', location);
					return;
				}
				<%-- 乐观锁，提醒是否执行页面刷新操作   End --%>
				showMessage(data.message);
				if(data.result == Global.TRUE){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
					});
				}
			}, "json");
		}
	});
	
	// 流程按钮执行自定义动作
	function flowCommitBefore(flowInfo){
		// 流程任务提交
		//var commandType = flowInfo.commandType;
		//var commandName = flowInfo.commandName;
		
		// 这里编写你的动作代码
		
		// 返回true继续执行默认动作进行表单提交
		// 返回false不提交表单，不执行默认动作
		return true;
	}
</script>