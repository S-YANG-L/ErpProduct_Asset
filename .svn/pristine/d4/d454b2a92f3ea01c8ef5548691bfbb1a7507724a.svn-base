<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="任务查询" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i> ${param.flag eq '1' ? '待办' : '已办'}任务</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
<!-- 			<a href="#" class="btn btn-default btn-sm" id="btnDelegation" title="设置代理人"><i class="fa fa-magnet"></i> 设置代理人</a> -->
			<shiro:hasPermission name="flow:manager">
				<a href="#" class="btn btn-default btn-sm" id="btnUpdateCache" title="清理工作流缓存"><i class="fa fa-refresh"></i> 清理缓存</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" action="${ctx}/flow/task/listData?flag=${param.flag}" method="post" class="breadcrumb form-inline"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<input type="hidden" id="category" name="category" value="${flow.category}"/>
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
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" id="btnSubmit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" id="btnReset" value="重置"/>
			</div>
			<div class="form-group">
<!-- 				&nbsp; <input type="hidden" id="agentUsers" name="agentUsers" class="form-control input-sm width-90"/> -->
<!-- 				&nbsp; <input type="hidden" id="agentToUsers" name="agentUsers" class="form-control input-sm width-90"/> -->
				<input type="hidden" id="agentUserId" name="agentUserId"/>
				<input type="hidden" id="agentType" name="agentType"/>
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
	   			return '<a name="doTask" href="#" formUri="'+row.formUri+'" taskId="'+row.id+'" procInsId="'+row.processInstanceId
					+'" bizKey="'+row.bizKey+'" procDefKey="'+row.processDefinitionKey+'" taskTitle="'+row.name+'">'+val+'</a>';
			}},
  	     	{header:'任务主题', name:'subject', width:200, align:"center", sortable:false, formatter: function(val, obj, row, act){
	   			return '<a name="doTask" href="#" formUri="'+row.formUri+'" taskId="'+row.id+'" procInsId="'+row.processInstanceId
	   				+'" bizKey="'+row.bizKey+'" procDefKey="'+row.processDefinitionKey+'" taskTitle="'+row.name+'">'+val+'</a>';
	   		}},
	   		{header:'流程名称', name:'processDefinitionName', width:150, align:"center", sortable:false, formatter: function(val, obj, row, act){
				return '<a name="queryProcess" href="#" procDefName="'+row.processDefinitionName+'">'+val+'</a>';
			}},
			{header:'发起人', name:'processInitiatorName', width:140, align:"center", sortable:false},
			{header:'发起时间', name:'processStartTime', width:95, align:"center", fixed:true, sortable:false, formatter:'date', formatoptions:{srcformat:'u', newformat:'Y-m-d H:i:s'}},
			{header:'${param.flag eq "1" ? "当前步骤" : "办理信息"}', name:'nodeName', width:200, align:"center", sortable:false, formatter: function(val, obj, row, act){
				return '<a name="flowGraph" href="#" procInsId="'+row.processInstanceId+'" procDefKey="'+row.processDefinitionKey
					+'" procDefName="'+row.processDefinitionName+'">'+val+' '+(getVal(row,'commandMessage'))+'</a>';
			}},
			{header:'到达时间', name:'createTime', width:95, align:"center", fixed:true, formatter:'date', formatoptions:{srcformat:'u', newformat:'Y-m-d H:i:s'}},
			{header:'操作', name:'actions', width:80, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				actions.push('&nbsp;<a name="doTask" href="#" formUri="'+row.formUri+'" taskId="'+row.id+'" procInsId="'+row.processInstanceId+'" bizKey="'+row.bizKey+'" procDefKey="'+row.processDefinitionKey+'" taskTitle="'+row.name+'" title="办理"><i class="fa fa-caret-square-o-right font-purple"'+(row.formUri == '' ? ' style="color:#888!important"' : '')+'></i></a>&nbsp;');
				actions.push('&nbsp;<a name="flowGraph" href="#" bizKey="'+row.bizKey+'" procInsId="'+row.processInstanceId+'" procDefKey="'+row.processDefinitionKey+'" procDefName="'+row.processDefinitionName+'" title="跟踪"><i class="fa fa-bullseye"></i></a>&nbsp;');
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
// 			// 代理人设置
// 			var agentUsers = getVal(data, 'otherData.agentUsers');
// 			if (agentUsers && agentUsers != ""){
// 				var options = [];
// 				options.push({id: '', text: '代理人查询'});
// 				for (var i=0; i<agentUsers.length; i++){
// 					options.push({
// 						id: agentUsers[i].userid,
// 						text: agentUsers[i].username
// 					});
// 				}
// 				$("#agentUsers").select2({data: options}).on("change", function(e){
// 					$("#btnReset").click();
// 					$("#agentType").val($(this).val() != '' ? 1 : '');
// 					$("#agentUserId").val($(this).val());
// 					$("#agentToUsers").select2('val', '');
// 					$('#searchForm').submit();
// 				});
// 			}
// 			// 委托人设置
// 			var agentToUsers = getVal(data, 'otherData.agentToUsers');
// 			if (agentToUsers && agentToUsers != ""){
// 				var options = [];
// 				options.push({id: '', text: '委托人查询'});
// 				for (var i=0; i<agentToUsers.length; i++){
// 					options.push({
// 						id: agentToUsers[i].userid,
// 						text: agentToUsers[i].username
// 					});
// 				}
// 				$("#agentToUsers").select2({data: options}).on("change", function(e){
// 					$("#btnReset").click();
// 					$("#agentType").val($(this).val() != '' ? 0 : '');
// 					$("#agentUserId").val($(this).val());
// 					$("#agentUsers").select2('val', '');
// 					$('#searchForm').submit();
// 				});
// 			}
			// 根据流程查询
			$("a[name=queryProcess]").click(function(){
				var procDefName = $(this).attr("procDefName"); // 流程定义名称 
				$('#searchForm input[name="processDefinitionName"]').val(procDefName);
				$('#searchForm').submit();
			});
			// 任务办理按钮
			$("a[name=doTask]").click(function(){
				var formUrl = $(this).attr("formUri");	// 表单地址
				var taskId = $(this).attr("taskId");	// 任务编号
				var bizKey = $(this).attr("bizKey");	// 业务表单KEY
				var procInsId = $(this).attr("procInsId");// 流程实例编号
				var procDefKey = $(this).attr("procDefKey");// 流程定义KEY
				var taskTitle = $(this).attr("taskTitle");	// 任务标题
				if (formUrl == ''){
					showMessage('当前任务不能操作。');
					return;
				}
				var url = '${ctx}' + formUrl;
				url += new RegExp("=$").test(url) ? bizKey : "";
				url += formUrl.indexOf("?") != -1 ? "&" : "?";
				url += "taskId="+taskId+"&processInstanceId="+procInsId+"&processDefinitionKey="+procDefKey;
				addTabPage($(this), taskTitle, url, '${param.tabPageId}');
			});
			// 流程跟踪按钮
			$("a[name=flowGraph]").click(function(){
				var bizKey = $(this).attr("bizKey");	// 业务表单KEY
				var procInsId = $(this).attr("procInsId"); // 流程实例编号
				var procDefKey = $(this).attr("procDefKey"); // 流程定义KEY
				var procDefName = $(this).attr("procDefName"); // 流程定义名称
				var url = "${ctx}/flow/process/tracking?processDefinitionKey="+procDefKey+"&processInstanceId="+procInsId;
				<%--
				// 如果有流程定义KEY和流程实例ID（建议使用）
				var url = "${ctx}/flow/process/tracking?processDefinitionKey="+procDefKey+"&processInstanceId="+procInsId;
				// 如果只有流程实例ID
				var url = "${ctx}/flow/process/tracking?processInstanceId="+procInsId;
				// 如果只有业务KEY（业务KEY不重复的情况下）
				var url = "${ctx}/flow/process/tracking?bizKey="+bizKey;
				// 如果业务KEY存在重复的情况下，需要加入流程定义KEY参数
				var url = "${ctx}/flow/process/tracking?processDefinitionKey="+procDefKey+"&bizKey="+bizKey;
				--%>
				addTabPage($(this), procDefName+'跟踪', url, '${param.tabPageId}');
			});
		}
	});
	$("#btnDelegation").click(function(){ 
		var url = "FlowCenter?action=viewDelegation";
		addTabPage($(this), '设置代理人', url, '${param.tabPageId}');
	});
	$("#btnUpdateCache").click(function(){
		ajaxSubmit("${ctx}/flow/clearCache", function(data){
			showMessage(data.message);
			page();
		});
	});
</script>