<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="文件目录管理管理 - ${fileDir.isNewRecord ? '新增' : '编辑'}文件目录管理" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${fileDir.isNewRecord ? '新增' : '编辑'}${fns:getDictLabel(fileDir.globalId, 'sys_file_group', '')}文件目录管理</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="fileDir" action="${ctx}/file/fileDir/save" method="post" class="form-horizontal">
			<form:hidden path="isNewRecord"/>
			<form:hidden path="globalId" htmlEscape="false" maxlength="10" readonly="true" class="form-control"/>
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2"><span class="${isAdmin}">*</span>上级文件目录：</label>
							<div class="col-sm-6">
								<sys:treeselect id="parent" name="parent.id" value="${fileDir.parent.id}" labelName="parent.name" labelValue="${fileDir.parent.dirName}" 
									title="父级编号" url="/file/fileDir/treeData?globalId=${fileDir.globalId}" extCode="${fileDir.dirId}" cssClass="form-control ${isAdmin}" allowClear="true"/>
							</div>
						</div>
					</div>
				</div>
				<form:hidden path="dirId"/>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required">*</span> 目录名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-6">
								<form:input path="dirName" htmlEscape="false" maxlength="30" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required"></span> 归属部门：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-6">
								<sys:treeselect id="office" name="office.officeCode" value="${fileDir.office.officeCode}" labelName="office.officeName" labelValue="${fileDir.office.officeName}"
									title="部门" url="/sys/office/treeData?type=2" isAll="true" cssClass="" allowClear="true" notAllowSelectParent="true"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required">*</span> 排序（升序）：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-6">
								<form:input path="sorts" htmlEscape="false" maxlength="18" class="form-control required digits"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								备注：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="file:fileDir:edit">
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
// 						contentWindow.dataGrid.refreshTree(1, $('#parentCode').val());
						contentWindow.$('#dataGrid').dataGrid('refreshTreeChildren',
								$('#parentCode').val(), ${fileDir.isNewRecord});
					});
				}
			}, "json");
	    }
	});
</script>