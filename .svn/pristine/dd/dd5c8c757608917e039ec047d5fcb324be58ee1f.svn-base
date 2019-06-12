<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid"/>
<sys:header title="区域管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>区域列表</div>
		<div class="actions">
<!-- 			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a> -->
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="刷新"><i class="fa fa-refresh"></i> 全部</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExpandTreeNode" title="展开一级"><i class="fa fa-angle-double-down"></i> 展开</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCollapseTreeNode" title="折叠全部"><i class="fa fa-angle-double-up"></i> 折叠</a>
<%-- 			<shiro:hasPermission name="sys:office:edit"> --%>
				<a href="${ctx}/sys/office/form" class="btn btn-default btn-sm btnTool" title="新增区域"><i class="fa fa-plus"></i> 新增</a>
<%-- 			</shiro:hasPermission> --%>
			<a href="#" class="btn btn-default btn-sm" id="btnSaveData" title="保存数据"><i class="fa fa-plus"></i> 保存数据</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="office" action="${ctx}/sys/office/listData" method="post" class="breadcrumb form-inline hide">
			<div class="form-group" > &nbsp; &nbsp;
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>	
		</form:form>
		<table id="dataGrid"></table>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
var dataGrid; // 定义全局表格对象。
$(document).ready(function() {
	
	// 初始化DataGrid对象
	dataGrid = new DataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'区域名称', name:'officeName', width:200, formatter: function(val, obj, row, act){
				return '( '+row.officeCode+' ) '+'<a href="${ctx}/sys/office/form?officeCode='+row.id+'" class="btnList" data-title="编辑区域">'+val+'</a>';
			}},
			{header:'类型', name:'type', width:80, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('sys_office_type')}, val, '未知', true);
			}},
			//{header:'备注', name:'remarks', index:'remarks', width:200},
			{header:'分值', name:'score', index:'val', width:80, align:"center", fixed:true, formatter: function(val, obj, row, act){
				var html = [];
				html.push('<input name="score" type="text" value="'+(val ? val : '')+'"');
				html.push(' data-code="'+row.officeCode+'" data-name="'+row.officeName+'" data-sort-grade="'+row.sortGrade+'"');
				html.push(' style="width:95%;margin:0;padding:0;text-align:center;">');
				return html.join('');
			}},
			{header:'状态', name:'status', width:50, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('status')}, val, '未知', true);
			}}//,
// 			{header:'操作', name:'actions', width:100, sortable:false, formatter: function(val, obj, row, act){
// 				var actions = [];//<%--<shiro:hasPermission name="sys:office:edit">--%>
// 				if (row.status == Global.STATUS_NORMAL){
// 					actions.push('<a href="${ctx}/sys/office/form?officeCode='+row.id+'" class="btnList" title="编辑区域"><i class="fa fa-pencil"></i></a>&nbsp;');
// 					actions.push('<a href="${ctx}/sys/office/delete?officeCode='+row.id+'" class="btnList" title="删除区域" data-confirm="确认要删除该区域及所有子区域吗？" data-confirm-success="dataGrid.delTreeNode(\''+row.id+'\');"><i class="fa fa-trash-o"></i></a>&nbsp;');
// 					actions.push('<a href="${ctx}/sys/office/form?parentCode='+row.id+'" class="btnList" title="新增下级区域"><i class="fa fa-plus-square"></i></a>&nbsp;');
// 				}//<%--</shiro:hasPermission>--%>
// 				return actions.join('');
// 			}}
		],
		treeGrid: true,			// 启用树结构表格
		defaultExpandLevel: 0,	// 默认展开的层次
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		},
		// 展开节点事件
		onExpandNode: function(rc){
			$('#'+rc._id_+' input[name=score]').attr("disabled", true).hide();
			var dr = dataGrid.jqGrid("getNodeChildren", rc);
			for (i=0; i<dr.length; i++){
				$('#'+dr[i]._id_+' input[name=score]').attr("disabled", false).show();
			}
		},
		// 折叠节点事件
		onCollapseNode: function(rc){
			$('#'+rc._id_+' input[name=score]').attr("disabled", false).show();
			var dr = dataGrid.jqGrid("getNodeChildren", rc);
			for (i=0; i<dr.length; i++){
				$('#'+dr[i]._id_+' input[name=score]').attr("disabled", true).hide();
			}
		}
	});

	// 保存数据
	$('#btnSaveData').click(function(){
		// 获取表格中的输入框
		var scores = [], nullName = [];
		$('input[name=score]:not(:disabled)', dataGrid.jqGrid()).each(function(){
			var $t = $(this), code = $t.data('code'), name = $t.data('name'), sortGrade = $t.data('sortGrade'), score = $t.val();
			scores.push({code: code, name: name, sortGrade: sortGrade, score: score});
			if (score == ''){
				nullName.push(name);
			}
		});
		log(scores);
    	showMessage('以下分值为空：' + nullName);
    	showMessage('请打开浏览器控制台，看数据！');
	});
	
});

</script>