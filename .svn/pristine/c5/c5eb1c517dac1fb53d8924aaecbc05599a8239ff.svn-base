<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid"/>
<sys:header title="字典管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa icon-social-dropbox"></i>${fns:text('系统字典')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="${fns:text('刷新')}"><i class="fa fa-refresh"></i> ${fns:text('全部')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExpandTreeNode" title="${fns:text('展开')}"><i class="fa fa-angle-double-down"></i> ${fns:text('展开')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCollapseTreeNode" title="${fns:text('折叠')}"><i class="fa fa-angle-double-up"></i> ${fns:text('折叠')}</a>
			<shiro:hasPermission name="sys:dict:edit">
				<a href="${ctx}/sys/dict/form" class="btn btn-default btn-sm btnTool" title="${fns:text('新增字典')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="dict" action="${ctx}/sys/dict/listData" method="post" class="breadcrumb form-inline hide">
			<input type="hidden" id="status" name="status" value=""/>
			<div class="form-group">
				<label class="control-label">${fns:text('字典名称')}：</label>
					<form:input path="name" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('字典类型')}：</label>
					<form:input path="type" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
			</div>
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
			{header:'${fns:text("字典名称")}&nbsp;<font style="font-weight:normal;">|</font>&nbsp;${fns:text("类型")}', name:'name', width:220, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/dict/form?dictCode='+row.id+'" class="btnList"'
					+(row.status=='2'?' style="color:#aaa"':'')+' data-title="${fns:text("编辑字典")}">'+val+'</a>'
					+(row.isRoot ? '  |  <a href="#" title="按类型查询" onclick="$(\'#type\').val($(this).text());$(\'#dataGrid\').dataGrid(\'refreshTree\',1);">'+row.type+'</a>' : '');
			}},
			{header:'${fns:text("字典编码")}', name:'value', width:100, align:"center"},
			{header:'${fns:text("排序")}', name:'sorts', width:50, align:"center"},
			{header:'${fns:text("系统内置")}', name:'isSys', width:50, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('yes_no')}, val, '未知', true);
			}},
			{header:'${fns:text("字典描述")}', name:'description', width:100},
			{header:'${fns:text("更新时间")}', name:'updateDate', width:150, fixed:true, align:"center"},
			{header:'${fns:text("操作")}', name:'actions', width:100, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:dict:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/dict/form?dictCode='+row.id+'" class="btnList" title="编辑字典"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/dict/disable?dictCode='+row.id+'" class="btnList" title="停用字典" data-confirm="确认要停用该字典及所有子字典吗？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/sys/dict/enable?dictCode='+row.id+'" class="btnList" title="启用字典" data-confirm="确认要启用该字典及所有子字典吗？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/dict/delete?dictCode='+row.id+'" class="btnList" title="删除字典" data-confirm="确认要删除该字典及所有子字典吗？" data-confirm-success="$(\'#dataGrid\').dataGrid(\'delTreeNode\',\''+row.id+'\');"><i class="fa fa-trash-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/dict/form?parentCode='+row.id+'" class="btnList" title="新增下级字典"><i class="fa fa-plus-square"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		treeGrid: true,			// 启用树结构表格
		defaultExpandLevel: 0,	// 默认展开的层次
		expandNodeClearPostData: 'name,type', // 展开节点清理请求参数数据
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
</script>