<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="语言管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 语言管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="sys:lang:edit">
				<a href="${ctx}/sys/lang/form" class="btn btn-default btn-sm btnTool" title="新增语言"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="lang" action="${ctx}/sys/lang/listData" method="post" class="breadcrumb form-inline hide2"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">编码：</label>
				<div class="input-inline">
					<form:input path="langCode" htmlEscape="false" maxlength="200" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">译文：</label>
				<div class="input-inline">
					<form:input path="langText" htmlEscape="false" maxlength="200" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">类型：</label>
				<div class="input-inline">
					<form:select path="langType" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
					    <form:option  value="">全部</form:option>
						<form:options items="${fns:getDictList('sys_lang_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
			{header:'编码', name:'langCode', index:'a.lang_code', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/lang/form?id='+row.id+'" class="btnList" data-title="编辑语言">'+(val ? val : row.id)+'</a>';
			}},
			{header:'译文', name:'langText', index:'a.lang_text', width:200, align:"left"},
			{header:'类型', name:'langType', index:'a.lang_type', width:100, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('sys_lang_type')}, val, '未知', true);
			}},
			{header:'备注信息', name:'remarks', index:'a.remarks', width:100, align:"left"},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:100, align:"center"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:lang:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/lang/form?id='+row.id+'" class="btnList" title="编辑语言"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/lang/delete?id='+row.id+'" class="btnList" title="删除该语言" data-confirm="确认要删除该语言吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>