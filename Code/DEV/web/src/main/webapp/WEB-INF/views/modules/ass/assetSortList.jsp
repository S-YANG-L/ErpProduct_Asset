<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="分类管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 分类管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="刷新"><i class="fa fa-refresh"></i> 全部</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExpandTreeNode" title="展开一级"><i class="fa fa-angle-double-down"></i> 展开</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCollapseTreeNode" title="折叠全部"><i class="fa fa-angle-double-up"></i> 折叠</a>
			<shiro:hasPermission name="ass:assetSort:edit">
				<a href="${ctx}/ass/assetSort/form" class="btn btn-default btn-sm btnTool" title="新增分类"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="assetSort" action="${ctx}/ass/assetSort/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">分类名称：</label>
				<div class="input-inline">
					<form:input path="sortName" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
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
			{header:'分类编码', name:'sortCode', index:'a.sort_code', width:200, align:"center", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/ass/assetSort/form?id='+row.id+'" class="btnList" data-title="编辑分类">'+(val ? val : row.id)+'</a>';
			}},
			{header:'分类名称', name:'sortName', index:'a.sort_name', width:200, align:"left"},
			{header:'分类级别', name:'sortGrade', index:'a.sort_grade', width:200, align:"center"},
			{header:'使用年限(月)', name:'ageLimit', index:'a.age_limit', width:200, align:"center"},
			{header:'净残值率', name:'netsalvageRate', index:'a.netsalvage_rate', width:200, align:"right",frozen:true, formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="netsalvageRate" value="' + val + '"/>');
                    actions.push(formatRate(val));
                    return actions.join('');
                }
			},
			{header:'计量单位', name:'assetUnit', index:'a.asset_unit', width:200, align:"center"},
			{header:'备注', name:'memo', index:'a.memo', width:200, align:"left"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				//<shiro:hasPermission name="ass:assetSort:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/ass/assetSort/form?id='+row.id+'" class="btnList" title="编辑分类"><i class="fa fa-pencil"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="ass:assetSort:enable">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/ass/assetSort/disable?id='+row.id+'" class="btnList" title="停用分类" data-confirm="确认要停用该分类吗？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="ass:assetSort:disable">
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/ass/assetSort/enable?id='+row.id+'" class="btnList" title="启用分类" data-confirm="确认要启用该分类吗？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="ass:assetSort:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/ass/assetSort/delete?id='+row.id+'"  class="btnList" title="删除分类" data-confirm="确认要删除该分类及所有子分类吗？" data-confirm-success="$(\'#dataGrid\').dataGrid(\'delTreeNode\',\''+row.id+'\');"><i class="fa fa-trash-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/ass/assetSort/form?parentCode='+row.id+'" class="btnList" title="新增下级分类"><i class="fa fa-plus-square"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		treeGrid: true,			// 启用树结构表格
		defaultExpandLevel: 0,	// 默认展开的层次
		ajaxSuccess: function(data){ // 加载成功后执行方法
		}
	});
    /***格式化
     *@params netsalvageRate {Number or String} 比率
     *@params digit {Number} 小数点的位数，不够补0
     *@returns {String} 格式化后的比率
     **/
    function formatRate(rate, digit) {
        var tpRate = '0.0000';
        if (undefined != rate) {
            tpRate = rate;
        }
        tpRate = new Number(tpRate);
        if (isNaN(tpRate)) {
            return '0.0000';
        }
        if (digit == null || digit == '') {
            digit = 4;
        }
        tpRate = tpRate.toFixed(digit) + '';
        var re = /^(-?\d+)(\d{5})(\.?\d*)/;
        while (re.test(tpRate)) {
            tpRate = tpRate.replace(re, "1,2345")
        }
        return '%'+tpRate;
    }
</script>