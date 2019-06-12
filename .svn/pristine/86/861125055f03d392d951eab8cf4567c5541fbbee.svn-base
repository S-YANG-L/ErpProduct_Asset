<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,fileupload"/>
<sys:header title="群组管理 - ${msgImGroup.isNewRecord ? '新增' : '编辑'}群组" extLibs="${extLibs}"/>
<style>
	.portlet.box.default {padding:0 !important}
	.form-body {border:0 !important}
	.wup_container.mini {height:120px;width:150px;margin:0 auto;margin-top:5px;}
	.wup_container.mini .web_uploader_img .placeholder .webuploader-pick {margin:38px 0;}
</style>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="msgImGroup" action="${ctx}/msgim/msgImGroup/save" method="post" class="form-horizontal">
			<div class="form-body">
				<form:hidden path="groupId"/>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<sys:fileupload id="groupAvatar" bizCategory="groupAvatar" bizKey="${msgImGroup.groupAvatar}"
									returnPath="true" uploadType="image" maxUploadNum="1" isMini="true"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								群组名：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:input path="groupName" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								群介绍：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${msgImGroup.isNewRecord}">
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								群成员：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<sys:listselect id="groupUserCodes"
										name="groupUserCodes" value="" labelName="" labelValue=""
										title="用户" url="${ctx}/sys/user/userSelect" isAll="true"
										returnCodeAttr="userCode" returnNameAttr="userName"
										multiple="true" cssClass="form-control"/>
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
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="top.layer.close(top.groupAddIndex);"><i class="fa fa-reply-all"></i> 关 闭</button>
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
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					top.layer.close(top.groupAddIndex);
				}
			}, "json");
	    }
	});
</script>
