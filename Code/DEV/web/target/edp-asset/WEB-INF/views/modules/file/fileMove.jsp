<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="文件移到" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<form:form id="inputForm" modelAttribute="fileUser" action="${ctx}/file/fileMoveSave" method="post" class="form-horizontal">
		<form:hidden path="fileUserId"/>
		<form:hidden path="fileDir.globalId"/>
		<form:hidden path="dirId"/>
		<sys:treeselect id="dirId" name="" value="" labelName="" labelValue="" 
									title="文件移到" url="/file/fileDir/treeData?globalId=${fileUser.fileDir.globalId}" 
									extCode="" cssStyle="" hideBtn="false" cssClass="required" allowClear="true"/>
		<button id="btnSubmit" type="submit" class="btn btn-primary hide" style="float:right;margin-top:88px;"><i class="fa fa-check"></i> 保 存</button>&nbsp;
	</form:form>								
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
$("#inputForm").validate({
	submitHandler: function(form){
		if(null==$("#dirIdCode").val()||''==$("#dirIdCode").val())
		{
			alert("请选择文件移动到的目录");
			return;
		}
		$("#dirId").val($("#dirIdCode").val());
		ajaxSubmitForm($(form), function(data){
			showMessage(data.message);
			if(data.result == Global.TRUE){
				/* closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
					contentWindow.dataGrid.refreshTree(1, $('#parentCode').val());
				}); */
			}
		}, "json");
    }
});
</script>