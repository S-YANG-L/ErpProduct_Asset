<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<table id="formQueryOrderBy"></table>
<a href="#" id="formQueryOrderByAddRowBtn" class="btn btn-primary mt10 mb10"><i class="fa fa-plus"></i> 增行</a>

<script type="text/javascript">
var queryId='${formQuery.queryId}';
//初始化数据字典列DataGrid对象
$("#formQueryOrderBy").dataGrid({
	data: ${fns:toJson(formQuery.formQueryOrderByList)},
	datatype: "local", // 设置本地数据
	autoGridHeight: function(){return 'auto'}, // 设置自动高度
	
	// 设置数据表格列
	columnModel: [
		{header:'编号', name:'tableByName', hidden:true, formatter: function(val, obj, row, act){
			var html = [];
			html.push('<input id="'+obj.rowId+'_tableByName" name="tableByName" type="hidden" value="'+val+'"/>');
			return html.join('');
		}},
		 {header:'表名', name:'tableName', width:150,editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					return template('treeselectOrderByTpl', {
						id: 'tableName_'+editOptions.id, 
						name: 'tableName', value: val, 
						labelName: 'tableName_', labelValue: val,
						title: '数据表', url: '/form/formQuery/getSearchList?queryId='+queryId,
						cssClass: 'required', allowClear: 'false'
					});
				}
			}
		}, 
		{header:'排序字段', name:'columnName', width:150, editable:true, 
			editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					return template('treeselectOrderByTpl', {
						id: 'columnName_'+editOptions.id, 
						name: 'columnName', value: val, 
						labelName: 'columnName_', labelValue: val,
						title: '表字段', url: '/form/formQuery/getSearchList?queryId='+queryId+'&tableName=_none_',
						cssClass: 'required', allowClear: 'false'
					});
				} ,
				dataInit: function(element){
					var td = $(element).closest('td'),
					prevTd = td.prev(),
					prevId = prevTd.find('.customelement').attr('id'),
					prevCode = prevTd.find('#tableName_' + prevId + 'Code').val(),
					id = td.find('.customelement').attr('id'),
					div = td.find('#columnName_' + id + 'Div'),
					url = '${ctx}/form/formQuery/getSearchList?queryId='+queryId+'&tableName=';
					div.attr('data-url', url + (prevCode != '' ? prevCode : '_none_'));
				} 
			}
		},
		{header:'排序方式', name:'orderBy', width:120, editable:true, edittype:'select', editoptions:{'class':'form-control required',
			items: [
				    {label:'升序',value:'asc'},{label:'降序',value:'desc'}
				],
			itemLabel: 'label', itemValue: 'value', dataInit: function(element){
				$(element).select2().on("change",function(){try{$(this).valid();}catch(e){}});
			}
		}},
		{header:'排序', name:'whereSort', width:30, align:'center', editable:true, edittype:'text', editoptions:{'maxlength':'8', 'class':'form-control required digits hide whereSort',
			dataInit: function(element){
				if ($(element).val() == ''){
					$(element).val($(element).closest('table').find('tr').length * 10);
				}
				$(element).parent().append('<i class="fa fa-arrows" style="color:#aaa;cursor:move"></i>');	
			},
			formatter:function (val,obj,row,act){
				$("#formQueryOrderBy").tableDnD({
					onDragClass: "dragClass",
					dragHandle: "whereSort",
					onDrop: function(table, row){
						$(table).find('input.whereSort').each(function(i){
							$(this).val((i + 1) * 10);
						});
					}
				});
			}
		}, classes: 'whereSort'} ,
		{header:'操作', name:'actions', width:80, sortable:false, fixed:true, formatter: function(val, obj, row, act){
			var actions = [];
			if (val == 'new'){
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除该字段吗？\', function(){$(\'#formQueryOrderBy\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}else{
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除该字段吗？\', function(){$(\'#formQueryOrderBy\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'})});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}
			return actions.join('');
		}, editoptions: {defaultValue: 'new'}}
	],
	
	// 编辑表格参数
	editGrid: true,				// 是否是编辑表格
	editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
	editGridAddRowBtn: $('#formQueryOrderByAddRowBtn'),	// 子表增行按钮
	editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL},	// 新增行的时候初始化的数据
	
	// 编辑表格的提交数据参数
	editGridInputFormListName: 'formQueryOrderByList', // 提交的数据列表名
	editGridInputFormListAttrs: 'tableByName,tableName,columnName,orderBy,whereSort', // 提交数据列表的属性字段
	
	ajaxSuccess: function(data){ // 加载成功后执行方法
		
	}
});
function treeselectOrderByCallBack(id, v, h, f){
	debugger;
	if (id.startWith('tableName_')){
		var td = $('#'+id+'Div').closest('td'),
		id = td.find('.customelement').attr('id'),
		code = td.find('#tableName_' + id + 'Code').val(),
		url = '${ctx}/form/formQuery/getSearchList?queryId='+queryId+'&tableName=',
		nextTd = td.next(),
		nextId = nextTd.find('.customelement').attr('id');
		//设置关联表主键、返回值弹窗的data-url 并清空值
		nextTd.find('#columnName_' + nextId + 'Div').attr('data-url', url + code);
		nextTd.find('#columnName_' + nextId + 'Code').val('');
		nextTd.find('#columnName_' + nextId + 'Name').val('');
		setTbByName(id,code);
	}
}
//设置表的别名
function setTbByName(ids,tbName){
	debugger;
	var id=ids.split("_");
	$.ajax({ 
       type: "post", 
       url: "${ctx}/form/formQuery/getTbByName?queryId="+queryId+"&tableName="+tbName, 
       cache:false, 
       async:false, 
       success: function(data){ 
    	   dd=data+"_str";
    	   $("#"+id[0]+"_tableByName").val(data);
      } 
	});
}
</script>
<script id="treeselectOrderByTpl" type="text/template">//<!--<div>
<sys:treeselect id="{{id}}" name="{{name}}" value="{{value}}" labelName="{{labelName}}" labelValue="{{labelValue}}" 
		title="{{title}}" url="{{url}}" cssClass="{{cssClass}}" checked="{{checked}}" allowClear="{{allowClear}}"/>
<script>function {{id}}TreeselectCallBack(v, h, f){treeselectOrderByCallBack('{{id}}', v, h, f);}</script>
</div>
//--></script>