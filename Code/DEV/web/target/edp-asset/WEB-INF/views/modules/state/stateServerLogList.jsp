<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="服务器监控日志" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 服务器监控日志</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="stateServerLog" action="${ctx}/state/stateServerLog/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">日期：</label>
				<div class="input-inline">
					<input id="createDate" name="createDate" type="text"  maxlength="20" class="form-control Wdate" readonly="readonly" value="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false}); " />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">IP地址：</label>
				<div class="input-inline">
					<input id="serverIp" name="serverIp" type="text"  maxlength="20" class="form-control" value=""/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">主机名：</label>
				<div class="input-inline">
					<input id="serverName" name="serverName" type="text"  maxlength="20" class="form-control" value=""/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">使用率：</label>
				<div class="input-inline">
					<input id="startUsage" name="startUsage" type="text"  maxlength="20" class="form-control width-60" value=""/>~<input id="endUsage" name="endUsage" type="text"  maxlength="20" class="form-control width-60" value=""/>
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
			{header:'服务器IP', name:'serverIp', index:'a.server_ip', width:200, align:"center", frozen:true/* , formatter: function(val, obj, row, act){
				return '<a href="${ctx}/state/stateServerLog/form?id='+row.id+'" class="btnList" data-title="编辑服务器监控日志">'+(val ? val : row.id)+'</a>';
			} */},
			{header:'服务器名称', name:'serverName', index:'a.server_name', width:200, align:"center"},
			{header:'类型', name:'stateType', index:'a.state_type', width:200, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('sys_state_monitor_type')}, val, '未知', true);
			}},
			{header:'使用率', name:'stateUsage', index:'a.state_usage', width:200, align:"center", formatter: function(val, obj, row, act){
				return val+"%";
			}},
			{header:'日期', name:'createDate', index:'a.create_date', width:200, align:"center"},
			{header:'操作', name:'actions', align:"center",hidden:true, width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="state:stateServerLog:edit">
				/* if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/state/stateServerLog/form?id='+row.id+'" class="btnList" title="编辑服务器监控日志"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/state/stateServerLog/delete?id='+row.id+'" class="btnList" title="删除该服务器监控日志" data-confirm="确认要删除该服务器监控日志吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				} *///</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>