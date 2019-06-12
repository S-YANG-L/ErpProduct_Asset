<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="工作流模板管理 - 流程图配置" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>流程图配置</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="flowTemplate" action="${ctx}/eflow/flowTemplate/saveGojs" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="gojsOptions" id="gojsOptions"/>
			<div class="portlet-tabs">
				<ul class="nav nav-tabs">
					<li class="active"><a id="btn_portlet_tab2" href="#portlet_tab2" data-toggle="tab">流程图配置</a></li>
					<li><a id="btn_portlet_tab1" href="${ctx}/eflow/flowTemplate/form?id=${flowTemplate.id}">基础信息</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="portlet_tab2">
							<div id="sample" style="width:100%;margin: 0 auto">
								  <div style="width:100%; white-space:nowrap;">
								    <!--  设计面板 -->
								    <span style="display: inline-block; vertical-align: top; padding: 5px; width:100%">
								      <div id="myFlowDesignerDiv" style="border: solid 1px #9e9e9e; height: 390px;"></div>
								    </span>
								  </div>
								</div>
						</div>
						
						<div class="form-actions fluid">
							<div class="row">
								<div class="col-sm-offset-4 col-sm-8">
										<shiro:hasPermission name="eflow:flowTemplate:edit">
											<button id="btnRefresh" type="button" class="btn btn-primary"><i class="fa fa-refresh"></i> 重新生成</button>&nbsp;
											<button id="btnSubmit" type="button" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
										</shiro:hasPermission>
									<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
								</div>
							</div>
						</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script src="${ctxStatic}/gojs/js/layer/layer.js"></script>
<script src="${ctxStatic}/gojs/js/go.js"></script>
<script src="${ctxStatic}/gojs/js/flow-desinger.js"></script>
<script src="${ctxStatic}/gojs/js/flow-display.js"></script>
<script src="${ctxStatic}/eflow/eflow-gojs.js"></script>
<script type="text/javascript">
	
	$("#inputForm").validate({
		submitHandler: function(form){
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