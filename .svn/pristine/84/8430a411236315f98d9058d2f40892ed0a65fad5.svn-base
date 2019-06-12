<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="流程实例管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i> 流程实例管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="flow:manager">
				<a href="#" class="btn btn-default btn-sm" id="btnUpdateCache" title="清理工作流缓存"><i class="fa fa-refresh"></i> 清理缓存</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" action="${ctx}/flow/manage/process/listData" method="post" class="breadcrumb form-inline"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<input type="hidden" id="category" name="category" value="${flow.category}"/>
			<input type="hidden" id="processDefinitionKey" name="processDefinitionKey" value="${flow.processDefinitionKey}"/>
			<div class="form-group">
				<label class="control-label">单据号：</label>
				<input name="bizKey" class="form-control input-sm width-90" type="text" maxlength="50">
			</div>
			<div class="form-group">
				<label class="control-label">任务主题：</label>
				<input name="subject" class="form-control input-sm width-90" type="text" maxlength="50">
			</div>
			<div class="form-group">
				<label class="control-label">流程名称：</label>
				<input name="processDefinitionName" class="form-control input-sm width-90" type="text" maxlength="50">
			</div>
			<div class="form-group">
				<label class="control-label">流程状态：</label>
				<select name="processInstanceStatus" class="form-control input-sm width-90" onchange="page()">
                	<option value="">全部</option>
                	<c:forEach items="${fns:getDictList('flow_status')}" var="dict">
                		<option value="${dict.value}">${dict.name}</option>
                	</c:forEach>
				</select>
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
	       	{header:'单据号', name:'bizKey', width:200, align:"center", sortable:false, formatter: function(val, obj, row, act){
	   			return '<a href="${ctx}/flow/manage/task/list?processInstanceId='+row.id+'" class="btnList" title="查询流程任务">'+val+'</a>';
		   	}},
	     	{header:'任务主题', name:'subject', width:200, align:"center", sortable:false, formatter: function(val, obj, row, act){
	     		return '<a href="${ctx}/flow/manage/task/list?processInstanceId='+row.id+'" class="btnList" title="查询流程任务">'+val+'</a>';
			}},
	   		{header:'流程名称', name:'processDefinitionName', width:150, align:"center", sortable:false, formatter: function(val, obj, row, act){
	   			return '<a name="queryProcess" href="#" procDefName="'+row.processDefinitionName+'">'+val+'</a>';
	   		}},
		    {header:'发起人', name:'startAuthorName', width:120, sortable:false, align:"center"},
			{header:'发起时间', name:'startTime', width:95, align:"center", fixed:true, formatter:'date', formatoptions:{srcformat:'u', newformat:'Y-m-d H:i:s'}},
			{header:'更新时间', name:'updateTime', width:95, align:"center", fixed:true, formatter:'date', formatoptions:{srcformat:'u', newformat:'Y-m-d H:i:s'}},
			{header:'当前步骤', name:'nowNodeInfo', width:300, sortable:false, formatter: function(val, obj, row, act){
				return '<a name="flowGraph" href="#" procInsId="'+row.id+'" procDefKey="'+row.processDefinitionKey
					+'" procDefName="'+row.processDefinitionName+'">'+val+'</a>';
			}},
			{header:'状态', name:'instanceStatus', width:80, sortable:false, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('flow_status')}, val, '未知', true);
			}},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
// 				actions.push('<a name="viewTask" href="#" formUri="${ctx}'+row.formUri+'" bizKey="'+row.bizKey
// 						+'" taskTitle="查看"><i class="fa fa-file-text"></i></a>&nbsp;');
				actions.push('<a href="${ctx}/flow/manage/process/delete?processInstanceId='+row.id+'" class="btnList" title="删除流程实例" data-confirm="确认要删除该流程实例吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				actions.push('<a href="${ctx}/flow/manage/process/abort?processInstanceId='+row.id+'" class="btnList" title="终止流程实例" data-confirm="确认要终止该流程实例吗？"><i class="fa fa-stop font-yellow"></i></a>&nbsp;');
				actions.push('<a name="flowGraph" href="#" procInsId="'+row.id+'" procDefKey="'+row.processDefinitionKey
						+'" procDefName="'+row.processDefinitionName+'" title="跟踪"><i class="fa fa-bullseye"></i></a>&nbsp;');
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			// 根据流程查询
			$("a[name=queryProcess]").click(function(){
				var procDefName = $(this).attr("procDefName"); // 流程定义名称 
				$('#searchForm input[name="processDefinitionName"]').val(procDefName);
				$('#searchForm').submit();
			});
			// 任务查看按钮
// 			$("a[name=viewTask]").click(function(){
// 				var formUrl = $(this).attr("formUri");// 表单地址
// 				var bizKey = $(this).attr("bizKey");// 业务表单KEY
// 				var taskTitle = $(this).attr("taskTitle"); // 任务标题
// 				var url = formUrl;
// 				url += new RegExp("=$").test(url) ? bizKey : "";
// 				url += url.indexOf("?") != -1 ? "&" : "?";
// 				addTabPage($(this), taskTitle, url, '${param.tabPageId}');
// 			});
			// 流程跟踪按钮
			$("a[name=flowGraph]").click(function(){
				var procDefName = $(this).attr("procDefName"); // 流程定义名称
				var procDefKey = $(this).attr("procDefKey"); // 流程定义KEY
				var procInsId = $(this).attr("procInsId"); // 流程实例编号
				var url = "${ctx}/flow/process/tracking?processDefinitionKey="+procDefKey+"&processInstanceId="+procInsId;
				addTabPage($(this), procDefName+'跟踪', url, '${param.tabPageId}');
			});
		}
	});
	$("#btnUpdateCache").click(function(){
		ajaxSubmit("${ctx}/flow/clearCache", function(data){
			showMessage(data.message);
			page();
		});
	});
</script>