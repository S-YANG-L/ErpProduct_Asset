<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="编码规范子表管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 编码规范子表管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="ass:codeRules:edit">
				<a href="${ctx}/ass/codeRules/form" class="btn btn-default btn-sm btnTool" title="新增编码规范子表"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="codeRules" action="${ctx}/ass/codeRules/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">规则编码名称：</label>
				<div class="input-inline">
					<form:input path="rulesItemName" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">编码格式：</label>
				<div class="input-inline">
					<form:input path="codeFormat" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
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
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
			{header:'规则编码名称', name:'rulesItemName', index:'a.rules_item_name', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/ass/codeRules/form?id='+row.id+'" class="btnList" data-title="编辑编码规范子表">'+(val ? val : row.id)+'</a>';
			}},
			{header:'编码格式', name:'codeFormat', index:'a.code_format', width:200, align:"left"},
			{header:'编码格式内容', name:'codeFormatContent', index:'a.code_format_content', width:200, align:"left"},
			{header:'编码长度', name:'codeLen', index:'a.code_len', width:200, align:"left"},
			{header:'规则备注', name:'rulesRemarks', index:'a.rules_remarks', width:200, align:"left"},
			{header:'排序', name:'codeSort', index:'a.code_sort', width:200, align:"left"},
			{header:'备注信息', name:'remarks', index:'a.remarks', width:200, align:"left"},
			{header:'创建时间', name:'createDate', index:'a.create_date', width:200, align:"left"},
			{header:'更新者', name:'updateBy.userCode', index:'a.update_by', width:200, align:"left"},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:200, align:"left"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="ass:codeRules:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/ass/codeRules/form?id='+row.id+'" class="btnList" title="编辑编码规范子表"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/ass/codeRules/delete?id='+row.id+'" class="btnList" title="删除该编码规范子表" data-confirm="确认要删除该编码规范子表吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>