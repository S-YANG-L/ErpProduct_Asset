<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="作业调度 - ${jobEntity.isNewRecord ? '新增' : '编辑'}作业" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${jobEntity.isNewRecord ? '新增' : '编辑'}作业调度</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="sys:job:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="jobEntity" action="${ctx}/sys/job/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 任务名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:hidden path="isNewRecord"/>
								<form:input path="jobName" htmlEscape="false" maxlength="64" readonly="${!jobEntity.isNewRecord}" class="form-control required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 任务组名：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<c:if test="${jobEntity.isNewRecord}">
									<form:select path="jobGroup" class="form-control required">
										<form:option value="" label=""/>
										<form:options items="${fns:getDictList('job_group')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</c:if>
								<c:if test="${!jobEntity.isNewRecord}">
									<form:hidden path="jobGroup" htmlEscape="false" maxlength="64" readonly="${!jobEntity.isNewRecord}" class="form-control required"/>
									<input type="text" name="jobGroupName" value="${fns:getDictLabel(jobEntity.jobGroup, 'job_group', '')}" maxlength="64" readonly="${!jobEntity.isNewRecord}" class="form-control required"/>
								</c:if>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required">*</span> 任务描述：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:input path="description" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required">*</span> 调用目标串：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:input path="invokeTarget" htmlEscape="false" maxlength="1000" class="form-control required"/>
								<div class="alert alert-warning" style="margin:10px 0 0 0">
									<ul style="padding:0 0 0 20px;">
										<li>Bean调用：Bean名或Bean类型名.方法名(参数1, 参数2, 参数n...) 示例：testDataService.executeTestTask(data, 1, 2L, 3F, 4D, "abc")</li>
										<li>静态类调用：静态类全名.方法名(参数1, 参数2, 参数n...)	示例： cn.net.ecode.modules.sys.utils.UserUtils.getRoleList()</li>
										<li>参数说明：支持Bean名参数、数值类型参数、字符串参数，字符串参数需要加双引号。</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required">*</span> Cron表达式：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:hidden path="cronExpression" htmlEscape="false" maxlength="255" class="form-control "/>
								<iframe id="cronFrame" src="${ctxStatic}/cron/index.html?ctx=${ctx}" style="width:660px;height:530px;border:0"></iframe>
								<script type="text/javascript">
									$('#cronFrame').load(function(){
										var conts = $(this).contents();
										conts.find('#cron').val($('#cronExpression').val());
										conts.find("input[name^='v_']").change(function(){
											log(1)
											$('#cronExpression').val($(this).val());
										});
										conts.find('#btnFan').click();
									});
								</script>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								计划错过策略：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<div class="radio-list">
									<form:radiobuttons path="misfireInstruction" items="${fns:getDictList('job_misfire_instruction')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control"/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								是否并发：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="concurrent" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control"/>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								备注信息：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:job:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
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
			if ($('#cronExpression').val($('#cronFrame').contents().find('#cron').val()).val() == ''){
				showMessage('请填写Cron表达式！', '', 'warning');
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
</script>
