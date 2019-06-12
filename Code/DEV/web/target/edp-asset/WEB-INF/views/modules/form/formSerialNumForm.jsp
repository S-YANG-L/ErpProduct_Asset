<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="流水号管理 - ${formSerialNum.isNewRecord ? '新增' : '编辑'}流水号规则" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${formSerialNum.isNewRecord ? '新增' : '编辑'}流水号规则</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="form:formSerialNum:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formSerialNum" action="${ctx}/form/formSerialNum/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<input id="oldSerialKey" type="hidden" value="${formSerialNum.serialKey}"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="流水号名称，简单描述该流水号规则的作用">
								<span class="required">*</span> 流水号名称：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:input path="serialName" htmlEscape="false" maxlength="50" class="form-control required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="流水号的唯一标识，不可重复">
								<span class="required">*</span> 流水号标识：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<input id="serialKey" name="serialKey" maxlength="50" class="form-control required abcd serialNumExist" value="${formSerialNum.serialKey}"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label id="serialRuleLabel" class="control-label col-sm-2" title="可选规则如下：
{yyyy}{MM}{dd} 年月日，年4位，月日2位
{HH}{mm}{ss} 时分秒，均2位
{NO} 表示流水号，前面补零
{officeCode} 当前用户所属组织的code代码
{companyCode} 当前用户所属公司code代码">
								<span class="required">*</span> 流水号规则：<i class="fa icon-question"></i></label>
							<div class="col-sm-10">
								<form:input path="serialRule" htmlEscape="false" maxlength="100" class="form-control required checkRuleDay checkRuleMonth checkRuleYear checkRuleNO" placeholder="请手工输入规则或通过下方快速选择规则，只提供快速选择，如果已经存在则不进行复制"/>
								<div style="margin-top: 6px;" title="只提供快速选择，如果已经存在，则不进行复制">
									<form:checkboxes items="${fns:getDictList('form_serial_rules')}" path="serialRules" itemLabel="label" itemValue="value" cssClass="serialRules"/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="流水号的生成类型：
每天：每天从流水号初始值按照指定步长递增；
每月：每月从流水号初始值按照指定步长递增；
每年：每年从流水号初始值按照指定步长递增；">
								<span class="required">*</span> 生成类型：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:select path="genType" class="form-control required">
									<form:option value="" label=""/>
									<form:options items="${fns:getDictList('form_serial_gen_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="流水号长度，指{NO}处的长度">
								<span class="required">*</span> 流水号长度：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:input path="serialLength" htmlEscape="false" maxlength="18" class="form-control required digits"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="流水号的初始值">
								<span class="required">*</span> 流水号初始值：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:input path="initNum" htmlEscape="false" maxlength="18" class="form-control required digits"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="流水号每次递增的数值">
								<span class="required">*</span> 流水号步长：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:input path="step" htmlEscape="false" maxlength="18" class="form-control required digits"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="form:formSerialNum:edit">
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
<script src="${ctxStatic}/form/js/form-public.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/form/js/form-serial.js?${_version}" type="text/javascript"></script>
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
