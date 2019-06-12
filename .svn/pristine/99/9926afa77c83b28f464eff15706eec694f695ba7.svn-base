<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<table id="formQueryJoinDataGrid"></table>
<a href="#" id="formQueryJoinDataGridAddRowBtn" class="btn btn-primary mt10 mb10"><i class="fa fa-plus"></i> 增行</a>
<font color="red">&nbsp;&nbsp;&nbsp;* 关联业务实体只有当有子表且需要子表进行生成查询条件时使用，如无子表或不以子表为条件查询时请谨慎配置！</font>
<script type="text/javascript">
var tbName='${formEntity.tableName}';
var showType='${showType}';
var data=[];
if(showType=='1'){
	data=${fns:toJson(formEntity.formEntityJoinList)};
}else{
	data=${fns:toJson(formQuery.formQueryJoinList)};
}
//初始化业务查询关联表DataGrid对象
$("#formQueryJoinDataGrid").dataGrid({
	data:data,
	datatype: "local", // 设置本地数据
	autoGridHeight: function(){return 'auto'}, // 设置自动高度
	// 设置数据表格列
	columnModel: [
		{header:'编号', name:'id', hidden:true, formatter: function(val, obj, row, act){
			var html = [];
			html.push('<input id="'+obj.rowId+'_id" name="id" type="hidden" value="'+val+'"/>');
			html.push('<input id="'+obj.rowId+'_status" name="status" type="hidden" value="0"/>');
			html.push('<input id="'+obj.rowId+'_showType" name="showType" type="hidden" value="'+(row.showType ? row.showType : showType) +'"/>');
			return html.join('');
		}},
		{header:'关联类型', name:'joinType', width:120, editable:true, edittype:'select', editoptions:{'class':'form-control required',
			items: [
			    {label:'LEFT JOIN',value:'left join'},{label:'JOIN',value:'join'}
			],
			itemLabel: 'label', itemValue: 'value', dataInit: function(element){
				$(element).select2();
			}
		}},
		 {header:'关联业务实体(可为空)', name:'entityId', width:150,
			formatter: function(val, obj, row, act){
				return getVal(row, 'entityId')+'|'+getVal(row, 'entityName');
			},
			editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					return template('treeselectEntityTpl', {
						id: 'entityId_'+editOptions.id, 
						name: 'entityId', value: val.split('|')[0], 
						labelName: 'entityName', labelValue: val.split('|')[1],
						title: '业务实体', url: '/form/formQuery/getEntityList',
						cssClass: ''
					});
				}
			}
		}, 
		
	    {header:'关联表名称', name:'joinTableName', width:150,editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					return template('treeselectTpl', {
						id: 'joinTableName_'+editOptions.id, 
						name: 'joinTableName', value: val, 
						labelName: 'joinTableName_', labelValue: val,
						title: '数据表', url: '/form/formTable/getDbTables',
						cssClass: 'required', allowClear: 'false'
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
						cssClass: 'required', allowClear: 'false'
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
						cssClass: 'required', allowClear: 'false'
					});
				},
				dataInit: function(element){
					var td = $(element).closest('td'),
					prevTd = td.prev(),
					prevId = prevTd.find('.customelement').attr('id'),
					prevCode = prevTd.find('#mainTableName_' + prevId + 'Code').val(),
					id = td.find('.customelement').attr('id'),
					div = td.find('#mainTableFk_' + id + 'Div'),
					url = '${ctx}/form/formTable/getDbTables?tableName=';
					div.attr('data-url', url + (tbName != '' ? tbName : '_none_'));
				}
			}	
		},
		{header:'返回字段', name:'returnOptions', width:240,
			editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
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
		{header:'排序', name:'tableSort', width:60, align:'center', editable:true, edittype:'text', editoptions:{'maxlength':'8', 'class':'form-control required digits hide tableSort',
			dataInit: function(element){
				if ($(element).val() == ''){
					$(element).val($(element).closest('table').find('tr').length * 10);
				}
				$(element).parent().append('<i class="fa fa-arrows" style="color:#aaa;cursor:move"></i>');	
			},formatter:function(val,obj,row,act){
				$("#formQueryJoinDataGrid").tableDnD({
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
		{header:'操作', name:'actions', width:60,align:'center', sortable:false, fixed:true, formatter: function(val, obj, row, act){
			var actions = [];
			if (val == 'new'){
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#formQueryJoinDataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}else{
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#formQueryJoinDataGrid\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'})});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}
			return actions.join('');
		}, editoptions: {defaultValue: 'new'}}
	],
	
	// 编辑表格参数
	editGrid: true,				// 是否是编辑表格
	editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
	editGridAddRowBtn: $('#formQueryJoinDataGridAddRowBtn'),	// 子表增行按钮
	editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL,showType: '1'},	// 新增行的时候初始化的数据
	// 编辑表格的提交数据参数
	editGridInputFormListName: 'formQueryJoinList', // 提交的数据列表名
	editGridInputFormListAttrs: 'id,status,joinType,joinTableName,joinTablePk,mainTableFk,tableSort,returnOptions,showType,entityId', // 提交数据列表的属性字段
	ajaxSuccess: function(data){ // 加载成功后执行方法
		
		
	}
});
function treeselectCallBack(id, v, h, f){
	if (id.startWith('joinTableName_')){
		var td = $('#'+id+'Div').closest('td'),
		id = td.find('.customelement').attr('id'),
		code = td.find('#joinTableName_' + id + 'Code').val(),
		url = '${ctx}/form/formTable/getDbTables?tableName=',
		nextTd = td.next(),
		nextTds = td.next().next().next(),
		nextId = nextTd.find('.customelement').attr('id');
		nextIds = nextTds.find('.customelement').attr('id');
		//设置关联表主键、返回值弹窗的data-url 并清空值
		nextTd.find('#joinTablePk_' + nextId + 'Div').attr('data-url', url + code);
		nextTd.find('#joinTablePk_' + nextId + 'Code').val('');
		nextTd.find('#joinTablePk_' + nextId + 'Name').val('');
		nextTds.find('#returnOptions_' + nextIds + 'Div').attr('data-url', url + code);
		nextTds.find('#returnOptions_' + nextIds + 'Code').val('');
		nextTds.find('#returnOptions_' + nextIds + 'Name').val('');
	}
	$('#formQueryJoinDataGrid').dataGrid('updateListFieldName');
}



function treeselectEntityCallBack(id, v, h, f){
	var td = $('#'+id+'Div').closest('td'),
	id = td.find('.customelement').attr('id'),
	entityId = td.find('#entityId_' + id + 'Code').val(),
	nextTd = td.next(),
	nextId = nextTd.find('.customelement').attr('id');
	$.ajax({ 
	       type: "post", 
	       url: "${ctx}/form/formEntity/getFormEntityInfo?entityId="+entityId+"&canAdmin=true", 
	       cache:false, 
	       async:false, 
	       success: function(data){ 
	    	   nextTd.find('#joinTableName_' + nextId + 'Code').val(data);
	    	   nextTd.find('#joinTableName_' + nextId + 'Name').val(data);
			   treeselectCallBack('joinTableName_'+nextId,null,null,null);
	      } 
	});
}
</script>


<script id="treeselectEntityTpl" type="text/template">//<!--<div>
<sys:treeselect id="{{id}}" name="{{name}}" value="{{value}}" labelName="{{labelName}}" labelValue="{{labelValue}}" 
		title="{{title}}" url="{{url}}" cssClass="{{cssClass}}" checked="{{checked}}" allowClear="true"/>
<script>function {{id}}TreeselectCallBack(v, h, f){treeselectEntityCallBack('{{id}}', v, h, f);}</script>
</div>
//--></script>
