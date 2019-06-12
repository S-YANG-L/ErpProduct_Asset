<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="资产领用子表管理 - ${assetUsedDtl.isNewRecord ? '新增' : '编辑'}资产领用子表" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${assetUsedDtl.isNewRecord ? '新增' : '编辑'}资产领用子表</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="usedinfo:assetUsedDtl:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="assetUsedDtl" action="${ctx}/usedinfo/assetUsedDtl/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								领用编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="usedCode" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 资产编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="assetCode" htmlEscape="false" maxlength="64" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 资产名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="assetName" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 资产分类编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="sortCode" htmlEscape="false" maxlength="64" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 资产分类名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="sortName" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								品牌：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="brand" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								型号：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="version" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								存放地点：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="storagePlace" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								公司编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="companyCode" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								公司名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="companyName" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								责任部门编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<sys:treeselect id="office" name="office.officeCode" value="${assetUsedDtl.office.officeCode}" labelName="office.officeName" labelValue="${assetUsedDtl.office.officeName}"
									title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								责任部门：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="officeName" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								使用人编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<sys:treeselect id="user" name="user.userCode" value="${assetUsedDtl.user.userCode}" labelName="user.userName" labelValue="${assetUsedDtl.user.userName}"
									title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								使用人名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="userName" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								退库状态：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="returnSatus" htmlEscape="false" maxlength="1" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								扩展1：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="extendS1" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								扩展2：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="extendS2" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								扩展3：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="extendS3" htmlEscape="false" maxlength="100" class="form-control"/>
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
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1000" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="usedinfo:assetUsedDtl:edit">
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
