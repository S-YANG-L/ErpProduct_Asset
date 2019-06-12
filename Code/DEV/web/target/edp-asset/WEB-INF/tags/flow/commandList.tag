<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="formId" type="java.lang.String" required="false" description="业务表单form的id"%>
<%@ attribute name="bizKeyId" type="java.lang.String" required="false" description="业务主键input的id"%>
<%-- <c:set var="btnClass" value="${fn:contains('startandsubmit,general', row.type) ? 'btn-primary' :  --%>
<%-- 	fn:contains('processStatus', row.type) ? 'btn-info' : 'grey-cascade'}" /> --%>
<span id="flowCommandList"></span><input type="hidden" name="taskCommandInfo" id="taskCommandInfo">
<script type="text/javascript" src="${ctxPath}/foxbpm/taskCommand/js/foxbpmframework.js?${_version}"></script>
<script type="text/javascript" src="${ctxPath}/foxbpm/taskCommand/js/flowCommandCompenent.js?${_version}"></script>
<script type="text/javascript" src="${ctxPath}/foxbpm/taskCommand/js/flowCommandHandler.js?${_version}"></script>
<script type="text/javascript">
	var flowCommandCompenent = new Foxbpm.FlowCommandCompenent({
		containterId : "flowCommandList",
		getBizKey : function(){
			return $("#${bizKeyId}").val();
		},
		getTaskComment : function(){
			return $("#_taskComment").val();
		},
		flowCommit : function(flowInfo) {
			// 流程提交前执行方法
			if(typeof flowCommitBefore == 'function'){
				if (!flowCommitBefore(flowInfo)){
					return;
				}
			}
			// 流程任务提交
			var commandType = flowInfo.commandType;
			var commandName = flowInfo.commandName;
			var flowInfoStr = JSON.stringify(flowInfo);
			if (commandType == "claim" || commandType == "unclaim" || commandType == "releaseTask" 
				/*|| commandType == "rollBack_previousStep" 退回-上一步 */){
				ajaxSubmit("${ctx}/flow/task/complete", {commandName: commandName, 
						taskCommandInfo: flowInfoStr}, function(data){
					showMessage(data.message);
					flowCommandCompenent.init();
				}, "json");
			}else{
				$("#taskCommandInfo").val(flowInfoStr);
				if ("${formId}" != ''){
					$("#${formId}").submit();
				}else{
					$("#taskCommandInfo").parents('form').submit();
				}
			}
		}
	});
	flowCommandCompenent.init();
</script>