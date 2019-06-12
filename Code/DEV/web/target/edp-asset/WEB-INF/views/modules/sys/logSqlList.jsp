<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="SQL日志查询" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> SQL日志查询</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="sys:logSql:edit">
				<a href="${ctx}/sys/logSql/form" class="btn btn-default btn-sm btnTool" title="新增日志"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="logSql" action="${ctx}/sys/logSql/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">命令类型：</label>
				<div class="input-inline">
					<form:input path="cmdType" htmlEscape="false" maxlength="10" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">更新表名：</label>
				<div class="input-inline">
					<form:input path="paramMapping" htmlEscape="false" maxlength="2000" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">执行的SQL：</label>
				<div class="input-inline">
					<form:input path="executeSql" htmlEscape="false" maxlength="4000" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">源码位置：</label>
				<div class="input-inline">
					<form:input path="mapperId" htmlEscape="false" maxlength="2000" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">请求URI：</label>
				<div class="input-inline">
					<form:input path="requestUri" htmlEscape="false" maxlength="255" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="clearfix"></div>
			<div class="form-group">
				<label class="control-label">创建者：</label>
				<div class="input-inline">
					<form:input id="createByCode" path="createBy.userCode" htmlEscape="false" maxlength="64" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">创建者姓名：</label>
				<div class="input-inline">
					<form:input path="createBy.userName" htmlEscape="false" maxlength="200" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">创建时间：</label>
				<div class="input-inline">
					<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate-date"
						value="${fns:formatDate(logSql.beginCreateDate, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					&nbsp;--&nbsp;
					<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate-date"
						value="${fns:formatDate(logSql.endCreateDate, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">操作IP地址：</label>
				<div class="input-inline">
					<form:input path="remoteAddr" htmlEscape="false" maxlength="255" class="form-control input-sm width-90"/>
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
			{header:'命令类型', name:'cmdType', index:'a.cmd_type', width:120, align:"center", frozen:true},
			{header:'更新表表名', name:'paramMapping', index:'a.param_mapping', width:200, align:"left"},
			{header:'执行的SQL', name:'executeSql', index:'a.exec_sql', width:200, align:"left", formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/logSql/form?id='+row.id+'" class="btnList" data-title="查看日志详情">'+(val ? val : row.id)+'</a>';
			}},
			{header:'提交的数据', name:'paramObject', sortable:false, width:200, align:"left", formatter: function(val, obj, row, act){
				return val ? (val.replace(/[<>&"]/g,function(c){return {'<':'&lt;','>':'&gt;','&':'&amp;','"':'&quot;'}[c];})) : '';
			}},
			{header:'源码位置', name:'mapperId', index:'a.mapper_id', width:200, align:"left", formatter: function(val, obj, row, act){
				return '<a href="javascript:$(\'#mapperId\').val(\''+val+'\').closest(\'form\').submit()">'+(val ? val : row.id)+'</a>';
			}},
			{header:'创建者', name:'createByCode', index:'a.create_by', width:150, align:"center", formatter: function(val, obj, row, act){
				return '<a href="javascript:$(\'#createByCode\').val(\''+val+'\').closest(\'form\').submit()">'+(val ? val : '')+'</a>';
			}},
			{header:'创建者姓名', name:'createByName', index:'a.create_by_name', width:150, align:"center"},
			{header:'创建时间', name:'createDate', index:'a.create_date', width:200, align:"center"},
			{header:'请求URI', name:'requestUri', index:'a.request_uri', width:200, align:"left", formatter: function(val, obj, row, act){
				return '<a href="javascript:$(\'#requestUri\').val(\''+val+'\').closest(\'form\').submit()">'+(val ? val : row.id)+'</a>';
			}},
			{header:'操作IP地址', name:'remoteAddr', index:'a.remote_addr', width:150, align:"center", formatter: function(val, obj, row, act){
				return '<a href="javascript:$(\'#remoteAddr\').val(\''+val+'\').closest(\'form\').submit()">'+(val ? val : row.id)+'</a>';
			}},
			{header:'响应时间', name:'executeTimeFormat', index:'a.execute_time', width:100, align:"center"}/* ,
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:logSql:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/logSql/form?id='+row.id+'" class="btnList" title="编辑日志"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/logSql/delete?id='+row.id+'" class="btnList" title="删除该日志" data-confirm="确认要删除该日志吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}} */
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>