<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="表单定义管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 表单定义管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="form:formDef:edit">
				<a href="${ctx}/form/formDef/form?formKey=${formDef.formKey}&entityId=${formDef.entityId}&flag=true" class="btn btn-default btn-sm btnTool" title="新增表单定义信息"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="formDef" action="${ctx}/form/formDef/listVersionData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<!-- formKey隐藏 -->
			<form:input path="formKey" htmlEscape="false" type="hidden" value="${formDef.formKey}"/>
			<div class="form-group">
				<label class="control-label">表单名称：</label>
				<div class="input-inline">
					<form:input path="formName" htmlEscape="false" maxlength="200" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">表单分类：</label>
				<div class="input-inline width-160">
					<!--<form:input path="formCategory" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>-->
					<sys:treeselect id="formCategory" name="formCategory.categoryCode" value="${formDef.formCategory.categoryCode}"
						labelName="formCategory.categoryName" labelValue="${formDef.formCategory.categoryName}" controlSize="sm"
						title="表单分类" url="/form/formCategory/treeData" cssClass="form-control required" allowClear="false"/>
				</div>
			</div>
			<!-- 
			<div class="form-group">
				<label class="control-label">表单分类：</label>
				<div class="input-inline">
					<sys:treeselect id="formCategory" name="formCategory.categoryCode" value="${formTable.formCategory.categoryCode}"
						labelName="formCategory.categoryName" labelValue="${formTable.formCategory.categoryName}" controlSize="sm"
						title="表单分类" url="/form/formCategory/treeData" cssClass="form-control required" allowClear="false"/>
				</div>
			</div> -->
			<div class="form-group">
				<label class="control-label">表单类型：</label>
				<div class="input-inline">
					<!--<form:input path="formType" htmlEscape="false" maxlength="1" class="form-control input-sm width-160"/>-->
					<form:select path="formType" class="form-control nput-sm width-160" id="formType">
						<form:option value="" label="请选择"/>
						<form:options items="${fns:getDictList('form_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>
		</form:form>
		<table id="dataGrid"></table>
		<div id="dataGridPage"></div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<style type="text/css">
.SelectBG{
    /**background-color:#71C671;*/
    color:#71C671;
}
</style>
<script type="text/javascript">
	// 初始化DataGrid对象
	var SelectRowIndx;
	$("#dataGrid").dataGrid({
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
			{header:'表单名称', name:'formName', index:'a.form_name', width:200, align:"left"},
			{header:'表单key', name:'formKey', index:'a.form_key', width:200, align:"left"},
			{header:'表单标题', name:'formTitle', index:'a.form_title', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/form/formDef/form?formId='+row.formId+'" class="btnList" data-title="编辑表单">'+(val ? val : row.formId)+'</a>';
			}},
			{header:'表单类型', name:'formType', index:'a.form_type', width:200, align:"left",formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('form_type')},val,'',true);
			}},
			{header:'表单分类', name:'formCategory.categoryName', index:'a.form_category', width:200, align:"left"},
			{header:'表单版本号', name:'formVersion', index:'a.form_version', width:150, align:"center",formatter: function(val, obj, row, act){
				return ' V'+(val ? val : row.formKey)+' ';
			}},
			{header:'是否主版本', name:'isMainVersion', index:'a.is_main_version', width:150, align:"center",formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('form_post_status')},val,'',true);
			}},
			//{header:'备注信息', name:'remarks', index:'a.remarks', width:200, align:"left"},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:230, align:"center"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="form:formDef:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/form/formDef/form?formId='+row.formId+'&flag=true" class="btnList" title="编辑表单"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formDef/releaseForm?formId='+row.formId+'&formKey='+row.formKey+'" class="btnList" title="发布版本" data-confirm="确认要发布该版本吗？"><i class="fa fa-play"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formDef/delete?formId='+row.formId+'" class="btnList" title="删除该表单" data-confirm="确认要删除该表单吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		gridComplete: function () {// 设置表格数据加载完毕后，所执行的操作
            var ids = $("#dataGrid").getDataIDs();
            for (var i = 0; i < ids.length; i++) {
                var rowData = $("#dataGrid").getRowData(ids[i]);
                if (rowData.isMainVersion == "是") {// 如果发布状态，则背景色置于绿色
                    $('#' + ids[i]).find("td").addClass("SelectBG");
                }
            }
            $("#" + this.id).jqGrid('setSelection', SelectRowIndx);
        },
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>