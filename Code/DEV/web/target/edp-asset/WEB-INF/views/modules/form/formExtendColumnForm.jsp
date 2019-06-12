<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<style>
.panel-default{
	margin-left: 15px;
}
</style>
<sys:header title="字段管理 - ${formEntityColumn.isNewRecord ? '新增' : '编辑'}字段" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}2 autoHeight">
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formEntityColumn" action="${ctx}/form/formEntityColumn/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">配置字段：${formEntityColumn.columnName}&nbsp;&nbsp;&nbsp;<c:if test="${not empty formEntityColumn.formTableColumn.columnComment}">字段描述：${formEntityColumn.formTableColumn.columnComment}</c:if></h4>
				<form:hidden path="id"/>
				<form:hidden path="entityId"/>
				<form:hidden path="columnName"/>
				<form:hidden path="tableName" value="${formTableColumn.tableName}"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								控件显示类型：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:select path="showType" class="form-control" id="showType" onchange="showTypeChange(this.value)">
									<form:option value="" label="请选择"/>
									<form:options items="${fns:getDictList('form_extend_tag_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
								</form:select>
							</div>
						</div>
					</div>
				</div>
				<div id="centerPage">
				</div>
				<!-- 附件配置 -->
				<%@ include file="/WEB-INF/views/modules/form/include/formEntityColumnFile.jsp"%>
			</div>
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
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
			}, "json");
	    }
	});
	showTypeChange('${formEntityColumn.showType}');
	function showTypeChange(val){
		if(val=='file'){
			$("#fileConfig").show();
		}
	}
</script>
