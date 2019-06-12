<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<table id="formQueryBtnGrid"></table>
<a href="#" id="formQueryBtnGridAddRowBtn" class="btn btn-primary mt10 mb10"><i class="fa fa-plus"></i> 增行</a>
<font color="red"> &nbsp;&nbsp; * 该界面系统内置按钮，不可删除，如不需要可以在按钮详细配置界面进行停用操作,新增的自定义按钮可以进行删除操作。</font>
<script type="text/javascript">
//初始化业务查询关联表DataGrid对象
$("#formQueryBtnGrid").dataGrid({
	data:${fns:toJson(formQuery.formQueryButtonList)},
	datatype: "local", // 设置本地数据
	autoGridHeight: function(){return 'auto'}, // 设置自动高度
	// 设置数据表格列
	columnModel: [
		{header:'编号', name:'id', hidden:true, formatter: function(val, obj, row, act){
			var html = [];
			html.push('<input id="'+obj.rowId+'_id" name="id" type="hidden" value="'+val+'"/>');
			html.push('<input id="'+obj.rowId+'_status" name="status" type="hidden" value="0"/>');
			html.push('<input id="'+obj.rowId+'_isSys" name="isSys" type="hidden" value="'+row.isSys+'"/>');
			return html.join('');
		}},
		{header:'按钮id', name:'btnId', width:100, formatter: function(val, obj, row, act){
			if(row.isSys != '0'){
				return '<input id="'+obj.rowId+'_btnId" name="btnId" type="text" value="'+row.btnId+'" maxlength="20" class="form-control required abcd" />';
			}else{
				return '<input id="'+obj.rowId+'_btnId" name="btnId" type="text" value="'+row.btnId+'" maxlength="20" class="form-control required abcd" readonly="true" />';
			}
		}},
				
		{header:'按钮名称', name:'btnName', width:150, editable:true, edittype:'text',
			editoptions:{'maxlength':'20', 'class':'form-control required'}
		},
		{header:'按钮类型', name:'btnType', width:100, editable:true, edittype:'select', editoptions:{'class':'form-control required',
			items: [
			    {label:'顶部按钮',value:'0'},{label:'操作按钮',value:'1'}
			],
			itemLabel: 'label', itemValue: 'value', dataInit: function(element){
				$(element).select2();
			}
		}},
		{header:'排序', name:'btnSort', width:30, align:'center', editable:true, edittype:'text', editoptions:{'maxlength':'8', 'class':'form-control required digits hide btnSort',
			dataInit: function(element){
				if ($(element).val() == ''){
					$(element).val($(element).closest('table').find('tr').length * 10);
				}
				$(element).parent().append('<i class="fa fa-arrows" style="color:#aaa;cursor:move"></i>');	
			},formatter:function(val,obj,row,act){
				$("#formQueryBtnGrid").tableDnD({
					onDragClass: "dragClass",
					dragHandle: "btnSort",
					onDrop: function(table, row){
						$(table).find('input.btnSort').each(function(i){
							$(this).val((i + 1) * 10);
						});
					}
				});
			}
		}, classes: 'btnSort'},
		{header:'操作', name:'actions', width:80, sortable:false, fixed:true, formatter: function(val, obj, row, act){
			var actions = [];
			if (val == 'new'){
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#formQueryBtnGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}else if(row.isSys != '0'){
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#formQueryBtnGrid\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'})});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}
			return actions.join('');
		}, editoptions: {defaultValue: 'new'}}
	],
	
	// 编辑表格参数
	editGrid: true,				// 是否是编辑表格
	editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
	editGridAddRowBtn: $('#formQueryBtnGridAddRowBtn'),	// 子表增行按钮
	editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL,isSys:'1',btnId:''},	// 新增行的时候初始化的数据
	
	// 编辑表格的提交数据参数
	editGridInputFormListName: 'formQueryButtonList', // 提交的数据列表名
	editGridInputFormListAttrs: 'id,status,btnId,btnName,btnType,btnSort,isSys', // 提交数据列表的属性字段
	
	ajaxSuccess: function(data){ // 加载成功后执行方法
		
		
	}
});
</script>
