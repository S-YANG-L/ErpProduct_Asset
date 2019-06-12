<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${fns:text('菜单管理')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-list-alt"></i> ${fns:text('菜单管理')}（
			<div class="dropdown input-inline">
				<div class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">
					${fns:getDictLabel(menu.sysCode, 'menu_sys_code', fns:text('全部菜单'))}<b class="caret"></b>
				</div>
				<ul class="dropdown-menu">
					<c:forEach items="${fns:getDictList('menu_sys_code')}" var="dict">
						<li><a href="${ctx}/sys/menu/list?sysCode=${dict.value}">
							<i class="fa fa-angle-right"></i> ${dict.label}</a></li>
					</c:forEach>
				</ul>
			</div> ）
		</div>
		<div class="actions">
<!-- 			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a> -->
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="${fns:text('全部')}"><i class="fa fa-refresh"></i> ${fns:text('全部')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExpandTreeNode" title="${fns:text('展开')}"><i class="fa fa-angle-double-down"></i> ${fns:text('展开')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCollapseTreeNode" title="${fns:text('折叠')}"><i class="fa fa-angle-double-up"></i> ${fns:text('折叠')}</a>
			<shiro:hasPermission name="sys:menu:edit">
				<a href="${ctx}/sys/menu/form?sysCode=${menu.sysCode}" class="btn btn-default btn-sm btnTool" title="${fns:text('新增')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:menu:edit">
				<input id="btnUpdateSort" class="btn btn-default btn-sm" type="button" value="${fns:text('保存排序')}"/>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="menu" action="${ctx}/sys/menu/listData" method="post" class="breadcrumb form-inline hide">
			<form:hidden path="moduleCode" cssClass="isReset"/>
			<form:hidden path="sysCode"/>
			<div class="form-group">
				<label class="control-label">名称：</label>
				<div class="input-inline width-160" >
					<form:input path="name" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group" > &nbsp; &nbsp;
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>	
		</form:form>
		<form:form id="tableForm" action="${ctx}/sys/menu/updateSorts" method="post">
			<table id="dataGrid"></table>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	
	// 初始化DataGrid对象
	$('#dataGrid').dataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'${fns:text("菜单名称")}', name:'name', width:200, formatter: function(val, obj, row, act){
				return '<i class="'+row.icon+'" style="color:'+row.color+'"></i> <a href="${ctx}/sys/menu/form?menuCode='
						+row.id+'" class="btnList" style="color:'+row.color+'" data-title="编辑菜单">'+val+'</a>';
			}},
			{header:'${fns:text("归属模块")}', name:'moduleCode', width:100, align:"center", formatter: function(val, obj, row, act){
				return '<a href="javascript:" title="按模块查询" onclick="$(\'#moduleCode\').val($(this).text());$(\'#dataGrid\').dataGrid(\'refreshTree\',1);">'+val+'</a>';
			}},
			{header:'${fns:text("链接(Href)")}', name:'href', width:150},
			{header:'${fns:text("排序")}', name:'sorts', width:63, align:"center", fixed:true, formatter: function(val, obj, row, act){
				var html = [];//<shiro:hasPermission name="sys:menu:edit">
				html.push('<input type="hidden" name="ids" value="'+row.id+'"/>');
				html.push('<input name="sorts" type="text" value="'+row.sorts+'" style="width:50px;height:19px;margin:0;padding:0;text-align:center;">');
				//</shiro:hasPermission><shiro:lacksPermission name="sys:menu:edit">
				html.push(row.sorts);
				//</shiro:lacksPermission>
				return html.join('');
			}},
			{header:'${fns:text("菜单类型")}', name:'type', width:90, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('menu_type')}, val, '未知', true);
			}},
			{header:'${fns:text("可见")}', name:'isShow', width:80, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('show_hide')}, val, '未知', true);
			}},
			{header:'${fns:text("权限标识")}', name:'permission', width:150},
			{header:'${fns:text("菜单权重")}', name:'weight', width:80, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('menu_weight')}, val, '未知', true);
			}},
			{header:'${fns:text("操作")}', name:'actions', width:100, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:menu:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/menu/form?menuCode='+row.id+'" class="btnList" title="${fns:text("编辑菜单")}"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/menu/delete?menuCode='+row.id+'" class="btnList" title="${fns:text("删除菜单")}" data-confirm="${fns:text("确认要删除该菜单及所有子菜单吗？")}" data-confirm-success="$(\'#dataGrid\').dataGrid(\'delTreeNode\',\''+row.id+'\');"><i class="fa fa-trash-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/menu/form?parentCode='+row.id+'&sysCode='+row.sysCode+'" class="btnList" title="${fns:text("新增下级菜单")}"><i class="fa fa-plus-square"></i></a>&nbsp;');
					//actions.push('<a href="#" title="只看本节点" onclick="dataGrid.refreshTree(1, \''+row.id+'\')"><i class="fa fa-arrow-circle-down"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		treeGrid: true,			// 启用树结构表格
		defaultExpandLevel: ${menu.sysCode eq 'corpAdmin' or menu.sysCode eq 'superAdmin' ? 1 : 0},	// 默认展开的层次
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
	// 绑定更新排序按钮
	$('#btnUpdateSort').click(function(){
		 ajaxSubmitForm($("#tableForm"), function(data){
			if(data.result == Global.TRUE){
				$('#btnRefreshTree').click();
			}
			showMessage(data.message);
		}, "json");
	});
	
</script>