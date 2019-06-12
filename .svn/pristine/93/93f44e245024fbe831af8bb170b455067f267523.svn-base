 <%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,ueditor"/>
<sys:header title="消息管理 - ${message.isNewRecord ? '写新' : '编辑'}消息" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-bullhorn"></i>${message.isNewRecord ? '写新' : '编辑'}消息</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="user">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="message" action="${ctx}/msg/message/save" method="post" class="form-horizontal">
			<div class="form-body">
				<!-- <h4 class="form-section">基本信息</h4> --><br/>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2"><span class="required">*</span> 标题：</label>
							<div class="col-sm-10">
								<input type="hidden" name="type" value="2" />
								<form:input path="contentTitle" htmlEscape="false" maxlength="200" class="form-control -measure-input required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="消息的优先等级，不同等级显示不同颜色和排序">
								<span class="required">*</span> 等级：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:select path="contentLevel" class="form-control required">
									<form:options items="${fns:getDictList('msg_level')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
<!-- 				</div> -->
<!-- 				<div class="row"> -->
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="消息的分类">
								<span class="required">*</span> 分类：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:select path="contentType" class="form-control required">
									<form:option value="" label=""/>
									<form:options items="${fns:getDictList('msg_content_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2"><span class="required">*</span> 消息内容：</label>
							<div class="col-sm-10">
<%-- 								<form:textarea id="contentUE" htmlEscape="true" path="contentText" rows="4" maxlength="2000" style="width:100%;height:130px;"/> --%>
								<sys:ueditor id="content" name="contentText" value="${message.contentText}" maxlength="500" height="145" simpleToolbars="true"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2"><span class="required">*</span> 接受者：</label>
							<div class="col-sm-10">
								<div class="radio-list">
									<form:radiobuttons path="receiverType" items="${fns:getDictList('msg_receiver_type')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control required"/>
									<form:hidden path="receiverCodes"/> <form:hidden path="receiverNames"/>
								</div>
								<div id="userSelect" style="display:none;">
									<sys:listselect id="receiverUser" name="" value="${message.receiverCodes}"  labelName="" labelValue="${message.receiverNames}"
										title="用户" url="${ctx}/sys/user/userSelect" isAll="true" returnCodeAttr="userCode" returnNameAttr="userName" multiple="true" cssClass="form-control"/>
								</div>
								<div id="officeSelect" style="display:none;">
									<sys:treeselect id="receiverOffice" name="" value="${message.receiverCodes}" labelName="" labelValue="${message.receiverNames}"
										title="机构" url="/sys/office/treeData?type=2" isAll="true" cssClass="form-control" allowClear="true" notAllowSelectParent="true" checked="true"/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${not empty message.sender}">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label class="control-label col-sm-4"><span class="required">*</span> 发送者：</label>
								<div class="col-sm-8">
									${message.senderName} <fmt:formatDate value="${message.sendDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</div>
							</div>
						</div>
					</div>
				</c:if>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="user">
							<form:hidden path="status"/>
						<c:if test="${  message.status==null or message.status=='9' }">	
							<button id="btnDraft" type="submit" class="btn green" onclick="$('#status').val(9)"><i class="fa fa-save"></i> 暂 存</button>&nbsp;
							<button id="btnSubmit" type="submit" class="btn btn-primary" onclick="$('#status').val(0)"><i class="fa fa-check"></i> 发 送</button>&nbsp;
						</c:if>
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	$("#inputForm").validate({
		submitHandler: function(form){
			if (!contentUE.hasContents()){
           		contentUE.focus();
            	showMessage('请填写消息内容！', '警告','warning');
                return false;
            }
			// 设置接受者
			var receiverType = $('#inputForm input[name=receiverType]:checked').val();
			if (receiverType == '1'){
				$('#receiverCodes').val($('#receiverUserCode').val());
				$('#receiverNames').val($('#receiverUserName').val());
			}else if (receiverType == '2'){
				$('#receiverCodes').val($('#receiverOfficeCode').val());
				$('#receiverNames').val($('#receiverOfficeName').val());
			}
			if ($('#receiverCodes').val() == '' || $('#receiverNames').val() == ''){
				refreshReceiverType($('#inputForm input[name=receiverType]').focus().val());
            	showMessage('请选择接受者！', '警告','warning');
                return false;
			}
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
					});
				}
			}, "json");
	    }
	});
	// 配置接受者类型
	$('#inputForm input[name=receiverType]').click(function(){
		refreshReceiverType($(this).val());
	});
	refreshReceiverType($('#inputForm input[name=receiverType]:checked').val());
	function refreshReceiverType(val){
		if (val == '1'){
			$('#officeSelect').hide();
			var scrollTop = $('#userSelect').show().offset().top;
			$('#inputForm .form-body').animate({scrollTop: scrollTop});
		}else if (val == '2'){
			$('#userSelect').hide();
			var scrollTop = $('#officeSelect').show().offset().top;
			$('#inputForm .form-body').animate({scrollTop: scrollTop});
		}
	}
	
	// 人员选择初始默认
	function receiverUserBeforeForMap(selectData){
		var codes = $('#receiverUserCode').val();
		var names = $('#receiverUserName').val();
		var codesArr = new Array();
		var namesArr = new Array();
		if(codes != null && codes != "" && names != null && names != ""){
			codesArr = codes.split(",");
			namesArr = names.split(",");
			var jsons = {}, str = "";
			for(var i=0; i<codesArr.length; i++) {
				str='{"userCode":"'+codesArr[i]+'","userName":"'+namesArr[i]+'"}';
				jsons[codesArr[i]] = JSON.parse(str);
			}
			if(codesArr.length>0){
				selectData = JSON.stringify(jsons);
				selectData = selectData.replace(new RegExp("\"","g"),"\'");
			}
		}
   		return selectData;
	}
	
</script>