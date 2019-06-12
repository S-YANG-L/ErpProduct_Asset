<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="流程审批" extLibs="${extLibs}" />
<style type="text/css">
	.btn-group li a{text-align: left;}
</style>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="flowBusiness" action="" method="post" class="form-horizontal">
			<div class="form-body">
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								审批意见：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<textarea id="approvalMemo" name="approvalMemo" htmlEscape="false" rows="4" maxlength="255" class="form-control"></textarea>
							</div>
						</div>
					</div>
				</div>
				<c:choose>
					<c:when test="${not empty nextFlowBusinessMap}">
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="">
										选择下一步：<i class="fa icon-question hide"></i></label>
									<div class="col-sm-10">
										<c:forEach items="${nextFlowBusinessMap}" var="item">
											<input type="radio" id="nextStep${item.key}" name="nextFlowBusinessId" value="${item.value.id}" class="required" data-msg-required="请选择下一步"/><label for="nextStep${item.key}">${item.value.stepName}</label>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
						<div class="row hide" id="div_nextApproval">
							<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="">
										下一步审批人：<i class="fa icon-question hide"></i></label>
									<div class="col-sm-4">
										<sys:listselect id="approval" name="approvalCode" value="${nextApprovalCode }" labelName="approvalName" labelValue="${nextApprovalName }"
									boxHeight="500"	boxWidth="450"	returnCodeAttr="userCode" returnNameAttr="userName" url="" title="审批人" multiple="false" cssClass="form-control"  />
									</div>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<c:if test="${hasNextStep and nextFlowBusiness.isFixApproval}">
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="">
										下一步审批人：<i class="fa icon-question hide"></i></label>
									<div class="col-sm-4">
										<sys:listselect id="approval" name="approvalCode" value="${nextApprovalCode }" labelName="approvalName" labelValue="${nextApprovalName }"
											boxHeight="500"	boxWidth="450" returnCodeAttr="userCode" returnNameAttr="userName"	title="审批人" url="${ctx}/eflow/flowBusiness/nextApprovalSelect?nextFlowBusinessId=${nextFlowBusiness.id }&approvalCodeNe=${fns:getUser().userCode}&" multiple="false" cssClass="form-control required"  />
									</div>
								</div>
							</div>
						</div>
						</c:if>
					</c:otherwise>
				</c:choose>
				<input type="hidden" id="nextFlowBusinessId" name="nextFlowBusinessId" value="${nextFlowBusiness.id}" />
				<div class="hide">
					<sys:listselect id="forwardTo" name="forwardToCode" value="" labelName="forwardToName" labelValue=""
						boxHeight="500"	boxWidth="450" returnCodeAttr="userCode" returnNameAttr="userName"	title="审批人" url="${ctx}/eflow/flowBusiness/nextApprovalSelect?nextFlowBusinessId=${flowBusiness.id }&approvalCodeNe=${fns:getUser().userCode}&" multiple="false" cssClass="form-control"  />
					<sys:treeselect id="csignUser" name="csignUserCode"  value="" labelName="csignUserName" labelValue="" title="会签人员" 
						url="/sys/office/treeData?type=4" checked="true" cssClass="" allowClear="true" notAllowSelectParent="true" isAll="true"/>
					<sys:treeselect id="mulapprovalUser" name="mulapprovalUserCode"  value="" labelName="mulapprovalUserName" labelValue="" title="会审人员" 
						url="/sys/office/treeData?type=4" checked="true" cssClass="" allowClear="true" notAllowSelectParent="true" isAll="true"/>
					<sys:treeselect id="notifyUser" name="notifyUserCode"  value="" labelName="notifyUserName" labelValue="" title="知会人员" 
						url="/sys/office/treeData?type=4" checked="true" cssClass="" allowClear="true" notAllowSelectParent="true" isAll="true"/>
				</div>
			</div>
			<div class="form-actions fluid" style="position: fixed; bottom: 0px;width: 95%;z-index:9999">
				<div class="row">
					<div class="" style="text-align:center">
						<c:choose>
							<c:when test="${flowBusiness.actionType eq '1'}">
								<button id="btnSmtCsignMemo" type="button" class="btn btn-primary"><i class="fa fa-check"></i> 提交</button>&nbsp;
							</c:when>
							<c:when test="${flowBusiness.actionType eq '2'}">
								<button id="btnJointPass" type="button" class="btn btn-primary"><i class="fa fa-check"></i> 审批通过</button>&nbsp;
								<button id="btnJointUnpass" type="button" class="btn btn-primary"><i class="fa fa-times"></i> 审批不通过</button>&nbsp;
							</c:when>
							<c:otherwise>
								<button id="btnAuditPass" type="button" class="btn btn-primary"><i class="fa fa-check"></i> 审批通过</button>&nbsp;
								<button id="btnAuditUnpass" type="button" class="btn btn-primary"><i class="fa fa-times"></i> 审批不通过</button>&nbsp;
								<c:if test="${flowBusiness.isFixApproval}">
									<button id="btnForward" type="button" class="btn btn-primary"><i class="fa fa-mail-forward"></i> 转发</button>&nbsp;
								</c:if>
								<c:if test="${flowBusiness.isCsign eq '1'}">
								<div class="btn-group dropup">
									<a class="btn btn-primary btn-sm" href="#" data-toggle="dropdown"><i class="fa "></i> 会签 <i class="fa fa-angle-down"></i></a>&nbsp;
									<ul class="dropdown-menu pull-left" style="min-width:120px;">
										<li><a href="#" id="aBeginCsign"> <i class="fa "></i> 发起会签</a></li>
										<li><a href="#" id="aViewCsignList"> <i class="fa "></i> 查看会签结果</a></li>
										<li><a href="#" id="aUndoCsign"> <i class="fa "></i> 撤回会签</a></li>
									</ul>
								</div>
								</c:if>
								<c:if test="${flowBusiness.isJoint eq '1'}">
								<div class="btn-group dropup">
									<a class="btn btn-primary btn-sm" href="#" data-toggle="dropdown"><i class="fa "></i> 会审 <i class="fa fa-angle-down"></i></a>&nbsp;
									<ul class="dropdown-menu pull-left" style="min-width:120px;">
										<li><a href="#" id="aBeginJoint"> <i class="fa "></i> 发起会审</a></li>
										<li><a href="#" id="aViewJointList"> <i class="fa "></i> 查看会审结果</a></li>
										<li><a href="#" id="aUndoJoint"> <i class="fa "></i> 撤回会审</a></li>
									</ul>
								</div>
								</c:if>
								<c:if test="${flowBusiness.isNotify eq '1'}">
								<div class="btn-group dropup">
									<a class="btn btn-primary btn-sm" href="#" data-toggle="dropdown"><i class="fa "></i> 知会 <i class="fa fa-angle-down"></i></a>&nbsp;
									<ul class="dropdown-menu pull-left" style="min-width:120px;">
										<li><a href="#" id="aBeginNotify"> <i class="fa "></i> 发起知会</a></li>
										<li><a href="#" id="aViewNotifyList"> <i class="fa "></i> 查看知会结果</a></li>
										<li><a href="#" id="aUndoNotify"> <i class="fa "></i> 撤回知会</a></li>
									</ul>
								</div>
								</c:if>
	<!-- 						<button id="btnReject" type="button" class="btn btn-primary"><i class="fa fa-times"></i> 驳回</button>&nbsp; -->
							</c:otherwise>
						</c:choose>
						<button id="btnCancel" type="button" class="btn default" onclick="window.parent.window.jBox.close();"><i class="fa fa-reply-all"></i> 关闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	// 审批通过
	$("#btnAuditPass").click(function(){
		validate = $("#inputForm").validate();
		if(validate.form()){
			$.post("${ctx}/eflow/flowBusiness/auditPass",
					{
						"skipFlowBusinessIds":"${skipFlowBusinessIds}",
						"flowBusinessId":"${flowBusiness.id}", 
						"approvalMemo":$("#approvalMemo").val(), 
						"nextApprovalCode":$("#approvalCode").val(), 
						"nextFlowBusinessId":$("#nextFlowBusinessId").val()
					},
					function(data){
						showMessage(data.message);
						window.parent.window.jBox.close();
						window.parent.getCurrentTabPage()[0].contentWindow.page();
					},
					"json"
			)
		}
	})
	// 审批不通过
	$("#btnAuditUnpass").click(function(){
		top.$.jBox.confirm("确认审批不通过吗？","系统提示",function(v,h,f){
			if(v=="ok"){
				$.post("${ctx}/eflow/flowBusiness/auditUnpass",
						{
							"skipFlowBusinessIds":"${skipFlowBusinessIds}",
							"flowBusinessId":"${flowBusiness.id}", 
							"approvalMemo":$("#approvalMemo").val()
						},
						function(data){
							showMessage(data.message);
							top.$.jBox.close(true);
							window.parent.getCurrentTabPage()[0].contentWindow.page();
						},
						"json"
				)
			}
		},{buttonsFocus:1});
		top.$('.jbox-body .jbox-icon').css('top','55px');
	})
	// 驳回
	$("#btnReject").click(function(){
		top.$.jBox.confirm("确认要驳回吗？","系统提示",function(v,h,f){
			if(v=="ok"){
				$.post("${ctx}/eflow/flowBusiness/reject",
						{"flowBusinessId":"${flowBusiness.id}", "approvalMemo":$("#approvalMemo").val()},
						function(data){
							showMessage(data.message);
							top.$.jBox.close(true);
							window.parent.getCurrentTabPage()[0].contentWindow.page();
						},
						"json"
				)
			}
		},{buttonsFocus:1});
		top.$('.jbox-body .jbox-icon').css('top','55px');

	})
	// 选择下一步后，动态决定是否需要显示下一步审批人
	$("input[type='radio'][name='nextFlowBusinessId']").click(function(){
		$("#nextFlowBusinessId").val(this.value);
		$.post("${ctx}/eflow/flowBusiness/getFlowBusinessById",
			{"id":this.value},
			function(data){
				if(data.isFixApproval){
					// 需要指定审批人
					$("#div_nextApproval").removeClass('hide');
					$("#approvalName").addClass("required");
					var url="${ctx}/eflow/flowBusiness/nextApprovalSelect?nextFlowBusinessId="+data.id+"&approvalCodeNe=${fns:getUser().userCode}&";
					$("#approvalDiv").attr("data-url",url);
				}else{
					$("#div_nextApproval").addClass("hide");
					$("#approvalName").removeClass('required');
				}
			},
			"json"
		)
	})
	// 转发
	$("#btnForward").click(function(){
		$("#forwardToName").click();
	})
	function forwardToCallbackForMap(dataMap, v, h, f){
		if(v=="ok"){
			var userCode, userName;
			$.each(dataMap, function(key, value){
				userCode = value.userCode;
				userName = value.userName;
			})
			if(userCode != null){
				$.post("${ctx}/eflow/flowBusiness/forward",
					{"flowBusinessId":"${flowBusiness.id}", "forwardToCode":userCode, "forwardToName":userName, "approvalMemo":$("#approvalMemo").val()},
					function(data){
						showMessage(data.message);
						top.$.jBox.close(true);
						window.parent.getCurrentTabPage()[0].contentWindow.page();
					},
					"json"
				)
			}
		}
	}
	// 发起会签
	$("#aBeginCsign").click(function(){
		$("#csignUserName").click();
	})
	function csignUserTreeselectCallBack(v, h, f){
		if(v=="ok"){
			var userCodes = $("#csignUserCode").val().replace(",u_",",");
			var userNames = $("#csignUserName").val();
			if(userCodes != null && userCodes.length > 0 ){
				$.post("${ctx}/eflow/flowBusiness/beginCsign",
					{"flowBusinessId":"${flowBusiness.id}", "csignUserCodes":userCodes, "csignUserNames":userNames},
					function(data){
						showMessage(data.message);
						top.$.jBox.close(true);
					},
					"json"
				)
			}
		}
	}
	// 提交会签意见
	$("#btnSmtCsignMemo").click(function(){
		$("#approvalMemo").addClass("required");
		validate = $("#inputForm").validate();
		if(validate.form()){
			$.post("${ctx}/eflow/flowBusiness/saveCsignMemo",
					{	
						"flowBusinessApprovalId":"${flowBusiness.flowBusinessApprovalId}", 
						"approvalMemo":$("#approvalMemo").val()
					},
					function(data){
						showMessage(data.message);
						window.parent.window.jBox.close();
						window.parent.getCurrentTabPage()[0].contentWindow.page();
					},
					"json"
			)
		}
	})
	// 查看会签意见
	$("#aViewCsignList").click(function(){
		var $jBox = getJBox();
		$jBox.open("iframe:${ctx}/eflow/flowBusiness/csignList?flowBusinessId=${flowBusiness.id}", "会签意见", 800, 500, {
			buttons: {
				'<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭': "close"
			},
			loaded: function (h) {
				$(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
			}
		});
	})
	// 发起知会
	$("#aBeginNotify").click(function(){
		$("#notifyUserName").click();
	})
	function notifyUserTreeselectCallBack(v, h, f){
		if(v=="ok"){
			var userCodes = $("#notifyUserCode").val().replace(",u_",",");
			var userNames = $("#notifyUserName").val();
			if(userCodes != null && userCodes.length > 0 ){
				$.post("${ctx}/eflow/flowBusiness/notify",
					{"flowBusinessId":"${flowBusiness.id}", "notifyUserCodes":userCodes, "notifyUserNames":userNames},
					function(data){
						showMessage(data.message);
					},
					"json"
				)
			}
		}
	}
	// 查看知会列表
	$("#aViewNotifyList").click(function(){
		var $jBox = getJBox();
		$jBox.open("iframe:${ctx}/eflow/flowBusiness/notifyList?flowBusinessId=${flowBusiness.id}", "知会列表", 800, 280, {
			buttons: {
				'<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭': "close"
			},
			loaded: function (h) {
				$(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
			}
		});
	})
	// 发起会审
	$("#aBeginJoint").click(function(){
		var $jBox = getJBox();
		$jBox.open("iframe:${ctx}/eflow/flowBusiness/jointForm?id=${flowBusiness.id}&nextFlowBusinessId=${nextFlowBusiness.id }", "发起会审", 800, 280, {
			buttons: {
				"<i class=\"glyphicon glyphicon-ok\"></i>&nbsp;确定": "ok",
				'<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭': "close"
			},
			submit: function (v, h, f) { // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
				if (v == "ok") {
					var w = h.find("iframe")[0].contentWindow;
					var dataMap = w.getDataMap();
					if(dataMap.jointPassType == '1'){
						w.$("#nextApprovalCode").addClass("required");
					}else{
						w.$("#nextApprovalCode").removeClass("required");
					}
					w.$("#jointPassNum").attr("max",dataMap.jointUserCodes.split(",").length);
					if(w.$("#inputForm").validate().form()){
						$.post("${ctx}/eflow/flowBusiness/beginJoint",
							{"flowBusinessId":"${flowBusiness.id}", "jointUserCodes":dataMap.jointUserCodes.replace(",u_",","), "jointUserNames":dataMap.jointUserNames
							,"jointPassType":dataMap.jointPassType, "jointPassNum":dataMap.jointPassNum, "nextApprovalCode":dataMap.nextApprovalCode, "nextApprovalName":dataMap.nextApprovalName},
							function(data){
								showMessage(data.message);
								top.$.jBox.close(true);
							},
							"json"
						)
					}else{return false;}
				}
			},
			loaded: function (h) {
				$(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
			}
		});
	})
	// 会审通过
	$("#btnJointPass").click(function(){
			$.post("${ctx}/eflow/flowBusiness/saveJointResult",
				{"flowBusinessApprovalId":"${flowBusiness.flowBusinessApprovalId}", "approvalMemo":$("#approvalMemo").val(),"isPass":"1"},
				function(data){
					showMessage(data.message);
					window.parent.window.jBox.close();
					window.parent.getCurrentTabPage()[0].contentWindow.page();
				},
				"json"
			)
	})
	// 会审不通过
	$("#btnJointUnpass").click(function(){
		top.$.jBox.confirm("确认审批不通过吗？","系统提示",function(v,h,f){
			if(v=="ok"){
				$.post("${ctx}/eflow/flowBusiness/saveJointResult",
					{"flowBusinessApprovalId":"${flowBusiness.flowBusinessApprovalId}", "approvalMemo":$("#approvalMemo").val(),"isPass":"0"},
					function(data){
						showMessage(data.message);
						top.$.jBox.close(true);
						window.parent.getCurrentTabPage()[0].contentWindow.page();
					},
					"json"
				)
			}
		},{buttonsFocus:1});
		top.$('.jbox-body .jbox-icon').css('top','55px');
	})
	// 查看会审结果 
	$("#aViewJointList").click(function(){
		var $jBox = getJBox();
		$jBox.open("iframe:${ctx}/eflow/flowBusiness/jointList?flowBusinessId=${flowBusiness.id}", "会审结果", 800, 500, {
			buttons: {
				'<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭': "close"
			},
			loaded: function (h) {
				$(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
			}
		});
	})
	// 撤回会签
	$("#aUndoCsign").click(function(){
		top.$.jBox.confirm("确认撤回会签吗？","系统提示",function(v,h,f){
			if(v=="ok"){
				$.post("${ctx}/eflow/flowBusiness/undoApproval",
					{"id":"${flowBusiness.id}", "actionType":"1"},
					function(data){
						showMessage(data.message);
					},
					"json"
				)
			}
		},{buttonsFocus:1});
		top.$('.jbox-body .jbox-icon').css('top','55px');
	})
	// 撤回会审
	$("#aUndoJoint").click(function(){
		top.$.jBox.confirm("确认撤回会审吗？","系统提示",function(v,h,f){
			if(v=="ok"){
				$.post("${ctx}/eflow/flowBusiness/undoApproval",
					{"id":"${flowBusiness.id}", "actionType":"2"},
					function(data){
						showMessage(data.message);
					},
					"json"
				)
			}
		},{buttonsFocus:1});
		top.$('.jbox-body .jbox-icon').css('top','55px');
	})
	// 撤回知会
	$("#aUndoNotify").click(function(){
		top.$.jBox.confirm("确认撤回知会吗？","系统提示",function(v,h,f){
			if(v=="ok"){
				$.post("${ctx}/eflow/flowBusiness/undoApproval",
					{"id":"${flowBusiness.id}", "actionType":"3"},
					function(data){
						showMessage(data.message);
					},
					"json"
				)
			}
		},{buttonsFocus:1});
		top.$('.jbox-body .jbox-icon').css('top','55px');
	})
</script>