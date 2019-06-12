<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="消息管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 消息管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="sys:msgPush:edit">
<%-- 				<a href="${ctx}/sys/msgPush/form" class="btn btn-default btn-sm btnTool" title="新增消息"><i class="fa fa-plus"></i> 新增</a> --%>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="msgPush" action="${ctx}/sys/msgPush/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<form:hidden path="pushed"/>
			<div class="form-group">
				<label class="control-label">消息类型：</label>
				<div class="input-inline">
					<form:select path="msgType" class="form-control input-sm width-90">
						<form:option value="" label="全部"/>
						<form:options items="${fns:getDictList('sys_msg_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">业务主键：</label>
				<div class="input-inline">
					<form:input path="bizKey" htmlEscape="false" maxlength="64" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">业务类型：</label>
				<div class="input-inline">
					<form:input path="bizType" htmlEscape="false" maxlength="64" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">接受者账号：</label>
				<div class="input-inline">
					<form:input path="receiveCode" htmlEscape="false" maxlength="64" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="clearfix"></div>
			<div class="form-group">
				<label class="control-label">接受者编码：</label>
				<div class="input-inline">
					<form:input path="receiveUserCode" htmlEscape="false" maxlength="64" class="form-control input-sm width-90"/>
				</div>
			</div>
			<%-- <div class="form-group">
				<label class="control-label">接受者姓名：</label>
				<div class="input-inline">
					<form:input path="receiveUserName" htmlEscape="false" maxlength="100" class="form-control input-sm width-90"/>
				</div>
			</div> --%>
			<div class="form-group">
				<label class="control-label">发送者编码：</label>
				<div class="input-inline">
					<form:input path="sendUserCode" htmlEscape="false" maxlength="64" class="form-control input-sm width-90"/>
				</div>
			</div>
			<%-- <div class="form-group">
				<label class="control-label">发送者姓名：</label>
				<div class="input-inline">
					<form:input path="sendUserName" htmlEscape="false" maxlength="100" class="form-control input-sm width-90"/>
				</div>
			</div> --%>
			<div class="form-group">
				<label class="control-label">发送时间：</label>
				<div class="input-inline">
					<input name="beginSendDate" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate-date"
						value="${fns:formatDate(msgPush.beginSendDate, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					&nbsp;--&nbsp;
					<input name="endSendDate" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate-date"
						value="${fns:formatDate(msgPush.beginSendDate, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
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
			{header:'类型', name:'msgType', index:'a.msg_type', width:100, align:"center", frozen:true, formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('sys_msg_type')}, val, '未知', true);
			}},
			{header:'标题', name:'msgTitle', index:'a.msg_title', width:200, align:"left", formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/msgPush/form?id='+row.id+'&pushed=${msgPush.pushed}" class="btnList" data-title="编辑消息">'+(val ? val : row.id)+'</a>';
			}},
			{header:'内容', name:'msgContentEntity.content', index:'a.msg_content', width:200, align:"left"},
			{header:'业务主键', name:'bizKey', index:'a.biz_key', width:200, align:"center"},
			{header:'业务类型', name:'bizType', index:'a.biz_type', width:200, align:"center"},
			{header:'接受者账号', name:'receiveCode', index:'a.receive_code', width:200, align:"center"},
			{header:'接受者用户', name:'receiveUserCode', index:'a.receive_user_code', width:200, align:"center"},
// 			{header:'接受者姓名', name:'receiveUserName', index:'a.receive_user_name', width:200, align:"center"},
			{header:'发送者用户', name:'sendUserCode', index:'a.send_user_code', width:200, align:"center"},
// 			{header:'发送者姓名', name:'sendUserName', index:'a.send_user_name', width:200, align:"center"},
			{header:'发送时间', name:'sendDate', index:'a.send_date', width:200, align:"center"},
			{header:'合并推送', name:'isMergePush', index:'a.is_merge_push', width:150, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('yes_no')}, val, '未知', true);
			}},
			{header:'推送次数', name:'pushNumber', index:'a.push_number', width:150, align:"center"},
// 			{header:'推送结果码', name:'pushReturnCode', index:'a.push_return_code', width:200, align:"left"},
			{header:'推送状态', name:'pushStatus', index:'a.push_status', width:150, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('sys_msg_push_status')}, val, '待推送', true);
// 			}},
// 			{header:'推送时间', name:'pushDate', index:'a.push_date', width:200, align:"left"},
// 			{header:'读取时间', name:'readDate', index:'a.read_date', width:200, align:"left"},
// 			{header:'操作', name:'actions', width:50, fixed:true, sortable:false, formatter: function(val, obj, row, act){
// 				var actions = [];//<shiro:hasPermission name="sys:msgPush:edit">
// 				if (row.status == Global.STATUS_NORMAL){
// 					actions.push('<a href="${ctx}/sys/msgPush/form?id='+row.id+'&pushed=${msgPush.pushed}" class="btnList" title="编辑消息"><i class="fa fa-pencil"></i></a>&nbsp;');
// // 					actions.push('<a href="${ctx}/sys/msgPush/delete?id='+row.id+'" class="btnList" title="删除该消息" data-confirm="确认要删除该消息吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
// 				}//</shiro:hasPermission>
// 				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>