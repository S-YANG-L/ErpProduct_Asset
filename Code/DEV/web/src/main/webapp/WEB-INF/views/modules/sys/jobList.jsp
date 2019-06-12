<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="作业监控" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-male"></i>作业监控（定时器：${isRunning?'运行中':'停止中'}...）</div>
		<div class="actions">
			<c:if test="${!isRunning}">
				<a href="#" class="btn btn-default btn-sm" id="btnStart" title="运行定时器"><i class="fa fa-play"></i> 启动定时器</a>
			</c:if><c:if test="${isRunning}">
				<a href="#" class="btn btn-default btn-sm" id="btnStop" title="停止定时器"><i class="fa fa-stop"></i> 停止定时器</a>
			</c:if>
			<a href="#" class="btn btn-default btn-sm" id="btnRefresh" title="刷新页面"><i class="fa fa-refresh"></i> 刷新页面</a>
			<a href="#" class="btn btn-default btn-sm hide" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="sys:job:edit">
				<a href="${ctx}/sys/job/form" class="btn btn-default btn-sm btnTool" title="新增作业调度"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="jobEntity" action="${ctx}/sys/job/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
			<input class="btn default btn-sm" type="reset" value="重置"/>
		</form:form>
		<table id="dataGrid"></table>
	    <div id="dataGridPage"></div>
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
  			{header:'名称', name:'jobName', width:90, align:'center'},
			{header:'分组', name:'jobGroup', width:50, align:'center', formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('job_group')}, val, '未知', true);
			}},
			{header:'描述', name:'description', width:110, align:'center'},
			{header:'调用目标字符串', name:'invokeTarget', width:150, align:'center'},
			{header:'周期表达式', name:'cronExpression', width:100, align:'center'},
			{header:'上次运行时间', name:'prevFireTime', width:100, align:'center'},
			{header:'下次运行时间', name:'nextFireTime', width:100, align:'center'},
			{header:'状态', name:'status', width:50, align:'center', formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('job_status')}, val, '未知', true);
			}}
			//<shiro:hasPermission name="sys:job:edit">
			,{header:'操作', name:'actions', width:90, sortable:false, formatter: function(val, obj, row, act){
				var actions = [], params = 'jobName='+encodeURIComponent(row.jobName)+'&jobGroup='+encodeURIComponent(row.jobGroup);
				if (row.status == '2'){
					actions.push('<a href="${ctx}/sys/job/resume?'+params+'" class="btnList" title="恢复作业" data-confirm="确认要恢复该作业吗？"><i class="fa fa-play"></i></a>&nbsp;');
				}else{
					actions.push('<a href="${ctx}/sys/job/pause?'+params+'" class="btnList" title="暂停作业" data-confirm="确认要暂停该作业吗？"><i class="fa fa-pause"></i></a>&nbsp;');
				}
				actions.push('<a href="${ctx}/sys/job/runOnce?'+params+'" class="btnList" title="立即运行一次" data-confirm="确认要立即运行一次该作业吗？"><i class="fa fa-forward"></i></a>&nbsp;');
				if (row.jobGroup != 'sys' || '${jobEntity.currentUser.admin}' == 'true'){
					actions.push('<a href="${ctx}/sys/job/form?'+params+'" class="btnList" title="编辑作业"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/job/delete?'+params+'" class="btnList" title="删除作业" data-confirm="确认要删除该作业吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}}//</shiro:hasPermission>
		],
// 		subGrid: true,
// 		subGridRowExpanded: function(parentRowID, parentRowKey){
// 			var row = dataGrid.getRowData(parentRowKey);
// 			$("#" + parentRowID).append(row.remarks != '' ? row.remarks : '无备注！');
// 		},
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	$("#btnRefresh").click(function(){
		showMessage("页面已刷新。");
		location = "${ctx}/sys/job/list";
	});
	$("#btnStart").click(function(){ 
		ajaxSubmit("${ctx}/sys/job/startAll", function(data){
			showMessage(data.message);
			location = "${ctx}/sys/job/list";
		});
	});
	$("#btnStop").click(function(){ 
		ajaxSubmit("${ctx}/sys/job/stopAll", function(data){
			showMessage(data.message);
			location = "${ctx}/sys/job/list";
		});
	});
</script>