/**
 * 命令按钮组件
 */

Foxbpm.FlowCommandCompenent = function (flowConfig){
	 this._config = flowConfig;
};

Foxbpm.FlowCommandCompenent.prototype={
	init:function(){
		var self = this;
		var toolbarsDiv = $("#" + self._config.containterId);
		var tmpTaskId ;
		if(!_taskId || null == _taskId || '' == _taskId){
			tmpTaskId = 'null';
		}else{
			tmpTaskId = _taskId;
		}
		if (_processDefinitionKey == ''){
			return;
		}
		$.ajax({
	         type: "get",//使用get方法访问后台
	         dataType: "json",//返回json格式的数据
	         url: _bpmServiceUrl+"/runtime/tasks/"+tmpTaskId+"/taskCommands",//要访问的后台地址
	         data:{key:_processDefinitionKey}, async: false,
	         success: function(msg){//msg为返回的数据，在这里做数据绑定
	             var data = msg.data;
	             toolbarsDiv.empty();
	             //画任务命令
	             $.each(data, function(i, n){
	                 var toolBarDiv = $("<button type='button' class='btn btn-primary'></button>");
	                 toolBarDiv.attr("commandType",n.type);
	                 toolBarDiv.attr("commandId",n.id);
	                 toolBarDiv.attr("id","btn"+n.id); // 将原来的i修改为按钮id来固定id值，因为当编辑流程的时候按钮的顺序可能会发生变化
	                 if (n.commandParam){
	                	for (var prop in n.commandParam){
	                		if (n.commandParam.hasOwnProperty(prop)) {
	                			var str = n.commandParam[prop]["value"];
	                    		if (str && str != "" && str != "null"){
	                    	        str = str.replace(/\"/g, "\'");
	                    	        toolBarDiv.attr(prop, str);
	                    		}
	                		}
	                	}
	                 }
	                 toolBarDiv.append(n.name);
	                 toolbarsDiv.append(toolBarDiv).append(" &nbsp;");
	             });
	             
	             //给任务命令赋值事件
	             $("button[commandType]").click(function(){
	            	 var data = {};
	            	 data.processDefinitionKey = _processDefinitionKey;
	            	 data.processInstanceId = _processInstanceId;
	            	 data.taskId = _taskId;
	            	 data.button = this;
	            	 var commandType = $(data.button).attr("commandType");
	            	 var commandName = $(data.button).text();
	            	 data.fn = function(params, result){
	            		 var commandObj = {};
	                	 commandObj.processDefinitionKey=_processDefinitionKey;
	                	 commandObj.processInstanceId = _processInstanceId;
	                	 commandObj.taskId=_taskId;
	                	 commandObj.commandId=$(data.button).attr("commandId");
	                	 commandObj.commandType = commandType;
	                	 commandObj.commandName = commandName;
	                	 if(Foxbpm.commandHandler.result[commandType] !== undefined){
	                		 commandObj.commandParams = Foxbpm.commandHandler.result[commandType](result);
	                	 }
	                	 else {
	                		 commandObj.commandParams = result;
	                	 }
	                	 commandObj.bizKey = self._config.getBizKey();
	                	 commandObj.taskComment = self._config.getTaskComment();
	                	 self._config.flowCommit(commandObj);
	            	 };
	            	 if(Foxbpm.commandHandler[commandType] !== undefined){
	            		 //流程提交所需信息
	            		 Foxbpm.commandHandler[commandType](data);
	            	 }
	            	 else {
	              		 data.fn(data);
	            	 }
	        	 });
	         }
		 });
	}
};
