<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="编码规范子表管理 - ${codeRules.isNewRecord ? '新增' : '编辑'}编码规范子表" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${codeRules.isNewRecord ? '新增' : '编辑'}编码规范子表</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="ass:codeRules:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="codeRules" action="${ctx}/ass/codeRules/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								规则项编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="rulesItemCode" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								规则编码名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="rulesItemName" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								编码格式：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="codeFormat" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								编码格式内容：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="codeFormatContent" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								编码长度：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="codeLen" htmlEscape="false" maxlength="11" class="form-control digits"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								规则备注：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="rulesRemarks" htmlEscape="false" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								排序：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="codeSort" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								分类码1：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="category1" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								分类码2：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="category2" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								上次最大值：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="lastMax" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								流水号补齐字符：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="flowComplement" htmlEscape="false" maxlength="1" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								流水号补齐方式：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="flowComplementMode" htmlEscape="false" maxlength="1" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								备注信息：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 编码主键：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="codeId" htmlEscape="false" maxlength="64" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="ass:codeRules:edit">
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
