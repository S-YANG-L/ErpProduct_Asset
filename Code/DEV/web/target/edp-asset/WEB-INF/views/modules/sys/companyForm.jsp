<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<sys:header title="${fns:text('公司管理')} - ${company.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('公司')}" extLibs="validate"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${company.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('公司')}</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="company" action="${ctx}/sys/company/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">${fns:text('基本信息')}</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('上级公司')}：</label>
							<div class="col-sm-8">
								<sys:treeselect id="parent" name="parent.companyCode" value="${company.parent.companyCode}" labelName="parent.companyName" labelValue="${company.parent.companyName}"
									title="${fns:text('上级公司')}" url="/sys/company/treeData" extCode="${company.companyCode}" isShowCode="true" cssClass="" allowClear="true" />
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('公司编码')}：</label>
							<div class="col-sm-8">
								<form:hidden path="isNewRecord"/>
								<form:hidden path="companyCode"/>
								<form:input path="viewCode" htmlEscape="false" maxlength="30" readonly="${!company.isNewRecord}" class="form-control abc required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('公司简称')}：</label>
							<div class="col-sm-8">
							<input id="oldCompanyNameSimple" name="oldCompanyNameSimple" type="hidden" value="${company.companyNameSimple}">
							<form:input path="companyNameSimple" htmlEscape="false" maxlength="100" class="form-control required"/>
							<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('公司全称')}：</label>
							<div class="col-sm-8">
								<form:input path="companyName" htmlEscape="false" maxlength="100" class="form-control required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('设置该公司包含的组织机构，在选择机构时可根据公司筛选')}。">
								${fns:text('包含机构')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
							<sys:treeselect id="office" name="office.id" value="${company.office.id}" labelName="office.officeName" labelValue="${company.office.officeName}"
								title="机构" url="/sys/office/treeData" isShowCode="true" cssClass="form-control" checked="true" notAllowSelectParent="true" allowClear="true"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('注册地区')}：</label>
							<div class="col-sm-8">
								<sys:treeselect id="area" name="area.id" value="${company.area.id}" labelName="area.areaName" labelValue="${company.area.areaName}"
									title="${fns:text('注册地区')}" url="/sys/area/treeData" allowClear="true" isShowCode="true"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('备注')}：</label>
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
							<label class="control-label col-sm-2">${fns:text('快速授权角色数据权限')}：</label>
							<div class="col-sm-10">
								<style>.fix-width span{width:200px;display:inline-block;}</style>
								<div class="checkbox fix-width">
									<form:checkboxes path="roleCodes" items="${roleList}" itemLabel="roleName" itemValue="roleCode" class="form-control"/>
								</div>
								<div class="alert alert-warning" style="margin-top:10px;">
									${fns:text('提示')}：<br/>1、${fns:text('上述角色列表，仅列出了“角色数据范围为：自定义数据授权”的角色')}。<br/>
									2、${fns:text('此功能仅提供快速授权角色数据权限，不提供快速取消授权数据权限，如果取消角色数据权限，请进入角色管理里进行数据授权设置')}。<br/>
									3、${fns:text('如果角色列表中没有角色，可能是这两个原因：a.可能是您没有可管理的角色，b.角色列表中没有自定义数据权限的角色')}
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:company:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary" ><i class="fa fa-check"></i> ${fns:text('保 存')}</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> ${fns:text('关 闭')}</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="validate"/>
<script type="text/javascript">
	if("${company.status}"=="2"){
		$('input').attr("disabled","disabled");
		$('textArea').attr("disabled","disabled");
		$('button[type="submit"]').addClass('display-none');
	}
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result== Global.TRUE){
// 					showMessage('本次操作之后仅显示本级数据，若想查看全部数据，请点击“全部”按钮。', '', 'info', 3000);
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
// 						contentWindow.dataGrid.refreshTree(1, $('#parentCode').val());
						contentWindow.$('#dataGrid').dataGrid('refreshTreeChildren',
								$('#parentCode').val(), ${company.isNewRecord});
					});
				}
			}, "json");
	    }
	});
</script>