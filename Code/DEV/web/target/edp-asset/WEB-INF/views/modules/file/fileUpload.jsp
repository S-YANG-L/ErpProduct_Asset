<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,fileupload" />
<sys:header title="文件上传管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-coffee"></i>上传附件
		</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputFormPhoto" modelAttribute="fileUser" action="${ctx}/file/fileUploadSave" method="post" enctype="multipart/form-data" >
				<div class="form-group">
					<sys:fileupload id="fileId" bizCategory="fileId" bizKey="fileId" dirId="${fileUser.dirId }"/>
				</div>
				<!-- <div class="margin-top-10">
					<button id="btnSubmitPhtot" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保存</button>
				</div> -->
		</form:form>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
$("#inputFormPhoto").validate({
	submitHandler: function(form){
		loading('正在提交，请稍后...');
		form.submit();
	}
});
</script>