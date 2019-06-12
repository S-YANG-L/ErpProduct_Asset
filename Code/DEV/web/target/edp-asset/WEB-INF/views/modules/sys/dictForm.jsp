<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="字典管理 - ${dict.isNewRecord ? '新增' : '编辑'}字典" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa icon-social-dropbox"></i>${dict.isNewRecord ? '新增' : '编辑'}字典<c:if test="${!dict.isRoot || not empty param.parentCode}">（${dict.type}）</c:if></div>
		<%-- <div class="actions">
			<shiro:hasPermission name="sys:dict:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="dict" action="${ctx}/sys/dict/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<div class="row ${!dict.isRoot || not empty param.parentCode ? '' : 'hide'}">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">上级名称：</label>
							<div class="col-sm-8">
								<sys:treeselect id="parent" name="parent.id" value="${dict.parent.id}" labelName="parent.name" labelValue="${dict.parent.name}"
									title="上级名称" url="/sys/dict/treeData" extCode="${dict.id}" cssClass="" allowClear="true"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6 hide">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 唯一编码：</label>
							<div class="col-sm-8">
								<form:hidden path="isNewRecord"/>
								<form:input path="dictCode" htmlEscape="false" maxlength="64" readonly="${!dict.isNewRecord}" class="form-control abc required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 字典名称：</label>
							<div class="col-sm-8">
								<form:input path="name" htmlEscape="false" maxlength="100" class="form-control required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row ${!dict.isRoot || not empty param.parentCode ? 'hide' : ''}">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="标识字典类型，字典调用获取参数。例如：DictUtils.getDictList('dict_type')">
								<span class="required">*</span> 字典类型：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:input path="type" htmlEscape="false" maxlength="100" class="form-control required" readonly="${!dict.isRoot || not empty param.parentCode}"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row ${!dict.isRoot || not empty param.parentCode ? '' : 'hide'}">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 字典编码：</label>
							<div class="col-sm-8">
								<form:input path="value" htmlEscape="false" maxlength="100" class="form-control ${!dict.isRoot || not empty param.parentCode ? 'required' : ''}"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="排列序号（升序）">
								<span class="required">*</span> 排列顺序：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:input path="sorts" htmlEscape="false" maxlength="18" class="form-control required digits"/>
								<span class="help-block">排序（升序）&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row ${!dict.isRoot || not empty param.parentCode ? 'hide' : ''}">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="内置字段只允许超级管理员编辑修改。">
								<span class="required">*</span> 是否系统内置：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="isSys" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" 
										htmlEscape="false" class="required" readonly="${!dict.isRoot || not empty param.parentCode}"/>
								</div>
								<span class="help-block">系统内置（1是 0否）&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
<!-- 				<h4 class="form-section">其它信息</h4> -->
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">字典描述：</label>
							<div class="col-sm-8">
								<form:input path="description" htmlEscape="false" maxlength="100" class="form-control"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row ${!dict.isRoot || not empty param.parentCode ? '' : 'hide'}">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="CSS样式（如：style=“color:red”, 请填写：color:red）">CSS样式：</label>
							<div class="col-sm-8">
								<form:input path="cssStyle" htmlEscape="false" maxlength="500" class="form-control"/>
								<span class="help-block">CSS样式（如：style="color:red", 请填写：color:red）&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row ${!dict.isRoot || not empty param.parentCode ? '' : 'hide'}">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="CSS类名（如：class=“red”, 请填写：red）">CSS类名：</label>
							<div class="col-sm-8">
								<form:input path="cssClass" htmlEscape="false" maxlength="500" class="form-control"/>
								<span class="help-block">CSS类名（如：class="red", 请填写：red）&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">备注信息：</label>
							<div class="col-sm-8">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:dict:edit">
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
					showMessage('本次操作之后仅显示本级数据，若想查看全部数据，请点击“全部”按钮。', '', 'info', 3000);
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
// 						contents.find('#type').val('');
// 						contentWindow.dataGrid.refreshTree(1, $('#parentCode').val());
						contentWindow.$('#dataGrid').dataGrid('refreshTreeChildren',
								$('#parentCode').val(), ${dict.isNewRecord});
					});
				}
			}, "json");
	    }
	});
</script>