<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="文件分享管理 - ${fileUserShare.isNewRecord ? '新增' : '编辑'}文件分享" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<%-- <div class="actions">
			<shiro:hasPermission name="file:fileUserShare:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="fileUserShare" action="${ctx}/file/fileUserShare/save" method="post" class="form-horizontal">
			<div class="form-body">
				<form:hidden path="shareId"/>
				<form:hidden path="fileUserId"/>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								用户：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<sys:treeselect id="user" name="user.userCode" value="${fileUserShare.user.userCode}" labelName="user.userName" labelValue="${fileUserShare.user.userName}"
									title="用户" url="/sys/office/treeData?type=4" cssClass="required" isAll="true" checked="true" allowClear="true" notAllowSelectParent="true"/><br/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="file:fileUserShare:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary hide" style="float:right;margin-right:4px;"><i class="fa fa-check"></i> 确定分享</button>&nbsp;
						</shiro:hasPermission>
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
					//window.close();
				}
			}, "json");
	    }
	});
	
</script>
