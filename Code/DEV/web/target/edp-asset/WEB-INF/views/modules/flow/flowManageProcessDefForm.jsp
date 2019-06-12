<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="流程定义 - ${empty deploymentId ? '发布' : '更新'}定义" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-body form">
		<form id="inputForm" action="${ctx}/flow/manage/processDef/save" method="post" enctype="multipart/form-data" class="form-horizontal">
			<input type="hidden" name="deploymentId" id="deploymentId" value="${deploymentId}" />
			<div class="form-body">
				<div class="row">
					<div class="col-xs-12">
						<br/>
						<input id="uploadFile" name="file" type="file" style="width:350px"/><br/>
						<font color="red">支持“bpmn”或“zip”文件格式流程定义文件！<br/>zip压缩包里只能包含bpmn和png文件。</font>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					getCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
						getJBox().close();
					});
				}
			}, "json");
	    }
	});
	// 提交表单
	function submitForm(){
		$("#inputForm").submit();
	}
</script>