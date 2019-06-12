<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="区划管理 - ${area.isNewRecord ? '新增' : '编辑'}区划" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-map-marker"></i> ${area.isNewRecord ? '新增' : '编辑'}区划</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="area" action="${ctx}/sys/area/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">上级区划：</label>
							<div class="col-sm-8">
								<sys:treeselect id="parent" name="parent.id" value="${area.parent.id}" labelName="parent.areaName" labelValue="${area.parent.areaName}"
									title="区划" url="/sys/area/treeData" extCode="${area.id}" cssClass="form-control" allowClear="true"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 区划代码：</label>
							<div class="col-sm-8">
								<form:hidden path="isNewRecord"/>
								<form:input path="areaCode" htmlEscape="false" maxlength="64" readonly="${!area.isNewRecord}" class="form-control abc required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 区划名称：</label>
							<div class="col-sm-8">
								<form:input path="areaName" htmlEscape="false" maxlength="50" class="required form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 区划类型：</label>
							<div class="col-sm-8">
								<form:select path="type" class="form-control">
									<form:options items="${fns:getDictList('sys_area_type')}" itemLabel="name" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">备注：</label>
							<div class="col-sm-8">
								<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:area:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="validate"/>
<script type="text/javascript">
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
// 						contentWindow.dataGrid.refreshTree(1, $('#parentCode').val());
						contentWindow.$('#dataGrid').dataGrid('refreshTreeChildren',
								$('#parentCode').val(), ${area.isNewRecord});
					});
				}
			}, "json");
	    }
	});
</script>