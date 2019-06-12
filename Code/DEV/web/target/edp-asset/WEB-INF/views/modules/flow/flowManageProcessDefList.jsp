<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="流程定义管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i> 流程定义管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="sys:role:edit">
				<a href="${ctx}/flow/manage/processDef/form" class="btn btn-default btn-sm btnTool" title="新发布流程定义"
					data-type="jbox" data-width="400" data-height="200" data-btn-name="发布"><i class="fa fa-plus"></i> 新发布</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="flow:manager">
				<a href="#" class="btn btn-default btn-sm" id="btnUpdateCache" title="清理工作流缓存"><i class="fa fa-refresh"></i> 清理缓存</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" action="${ctx}/flow/manage/processDef/listData?flag=${param.flag}" method="post" class="breadcrumb form-inline"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">流程编号：</label>
				<input name="processDefinitionKey" class="form-control input-sm width-160" type="text" maxlength="50">
			</div>
			<div class="form-group">
				<label class="control-label">流程名称：</label>
				<input name="processDefinitionName" class="form-control input-sm width-160" type="text" maxlength="50">
			</div>
			<div class="form-group">
				<label class="control-label">流程分类：</label>
				<input name="category" class="form-control input-sm width-90" type="text" maxlength="50">
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
	var dataGrid = new DataGrid({
			
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
	       	{header:'流程编号', name:'key', width:200, align:"left", formatter: function(val, obj, row, act){
	   			return '<a href="${ctx}/flow/manage/process/list?processDefinitionKey='+row.key+'" class="btnList" title="查询流程实例">'+val+'</a>';
	   		}},
	   		{header:'流程名称', name:'name', width:200, align:"left", formatter: function(val, obj, row, act){
	   			return '<a href="${ctx}/flow/process/tracking?processDefinitionKey='+row.key+'" class="btnList" title="流程图" data-type="jbox">' + val + '</i></a>';
	   		}},
		    {header:'流程分类', name:'category', width:100, align:"center"},
			{header:'当前版本', name:'version', width:100, align:"center"},
			{header:'操作', name:'actions', width:130, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				actions.push('<a href="${ctx}/flow/manage/processDef/form?deploymentId='+row.deploymentId+'" class="btnList" title="更新流程定义"'
		   				+ ' data-type="jbox" data-width="400" data-height="200" data-btn-name="更新"><i class="fa fa-pencil"></i></a>&nbsp;');
				actions.push('<a href="${ctx}/flow/manage/processDef/delete?deploymentId='+row.deploymentId+'" class="btnList" title="删除流程定义" data-confirm="确认要删除该流程定义吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
// 				actions.push('<a href="${ctx}' + row.startFormUri + (row.startFormUri.indexOf("?")!= -1 ? "&" : "?")+'processDefinitionKey='
//				+ row.key + '" class="btnList" title="启动流程-'+row.name+'"><i class="fa fa-caret-square-o-right"></i></a>&nbsp;');
				actions.push('<a href="${ctx}/flow/manage/task/form?processDefinitionKey='+row.key+'" class="btnList" title="'+row.name+'启动"'
						+ ' data-type="jbox" data-width2="400" data-height2="300"><i class="fa fa-caret-square-o-right font-purple"></i></a>&nbsp;');
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	$("#btnUpdateCache").click(function(){
		ajaxSubmit("${ctx}/flow/clearCache", function(data){
			showMessage(data.message);
			page();
		});
	});
</script>