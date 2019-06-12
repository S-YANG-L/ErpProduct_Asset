<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="工作流模板管理 - ${flowTemplate.isNewRecord ? '新增' : '编辑'}工作流模板" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${flowTemplate.isNewRecord ? '新增' : '编辑'}工作流模板</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="flowTemplate" action="${ctx}/eflow/flowTemplate/save" method="post" class="form-horizontal">
			<div class="portlet-tabs">
				<ul class="nav nav-tabs">
					<li><a id="btn_portlet_tab2" href="#portlet_tab2">流程图配置</a></li>
					<li class="active"><a id="btn_portlet_tab1" href="#portlet_tab1" data-toggle="tab">基础信息</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="portlet_tab1">
						<div class="form-body">
							<h4 class="form-section">基本信息</h4>
							<form:hidden path="id"/>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											<span class="required">*</span> 工作流名称：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<form:input path="flowName" htmlEscape="false" maxlength="50" class="form-control required"/>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											<span class="required">*</span> 适用单据：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<form:select path="billtypeCodes" class="form-control required"  multiple="true">
			                					<form:options items="${fns:getDictList('eflow_bill_type')}" itemLabel="name" itemValue="value" htmlEscape="false" />
											</form:select>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											适用范围类型：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<input type="radio" name="scopeType" id="scopeType1" value="1" htmlEscape="false" maxlength="1" class="form-control" <c:if test="${flowTemplate.scopeType eq '1' or empty flowTemplate.scopeType }">checked="checked"</c:if> /><label for="scopeType1">公司</label>
											<input type="radio" name="scopeType" id="scopeType2" value="2" htmlEscape="false" maxlength="1" class="form-control" <c:if test="${flowTemplate.scopeType eq '2'}">checked="checked"</c:if>/><label for="scopeType2">部门</label>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											适用范围：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<sys:treeselect id="company" name="companyCodes" value="${flowTemplate.companyCodes}" labelName="companyNames" labelValue="${flowTemplate.companyNames}" 
															checked="true"	title="公司" url="/sys/company/treeData" isAll="true" cssClass="" allowClear="true" notAllowSelectParent="false"/>
											<sys:treeselect id="office" name="officeCodes" value="${flowTemplate.officeCodes}" labelName="officeNames" labelValue="${flowTemplate.officeNames}" 
															checked="true"	title="部门" url="/sys/office/treeData" isAll="true" cssClass=""  allowClear="true"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											当前版本：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<form:input path="version" htmlEscape="false" maxlength="20" class="form-control"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-2" title="">
											工作流程描述：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-10">
											<form:textarea path="flowDes" htmlEscape="false" maxlength="500" class="form-control"/>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div id="divBillDtl" class="hide"></div>
						<table id="dataGrid"></table>
						
						<div class="form-actions fluid">
							<div class="row">
								<div class="col-sm-offset-4 col-sm-8">
										<shiro:hasPermission name="eflow:flowTemplate:edit">
											<button id="addDtl" type="button" class="btn btn-primary" title="增行"><i class="fa fa-plus"></i> 增行</button>&nbsp;
										</shiro:hasPermission>
										<shiro:hasPermission name="eflow:flowTemplate:edit">
											<button id="btnSubmit" type="button" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
											<button id="btnNext" type="button" class="btn btn-primary" title="保存并下一步"><i class="fa fa-arrow-circle-right"></i> 下一步</button>&nbsp;
										</shiro:hasPermission>
									<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form:form>
		<form:form id="searchForm" modelAttribute="flowTemplate" action="${ctx}/eflow/flowTemplates/findFlowTemplatesByFlowId?flowId=${flowTemplate.id }" method="post" class="breadcrumb form-inline hide">
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script src="${ctxStatic}/eflow/eflow-template.js?${_version}"></script>
<script type="text/javascript">
	var lastSelection;
	// 保存方式，save：保存并关闭，saveNext：保存并下一步
	var saveFlag = "save";
	$(function(){
		if('${flowTemplate.scopeType}'=='1' || '${flowTemplate.scopeType}'==''){
			showCompany();
		}else if('${flowTemplate.scopeType}'=='2'){
			showOffice();
		}
		$("input:radio[name='scopeType']").change(function(){
			if($(this).val()=='1'){
				showCompany();
			}else if($(this).val()=='2'){
				showOffice();
			}
		});
	})
	
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					if(saveFlag=="save"){
						closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
							contentWindow.page();
						});
					}else if(saveFlag=="saveNext"){
						location.href="${ctx}/eflow/flowTemplate/formGojs?id="+data.flowTemplate.id;
					}
				}
			}, "json");
	    }
	});
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		autoGridHeight: function(){return '100%'},
		// 设置数据表格列
		columnModel: [
			{header:'id', name:'id', index:'a.id', width:50, align:"left",hidden:true},
			{header:'步骤', name:'step', index:'a.step', width:50, align:"center"},
			{header:'步骤名称', name:'stepName', index:'a.step_name', width:150, align:"left"},
			{header:'审批对象类型', name:'approvalObjType', index:'a.approval_obj_type', width:100, align:"left", formatter: 'select', 
				 edittype: "select", editoptions: { 'class' : 'form-control',
					value: "1:岗位;2:角色;3:人员;4:发起人"
			}},
			{header:'审批对象编码', name:'approvalObjCode', index:'a.approval_obj_code',hidden: true, width:200, align:"left"},
			{header:'审批对象', name:'approvalObjName', index:'a.approval_obj_code', width:120, align:"left"},
			{header:'最小值', name:'minValue', index:'a.min_value', width:80, align:"right"},
			{header:'最大值', name:'maxValue', index:'a.max_value', width:80, align:"right"},
			{header:'不可跳过', name:'notSkip', index:'a.not_skip', width:80, align:"center", formatter: 'select', 
				 edittype: "select", editoptions: { 'class' : 'form-control',
						value: "0:否;1:是"
			}},
			{header:'审批不通过时', name:'backFlag', index:'a.back_flag', width:120, align:"left", formatter: 'select', 
				 edittype: "select", editoptions: { 'class' : 'form-control',
						value: "0:退回到申请人;1:退回到上一步"
			}},
			{header:'下一步骤', name:'nextStep', index:'a.next_step', width:100, align:"left"},
			{header:'审批类型', name:'approvalType', index:'a.approval_type', width:120, align:"left", formatter: 'select', 
				 edittype: "select", editoptions: { 'class' : 'form-control',
						value: "0:指定审批人;1:不指定审批人"
			}},
			{header:'包含会签', name:'isCsign', index:'a.is_csign', width:80, align:"left", formatter: 'select', 
				 edittype: "select", editoptions: { 'class' : 'form-control',
						value: "0:否;1:是"
			}},
			{header:'包含会审', name:'isJoint', index:'a.is_joint', width:80, align:"left", formatter: 'select', 
				 edittype: "select", editoptions: { 'class' : 'form-control',
					 value: "0:否;1:是"
			}},
			{header:'包含知会', name:'isNotify', index:'a.is_notify', width:80, align:"left", formatter: 'select', 
				 edittype: "select", editoptions: { 'class' : 'form-control',
					 value: "0:否;1:是"
			}},
			{header:'操作', name:'actions', width:70, fixed:true, sortable:false, align:"center", formatter: function(val, obj, row, act){
				var actions = [];
				/* actions.push('<a href="javascript:void(0);"><i class="fa fa-pencil"></i></a>&nbsp;'); */
				actions.push('<a href="#" onClick="openFlowTemplates(\''+obj.rowId+'\',false)" title="编辑工作流模板"><i class="fa fa-pencil"></i></a>&nbsp;');
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\');deleteArr(\''+row.step+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				return actions.join('');
			}}
		],
		groupHeaders: {
	 		twoLevel:[
	 			{startColumnName: 'minValue', numberOfColumns:2, titleText:'审批条件'}
	 		],
		},
	    onSelectRow: function (id) {
			if (id) {
				var dg = $('#dataGrid');
				// 按回车焦点向下获取，到最后一列时，调用此方法新增一行空数据，若不需要新增行，则不需要此代码
				if (id == 'new') {
					var dg = $('#dataGrid');
					dg.dataGrid('addRow', {
						position: 'last',
						addRowParams: {keys: true, focusField: true}
					});
				} else {
					// 选择行后，编辑此行数据
					dg.dataGrid('saveRow', lastSelection);
					dg.dataGrid('restoreRow', lastSelection);
					dg.dataGrid('editRow', id, {
						keys: true, focusField: true
					});
					lastSelection = id;
				}
			}

	    },
	    ondblClickRow: function(id, rownum, colnum, event){
	    	openFlowTemplates(id,false);
	    },
		ajaxSuccess: function(data){ // 加载成功后执行方法
			$(function(){
				var dg = $("#dataGrid");
				var ids = dg.dataGrid('getDataIDs');
				for (var i = 0; i < ids.length; i++) {
					dg.dataGrid('editRow', ids[i], {keys:true, focusField:false});
				}
				log(data);
				if(data != null &&  data != '' && data != undefined){
					$.each(data,function(k,item){
						selectStep.push(item.step);
					});
					log(selectStep);
				}
			});
		}
	});
	
	
</script>