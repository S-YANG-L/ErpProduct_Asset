<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="脚本 - ${formScript.isNewRecord ? '新增' : '编辑'}脚本" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${formScript.isNewRecord ? '新增' : '编辑'}脚本</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="form:formScript:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formScript" action="${ctx}/form/formScript/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 脚本语言：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:select id="scriptLanguage" path="scriptLanguage" class="form-control required">
									<form:option value="" label=""/>
									<form:options items="${fns:getDictList('form_entity_language')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 脚本类别：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:select path="scriptType" id="scriptType" class="form-control required">
									<form:option value="" label=""/>
									<form:options items="${fns:getDictList('form_entity_script_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required">*</span> 脚本名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:input path="scriptName" id="scriptName" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class='container-fluid'>
						<!-- <h4 class="form-section">表单增强和表单事件</h4> -->
						<div class='tabbable tabs-left'>
							<div class='tab-content'>
								<div class='tab-pane active' id='tab1'>
									<div class="row feature">
										<div class="form-group">
											<label class="control-label col-sm-2" title="" style="margin-left: 22px;">
												<span class="required">*</span> 脚本内容：<i class="fa icon-question hide"></i></label>
								            <div class="col-md-8">
								            	<textarea name="scriptContent" class="required">${formScript.scriptContent}</textarea>
												<div id="scriptContent" class="editorcss"></div>
												<div>
													<font style="display:inline-block;height:20px;" color="red">说明：根据脚本语言输入脚本</font>
												</div>
								            </div>
							            </div>
							        </div>
								</div>
							</div> 
						</div>
				  </div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<div class="form-group">
						<label class="control-label col-sm-2" title="">
							脚本描述：<i class="fa icon-question hide"></i></label>
						<div class="col-sm-10">
							<form:textarea path="remarks" htmlEscape="false" rows="2" maxlength="255" class="form-control"/>
						</div>
					</div>
				</div>
			</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="form:formScript:edit">
							<button id="btnSubmit" type="button" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCheckGroovy" type="button" class="btn btn-primary ${formScript.scriptLanguage ne 'Groovy' && formScript.scriptLanguage ne 'sql'?'hide':''}"><i class="fa fa-check"></i> 检查脚本</button>&nbsp;
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<!-- ace -->
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/ext-language_tools.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/theme-monokai.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/ext-settings_menu.js"></script>
<script src="${ctxStatic}/form/js/form-public.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/form/js/form-script.js?${_version}" type="text/javascript"></script>
<style>
.editorcss {
    /**position: absolute;**/
    width: 131%;
    height: 300px;
}

pre {
	white-space: pre-wrap;       /* css-3 */
	white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
	white-space: -pre-wrap;      /* Opera 4-6 */
	white-space: -o-pre-wrap;    /* Opera 7 */
	word-wrap: break-word;       /* Internet Explorer 5.5+ */
	word-break:break-all;
	overflow:hidden;
	width:800px;
	height:300px
}
</style>

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
