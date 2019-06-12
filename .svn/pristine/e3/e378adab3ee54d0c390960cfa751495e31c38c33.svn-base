<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="消息管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa icon-bubbles"></i> ${msgPush.pushed?'已读':'未读'}消息</div>
		<div class="actions">
			<c:if test="${!msgPush.pushed}">
				<a href="#" class="btn btn-default btn-sm" id="btnReadAllMsg"><i class="fa fa fa-eye"></i> 全部标记为已读</a>
			</c:if>
			<a href="${ctx}/sys/msg/list?pushed=${!msgPush.pushed}" class="btn btn-default btn-sm"
				 ><i class="fa fa-retweet"></i> 查看${!msgPush.pushed?'已读':'未读'}消息</a>
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="msgPush" action="${ctx}/sys/msg/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<form:hidden path="pushed"/>
			<div class="form-group hide">
				<label class="control-label">类型：</label>
				<div class="input-inline">
					<%-- <form:select path="msgType" class="form-control input-sm width-90">
						<form:option value="" label="全部"/>
						<form:options items="${fns:getDictList('sys_msg_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select> --%>
					<input type="text" name="msgType" value="pc">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">发送者：</label>
				<div class="input-inline">
					<form:input path="sendUserName" htmlEscape="false" maxlength="100" class="form-control input-sm width-90"/>
				</div>
			</div>
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
// 			{header:'类型', name:'msgType', index:'a.msg_type', width:100, align:"center", frozen:true, formatter: function(val, obj, row, act){
// 				return getDictLabel(${fns:getDictListJson('sys_msg_type')}, val, '未知', true);
// 			}},
			{header:'标题', name:'msgContentEntity.title', index:'a.msg_title', width:200, align:"left", formatter: function(val, obj, row, act){
				return '<a href="javascript:" onclick="return readMsg($(this))" data-msg-id="'+row.id+'" data-row-id="'+obj.rowId+'">'+(val ? val : row.id)+'</a>';
			}},
			{header:'内容', name:'msgContentEntity.content', index:'a.msg_content', width:200, align:"left"},
// 			{header:'业务主键', name:'bizKey', index:'a.biz_key', width:200, align:"center"},
// 			{header:'业务类型', name:'bizType', index:'a.biz_type', width:200, align:"center"},
// 			{header:'接受者账号', name:'receiveCode', index:'a.receive_code', width:200, align:"center"},
// 			{header:'接受者用户', name:'receiveUserCode', index:'a.receive_user_code', width:200, align:"center"},
// 			{header:'接受者姓名', name:'receiveUserName', index:'a.receive_user_name', width:200, align:"center"},
// 			{header:'发送者用户', name:'sendUserCode', index:'a.send_user_code', width:200, align:"center"},
			{header:'发送者', name:'sendUserName', index:'a.send_user_name', width:200, align:"center"},
			{header:'发送时间', name:'sendDate', index:'a.send_date', width:200, align:"center"},
			{header:'延迟消息', name:'isMergePush', index:'a.is_merge_push', width:90, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('yes_no')}, val, '未知', true);
			}},
// 			{header:'推送次数', name:'pushNumber', index:'a.push_number', width:150, align:"center"},
// 			{header:'推送结果码', name:'pushReturnCode', index:'a.push_return_code', width:200, align:"left"},
			{header:'推送状态', name:'pushStatus', index:'a.push_status', width:100, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('sys_msg_push_status')}, val, '待推送', true);
			}},
// 			{header:'推送时间', name:'pushDate', index:'a.push_date', width:200, align:"center"},
			<c:if test="${msgPush.pushed}">
			{header:'读取时间', name:'readDate', index:'a.read_date', width:200, align:"center"},
			</c:if>
			{header:'读取状态', name:'readStatus', index:'a.read_status', width:100, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('sys_msg_read_status')}, val, '未读', true);
// 			}},
// 			{header:'操作', name:'actions', width:50, fixed:true, sortable:false, formatter: function(val, obj, row, act){
// 				var actions = [];//<shiro:hasPermission name="sys:msgPush:edit">
// 				if (row.status == Global.STATUS_NORMAL){
// 					actions.push('<a href="${ctx}/sys/msg/form?id='+row.id+'&pushed=${msgPush.pushed}" class="btnList" title="编辑消息"><i class="fa fa-pencil"></i></a>&nbsp;');
// // 					actions.push('<a href="${ctx}/sys/msg/delete?id='+row.id+'" class="btnList" title="删除该消息" data-confirm="确认要删除该消息吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
// 				}//</shiro:hasPermission>
// 				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	$('#btnReadAllMsg').click(function(){
		confirmx("是否要将全部未读信息标记为已读？", function(){
			ajaxSubmit("${ctx}/sys/msg/readAllMsg", function(data){
				showMessage(data.message);
				location.href = location.href;
			});
		});
		return false;
	});
	function readMsg($this){
		addTabPage($this, '查看消息', '${ctx}/sys/msg/form?id='
				+$this.data('msgId')+'&pushed=${msgPush.pushed}');
		if (!${msgPush.pushed}){
			$('#dataGrid').dataGrid('delRowData',$this.data('rowId'));
		}
		return false;
	}
</script>