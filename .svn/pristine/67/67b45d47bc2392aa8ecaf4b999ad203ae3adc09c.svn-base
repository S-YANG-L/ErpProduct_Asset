<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="资产分类管理 - ${assetSort.isNewRecord ? '新增' : '编辑'}资产分类" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${assetSort.isNewRecord ? '新增' : '编辑'}资产分类</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="assetSort" action="${ctx}/ass/assetSort/save" method="post" class="form-horizontal">
			<form:hidden path="isNewRecord"/>
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">上级分类：</label>
							<div class="col-sm-8">
								<sys:treeselect id="parent" name="parent.id" value="${assetSort.parent.id}" labelName="parent.sortName" labelValue="${assetSort.parent.sortName}"
												title="上级编码" url="${ctx}/ass/assetSort/treeData" extCode="${assetSort.id}" cssClass="form-control" allowClear="true"/>
							</div>
						</div>
					</div>
				</div>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 分类名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="sortName" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								排序码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="sorts" htmlEscape="false" class="form-control digits"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								备注：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="memo" htmlEscape="false" rows="4" maxlength="1024" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="ass:assetSort:edit">
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
						//contentWindow.dataGrid.refreshTree(1, $('#parentCode').val());
						contentWindow.$('#dataGrid').dataGrid('refreshTreeChildren',
								$('#parentCode').val(), ${assetSort.isNewRecord});
					});
				}
			}, "json");
	    }
	});
</script>