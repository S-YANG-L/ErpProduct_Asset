<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="消息管理" extLibs="${extLibs}" />
<style type="text/css">
.inbox .inbox-nav {margin:0;padding:0;list-style:none;}
.inbox .inbox-nav li {position:relative;}
.inbox .inbox-nav li a {color:#4d82a3;display:block;font-size:15px;border-left:none;text-align:left !important;padding:6px 14px;margin-bottom:1px;background:#f4f9fd;}
.inbox .inbox-nav li.active a,
.inbox .inbox-nav li.active:hover a {color:#fff;border-left:none;background:#169ef4 !important;text-decoration:none;}
.inbox .inbox-nav li.active b {top:0;right:-4px;width:8px;height:35px;position:absolute;display:inline-block;background:url("${ctxStatic}/assets/admin/pages/img/inbox-nav-arrow-blue.png" ) no-repeat;}
.inbox .inbox-nav li:hover a {color:#4d82a3;background:#eef4f7 !important;text-decoration:none;}
.inbox .inbox-nav li.compose-btn a {color:#fff;text-shadow:none;text-align:center;padding:8px 14px;margin-top:4px;margin-bottom:15px;background:#35aa47;}
.inbox .inbox-nav li.compose-btn i,
.inbox .inbox-nav li.compose-btn:hover i {top:1px;color:#fff;font-size:15px;position:relative;background:none !important;}
.inbox .inbox-nav li.compose-btn a:hover {background-color:#1d943b !important;}
</style>
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-bullhorn"></i> 消息管理</div>
		<div class="actions">
			<shiro:hasPermission name="user">
				<a href="#" class="btn btn-default btn-sm" onclick="markRead()" title="标记为已读"><i class="fa fa-eye"></i> 标记为已读</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="user">
				<a href="${ctx}/msg/message/form" class="btn btn-default btn-sm btnTool" title="写新消息"><i class="fa fa-plus"></i> 写消息</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<div class="row inbox">
			<div class="col-sm-2">
				<ul class="inbox-nav margin-bottom-10">
					<li class="compose-btn">
						<a href="${ctx}/msg/message/form" class="btn green btnTool" title="写新消息">
						<i class="fa fa-edit"></i> 写消息</a>
					</li>
					<c:forEach items="${fns:getDictList('msg_status')}" var="dict">
						<li class="${message.status eq dict.value ? 'active' : ''}">
							<a href="javascript:;" class="btn"
							 onclick="$('#status').val('${dict.value}');$('#searchForm').submit();
							 	$(this).parent().parent().children().removeClass('active');
							 	$(this).parent().addClass('active');">${dict.name} </a><b></b>
						</li>
					</c:forEach>
				</ul>
				<div class="clearfix"></div>
				<ul class="inbox-nav margin-bottom-10">
					<li class="compose-btn">
						<h4 style="color:#888;">消息类型</h4>
					</li>
					<li class="${message.type eq dict.value ? 'active' : ''}">
						<a href="javascript:;" class="btn"
						 onclick="$('#type').val('');$('#searchForm').submit();
							 	$(this).parent().parent().children().removeClass('active');
					 	$(this).parent().addClass('active');">全部 </a><b></b>
					</li>
					<c:forEach items="${fns:getDictList('msg_type')}" var="dict">
						<li class="${message.type eq dict.value ? 'active' : ''}">
							<a href="javascript:;" class="btn"
							 onclick="$('#type').val('${dict.value}');$('#searchForm').submit();
							 	$(this).parent().parent().children().removeClass('active');
							 	$(this).parent().addClass('active');">${dict.name} </a><b></b>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="col-sm-10">
				<div class="inbox-header">
					<form:form id="searchForm" modelAttribute="message" action="${ctx}/msg/message/listData" method="post" class="breadcrumb form-inline "
						data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
					<form:hidden path="type"/><form:hidden path="status"/>
					<%-- <div class="form-group">
						<label class="control-label">类型：</label>
						<div class="input-inline" >
							<form:radiobuttons path="type" items="${fns:getDictList('msg_type')}" onclick="$('#searchForm').submit();" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</div>
					</div> --%>
					<div class="form-group">
						<label class="control-label">标题：</label>
						<div class="input-inline" >
							<form:input path="contentTitle" htmlEscape="false" maxlength="200" class="form-control input-sm width-90"/>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label">等级：</label>
						<div class="input-inline" >
							<form:select path="contentLevel" class="form-control input-sm" onchange="$(this).parents('form').submit()">
								<form:option value="" label="全部"/>
								<form:options items="${fns:getDictList('msg_level')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label">分类：</label>
						<div class="input-inline" >
							<form:select path="contentType" class="form-control input-sm" onchange="$(this).parents('form').submit()">
								<form:option value="" label="全部"/>
								<form:options items="${fns:getDictList('msg_content_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
					<%-- <div class="clearfix"></div>
					<div class="form-group">
						<label class="control-label">信箱：</label>
						<div class="input-inline width-320-" >
							<form:radiobuttons path="status" onclick="$('#searchForm').submit();" items="${fns:getDictList('msg_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</div>
					</div> --%>
					<div class="form-group">
						<label class="control-label">发送时间：</label>
						<input id="beginSendDate" name="beginSendDate" type="text" readonly="readonly" maxlength="20" class="Wdate-date"
							value="${fns:formatDate(message.beginSendDate, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
						<label>&nbsp;--&nbsp;&nbsp;</label>
						<input id="endSendDate" name="endSendDate" type="text" readonly="readonly" maxlength="20" class="Wdate-date"
							value="${fns:formatDate(message.endSendDate, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</div>
					<%-- <div class="form-group">
						<label class="control-label">发送者：</label>
						<div class="input-inline width-160" >
							<form:input path="sender" htmlEscape="false" maxlength="64" class="form-control input-sm"/>
						</div>
					</div> --%>
					<div class="form-group" style="margin-left:10px;"> 
						<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
						<input class="btn default btn-sm" type="reset" value="重置"/>
					</div>
				</form:form>
				</div>
				<div class="inbox-content">
					<table id="dataGrid"></table>
				    <div id="dataGridPage"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	// 初始化DataGrid对象
	var dataGrid = new DataGrid({
			
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		multiselect: true,//复选
		// 设置数据表格列
		columnModel: [
			{header:'id', name:'id', index:'id', width:50, align:"center",frozen:true, hidden:true},        
  			{header:'类型', name:'type', index:'type', width:50, align:"center",frozen:true, formatter: function(val, obj, row, act){
  				return (val ? getDictLabel(${fns:getDictListJson('msg_type')}, val, '未知', true) : row.id);
  			}},
			{header:'标题', name:'contentTitle', index:'content_title', width:280,frozen:true, formatter: function(val, obj, row, act){
				var readStatus = row.readStatus;
				if(typeof(readStatus) != "undefined" && readStatus != null){
					if(readStatus == "0"){
						readStatus = ' <span class="label label-sm label-warning">未达</span>&nbsp; ';
					}else if(readStatus == "1"){
						readStatus = ' <span class="label label-sm label-danger">未读</span>&nbsp; ';
					}else if(readStatus == "2"){
						readStatus = ' <span class="label label-sm label-success">已读</span>&nbsp; ';
					}else if(readStatus == "3"){
						readStatus = ' <span class="label label-sm label-danger">失败</span>&nbsp; ';
					}
				}else{
					readStatus = "";
				}
				var actions = [readStatus];//<shiro:hasPermission name="user">
				if (row.status == '9'){
					actions.push('<a href="${ctx}/msg/message/form?id='+row.id+'" class="btnList" data-title="编辑消息">'+val+'</a>');
				}else{
					actions.push('<a href="${ctx}/msg/message/view?id='+row.id+'" class="btnList" title="查看消息">'+val+'</a>');
				}
				//</shiro:hasPermission>
				return actions.join('');
			}},
			{header:'等级', name:'contentLevel', index:'content_level', width:80, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('msg_level')}, val, '普通', true);
			}},
			{header:'分类', name:'contentType', index:'content_type', width:80, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('msg_content_type')}, val, '', true);
			}},
			{header:'接受者', name:'receiverNames', index:'receiver_names', width:150, formatter: function(val, obj, row, act){
				return abbr(val, 300);
			}},
			{header:'发送者', name:'senderName', index:'sender_name', width:150},
			{header:'发送时间', name:'sendDate', index:'send_date', width:150},
			{header:'操作', name:'actions', width:80, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="user">
				if (row.status == '9'){
					actions.push('<a href="${ctx}/msg/message/form?id='+row.id+'" class="btnList" title="编辑消息"><i class="fa fa-pencil"></i></a>&nbsp;');
					if (row.createByCode == '${fns:getUser().userCode}'){
						actions.push('<a href="${ctx}/msg/message/delete?id='+row.id+'" class="btnList" title="删除该消息" data-confirm="确认要删除该消息吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
					}
				}else{
					actions.push('<a href="${ctx}/msg/message/view?id='+row.id+'" class="btnList" title="查看消息"><i class="fa fa-book"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
	//复选消息，并将已选择的消息设置为已读
	function markRead(){
		var selectedIds = $("#dataGrid").jqGrid("getGridParam", "selarrrow");
		if(selectedIds.length<1){
			showMessage("请选择需要标记的信息");
			return;
		}
		//循环数组获取消息体的编码
		var ids = "";
		for(var i=0;i<selectedIds.length;i++){
			var record = $("#dataGrid").jqGrid("getRowData", selectedIds[i]);
			ids+=record.id+",";
		}
		$.ajax({ 
			url: "${ctx}/msg/message/markRead",
			type:"post",
			data:{id:ids},
		    dataType: "json",
			success: function(data){
				showMessage(data.message);
				window.location.reload();//刷新当前页面
	    	}
		});
	}
</script>