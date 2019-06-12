<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="任务管理 - 任务执行" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<!-- <div class="portlet-title">
		<div class="caption">流程测试</div>
	</div> -->
	<div class="portlet-body form">
		<form id="inputForm" action="${ctx}/flow/manage/task/complete" method="post" class="form-horizontal2">
			<div class="form-body">
				<table class="table table-striped">
					<tr><th>变量名</th><th>变量值(JSON)</th><th>变量类型</th><th>是否持久</th><th>描述</th></tr>
					<c:if test="${fn:length(vers) eq 0}">
						<tr><td colspan="5"><br/>未设置流程变量<br/><br/></td>
					</c:if>
					<c:forEach var="v" items="${vers}">
						<tr><td>${v.key}</td>
						<td><input name="var_${v.key}" type="text" value="${fn:escapeXml(v.value[0])}"
								onchange="$.uniform.update($('input[name=chk_${v.key}]').attr('checked',true))"/>
							<input name="chk_${v.key}" type="checkbox" value="${v.key}" title="标记为修改状态"/>
						</td>
						<td>${fn:escapeXml(v.value[1])}</td>
						<td>${fn:escapeXml(v.value[2])}
							<input name="persi_${v.key}" type="hidden" value="${fn:escapeXml(v.value[2])}"/>
						</td>
						<td>${fn:escapeXml(v.value[3])}</td></tr>
					</c:forEach>
				</table>
				<div class="form-actions fluid">
					<div class="row">
						<div class="col-sm-offset-2 col-sm-10">
							<flow:commandList />
						</div>
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
						alertx(data.message);
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