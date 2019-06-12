<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="业务实体管理 - ${formEntity.isNewRecord ? '新增' : '编辑'}业务实体" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${formEntity.isNewRecord ? '新增' : '编辑'}业务实体</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formEntity" action="${ctx}/form/formEntity/save" method="post" class="form-horizontal">
			<div class="portlet-tabs">
				<ul class="nav nav-tabs">
					<li><a id="btn_portlet_tab3" href="#portlet_tab3">权限配置</a></li>
					<li><a id="btn_portlet_tab2" href="#portlet_tab2">字段配置</a></li>
					<li class="active"><a id="btn_portlet_tab1" href="#portlet_tab1" data-toggle="tab">业务实体 </a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="portlet_tab1">
						<div class="form-body">
							<h4 class="form-section">基本信息</h4>
							<form:hidden path="entityId"/>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											<span class="required">*</span> 分类：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<sys:treeselect id="formCategory" name="formCategory.categoryCode" value="${formEntity.formCategory.categoryCode}"
												labelName="formCategory.categoryName" labelValue="${formEntity.formCategory.categoryName}" 
												title="表单分类" url="/form/formCategory/treeData" cssClass="form-control required" allowClear="false"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											<span class="required">*</span> 业务实体名称：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<form:input path="entityName" htmlEscape="false" maxlength="200" class="form-control required"/>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="">
											<span class="required">*</span> 归属物理表：<i class="fa icon-question hide"></i></label>
										<div class="col-sm-8">
											<c:if test="${formEntity.isNewRecord}">
												<form:select path="tableName" htmlEscape="false" class="form-control required" onchange="setTbNameVal(this.value);">
													<form:option value=""></form:option>
													<c:forEach items="${formTableList}" var="formTable">
														<form:option value="${formTable.tableName}">${formTable.tableName} (${formTable.tableComment})</form:option>
													</c:forEach>
												</form:select>
											</c:if>
											<c:if test="${!formEntity.isNewRecord}">
												<form:input path="tableName" class="form-control required abcd" readonly="${!formEntity.isNewRecord}" />
											</c:if>
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
							<h4 class="form-section">业务实体副表</h4>
							<div class="ml10 mr10">
								<table id="formEntitySubDataGrid"></table>
								<shiro:hasPermission name="form:formEntity:edit">
									<a href="#" id="formEntitySubDataGridAddRowBtn" class="btn btn-primary mt10 mb10"><i class="fa fa-plus"></i> 增行</a>
								</shiro:hasPermission>
							</div>
							<h4 class="form-section">辅助查询关联表</h4>
							<div class="ml10 mr10">
								<table id="formEntityJoinDataGrid"></table>
								<shiro:hasPermission name="form:formEntity:edit">
									<a href="#" id="formEntityJoinDataGridAddRowBtn" class="btn btn-primary mt10 mb10"><i class="fa fa-plus"></i> 增行</a>
								</shiro:hasPermission>
							</div>
						</div>
						<div class="form-actions fluid">
							<div class="row">
								<div class="col-sm-offset-2 col-sm-10">
									<shiro:hasPermission name="form:formEntity:edit">
										<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
										<button id="btnSubmitAndNext" type="button" class="btn btn-primary"><i class="fa fa-arrow-circle-right"></i> 下一步</button>&nbsp;
									</shiro:hasPermission>
									<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
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
<script src="${ctxStatic}/jqGrid/4.7/plugins/jquery.tablednd.js?${_version}"></script>
<script src="${ctxStatic}/form/js/form-entity.js?${_version}" type="text/javascript"></script>
<script type="text/javascript">
//初始化业务实体副表DataGrid对象
$("#formEntitySubDataGrid").dataGrid({
	data: ${fns:toJson(formEntity.formEntitySubList)},
	datatype: "local", // 设置本地数据
	autoGridHeight: function(){return 'auto'}, // 设置自动高度
	
	// 设置数据表格列
	columnModel: [
		{header:'编号', name:'entitySubId', hidden:true, formatter: function(val, obj, row, act){
			var html = [];
			html.push('<input id="'+obj.rowId+'_entitySubId" name="entitySubId" type="hidden" value="'+val+'"/>');
			html.push('<input id="'+obj.rowId+'_status" name="status" type="hidden" value="'+row.status+'"/>');
			return html.join('');
		}},
		{header:'关联关系', name:'joinType', width:80, editable:true, edittype:'select', editoptions:{'class':'form-control required',
			items: [
			    {label:'一对多',value:'onetomany'}, {label:'一对一',value:'join'}
			],
			itemLabel: 'label', itemValue: 'value', dataInit: function(element){
				$(element).select2();
			}
		}},
		{header:'副表名称', name:'subTableName', width:150,
			editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					return template('treeselectTpl', {
						id: 'subTableName_'+editOptions.id, 
						name: 'subTableName', value: val, 
						labelName: 'subTableName_', labelValue: val,
						title: '数据表', url: '/form/formTable/getTables',
						cssClass: 'required', allowClear: 'false'
					});
				}
			}
		},
		{header:'副表外键', name:'subTableFk', width:150,
			editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					return template('treeselectTpl', {
						id: 'subTableFk_'+editOptions.id, 
						name: 'subTableFk', value: val, 
						labelName: 'subTableFk_', labelValue: val,
						title: '表字段', url: '/form/formTable/getTables?tableName=_none_',
						cssClass: 'required', allowClear: 'false'
					});
				},
				dataInit: function(element){
					var td = $(element).closest('td'),
					prevTd = td.prev(),
					prevId = prevTd.find('.customelement').attr('id'),
					prevCode = prevTd.find('#subTableName_' + prevId + 'Code').val(),
					id = td.find('.customelement').attr('id'),
					div = td.find('#subTableFk_' + id + 'Div'),
					url = '${ctx}/form/formTable/getTables?tableName=';
					div.attr('data-url', url + (prevCode != '' ? prevCode : '_none_'));
				}
			}	
		},
		{header:'排序', name:'tableSort', width:30, align:'center', editable:true, edittype:'text', editoptions:{'maxlength':'8', 'class':'form-control required digits hide tableSort',
			dataInit: function(element){
				if ($(element).val() == ''){
					$(element).val($(element).closest('table').find('tr').length * 10);
				}
				$(element).parent().append('<i class="fa fa-arrows" style="color:#aaa;cursor:move"></i>');	
			},formatter:function (val,obj,row,act){
				$("#formEntitySubDataGrid").tableDnD({
					onDragClass: "dragClass",
					dragHandle: "tableSort",
					onDrop: function(table, row){
						$(table).find('input.tableSort').each(function(i){
							$(this).val((i + 1) * 10);
						});
					}
				});
			}
		}, classes: 'tableSort'},
		{header:'操作', name:'actions', width:80, sortable:false, fixed:true, formatter: function(val, obj, row, act){
			var actions = [];
			if (val == 'new'){
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#formEntitySubDataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}else{
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#formEntitySubDataGrid\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'})});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}
			return actions.join('');
		}, editoptions: {defaultValue: 'new'}}
	],
	
	// 编辑表格参数
	editGrid: true,				// 是否是编辑表格
	editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
	editGridAddRowBtn: $('#formEntitySubDataGridAddRowBtn'),	// 子表增行按钮
	editGridAddRowInitData: {entitySubId: '', status: Global.STATUS_NORMAL},	// 新增行的时候初始化的数据
	
	// 编辑表格的提交数据参数
	editGridInputFormListName: 'formEntitySubList', // 提交的数据列表名
	editGridInputFormListAttrs: 'entitySubId,status,entitySubId,joinType,subTableName,subTableFk,tableSort', // 提交数据列表的属性字段
	
	ajaxSuccess: function(data){ // 加载成功后执行方法
		
	}
});
var tbName=$("#tableName").val();
function setTbNameVal(tbVal){
	tbName=tbVal;
	$("#formEntityJoinDataGrid").jqGrid("clearGridData");
}
//初始化业务查询关联表DataGrid对象
$("#formEntityJoinDataGrid").dataGrid({

	data: ${fns:toJson(formEntity.formEntityJoinList)},
	datatype: "local", // 设置本地数据
	autoGridHeight: function(){return 'auto'}, // 设置自动高度
	
	// 设置数据表格列
	columnModel: [
		{header:'编号', name:'id', hidden:true, formatter: function(val, obj, row, act){
			var html = [];
			html.push('<input id="'+obj.rowId+'_id" name="id" type="hidden" value="'+val+'"/>');
			html.push('<input id="'+obj.rowId+'_status" name="status" type="hidden" value="'+row.status+'"/>');
			return html.join('');
		}},
		
		{header:'副表名称', name:'subTableNames', width:150,
			editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					return template('treeselectTpl', {
						id: 'subTableNames_'+editOptions.id, 
						name: 'subTableNames', value: val, 
						labelName: 'subTableNames_', labelValue: val,
						title: '数据表', url: '/form/formTable/getTables',
						 allowClear: 'true'
					});
				}
			}
		},
		{header:'关联类型', name:'joinType', width:100, editable:true, edittype:'select', editoptions:{'class':'form-control required',
			items: [
			    {label:'LEFT JOIN',value:'left join'},{label:'JOIN',value:'join'}
			],
			itemLabel: 'label', itemValue: 'value', dataInit: function(element){
				$(element).select2();
			}
		}},
		{header:'关联表名称', name:'joinTableName', width:150,
			editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					return template('treeselectTpl', {
						id: 'joinTableName_'+editOptions.id, 
						name: 'joinTableName', value: val, 
						labelName: 'joinTableName_', labelValue: val,
						title: '数据表', url: '/form/formTable/getDbTables',
						cssClass: 'required', allowClear: 'true'
					});
				}
			}
		},
		{header:'关联表主键', name:'joinTablePk', width:150,
			editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					return template('treeselectTpl', {
						id: 'joinTablePk_'+editOptions.id, 
						name: 'joinTablePk', value: val, 
						labelName: 'joinTablePk_', labelValue: val,
						title: '表字段', url: '/form/formTable/getDbTables?tableName=_none_',
						cssClass: 'required', allowClear: 'true'
					});
				},
				dataInit: function(element){
					var td = $(element).closest('td'),
					prevTd = td.prev(),
					prevId = prevTd.find('.customelement').attr('id'),
					prevCode = prevTd.find('#joinTableName_' + prevId + 'Code').val(),
					id = td.find('.customelement').attr('id'),
					div = td.find('#joinTablePk_' + id + 'Div'),
					url = '${ctx}/form/formTable/getDbTables?tableName=';
					div.attr('data-url', url + (prevCode != '' ? prevCode : '_none_'));
				}
			}	
		},
		{header:'主表外键', name:'mainTableFk', width:150, 
			editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					return template('treeselectTpl', {
						id: 'mainTableFk_'+editOptions.id, 
						name: 'mainTableFk', value: val, 
						labelName: 'mainTableFk_', labelValue: val,
						title: '表字段', url: '/form/formTable/getDbTables?tableName=_none_',
						cssClass: 'required', allowClear: 'true'
					});
				},
				dataInit: function(element){
					var td = $(element).closest('td'),
					prevTd = td.prev().prev().prev(),
					prevId = prevTd.find('.customelement').attr('id'),
					prevCode = prevTd.find('#subTableNames_' + prevId + 'Code').val(),
					id = td.find('.customelement').attr('id'),
					div = td.find('#mainTableFk_' + id + 'Div'),
					url = '${ctx}/form/formTable/getDbTables?tableName=';
					div.attr('data-url', url + (tbName != '' ? tbName : '_none_'));
				}
			}	
		},
		{header:'返回字段', name:'returnOptions', width:150,
			editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					log(val);
					log(editOptions);
					return template('treeselectTpl', {
						id: 'returnOptions_'+editOptions.id, 
						name: 'returnOptions', value: val, 
						labelName: 'returnOptions_', labelValue: val,
						title: '表字段', url: '/form/formTable/getDbTables?tableName=_none_',
						cssClass: 'required', allowClear: 'true',checked: 'true'
					});
				},
				dataInit: function(element){
					var tr = $(element).closest('tr'),
					td=tr.children("td"),
					prevTd = td.eq(4),
					prevId = prevTd.find('.customelement').attr('id'),
					prevCode = prevTd.find('#joinTableName_' + prevId + 'Code').val(),
					crentTd=td.eq(7),
					id = crentTd.find('.customelement').attr('id'),
					div = crentTd.find('#returnOptions_' + id + 'Div'),
					url = '${ctx}/form/formTable/getDbTables?tableName=';
					div.attr('data-url', url + (prevCode != '' ? prevCode : '_none_'));
				}
			}	
		},
		{header:'排序', name:'tableSort', width:30, align:'center', editable:true, edittype:'text', editoptions:{'maxlength':'8', 'class':'form-control required digits hide tableSort',
			dataInit: function(element){
				if ($(element).val() == ''){
					$(element).val($(element).closest('table').find('tr').length * 10);
				}
				$(element).parent().append('<i class="fa fa-arrows" style="color:#aaa;cursor:move"></i>');	
			},formatter:function(val,obj,row,act){
				$("#formEntityJoinDataGrid").tableDnD({
					onDragClass: "dragClass",
					dragHandle: "tableSort",
					onDrop: function(table, row){
						$(table).find('input.tableSort').each(function(i){
							$(this).val((i + 1) * 10);
						});
					}
				});
			}
		}, classes: 'tableSort'},
		{header:'操作', name:'actions', width:80, sortable:false, fixed:true, formatter: function(val, obj, row, act){
			var actions = [];
			if (val == 'new'){
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#formEntityJoinDataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}else{
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#formEntityJoinDataGrid\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'})});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}
			return actions.join('');
		}, editoptions: {defaultValue: 'new'}}
	],
	
	// 编辑表格参数
	editGrid: true,				// 是否是编辑表格
	editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
	editGridAddRowBtn: $('#formEntityJoinDataGridAddRowBtn'),	// 子表增行按钮
	editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL},	// 新增行的时候初始化的数据
	
	// 编辑表格的提交数据参数
	editGridInputFormListName: 'formEntityJoinList', // 提交的数据列表名
	editGridInputFormListAttrs: 'id,status,joinType,joinTableName,joinTablePk,mainTableFk,tableSort,returnOptions,subTableNames', // 提交数据列表的属性字段
	
	ajaxSuccess: function(data){ // 加载成功后执行方法
		
	}
});

$("#inputForm").validate({
	submitHandler: function(form){
		ajaxSubmitForm($(form), function(data){
			log(data);
			showMessage(data.message);
			if(data.result == Global.TRUE){
				// 保存并关闭
				if(saveFlag=="save"){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
					});
				}else if(saveFlag=="saveNextColumn"){	// 保存并下一步字段配置
					location.href="${ctx}/form/formEntityColumn/list?entityId="+data.formEntity.id;
				}else if(saveFlag=="saveNextPermi"){	// 保存并下一步权限配置
					location.href="${ctx}/form/formPermi/list?entityId="+data.formEntity.id+"&tableName="+data.formEntity.tableName;
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