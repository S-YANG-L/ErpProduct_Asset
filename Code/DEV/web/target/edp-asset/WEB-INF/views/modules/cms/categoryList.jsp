<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${fns:text('栏目管理')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title dropdown">
		&nbsp;<div class="caption dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">
			<i class="fa fa-gear"></i> ${fnc:getSite(fnc:getCurrentSiteCode()).siteName} <b class="caret"></b>
		</div>
		<ul class="dropdown-menu">
			<c:forEach items="${fnc:getSiteList()}" var="site">
				<li><a href="${ctx}/cms/site/select?siteCode=${site.siteCode}&redirect=${fns:getAdminPath()}/cms/category/list">
					<i class="fa fa-angle-right"></i> ${site.siteName}</a></li>
			</c:forEach>
		</ul>
		<div class="actions">
<!-- 			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a> -->
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="${fns:text('刷新')}"><i class="fa fa-refresh"></i> ${fns:text('全部')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExpandTreeNode" title="${fns:text('展开')}"><i class="fa fa-angle-double-down"></i> ${fns:text('展开')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCollapseTreeNode" title="${fns:text('折叠全部')}"><i class="fa fa-angle-double-up"></i> ${fns:text('折叠')}</a>
			<shiro:hasPermission name="cms:category:edit">
				<a href="${ctx}/cms/category/form" class="btn btn-default btn-sm btnTool" title="${fns:text('新增栏目')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:menu:edit">
				<input id="btnUpdateSort" class="btn btn-default btn-sm" type="button" value="${fns:text('保存排序')}"/>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="category" action="${ctx}/cms/category/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="${fns:text('查询')}"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="${fns:text('重置')}"/>
			</div>
		</form:form>
		<form:form id="tableForm" action="${ctx}/cms/category/updateSorts" method="post">
			<table id="dataGrid"></table>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	// 初始化DataGrid对象
	var dataGrid = new DataGrid({
			
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
	 		{header:'${fns:text("名称")}', name:'categoryName', width:200, formatter: function(val, obj, row, act){
				return '( '+row.categoryCode+' ) '+'<a href="${ctx}/cms/category/form?categoryCode='+row.categoryCode+'" class="btnList" data-title="编辑栏目">'+(val ? val : row.id)+'</a>';
			}},
			{header:'${fns:text("模型")}', name:'module', width:80, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('cms_module')}, val, '公共模型', true);
			}},
			{header:'${fns:text("排序")}', name:'sorts', width:63, align:"center", fixed:true, formatter: function(val, obj, row, act){
				var html = [];//<shiro:hasPermission name="cms:category:edit">
				html.push('<input type="hidden" name="ids" value="'+row.id+'"/>');
				html.push('<input name="sorts" type="text" value="'+row.sorts+'" style="width:50px;height:19px;margin:0;padding:0;text-align:center;">');
				//</shiro:hasPermission><shiro:lacksPermission name="cms:category:edit">
				html.push(row.sorts);
				//</shiro:lacksPermission>
				return html.join('');
			}},
			{header:'${fns:text("导航栏目")}', name:'inMenu', width:50, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('show_hide')}, val, '未知', true);
			}},
			{header:'${fns:text("栏目列表")}', name:'inList', width:50, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('show_hide')}, val, '未知', true);
			}},
			{header:'${fns:text("展现方式")}', name:'showModes', width:100, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('cms_show_modes')}, val, '未知', true);
			}},
			{header:'${fns:text("操作")}', name:'actions', width:100, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="cms:category:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/cms/category/form?categoryCode='+row.categoryCode+'" class="btnList" title="${fns:text("编辑栏目")}"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/cms/category/delete?categoryCode='+row.categoryCode+'" class="btnList" title="${fns:text("删除栏目")}" data-confirm="${fns:text("确认要删除该栏目及所有子栏目吗")}？" data-confirm-success="dataGrid.delTreeNode(\''+row.id+'\');"><i class="fa fa-trash-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/cms/category/form?parentCode='+row.categoryCode+'" class="btnList" title="${fns:text("新增下级栏目")}"><i class="fa fa-plus-square"></i></a>&nbsp;');
					//<shiro:hasPermission name="cms:category:editIndex">
					actions.push('<a href="${ctx}/cms/category/editIndex?categoryCode='+row.categoryCode+'" class="btnList" title="${fns:text("重建该栏目索引")}" data-confirm="${fns:text("确认重建该栏目下文章索引吗")}？"><i class="fa fa-crosshairs"></i></a>&nbsp;');
					//</shiro:hasPermission>
					actions.push('<a href="${pageContext.request.contextPath}${fns:getFrontPath()}/list-'+row.categoryCode+'" target="_blank" title="${fns:text("浏览栏目")}"><i class="fa fa-globe"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		treeGrid: true,			// 启用树结构表格
		defaultExpandLevel: 0,	// 默认展开的层次
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
	//绑定更新排序按钮
	$('#btnUpdateSort').click(function(){
		 ajaxSubmitForm($("#tableForm"), function(data){
			if(data.result == Global.TRUE){
				$('#btnRefreshTree').click();
			}
			showMessage(data.message);
		}, "json");
	});
</script>