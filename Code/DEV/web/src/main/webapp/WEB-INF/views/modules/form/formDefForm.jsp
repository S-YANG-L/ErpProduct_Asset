<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="表单定义管理 - ${formDef.isNewRecord ? '新增' : '编辑'}表单" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>
			<c:choose>
				<c:when test="${formDef.ifCopyForm ne '1'}">
					${formDef.isNewRecord ? '新增' : '编辑'}表单
				</c:when>
				<c:otherwise>
					复制表单
				</c:otherwise>
			</c:choose>
		</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="form:formDef:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formDef" action="${ctx}/form/formDef/save" method="post" class="form-horizontal">
			<div class="portlet-tabs">
				<ul class="nav nav-tabs">
					<li><a id="btn_portlet_tab3" href="javascript:void(0);" onclick="openPreview('${formDef.formId}','${formDef.formKey}','1')">表单预览</a></li>
					<li><a id="btn_portlet_tab2" href="javascript:void(0);" title="新增时先保存再打开设计界面,修改时直接打开设计界面">表单设计</a></li>
					<li class="active"><a id="btn_portlet_tab1" href="javascript:void(0);">表单配置</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="portlet_tab1">
						<form:hidden path="ifCopyForm"/>
						<div class="form-body">
						<h4 class="form-section">基本信息</h4>
						<form:hidden path="formId"/>
						<div class="row">
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="">
										<span class="required">*</span> 表单分类：<i class="fa icon-question hide"></i></label>
									<div class="col-sm-8">
										<!--<form:input path="formCategory" htmlEscape="false" maxlength="64" class="form-control required"/>-->
										<sys:treeselect id="formCategory" name="formCategory.categoryCode" value="${formDef.formCategory.categoryCode}"
											labelName="formCategory.categoryName" labelValue="${formDef.formCategory.categoryName}" 
											title="表单分类" url="/form/formCategory/treeData" cssClass="form-control required" allowClear="false"/>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="">
										<span class="required">*</span> 表单名称：<i class="fa icon-question hide"></i></label>
									<div class="col-sm-8">
										<form:input path="formName" htmlEscape="false" maxlength="200" class="form-control required"/>
									</div>
								</div>
							</div>
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="表单唯一key">
										<span class="required">*</span> 表单KEY：<i class="fa icon-question"></i></label>
									<div class="col-sm-8">
										<c:choose>
											<c:when test="${formDef.ifCopyForm ne '1'}">
												<c:choose>
												   <c:when test="${empty flag}">
												   		<form:input path="formKey" maxlength="64" class="form-control required abcd" readonly="${!formDef.isNewRecord}"
												   		remote="${ctx}/form/formDef/checkFormKey?formId=${formDef.formId }" data-msg-remote="表单Key已存在，请重新填写"/>
												   </c:when>
												   <c:otherwise>
														<form:input path="formKey" maxlength="64" class="form-control required abcd" readonly="true"/>
												   </c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<form:input path="formKey" maxlength="64" class="form-control required abcd" title="不修改表单KEY则为新增一个版本"/>
											</c:otherwise>
										</c:choose>
										
										
									</div>
								</div>
							</div>					
						</div>
						<div class="row">
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="指定生成表单编辑界面标题">
										<span class="required">*</span> 表单标题：<i class="fa icon-question"></i></label>
									<div class="col-sm-8">
										<form:input path="formTitle" htmlEscape="false" maxlength="200" class="form-control required"/>
									</div>
								</div>
							</div>
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="">
										<span class="required">*</span> 所属实体：<i class="fa icon-question hide"></i></label>
									<div class="col-sm-8">
		
										<c:choose>
										   <c:when test="${empty flag}">	
												<c:if test="${formDef.isNewRecord}">
													<form:select path="entityId" htmlEscape="false" class="form-control required">
														<c:forEach items="${formEntityList}" var="formEntity">
															<form:option value="${formEntity.entityId}">${formEntity.entityName}</form:option>
														</c:forEach>
													</form:select>
												</c:if>
												<c:if test="${!formDef.isNewRecord}">
													<%--<form:input path="entityId" class="form-control required abcd" readonly="${!formDef.isNewRecord}" />--%>
													<c:forEach items="${formEntityList}" var="formEntity">
											          	<c:if test='${formEntity.entityId ==formDef.entityId}'>					          	
											          		<input type="hidden" name="entityId" value="${formEntity.entityId}" class="form-control required"/>
											          		<input value="${formEntity.entityName}" class="form-control required" disabled="disabled"/>
											          	</c:if>
											      	</c:forEach>
												</c:if>
											</c:when>
											<c:otherwise>
												<!-- 
												<select name="entityId" disabled="disabled">
												      <c:forEach items="${formEntityList}" var="formEntity">
												          <option <c:if test='${formEntity.entityId ==formDef.entityId}'>selected="selected"</c:if> value="${formEntity.entityId}">${formEntity.entityName}</option>
												      </c:forEach>
												</select> -->
												<c:forEach items="${formEntityList}" var="formEntity">
										          	<c:if test='${formEntity.entityId ==formDef.entityId}'>					          	
										          		<input type="hidden" name="entityId" value="${formEntity.entityId}" class="form-control required"/>
										          		<input value="${formEntity.entityName}" class="form-control required" disabled="disabled"/>
										          	</c:if>
										      	</c:forEach>
										   </c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="">
										<span class="required">*</span> 表单类型<!-- （PC、手机） -->：<i class="fa icon-question hide"></i></label>
									<div class="col-sm-8">
										<!--<form:input path="formType" htmlEscape="false" maxlength="1" class="form-control required"/>-->
										<form:select path="formType" class="form-control required" id="formType">
											<!--<form:option value="" label="请选择"/>-->
											<form:options items="${fns:getDictList('form_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="">
										<span class="required">*</span> 布局方式<!-- （UEditor、拖拽布局） -->：<i class="fa icon-question hide"></i></label>
									<div class="col-sm-8">
										<!--<form:input path="layoutType" htmlEscape="false" maxlength="1" class="form-control required"/>-->
										<form:select path="layoutType" class="form-control required" id="layoutType">
											<!--<form:option value="" label="请选择"/>-->
											<form:options items="${fns:getDictList('form_layout_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
						</div>
						
						<div class="row"> 
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
						<div class="row">
								<div class='container-fluid'>
									<!-- <h2 class='page-header'>选项卡</h2> -->
									<h4 class="form-section">表单增强和表单事件</h4>
									
									<div class='tabbable tabs-left'>
									
										<!-- 选项卡：通过BS的类来控制选项卡的样式 -->
										<ul class='nav nav-tabs'>
											<li class='active'><a href='#tab1' name="tab1" data-toggle='tab'>增强Groovy</a></li>
											<li><a href='#tab2' name="tab2" data-toggle='tab'>增强CSS样式</a></li>
											<li><a href='#tab3' name="tab3" data-toggle='tab'>增强JS脚本</a></li>
											<li><a href='#tab4' name="tab4" data-toggle='tab'>保存前执行JS</a></li>
											<li><a href='#tab5' name="tab5" data-toggle='tab'>保存后执行JS</a></li>
											<li><a href='#tab6' name="tab6" data-toggle='tab'>保存前执行Groovy</a></li>
											<li><a href='#tab7' name="tab7" data-toggle='tab'>保存后执行Groovy</a></li>
										</ul>
										
										<!--选项卡的内容定义-->
										<div class='tab-content'>
											<div class='tab-pane active' id='tab1'>
												<div class="row feature">
													<div class="form-group">
											            <div class="col-md-8">
											            	<textarea name="extGroovy">${formDef.extGroovy}</textarea>
															<div id="extGroovy" class="editorcss"></div>
															<div>
																<a href="javascript:void(0);" onclick="openSelectScriptDef('extGroovy')">选择脚本</a>&nbsp;
																<a href="javascript:void(0);" class="openScript" title="进入脚本管理">脚本管理</a>
															</div>
															<div>
																<font style="display:inline-block;height:20px;" color="red">说明：增强Groovy，打开表单之前执行，不需要重新生成界面</font>
															</div>
											            </div>
										            </div>
										        </div>
											</div>
											<div class='tab-pane' id='tab2'>
												<div class="row feature">
													<div class="form-group">
											            <div class="col-md-8">
											              	<%-- <form:textarea id="extCss" path="extCss" htmlEscape="false" rows="10" class="form-control"/>--%>
											              	<textarea name="extCss">${formDef.extCss}</textarea>
														    <div id="extCss" class="editorcss"></div>
															<div>
																<a href="javascript:void(0);" onclick="openSelectScriptDef('extCss')">选择脚本</a>&nbsp;
																<a href="javascript:void(0);" class="openScript" title="进入脚本管理">脚本管理</a>
															</div>
															<div>
																<font style="display:inline-block;height:20px;" color="red">说明：增强CSS样式，需要重新生成界面</font>
															</div>												    
													    </div>
										            </div>
										        </div>
											</div>
											<div class='tab-pane' id='tab3'>
												<div class="row feature">
													<div class="form-group">
											            <div class="col-md-8">
											              	<%-- <form:textarea id="extJs" path="extJs" htmlEscape="false" rows="10" class="form-control"/>--%>
											              	<textarea name="extJs">${formDef.extJs}</textarea>
														    <div id="extJs" class="editorcss"></div>
														    <div>
																<a href="javascript:void(0);" onclick="openSelectScriptDef('extJs')">选择脚本</a>&nbsp;
																<a href="javascript:void(0);" class="openScript" title="进入脚本管理">脚本管理</a>
															</div>
														    <div>
																<font style="display:inline-block;height:20px;" color="red">说明：增强JS脚本，需要重新生成界面</font>
															</div>
														</div>
										            </div>
										        </div>
											</div>
											<div class='tab-pane' id='tab4'>
												<div class="row feature">
													<div class="form-group">
											            <div class="col-md-8">
											              	<%-- <form:textarea id="saveBeforeJs" path="saveBeforeJs" htmlEscape="false" rows="10" class="form-control"/>--%>
											            	<textarea name="saveBeforeJs">${formDef.saveBeforeJs}</textarea>
														    <div id="saveBeforeJs" class="editorcss"></div>
														    <div>
																<a href="javascript:void(0);" onclick="openSelectScriptDef('saveBeforeJs')">选择脚本</a>&nbsp;
																<a href="javascript:void(0);" class="openScript" title="进入脚本管理">脚本管理</a>
															</div>
														    <div>
																<font style="display:inline-block;height:20px;" color="red">说明：保存前执行JS，需要重新生成界面</font>
															</div>
														</div>
										            </div>
										        </div>
											</div>
											<div class='tab-pane' id='tab5'>
												<div class="row feature">
													<div class="form-group">
											            <div class="col-md-8">
											              	<%-- <form:textarea id="saveAfterJs" path="saveAfterJs" htmlEscape="false" rows="10" class="form-control"/>--%>
											            	<textarea name="saveAfterJs">${formDef.saveAfterJs}</textarea>
														    <div id="saveAfterJs" class="editorcss"></div>
														    <div>
																<a href="javascript:void(0);" onclick="openSelectScriptDef('saveAfterJs')">选择脚本</a>&nbsp;
																<a href="javascript:void(0);" class="openScript" title="进入脚本管理">脚本管理</a>
															</div>
														    <div>
																<font style="display:inline-block;height:20px;" color="red">说明：保存后执行JS，需要重新生成界面</font>
															</div>
														</div>
										            </div>
										        </div>
											</div>
											<div class='tab-pane' id='tab6'>
												<div class="row feature">
													<div class="form-group">
											            <div class="col-md-8">
											              	<%-- <form:textarea id="saveBeforeGroovy" path="saveBeforeGroovy" htmlEscape="false" rows="10" class="form-control"/>--%>
											            	<textarea name="saveBeforeGroovy">${formDef.saveBeforeGroovy}</textarea>
														    <div id="saveBeforeGroovy" class="editorcss"></div>
														   <div>
																<a href="javascript:void(0);" onclick="openSelectScriptDef('saveBeforeGroovy')">选择脚本</a>&nbsp;
																<a href="javascript:void(0);" class="openScript" title="进入脚本管理">脚本管理</a>
															</div>
														    <div>
																<font style="display:inline-block;height:20px;" color="red">说明：保存前执行Groovy，不需要重新生成界面</font>
															</div>
														</div>
										            </div>
										        </div>
											</div>
											<div class='tab-pane' id='tab7'>
												<div class="row feature">
													<div class="form-group">
											            <div class="col-md-8">
											              	<%-- <form:textarea id="saveAfterGroovy" path="saveAfterGroovy" htmlEscape="false" rows="10" class="form-control"/>--%>
											            	<textarea name="saveAfterGroovy">${formDef.saveAfterGroovy}</textarea>
														    <div id="saveAfterGroovy" class="editorcss"></div>
														    <div>
																<a href="javascript:void(0);" onclick="openSelectScriptDef('saveAfterGroovy')">选择脚本</a>&nbsp;
																<a href="javascript:void(0);" class="openScript" title="进入脚本管理">脚本管理</a>
															</div>
														    <div>
																<font style="display:inline-block;height:20px;" color="red">说明：保存后执行Groovy，不需要重新生成界面</font>
															</div>
														</div>
										            </div>
										        </div>
											</div>
										</div> 
									</div>
							  </div>
						</div>
					<div class="form-actions fluid">
						<div class="row">
							<div class="col-sm-offset-2 col-sm-10">
								<shiro:hasPermission name="form:formDef:edit">
									<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
									<button id="btnSaveRelease" type="button" class="btn btn-primary"><i class="fa fa-check"></i> 保存并发布</button>&nbsp;
									<button id="btnSaveNext" type="button" class="btn btn-primary" title="先保存再打开设计界面"><i class="fa fa-arrow-circle-right"></i> 下一步</button>&nbsp;
								</shiro:hasPermission>
								<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
							</div>
						</div>
					</div>
				</div>
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
<script src="${ctxStatic}/form/js/form-def.js?${_version}" type="text/javascript"></script>
<style>
.editorcss {
    /**position: absolute;**/
    width: 130%;
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
var editor = ace.edit("extGroovy");
editor.focus();
editor.setOptions({  
   enableBasicAutocompletion: true,  
   enableSnippets: true,  
   enableLiveAutocompletion: true,//只能补全  
});
//editor.setTheme("ace/theme/twilight");
editor.session.setMode("ace/mode/groovy");

var textarea = $('textarea[name="extGroovy"]').hide();
//alert(textarea.val());
editor.getSession().setValue(textarea.val());
//alert(editor.getSession().getValue());
editor.getSession().on('change', function(){
	textarea.val(editor.getSession().getValue());
});


var init=function(id,setM){
	var editor = ace.edit(id);
	editor.focus();
	editor.setOptions({  
	   enableBasicAutocompletion: true,  
	   enableSnippets: true,  
	   enableLiveAutocompletion: true,//只能补全  
	});
	// editor.setTheme("ace/theme/twilight");
	editor.session.setMode("ace/mode/"+setM);
	
	var textarea = $('textarea[name="'+id+'"]').hide();
	editor.getSession().setValue(textarea.val());
	editor.getSession().on('change', function(){
	  textarea.val(editor.getSession().getValue());
	});
}

$(function(){
 $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
     // 获取已激活的标签页的名称
     var activeTab = $(e.target).text();
     // 获取前一个激活的标签页的名称
     var previousTab = $(e.relatedTarget).text();
		// 获取渲染ID
     // var id = $("#"+this.name).find("textarea").attr("id");
		var id = $("#"+this.name).find("textarea").attr("name");
     if(activeTab.indexOf("Groovy")>-1){
     	init(id,"groovy");
     }else if(activeTab.indexOf("JS")>-1){
     	init(id,"javascript");
     }else if(activeTab.indexOf("CSS")>-1){
     	init(id,"css");
     }
 });
});
</script>
<script type="text/javascript">
	/* if('${formDef.ifCopyForm}' == '1'){
		showMessage("说明：表单KEY和之前一致则为新增一个版本");
	} */
	var formId = '${formDef.formId}';
	var entityId = '${formDef.entityId}';
	var isNewRecord = '${formDef.isNewRecord}';
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					if(saveFlag == "save"){
						closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
							contentWindow.page();
						});
					}else if(saveFlag == "saveRelease"){
						$.post('${ctx}/form/formDef/releaseForm',{formId:data.formDef.formId},function(data){
							showMessage(data.message);
							if(data.result == Global.TRUE){
								closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
									contentWindow.page();
								});
							}
						},'json');
					}else if(saveFlag == "saveNext"){
						if(isNotBlank(data) && isNotBlank(data.formDef) && isNotBlank(data.formDef.formId) && isNotBlank(data.formDef.entityId)){
							var formId = data.formDef.formId;
							var entityId = data.formDef.entityId;
							//window.open("${ctx}/form/formDef/formDesigner?formId="+formId+"&entityId="+entityId);
							//openDesigner(formId,entityId);
							//top.addTabPage(top.$(this), '表单设计',ctx+"/form/formDef/formDesigner?formId="+formId+"&entityId="+entityId);
							location.href=ctx+"/form/formDef/formDesigner?formId="+formId+"&entityId="+entityId;
						}else{
							showMessage("无法打开设计界面！");
						}
					}
				}
			}, "json");
	    }
	});
	
</script>
