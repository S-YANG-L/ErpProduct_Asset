<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="字段管理 - ${formEntityColumn.isNewRecord ? '新增' : '编辑'}字段" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}2 autoHeight">
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formEntityColumn" action="${ctx}/form/formEntityColumn/save" method="post" class="form-horizontal">
			<div class="form-body">
				<!-- jbox方式打开的时候不显示 -->
				<c:if test="${openFlag ne 'jbox'}">
					<h4 class="form-section">配置字段：${formEntityColumn.columnName}</h4>
				</c:if>
				<form:hidden path="id"/>
				<form:hidden path="entityId"/>
				<form:hidden path="columnName"/>
				<form:hidden path="tableName" value="${formTableColumn.tableName }"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="指定表单中控件的类型">
								控件显示类型：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:select path="showType" class="form-control" id="showType" onchange="showTypeChange(this.value);">
									<form:option value="" label="请选择"/>
									<form:options items="${fns:getDictList('form_tag_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
								</form:select>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="指定表单中控件的名称">
								<span class="required">*</span> 字段描述：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<c:if test="${not empty formEntityColumn.columnComment}">
									<form:input path="columnComment" cssClass="form-control"/>
								</c:if>
								<c:if test="${empty formEntityColumn.columnComment}">
									<input type="text" name="columnComment" value="${formEntityColumn.columnName}" class="form-control required" />
								</c:if>
							</div>
						</div>
					</div>
				</div>
				<div id="centerPage">
				
				</div>
				<!-- 其他start -->
					<%@ include file="/WEB-INF/views/modules/form/include/formEntityColumnOther.jsp"%>
				<!-- 其他end -->
			</div>
			<c:if test="${openFlag ne 'jbox'}">
				<div class="form-actions fluid">
					<div class="row">
						<div class="col-sm-offset-2 col-sm-10">
							<shiro:hasPermission name="form:formEntityColumn:edit">
								<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
							</shiro:hasPermission>
							<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
						</div>
					</div>
				</div>
			</c:if>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/form/js/form-public.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/form/js/form-entity-column.js?${_version}" type="text/javascript"></script>
<style>
.panel-default{
	margin-left: 15px;
}
</style>
<script type="text/javascript">
	var result;
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				result = data;
			}, "json",false);
	    }
	});
	
	//获取id  
	var id="${formEntityColumn.id}";
	/* var type="${formEntityColumn.formTableColumn.columnType}";
	var csize="${formEntityColumn.formTableColumn.columnSize}";
	var value="${formEntityColumn.formTableColumn.defaultValue}";
	var vType="${formEntityColumn.validType}";
	initEntityColumn(type,csize,value,vType); */
	$(function(){
		var showType="${formEntityColumn.showType}";
		showTypeChange(showType);
	});
	// 保存
	function saveEntityColumn(){
		$("#inputForm").submit();
		return result;
	}
</script>
