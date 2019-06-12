<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="查询列表数据权限管理 - ${formQueryDataScope.isNewRecord ? '新增' : '编辑'}查询列表数据权限" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>列表数据权限配置</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formQueryDataScope" action="${ctx}/form/formQueryDataScope/save" method="post" class="form-horizontal">
			<div class="portlet-tabs">
				<ul class="nav nav-tabs">
					<li class="active"><a id="btn_portlet_tab6" href="javascript:void(0);">数据权限配置</a></li>
					<li><a id="btn_portlet_tab5" href="${ctx}/form/formQueryPermi/list?queryId=${formQueryDataScope.queryId}">按钮权限配置</a></li>
					<li><a id="btn_portlet_tab4" href="${ctx}/form/formQuery/formDataGridOptions?queryId=${formQueryDataScope.queryId}">表格选项配置</a></li>
					<li><a id="btn_portlet_tab3" href="${ctx}/form/formQueryButton/list?queryId=${formQueryDataScope.queryId}">按钮详细配置</a></li>
					<li><a id="btn_portlet_tab2" href="${ctx}/form/formQueryColumn/list?queryId=${formQueryDataScope.queryId}">列表字段配置</a></li>
					<li><a id="btn_portlet_tab1" href="${ctx}/form/formQuery/form?queryId=${formQueryDataScope.queryId}">&lt;&lt;基本信息</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="portlet_tab6">
						<div class="form-body">
							<h4 class="form-section">基本信息</h4>
							<form:hidden path="id"/>
							<form:hidden path="queryId"/>
							
							<table id="formQueryDataScopeGrid"></table>
							<a href="#" id="formQueryDataScopeGridAddRowBtn" class="btn btn-primary mt10 mb10"><i class="fa fa-plus"></i> 增行</a>
						</div>
						<div class="form-actions fluid">
							<div class="row">
								<div class="col-sm-offset-2 col-sm-10">
									<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
									<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>		
		</form:form>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	var queryId='${formQueryDataScope.queryId}';
	//初始化数据字典列DataGrid对象
	$("#formQueryDataScopeGrid").dataGrid({
		data: ${fns:toJson(dataScopeList)},
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
			{header:'权限类型', name:'ctrlType', width:120, editable:true, edittype:'select', editoptions:{'class':'form-control required',
				items: $.merge([{label:'&nbsp;',value:''}], ${fns:getDictListJson('form_query_datascope_ctrltype')}),
				itemLabel: 'label', itemValue: 'value', dataInit: function(element){
					$(element).select2().on("change",function(){try{$(this).valid();}catch(e){}});
				}
			}},
			{header:'权限过滤字段', name:'columnName', width:200,
				editable: true, edittype: "custom", editoptions: {
					custom_element: function(val, editOptions) {
						return template('treeselectTpl', {
							id: 'columnName_'+editOptions.id, 
							name: 'columnName', value: val, 
							labelName: 'columnName_', labelValue: val,
							title: '表字段', url: '/form/formQueryColumn/treeData?type=1&queryId='+queryId,
							cssClass: 'required', allowClear: 'true',checked: 'false'
						});
					}
				}	
			},
			{header:'操作', name:'actions', width:80, sortable:false, fixed:true, formatter: function(val, obj, row, act){
				var actions = [];
				if (val == 'new'){
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除该字段吗？\', function(){$(\'#formQueryDataScopeGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}else{
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除该字段吗？\', function(){$(\'#formQueryDataScopeGrid\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'})});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}, editoptions: {defaultValue: 'new'}}
		],
		
		// 编辑表格参数
		editGrid: true,				// 是否是编辑表格
		editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
		editGridAddRowBtn: $('#formQueryDataScopeGridAddRowBtn'),	// 子表增行按钮
		editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL},	// 新增行的时候初始化的数据
		
		// 编辑表格的提交数据参数
		editGridInputFormListName: 'dataScopeList', // 提交的数据列表名
		editGridInputFormListAttrs: 'id,status,ctrlType,columnName', // 提交数据列表的属性字段
		
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
	
	
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				/* if(data.result == Global.TRUE){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
					});
				} */
			}, "json");
	    }
	});
</script>
<script id="treeselectTpl" type="text/template">//<!--<div>
<sys:treeselect id="{{id}}" name="{{name}}" value="{{value}}" labelName="{{labelName}}" labelValue="{{labelValue}}" 
		title="{{title}}" url="{{url}}" cssClass="{{cssClass}}" checked="{{checked}}" allowClear="{{allowClear}}"/>
</div>
//--></script>