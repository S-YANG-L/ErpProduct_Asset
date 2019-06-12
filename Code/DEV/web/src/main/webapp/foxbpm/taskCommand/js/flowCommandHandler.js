/**
 * 命令按钮操作
 */

Foxbpm.commandHandler = {};

/**
 * 流程状态
 */
Foxbpm.commandHandler.processStatus = function(data){
	var url = _bpmFilePath+"/showTaskDetailInfor.jsp?";
	if(data.processInstanceId){
		url += "processInstanceId=" + data.processInstanceId;
	}else if(data.processDefinitionKey){
		url += "processDefinitionKey=" + data.processDefinitionKey;
	}else  if(data.processDefinitionId){
		url += "processDefinitionId=" + data.processDefinitionId;
	}else{
		return {status:"error",message:"参数不足"};
	}
//	addTabPage(null, "流程跟踪", url);
	getJBox().open("iframe:"+url, "流程跟踪", $(top.window).width() - 150, $(top.window).height() - 130, {
		buttons:{"<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭":true}
	});
	return {status:"success"};
};

/**
 * 通用
 */
Foxbpm.commandHandler.general = function(data){
	if ($(data.button).attr('isSelectUser') == 'true'){
		selectUser(data, '下一步处理人');  
	}else{
		data.fn(data);
	}
};

/**
 * 启动并提交
 */
Foxbpm.commandHandler.startandsubmit = function(data){
	Foxbpm.commandHandler.general(data);
};

/**
 * 提交
 */
Foxbpm.commandHandler.submit = function(data){
	Foxbpm.commandHandler.general(data);
};

/**
 * 流程转发-创建新任务
 */
Foxbpm.commandHandler.transferAndCreateTask = function(data){
	selectUser(data);
};

/**
 * 流程转发
 */
Foxbpm.commandHandler.transfer = function(data){
	Foxbpm.commandHandler.transferAndCreateTask(data);
};

///**
// * 流程选择用户确定下一步处理者
// */
//Foxbpm.commandHandler.selectAssignee = function(data){
//	Foxbpm.commandHandler.transferAndCreateTask(data);
//};

/**
 * 流程转办
 */
Foxbpm.commandHandler.pending = function(data){
	Foxbpm.commandHandler.transferAndCreateTask(data);
};

/**
 * 退回-重新分配
 */
Foxbpm.commandHandler.rollBack_reset = function(data){
	var params = {};
	var queryUrl = _bpmServiceUrl + "/runtime/tasks/"+data.taskId+"/rollbackNodes";
	var queryData = {taskId:data.taskId};
	var returnData = {rollBackNodeId:"nodeId"};
	var columnInfo = {nodeId:"节点编号",nodeName:"节点名称"};
	params.queryData = queryData;
	params.returnData = returnData;
	params.columnInfo = columnInfo;
	params.url = queryUrl;
	params.fn = data.fn;
	params.width = 280;
	params.height = 350;
	selectData(params, "节点");
};

/**
 * 退回-指定处理者
 */
Foxbpm.commandHandler.rollBack_assignee = function(data){
	var params = {};
	var queryUrl = _bpmServiceUrl + "/runtime/tasks/"+data.taskId+"/rollbackTasks";
	var queryData = {taskId:data.taskId};
	var returnData = {rollBackNodeId:"nodeId",rollBackAssignee:"assignee"};
	var columnInfo = {nodeName:"步骤名称",assgneeUserName:"处理者",endTime:"处理时间",commandMessage:"处理结果",taskComment:"处理意见"};
	params.queryData = queryData;
	params.returnData = returnData;
	params.columnInfo = columnInfo;
	params.url = queryUrl;
	params.fn = data.fn;
	selectData(params, "步骤");
};

/**
 * 界面收集参数
 */
Foxbpm.commandHandler.result = {
	// 通用
	general : function(userId) {
		return {
			selectUserId : userId
		};
	},
	// 启动并提交
	startandsubmit : function(userId) {
		return Foxbpm.commandHandler.result.general(userId);
	},
	// 提交
	submit : function(userId) {
		return Foxbpm.commandHandler.result.general(userId);
	},
	// 流程转发-创建新任务
	transferAndCreateTask : function(userId) {
		return {
			transferUserId : userId
		};
	},
	// 流程转发
	transfer : function(userId) {
		return Foxbpm.commandHandler.result.transferAndCreateTask(userId);
	},
//	// 流程选择用户确定下一步处理者
//	selectAssignee : function(userId) {
//		return {
//			nextUserId : userId
//		};
//	},
	// 流程转办
	pending : function(userId) {
		return {
			pendingUserId : userId
		}
	}
};

/**
 * 弹出选择用户对话框
 */
function selectUser(data, title){
	var $jBox = getJBox(),
		treeDataUrl = $(data.button).attr('treeDataUrl'),
		defaultUrl = "/sys/office/treeData?type=4&isAll=true",
		url = treeDataUrl != undefined && treeDataUrl != '' ? treeDataUrl : defaultUrl;
	if (url.substr(0,11) == "javascript:"){
		url = eval(url.substr(11));
	}
	$jBox.open("iframe:"+ctx+"/tag/treeselect?url="+encodeURIComponent(ctx+url)+"&checked="+($(data.button).attr('isMultiSelect') == 'true'), "选择"+title, 300, 400, {
		buttons:{"<i class=\"glyphicon glyphicon-ok\"></i>&nbsp;确定":"ok", "<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭":true}, 
		submit:function(v, h, f){ // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
			var ifr = h.find("iframe"), win = ifr[0].contentWindow, conts = ifr.contents();
			if (v=="ok"){
				var codes = [], nodes = [];
				if ($(data.button).attr('isMultiSelect') == 'true'){
					nodes = win.tree.getCheckedNodes(true);
				}else{
					nodes = win.tree.getSelectedNodes();
				}
				for(var i=0; i<nodes.length; i++) {
					if (nodes[i].isParent){
						continue; // 过滤掉父节点
					}
					codes.push(nodes[i].id);
				}
				if (codes.length == 0){
					showMessage("请选择"+title+"。", "", "warning");
					return false;
				}
				data.fn(data, codes.join(",").replace(/u_/ig,""));
			}
		}, loaded:function(h){
            $(".jbox-content", $jBox.getBox()).css("overflow-y","hidden");
		}
	});
}

/**
 * 弹出选择数据对话框
 */
function selectData(params, title) {
	// 正常打开	
	var $jBox = getJBox(), data = JSON.stringify(params);
	$jBox.open("iframe:"+_bpmFilePath+"/selectData.jsp?data="+encodeURIComponent(data), "选择"+title, 
				params.width ? params.width : 650, params.height ? params.height : 400, {
		buttons:{"<i class=\"glyphicon glyphicon-ok\"></i>&nbsp;确定":"ok", "<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭":true}, 
		submit:function(v, h, f){ // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
			var ifr = h.find("iframe"), win = ifr[0].contentWindow, conts = ifr.contents();
			if (v=="ok"){
				params.fn(params, win.selectData());
			}
		}, loaded:function(h){
            $(".jbox-content", $jBox.getBox()).css("overflow-y","hidden");
		}
	});
}