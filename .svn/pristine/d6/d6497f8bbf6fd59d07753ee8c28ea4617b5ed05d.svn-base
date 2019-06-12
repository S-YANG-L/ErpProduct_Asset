<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="代码生成 - ${genTable.isNewRecord ? '新增' : '编辑'}配置" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} tabbable autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-code"></i>${genTable.isNewRecord ? '新增' : '编辑'}配置</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="gen:genTable:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<c:choose>
			<c:when test="${empty genTable.tableName}">
				<form:form id="selectForm" modelAttribute="genTable" action="" method="post" class="form-horizontal">
					<div class="form-body">
						<h4 class="form-section">基本信息</h4>
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2">选择表：</label>
									<div class="col-sm-6">
										<input type="hidden" name="isNewRecord" value="true"/>
										<form:select path="tableName" class="form-control">
											<form:options items="${tableList}" itemLabel="nameAndComments" itemValue="tableName" htmlEscape="false"/>
										</form:select>
										<span class="help-block"></span>
										<br/>
										<sys:message content="${message}"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="form-actions fluid">
						<div class="row">
							<div class="col-sm-offset-2 col-sm-10">
								<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-arrow-circle-right"></i> 下一步</button>&nbsp;
								<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
							</div>
						</div>
					</div>
				</form:form>
			</c:when>
			<c:otherwise>
				<form:form id="inputForm" modelAttribute="genTable" action="${ctx}/gen/genTable/save" method="post" class="form-horizontal">
					<div class="portlet-tabs">
						<ul class="nav nav-tabs">
							<c:if test="${param.op eq 'gen'}">
								<li class="active"><a href="#portlet_tab3" data-toggle="tab">生成信息 </a></li>
							</c:if>
							<li><a id="btn_portlet_tab2" href="#portlet_tab2" data-toggle="tab">字段信息 </a></li>
							<li class="${param.op eq 'gen' ? '' : 'active'}"><a href="#portlet_tab1" data-toggle="tab">基本信息 </a></li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane ${param.op eq 'gen' ? '' : 'active'}" id="portlet_tab1">
								<div class="form-body">
									<h4 class="form-section">基本信息</h4>
									<div class="row">
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4"><span class="required">*</span> 表名：</label>
												<div class="col-sm-8">
													<form:hidden path="isNewRecord"/>
													<form:input path="tableName" htmlEscape="false" maxlength="64" readonly="true" class="form-control required"/>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4"><span class="required">*</span> 表说明：</label>
												<div class="col-sm-8">
													<form:input path="comments" htmlEscape="false" maxlength="500" class="form-control required"/>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4"><span class="required">*</span> 类名：</label>
												<div class="col-sm-8">
													<form:input path="className" htmlEscape="false" maxlength="100" class="form-control required"/>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4" title="功能开发者姓名">
													<span class="required">*</span> 功能作者：<i class="fa icon-question"></i></label>
												<div class="col-sm-8">
													<form:input path="functionAuthor" htmlEscape="false" maxlength="100" class="form-control required"/>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4"> 关联父表的表名：</label>
												<div class="col-sm-8">
													<form:select path="parentTableName" cssClass="form-control">
														<form:option value="">无</form:option>
														<form:options items="${tableList}" itemLabel="nameAndComments" itemValue="tableName" htmlEscape="false"/>
													</form:select>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4"> 本表关联的外键名：</label>
												<div class="col-sm-8">
													<form:select path="parentTableFkName" cssClass="form-control">
														<form:option value="">无</form:option>
														<form:options items="${genTable.columnList}" itemLabel="nameAndComments" itemValue="columnName" htmlEscape="false"/>
													</form:select>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
									</div>
									<h4 class="form-section">其它信息</h4>
									<div class="row">
										<div class="col-xs-12">
											<div class="form-group">
												<label class="control-label col-sm-2">备注：</label>
												<div class="col-sm-10">
													<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>	
							<div class="tab-pane" id="portlet_tab2">
								<table id="dataGrid"></table>
							</div>
							<c:if test="${param.op eq 'gen'}"><div class="tab-pane active" id="portlet_tab3">
								<div class="form-body">
									<c:if test="${genTable.parentExists}">
										<sys:message content="配置信息已保存，子表不需要配置生成信息。"></sys:message>
									</c:if>
									<h4 class="form-section">生成信息</h4>
									<div class="row">
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4">
													<span class="required">*</span> 生成模板：</label>
												<div class="col-sm-8">
													<form:select path="tplCategory" class="form-control required">
														<form:option value="">&nbsp;</form:option>
														<form:options items="${config.tplCategoryList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
													</form:select>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4" title="生成路径结构：{包名}/{模块名}/{分层(dao,entity,service,web)}/{子模块名}/{java类}">
													<span class="required">*</span> 生成包路径：<i class="fa icon-question"></i></label>
												<div class="col-sm-8">
													<form:input path="packageName" htmlEscape="false" maxlength="500" class="form-control required"/>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4" title="可理解为子系统名，例如 sys">
													<span class="required">*</span> 生成模块名：<i class="fa icon-question"></i></label>
												<div class="col-sm-8">
													<form:input path="moduleName" htmlEscape="false" maxlength="30" class="form-control required"/>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4" title="可选，分层(entity/dao/service/controller)下的文件夹">
													 生成子模块名：<i class="fa icon-question"></i></label>
												<div class="col-sm-8">
													<form:input path="subModuleName" htmlEscape="false" maxlength="30" class="form-control"/>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4" title="用作类描述">
													<span class="required">*</span> 生成功能名：<i class="fa icon-question"></i></label>
												<div class="col-sm-8">
													<form:input path="functionName" htmlEscape="false" maxlength="500" class="form-control required"/>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
										<div class="col-xs-6">
											<div class="form-group">
												<label class="control-label col-sm-4" title="用作功能提示，如：保存“某某”成功">
													<span class="required">*</span> 功能名（简写）：<i class="fa icon-question"></i></label>
												<div class="col-sm-8">
													<form:input path="functionNameSimple" htmlEscape="false" maxlength="100" class="form-control required"/>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12">
											<div class="form-group">
												<label class="control-label col-sm-2" title="可选，不填写，则生成到当前项目路径。">
													生成基础目录：<i class="fa icon-question"></i></label>
												<div class="col-sm-10">
													<form:input path="genBaseDir" htmlEscape="false" maxlength="2000" class="form-control"/>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
										<div class="col-xs-12">
											<div class="form-group">
												<label class="control-label col-sm-2" title="备用选项参数">
													其它生成选项：<i class="fa icon-question"></i></label>
												<div class="col-sm-10">
													<form:input path="options" htmlEscape="false" maxlength="2000" class="form-control"/>
													<br/><form:checkbox path="replaceFile" label="是否替换现有文件"/>
													&nbsp;<i class="fa icon-question" title="如果生成文件已经存在，选中该选项原文件则被覆盖。"></i>
													<span class="help-block"></span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div></c:if>
						</div>
					</div>
					<div class="form-actions fluid">
						<div class="row">
							<div class="col-sm-offset-2 col-sm-10">
								<shiro:hasPermission name="gen:genTable:edit">
									<form:hidden path="flag"/>
									<c:if test="${param.op ne 'gen'}">
										<button id="btnNext" type="submit" class="btn btn-primary" onclick="$('#flag').val('0');"><i class="fa fa-arrow-circle-right"></i> 下一步</button>&nbsp;
										<button id="btnSave" type="submit" class="btn btn-primary" onclick=""><i class="fa fa-check"></i> 保存配置</button>&nbsp;
									</c:if>
									<c:if test="${param.op eq 'gen' && !genTable.parentExists}">
										<button id="btnSubmit" type="submit" class="btn btn-primary" onclick="$('#flag').val('1');"
											title="输出到控制台，不生成文件。"><i class="fa fa-check"></i> 保存并编译</button>&nbsp;
										<button id="btnSubmitAndGen" type="submit" class="btn btn-danger" onclick="$('#flag').val('2');"
											title="输出到控制台，并生成文件。"><i class="fa fa-bug"></i> 保存并生成代码</button>&nbsp;
									</c:if>
								</shiro:hasPermission>
								<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
							</div>
						</div>
					</div>
				</form:form>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
var dataGrid; // 定义全局表格对象。
$(document).ready(function() {
	//<c:choose><c:when test="${empty genTable.tableName}">
	
	$("#selectForm").validate({
		submitHandler: function(form){
			form.submit();
	    }
	});
	
	//</c:when><c:otherwise>
	
	// 初始化DataGrid对象
	dataGrid = new DataGrid({
		
		dataGrid: $("#dataGrid"),
		data: ${fns:toJson(genTable.columnList)},
		datatype: "local", rowNum: 1000,
		sortableColumn: false, dataId: 'aa',
		autoGridHeight: function(){
			return $(window).height() - $('.portlet-title').outerHeight() 
				- $('.form-actions').outerHeight() - 120;
		},
		autoGridWidth: function(){
			return $('#inputForm .tab-content').width();
		},
		
		// 设置数据表格列
		columnModel: [
			{header:'列名', name:'columnName', width:100, frozen:true, formatter: function(val, obj, row, act){
				var html = [];
				if (row.status == Global.STATUS_DELETE){
					html.push('<span title="已被删除，保存后下次将不可见" style="color:red">' + val + ' <i class="fa icon-question"></i></span>');
				}else{
					html.push(val);
				}
				html.push('<input type="hidden" name="columnList[' + (obj.irow-1) + '].id" value="' + (row.id ? row.id : '') + '"/>');
				html.push('<input type="hidden" name="columnList[' + (obj.irow-1) + '].status" value="' + row.status + '"/>');
				html.push('<input type="hidden" name="columnList[' + (obj.irow-1) + '].columnName" value="' + row.columnName + '"/>');
				html.push('<input type="hidden" name="columnList[' + (obj.irow-1) + '].columnType" value="' + row.columnType + '"/>');
				return html.join('');
			}, formatCol: function(){
				log(222)
			}},
			{header:'列说明', name:'comments', width:100, align:"center", formatter: function(val, obj, row, act){
				return '<input type="text" name="columnList[' + (obj.irow-1) + '].comments" value="' + val + '" maxlength="64" class="required" data-msg-required="列说明不能为空" style="width:90px;" />';
			}},
			{header:'字段类型', name:'columnType', width:105},
			{header:'Java类型', name:'javaType', width:80, formatter: function(val, obj, row, act){
				var html = [];
				html.push('<select name="columnList[' + (obj.irow-1) + '].javaType" class="required" data-msg-required="请选择Java类型" style="width:70px;">'); //<c:forEach items="${config.javaTypeList}" var="dict">
				html.push('	<option value="${fns:escapeHtml(dict.value)}" ' + (val == '${fns:escapeHtml(dict.value)}' ? 'selected' : '') + ' title="${dict.description}">${fns:escapeHtml(dict.label)}</option>');//</c:forEach>
				html.push('</select>');
				return html.join('');
			}},
			{header:'Java字段 <i class="fa icon-question" title="实体对象的属性字段（格式：对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）；如果子表，则写主表实体类名+主键，如：formEntity.entityId"></i>', name:'javaField', width:100, formatter: function(val, obj, row, act){
				return '<input type="text" name="columnList[' + (obj.irow-1) + '].javaField" value="' + val + '" maxlength="64" class="required" data-msg-required="Java字段不能为空" style="width:90px;" />';
			}},
			{header:'主键', name:'isPk', width:35, align:"center", formatter: function(val, obj, row, act){
				return '<input type="checkbox" name="_columnList[' + (obj.irow-1) + '].isPk" value="1" ' + (val == '1' ? 'checked' : '') + ' />';
			}},
			{header:'可空', name:'isNull', width:35, align:"center", formatter: function(val, obj, row, act){
				return '<input type="checkbox" name="_columnList[' + (obj.irow-1) + '].isNull" value="1" ' + (val == '1' ? 'checked' : '') + ' />';
			}},
			{header:'插入', name:'isInsert', width:35, align:"center", formatter: function(val, obj, row, act){
				return '<input type="checkbox" name="_columnList[' + (obj.irow-1) + '].isInsert" value="1" ' + (val == '1' ? 'checked' : '') + ' />';
			}},
			{header:'更新', name:'isUpdate', width:35, align:"center", formatter: function(val, obj, row, act){
				return '<input type="checkbox" name="_columnList[' + (obj.irow-1) + '].isUpdate" value="1" ' + (val == '1' ? 'checked' : '') + ' />';
			}},
			{header:'列表', name:'isList', width:35, align:"center", formatter: function(val, obj, row, act){
				return '<input type="checkbox" name="_columnList[' + (obj.irow-1) + '].isList" value="1" ' + (val == '1' ? 'checked' : '') + ' />';
			}},
			{header:'查询', name:'isQuery', width:35, align:"center", formatter: function(val, obj, row, act){
				return '<input type="checkbox" name="_columnList[' + (obj.irow-1) + '].isQuery" value="1" ' + (val == '1' ? 'checked' : '') + ' />';
			}},
			{header:'匹配方式', name:'queryType', width:80, formatter: function(val, obj, row, act){
				var html = [];
				html.push('<select name="columnList[' + (obj.irow-1) + '].queryType" class="required" data-msg-required="请选择查询方式" style="width:70px;">'); //<c:forEach items="${config.queryTypeList}" var="dict">
				html.push('	<option value="${fns:escapeHtml(dict.value)}" ' + (val == '${fns:escapeHtml(dict.value)}' ? 'selected' : '') + ' title="${dict.description}">${fns:escapeHtml(dict.label)}</option>');//</c:forEach>
				html.push('</select>');
				return html.join('');
			}},
			{header:'编辑', name:'isEdit', width:35, align:"center", formatter: function(val, obj, row, act){
				return '<input type="checkbox" name="_columnList[' + (obj.irow-1) + '].isEdit" value="1" ' + (val == '1' ? 'checked' : '') + ' />';
			}},
			{header:'表单类型', name:'showType', width:90, formatter: function(val, obj, row, act){
				var html = [];
				html.push('<select name="columnList[' + (obj.irow-1) + '].showType" class="required" data-msg-required="请选择表单类型" style="width:80px;">'); //<c:forEach items="${config.showTypeList}" var="dict">
				html.push('	<option value="${fns:escapeHtml(dict.value)}" ' + (val == '${fns:escapeHtml(dict.value)}' ? 'selected' : '') + ' title="${dict.description}">${fns:escapeHtml(dict.label)}</option>');//</c:forEach>
				html.push('</select>');
				return html.join('');
			}},
			{header:'字典类型', name:'dictType', width:80, formatter: function(val, obj, row, act){
				return '<input type="text" name="columnList[' + (obj.irow-1) + '].dictType" value="' + val + '" maxlength="64" style="width:70px;" />';
			}},
			{header:'排序', name:'sorts', width:40, formatter: function(val, obj, row, act){
				return '<input type="text" name="columnList[' + (obj.irow-1) + '].sorts" value="' + val + '" maxlength="20" class="required" data-msg-required="排序不能为空" style="width:30px;" />';
			}},
			{header:'其它选项', name:'options', width:70, formatter: function(val, obj, row, act){
				return '<input type="text" name="columnList[' + (obj.irow-1) + '].options" value="' + (val ? val : '') + '" maxlength="2000" style="width:90px;" />';
			}}
		],
		
		// 设置多级表头
		groupHeaders: {
	 		twoLevel:[
	 			{startColumnName: 'columnName', numberOfColumns: 9, titleText: '字段'},
	 			{startColumnName: 'isList', numberOfColumns:3, titleText:'列表'},
	 			{startColumnName: 'isEdit', numberOfColumns:3, titleText:'表单'}
	 		]
		},
// 		frozenCols: true, 	// 冻结列，在colModel指定frozen: true
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});

	$("#inputForm").validate({
		ignore: "",
		submitHandler: function(form){
			if(${param.op ne 'gen'} && !$('#portlet_tab2').hasClass('active')){
				$('#btn_portlet_tab2').click();
				return false;
			}
			$("#inputForm input[type=checkbox]").each(function(){
				var name = $(this).attr("name").replace('_','');
				var id = name.replace('[','').replace(']','').replace('.','');
				var val = ($(this).attr("checked")?"1":"0");
				if ($("#" + id).length == 0){
					$(this).after("<input type=\"hidden\" name=\""+name+"\" id=\""+id+"\" value=\""+val+"\"/>");
				}else{
					$("#" + id).val(val);
				}
			});
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					if ($('#flag').val() == '0'){
						location = "${ctx}/gen/genTable/form?tableName=${genTable.tableName}&op=gen&parentTabPageId=${param.parentTabPageId}&tabPageId=${param.tabPageId}";
					}else{
						closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
							contentWindow.page();
						});
					}
				}
			}, "json");
	    }
	});
	//</c:otherwise></c:choose>
});
</script>