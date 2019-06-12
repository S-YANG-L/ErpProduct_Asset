<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="${fns:text('机构管理')} - ${office.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('机构')}" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${office.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('机构')}</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="form-body">
				<h4 class="form-section">${fns:text('基本信息')}</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('上级机构')}：</label>
							<div class="col-sm-8">
								<sys:treeselect id="parent" name="parent.id" value="${office.parent.id}" labelName="parent.officeName" labelValue="${office.parent.officeName}" 
									title="${fns:text('机构')}" url="/sys/office/treeData" extCode="${office.id}" isShowCode="true" cssClass="form-control" allowClear="true"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required ">*</span> ${fns:text('机构编码')}：</label>
							<div class="col-sm-8">
								<form:hidden path="isNewRecord"/>
								<form:hidden path="officeCode"/>
								<form:input path="viewCode" htmlEscape="false" maxlength="30" readonly="${!office.isNewRecord}" class="form-control abc required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('机构名称')}：</label>
							<div class="col-sm-8">
								<form:input path="officeName" htmlEscape="false" maxlength="50" class="required form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('机构全称')}：</label>
							<div class="col-sm-8">
								<form:input path="fullName" htmlEscape="false" maxlength="50" class="required form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('机构类型')}：</label>
							<div class="col-sm-8">
								<form:select path="type" class="form-control required">
									<form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('排序')}：</label>
							<div class="col-sm-8">
								<form:input path="sorts" htmlEscape="false" maxlength="18" class="form-control required digits"/>
								<span class="help-block">排序（升序）&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section extend_msg">${fns:text('详细信息')}</h4>
				<%-- <div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('联系地址')}：</label>
							<div class="col-sm-8">
								<form:input path="address" htmlEscape="false" maxlength="50" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('邮政编码')}：</label>
							<div class="col-sm-8">
								<form:input path="zipCode" htmlEscape="false" maxlength="50" class="form-control zipCode"/>
							</div>
						</div>
					</div>
				</div> --%>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('负责人')}：</label>
							<div class="col-sm-8">
								<form:input path="leader" htmlEscape="false" maxlength="50" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('电话')}：</label>
							<div class="col-sm-8">
								<form:input path="phone" htmlEscape="false" maxlength="50" class="form-control phone"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('传真')}：</label>
							<div class="col-sm-8">
								<form:input path="fax" htmlEscape="false" maxlength="50" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('邮箱')}：</label>
							<div class="col-sm-8">
								<form:input path="email" htmlEscape="false" maxlength="50" class="form-control email"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('备注')}：</label>
							<div class="col-sm-10">
								<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
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
					<div class="col-xs-12">
						<div class="col-sm-offset-3 col-sm-10">
							<shiro:hasPermission name="sys:office:edit">
								<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('保 存')}</button>&nbsp;
							</shiro:hasPermission>
							<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> ${fns:text('关 闭')}</button>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="validate"/>
<script type="text/javascript">
	$(document).ready(function() {
		if("${office.status}"=="2"){
			$('input').attr("disabled","disabled");
			$('textArea').attr("disabled","disabled");
			$('button[type="submit"]').addClass('display-none');
		}
		$("#inputForm").validate({
			submitHandler: function(form){
				ajaxSubmitForm($(form), function(data){
					showMessage(data.message);
					if(data.result == Global.TRUE){
// 						showMessage('本次操作之后仅显示本级数据，若想查看全部数据，请点击“全部”按钮。', '', 'info', 3000);
						closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
// 							contentWindow.dataGrid.refreshTree(1, $('#parentCode').val());
							contentWindow.$('#dataGrid').dataGrid('refreshTreeChildren',
									$('#parentCode').val(), ${office.isNewRecord});
						});
					}
				}, "json");
		    }
		});
	});
</script>