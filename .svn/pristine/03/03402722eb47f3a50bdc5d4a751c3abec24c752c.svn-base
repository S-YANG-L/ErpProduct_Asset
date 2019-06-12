<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="用户字典管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa icon-notebook"></i> ${userDict.dictTypeName}管理</div>
		<div class="actions">
<!-- 			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a> -->
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="刷新"><i class="fa fa-refresh"></i> 全部</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExpandTreeNode" title="展开一级"><i class="fa fa-angle-double-down"></i> 展开</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCollapseTreeNode" title="折叠全部"><i class="fa fa-angle-double-up"></i> 折叠</a>
			<shiro:hasPermission name="sys:userDict:edit">
				<a href="${ctx}/sys/userDict/form?dictTypeCode=${userDict.dictTypeCode}&dictTypeName=${userDict.dictTypeName}" class="btn btn-default btn-sm btnTool" title="新增用户字典"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="userDict" action="${ctx}/sys/userDict/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<input type="hidden" id="status" name="status" value=""/>
			<form:hidden path="dictTypeCode"/>
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
			{header:'字典名称', name:'dictName', index:'a.dict_name', width:200, frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/userDict/form?dictCode='+row.dictCode+'" class="btnList"'
					+(row.status=='2'?' style="color:#aaa"':'')+' data-title="编辑用户字典">'+(val ? val : row.dictCode)+'</a>';
			}},
			{header:'字典编码', name:'dictValue', index:'a.dict_value', width:200, align:"center"},
// 			{header:'字典类型', name:'dictTypeCode', index:'a.dict_type_code', width:200},
			{header:'排序', name:'sorts', index:'a.sorts', width:50, fixed:true, align:'center'},
			{header:'系统内置', name:'isSys', width:80, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('yes_no')}, val, '未知', true);
			}},
			{header:'描述', name:'description', index:'a.description', width:200},
			{header:'备注信息', name:'remarks', index:'a.remarks', width:200},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:200},
			{header:'操作', name:'actions', width:120, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				//<shiro:hasPermission name="sys:userDict:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/userDict/form?dictCode='+row.dictCode+'" class="btnList" title="编辑用户字典"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/userDict/disable?dictCode='+row.dictCode+'" class="btnList" title="停用用户字典" data-confirm="确认要停用该用户字典吗？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/sys/userDict/enable?dictCode='+row.dictCode+'" class="btnList" title="启用用户字典" data-confirm="确认要启用该用户字典吗？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/userDict/delete?dictCode='+row.dictCode+'"  class="btnList" title="删除用户字典" data-confirm="确认要删除该用户字典及所有子用户字典吗？" data-confirm-success="$(\'#dataGrid\').dataGrid(\'delTreeNode\',\''+row.dictCode+'\');"><i class="fa fa-trash-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/userDict/form?dictTypeCode=${userDict.dictTypeCode}&dictTypeName=${userDict.dictTypeName}&parentCode='+row.dictCode+'" class="btnList" title="新增下级用户字典"><i class="fa fa-plus-square"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		treeGrid: true,			// 启用树结构表格
		defaultExpandLevel: 0,	// 默认展开的层次
		ajaxSuccess: function(data){ // 加载成功后执行方法

		}
	});
</script>