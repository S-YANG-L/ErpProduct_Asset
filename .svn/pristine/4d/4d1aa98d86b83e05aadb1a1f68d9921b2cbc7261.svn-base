<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="表单查询管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 列表版本管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="form:formQuery:edit">
				<a href="${ctx}/form/formQuery/form?queryKey=${formQuery.queryKey}&entityId=${formQuery.entityId}&isCopy=1" class="btn btn-default btn-sm btnTool" title="新增表单查询"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="formQuery" action="${ctx}/form/formQuery/queryVersionListData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<form:hidden path="queryKey"/>
			<div class="form-group">
				<label class="control-label">查询名称：</label>
				<div class="input-inline">
					<form:input path="queryName" htmlEscape="false" maxlength="200" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">表单分类：</label>
				<div class="input-inline width-160">
					<sys:treeselect id="categoryCode" name="categoryCode" value="${formQuery.categoryCode}"
						labelName="formCategory.categoryName" labelValue="${formQuery.formCategory.categoryName}" 
						title="表单分类" url="/form/formCategory/treeData" cssClass="form-control required" allowClear="false"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">状态：</label>
				<div class="input-inline">
					<form:select path="status" class="form-control width-120 input-sm">
						<form:option value="" label="请选择"/>
						<form:options items="${fns:getDictList('search_status')}"  itemLabel="label" itemValue="value" htmlEscape="false"/>
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
<script type="text/javascript">
	var SelectRowIndx;
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
			{header:'查询列表名称', name:'queryName', index:'a.query_name', width:180, align:"left"},

			{header:'查询列表key', name:'queryKey', index:'a.query_key', width:160, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/form/formQuery/form?queryId='+row.queryId+'" class="btnList" data-title="编辑表单查询">'+(val ? val : row.queryId)+'</a>';
			}},
			{header:'查询列表标题', name:'queryTitle', index:'a.query_title', width:250, align:"left"},
			{header:'表单分类', name:'formCategory.categoryName', index:'a.category_code', width:160, align:"center"},
			{header:'表单版本号', name:'queryVersion', index:'a.form_version', width:120, align:"center",formatter: function(val, obj, row, act){
				return '<a href="${ctx}/form/formQuery/formDefVersionList?formKey='+row.formKey+'&entityId='+row.entityId+'" class="btnList" data-title="表单版本">'+(val ? "V"+val : row.queryKey)+'</a>';
			}},
			{header:'是否主版本', name:'isMainVersion', index:'a.is_main_version', width:120, align:"center",formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('form_post_status')},val,'',true);
			}},
			{header:'生成类型', name:'queryGenerationType', index:'a.query_generation_type', width:100, align:"center",formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('form_query_gener_type')},val,'',true);
			}},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:200, align:"center"},
			{header:'操作', name:'actions', width:160, fixed:true, sortable:false, align:"center",formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="form:formQuery:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/form/formQuery/form?queryId='+row.queryId+'" class="btnList" title="编辑查询列表"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formQuery/updateMainVersion?queryId='+row.queryId+'&queryKey='+row.queryKey+'" class="btnList" title="发布版本" data-confirm="确认要发布该版本吗？"><i class="fa fa-play"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formQuery/form?queryId='+row.queryId+'&isCopy=true"  class="btnList" title="复制查询列表"><i class="fa fa-copy"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formQuery/disable?queryId='+row.queryId+'" class="btnList" title="停用列表" data-confirm="确认要停用该列表及所有子版本吗？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/list?queryId='+row.queryId+'&queryKey='+row.queryKey+'" class="btnList" title="预览列表文件"><i class="fa fa-search-plus"></i></a>&nbsp;');
				}
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/form/formQuery/enable?queryId='+row.queryId+'" class="btnList" title="启用表单" data-confirm="确认要启用该列表及所有子表单吗？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formQuery/delete?queryId='+row.queryId+'" class="btnList" title="删除列表查询" data-confirm="确认要删除该查询列表吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
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
<style type="text/css">
.SelectBG{
    color:#71C671;
}
</style>