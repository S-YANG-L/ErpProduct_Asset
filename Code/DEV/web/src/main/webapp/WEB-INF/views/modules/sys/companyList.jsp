<%@ page contentType="text/html;charset=UTF-8"  trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${fns:text('公司管理')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${fns:text('公司管理')}</div>
		<div class="actions">
<!-- 			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a> -->
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="${fns:text('全部')}"><i class="fa fa-refresh"></i> ${fns:text('全部')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExpandTreeNode" title="${fns:text('展开')}"><i class="fa fa-angle-double-down"></i> ${fns:text('展开')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCollapseTreeNode" title="${fns:text('折叠')}"><i class="fa fa-angle-double-up"></i> ${fns:text('折叠')}</a>
			<shiro:hasPermission name="sys:company:edit">
				<a href="${ctx}/sys/company/form" class="btn btn-default btn-sm btnTool" title="${fns:text('新增公司')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="company" action="${ctx}/sys/company/listData" method="post" class="breadcrumb form-inline hide">
			<input id="status" name="status" value=""/>
			<div class="form-group" > &nbsp; &nbsp;
				<input class="btn btn-primary btn-sm" type="submit" value="${fns:text('查询')}"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="${fns:text('重置')}"/>
			</div>	
		</form:form>
		<table id="dataGrid"></table>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	//初始化DataGrid对象
	$('#dataGrid').dataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'${fns:text("公司简称")}', name:'companyNameSimple', width:200, formatter: function(val, obj, row, act){
				return '<span'+(row.status=='2'?' style="color:#aaa"':'')+'>( '+row.viewCode+' )</span> '
						+'<a href="${ctx}/sys/company/form?companyCode='+row.id+'" class="btnList"'
						+(row.status=='2'?' style="color:#aaa"':'')+' data-title="${fns:text("编辑公司")}">'+val+'</a>';
			}},
			{header:'${fns:text("公司全称")}', name:'companyName', width:200},
			{header:'${fns:text("注册地区")}', name:'area.areaName', width:100, align:"center"},
			{header:'${fns:text("备注")}', name:'remarks', width:100},
			{header:'${fns:text("状态")}', name:'status', width:50, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('status')}, val, '${fns:text("未知")}', true);
			}},
			{header:'${fns:text("操作")}', name:'actions', width:120, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:company:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/company/form?companyCode='+row.id+'" class="btnList" title="${fns:text("编辑公司")}"><i class="fa fa-pencil"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:company:enable">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/company/disable?companyCode='+row.id+'" class="btnList" title="${fns:text("停用公司")}" data-confirm="${fns:text("确认要停用该公司吗")}？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:company:disable">
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/sys/company/enable?companyCode='+row.id+'" class="btnList" title="${fns:text("启用公司")}" data-confirm="${fns:text("确认要启用该公司吗")}？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:company:edit">
				actions.push('<a href="${ctx}/sys/company/delete?companyCode='+row.id+'" class="btnList" title="${fns:text("删除公司")}" data-confirm="${fns:text("确认要删除该公司及所有子公司吗？")}" data-confirm-success="$(\'#dataGrid\').dataGrid(\'delTreeNode\',\''+row.id+'\');"><i class="fa fa-trash-o"></i></a>&nbsp;');
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/company/form?parentCode='+row.id+'" class="btnList" title="${fns:text("新增下级公司")}"><i class="fa fa-plus-square"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:office:view">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/office/list?company.companyCode='+row.id+'&company.companyName='+row.companyName+'" class="btnList" title="查找'+row.companyName+'的机构"><i class="fa fa-coffee"></i></a>&nbsp;');
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