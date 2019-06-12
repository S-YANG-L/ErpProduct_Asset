<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="表单查询管理 - ${formQuery.isNewRecord ? '新增' : '编辑'}表单查询" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${formQuery.isNewRecord ? '新增' : '编辑'}查询列表</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formQuery" action="${ctx}/form/formQuery/save" method="post" class="form-horizontal">
			<div class="portlet-tabs">
				<ul class="nav nav-tabs">
					<li><a id="btn_portlet_tab5" href="javascript:void(0);">详细配置>></a></li>
					<li><a id="btn_portlet_tab4" href="#portlet_tab4" data-toggle="tab">列表按钮配置 </a></li>
					<li><a id="btn_portlet_tab3" href="#portlet_tab3" data-toggle="tab">查询条件配置 </a></li>
					<li><a id="btn_portlet_tab2" href="#portlet_tab2" data-toggle="tab">字段配置 </a></li>
					<li class="active"><a id="btn_portlet_tab1" href="#portlet_tab1" data-toggle="tab">基本信息 </a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="portlet_tab1">
						<div class="form-body">
							<h4 class="form-section">基本信息</h4>
							<form:hidden path="queryId"/>
							<form:hidden path="isCopy"/>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											<span class="required">*</span> 表单分类：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<sys:treeselect id="categoryCode" name="categoryCode" value="${formQuery.categoryCode}"
												labelName="formCategory.categoryName" labelValue="${formQuery.formCategory.categoryName}" 
												title="表单分类" url="/form/formCategory/treeData" cssClass="form-control required" allowClear="false"/>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											<span class="required">*</span> 列表生成类型：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<form:radiobuttons path="queryGenerationType"  items="${fns:getDictList('form_query_gener_type')}"  itemLabel="label" itemValue="value" class="form-control required" htmlEscape="false"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											<span class="required">*</span> 查询名称：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<form:input path="queryName" htmlEscape="false" maxlength="200" class="form-control required" onblur="setValueToText(this.value);"/>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											<span class="required">*</span> 查询列表Key：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<c:choose>
												<c:when test="${formQuery.isCopy ne '1'}">
													<c:choose>
													   <c:when test="${formQuery.isNewRecord}">
													   		<form:input path="queryKey" htmlEscape="false" maxlength="64" class="form-control required abcd"
															remote="${ctx}/form/formQuery/checkQueryKeyIsExist?formId=${formQuery.queryId }" data-msg-remote="查询列表Key已存在，请重新填写"/>
													   </c:when>
													   <c:otherwise>
													   		<form:input path="queryKey" htmlEscape="false" maxlength="64" class="form-control required abcd" readonly="true"/>
													   </c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<form:input path="queryKey" htmlEscape="false" maxlength="64" class="form-control required abcd" readonly="true"/>
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
											<span class="required">*</span>查询列表标题：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<form:input path="queryTitle" htmlEscape="false" maxlength="200" class="form-control required"/>
										</div>
									</div>
								</div>
								<div class="col-xs-6 ">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											<span class="required">*</span> 所属实体：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<c:choose>
												<c:when test="${formQuery.isCopy ne '1'}">
													<c:choose>
													   <c:when test="${formQuery.isNewRecord}">
													   		<form:select path="entityId" htmlEscape="false" class="form-control required" onchange="formEntitChange(this.value);">
																<form:option value=""></form:option>
																<c:forEach items="${formEntityList}" var="formEntity">
																	<form:option value="${formEntity.entityId}">${formEntity.entityName}</form:option>
																</c:forEach>
															</form:select>
													   </c:when>
													   <c:otherwise>
													   		<form:hidden path="entityId"/>
													   		<select path="entityId" htmlEscape="false" class="form-control required" disabled="true">
																<c:forEach items="${formEntityList}" var="formEntity">
																	<option value="${formEntity.entityId}">${formEntity.entityName}</option>
																</c:forEach>
															</select>
													   </c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<form:hidden path="entityId"/>
											   		<select path="entityId" htmlEscape="false" class="form-control required" disabled="true">
														<c:forEach items="${formEntityList}" var="formEntity">
															<option value="${formEntity.entityId}">${formEntity.entityName}</option>
														</c:forEach>
													</select>
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
											选择表单key：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<select id="formKeySelect" name="queryOptionsMap['formKey']"  class="form-control">
												<option value="">&nbsp;</option>
											</select>
										</div>
									</div>
									
								</div>
								<div><font color="red"> &nbsp;&nbsp; * 当已经设计了表单请尽量选择该选项为后续按钮等功能提供参数支持减轻后续工作量。</font>
								
								</div>
							</div>
							<h4 class="form-section">列表查询关联表</h4>
							<div id="joinTableDiv"></div>
							<h4 class="form-section">列表增强和表单事件</h4>
							<%@ include file="/WEB-INF/views/modules/form/include/formQueryJoinExtGroovy.jsp"%>
						</div>
					</div>
					<div class="tab-pane" id="portlet_tab2">
						<div class="form-body">
							<h4 class="form-section">列表字段配置</h4>
							<div id="formQueryColumnDiv"></div>
						</div>
					</div>
					<div class="tab-pane" id="portlet_tab3">
						<div class="form-body">
							<h4 class="form-section">列表查询条件配置</h4>
							<div id="formQuerySearchDiv"></div>
							<h4 class="form-section">列表默认排序配置</h4>
							<div id="formQueryOrderByDiv"></div>
						</div>
					</div>
					
					<div class="tab-pane" id="portlet_tab4">
						<div class="form-body">
							<h4 class="form-section">列表按钮配置</h4>
							<div id="formQueryButtonDiv"></div>
						</div>
					</div>
					
				</div>
			</div>	
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<form:hidden path="flag"/>
						<shiro:hasPermission name="form:formQuery:edit">
							<button id="btnSave" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
							<button id="btnNext1" type="button" class="btn btn-primary"><i class="fa fa-arrow-circle-right"></i> 继续配置</button>
							<button id="btnNextInfoConfig" type="button" class="btn btn-primary"><i class="fa fa-check"></i> 保存并进入详细配置</button>&nbsp;
							<button id="btnNext2" type="button" class="btn btn-primary hide"><i class="fa fa-arrow-circle-right"></i> 继续配置</button>
							<button id="btnNext3" type="button" class="btn btn-primary hide"><i class="fa fa-arrow-circle-right"></i> 继续配置</button>
							<%-- <c:if test="${!formQuery.isNewRecord}">
								<button id="btnNextConfig_tab2" type="button" class="btn btn-primary"><i class="fa fa-arrow-circle-right"></i> 继续配置</button>
								<button id="btnNextConfig_tab3" type="button" class="btn btn-primary hide"><i class="fa fa-arrow-circle-right"></i> 继续配置</button>
								<button id="btnNextConfig_tab4" type="button" class="btn btn-primary hide"><i class="fa fa-arrow-circle-right"></i> 继续配置</button>
							</c:if> --%>
						</shiro:hasPermission>
						&nbsp;<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/jqGrid/4.7/plugins/jquery.tablednd.js?${_version}"></script>
<script src="${ctxStatic}/form/js/form-query.js?${_version}" type="text/javascript"></script>
<script type="text/javascript">

	//页面初始化
	$(document).ready(function(){
		var queryId=$("#queryId").val();
		var entityId=$("#entityId").val();
		var flag=$('#flag').val();
		var isCopy='${formQuery.isCopy}';
		var showTyp=2;if(isCopy=='1'){showTyp=1;}
		$.get("${ctx}/form/formQuery/initUnifiedEntrance?pageName=JoinDataGrid&showType="+showTyp+"&queryId="+queryId+"&formEntity.entityId="+entityId+"&time="+new Date(),function(data){
			$("#joinTableDiv").html(data);
	 	}); 
		//点击继续配置后加载列表字段
		if (flag== '0'){
			tab2(entityId,queryId,'1');
			$('#btn_portlet_tab2').click();
			$("#btnNext1").hide();
			$("#btnNext2").removeClass("hide");
		}
		//在配置字段列表点击继续配置加载where条件tab页并设置按钮
		else if (flag == '1'){
			tab2(entityId,queryId,'2');
			tab3(entityId,queryId);
			tab4(entityId,queryId);
			$('#btn_portlet_tab3').click();
			$("#btnNext1").hide();
			$("#btnNext2").hide();
			$("#btnNext3").removeClass("hide");
		}
		//在配置条件点击继续配置加载按钮条件tab页并设置按钮
		else if (flag == '2'){
			tab2(entityId,queryId,'2');
			tab3(entityId,queryId);
			tab4(entityId,queryId);
			tab5(entityId,queryId);
			$('#btn_portlet_tab4').click();
			$("#btnNext1").hide();
			$("#btnNext2").hide();
			$("#btnNext3").hide();
			$('#flag').val('');
		}
		//编辑时显示数据
		else if(queryId!='' && flag== ''){
			tab2(entityId,queryId,'2');
			tab3(entityId,queryId);
			tab4(entityId,queryId);
			tab5(entityId,queryId);
			$("#btnNext1").hide();
			$("#btnNext2").hide();
			$("#btnNext3").hide();
			$('#flag').val('');
		}
		getFormDefList(entityId);
	});
	
	var isNew ='${formQuery.isNewRecord}';
	function setValueToText(val){
		if(isNew=='true'){
			$("#queryTitle").val(val);
			genPinyin("queryKey",val);
		}
	}
	var formKey='${formQuery.queryOptionsMap.formKey}';
	$("#inputForm").submit(function(){
		$('#formQueryJoinDataGrid').dataGrid('updateListFieldName');
		$('#formQueryColumnDataGrid').dataGrid('updateListFieldName');
		$('#formQueryWhereDataGrid').dataGrid('updateListFieldName');
		$('#formQueryOrderBy').dataGrid('updateListFieldName');
		$('#formQueryBtnGrid').dataGrid('updateListFieldName');
	}).validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				var flag=$('#flag').val() ;
				if(flag=='' || data.result == Global.FALSE){
					showMessage(data.message);
				}
				if(data.result == Global.TRUE){
					if(flag!='' && flag != "3"){
						location="${ctx}/form/formQuery/form?queryId="+data.message+"&flag="+flag+"&parentTabPageId=${param.parentTabPageId}&tabPageId=${param.tabPageId}";
					}else if(flag!='' && flag == "3"){
						location="${ctx}/form/formQueryColumn/list?queryId="+data.message;
					}else{
						closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
							contentWindow.page();
						});
					}
				}
			}, "json");
	    }
	});
	
</script>
<script id="treeselectTpl" type="text/template">//<!--<div>
<sys:treeselect id="{{id}}" name="{{name}}" value="{{value}}" labelName="{{labelName}}" labelValue="{{labelValue}}" 
		title="{{title}}" url="{{url}}" cssClass="{{cssClass}}" checked="{{checked}}" allowClear="{{allowClear}}"/>
<script>function {{id}}TreeselectCallBack(v, h, f){treeselectCallBack('{{id}}', v, h, f);}</script>
</div>
//--></script>
