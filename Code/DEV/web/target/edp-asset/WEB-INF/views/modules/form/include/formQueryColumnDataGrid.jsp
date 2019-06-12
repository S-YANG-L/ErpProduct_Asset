<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="hide">
<span title=""><input type="checkbox" id="saveChk" class="chks"/>&nbsp;保存按钮</span></div>
<table id="formQueryColumnDataGrid"></table>

<script type="text/javascript">
//初始化数据字典列DataGrid对象
$("#formQueryColumnDataGrid").dataGrid({
	data: ${fns:toJson(formQuery.formQueryColumnList)},
	datatype: "local", // 设置本地数据
	autoGridHeight: function(){return 'auto'}, // 设置自动高度
	
	// 设置数据表格列
	columnModel: [
		{header:'编号', name:'id', hidden:true, formatter: function(val, obj, row, act){
			var html = [];
			html.push('<input id="'+obj.rowId+'_id" name="id" type="hidden" value="'+val+'"/>');
			html.push('<input id="'+obj.rowId+'_status" name="status" type="hidden" value="'+row.status+'"/>');
			html.push('<input id="'+obj.rowId+'_tableByName" name="tableByName" type="hidden" value="'+row.tableByName+'"/>');
			return html.join('');
		}},
		{header:'表名', name:'tableName', width:150, editable:true, edittype:'text',
			editoptions:{'maxlength':'64','class':'form-control','readOnly':'true'}
		},
		{header:'字段名', name:'columnName', width:150, editable:true, edittype:'text',
			editoptions:{'maxlength':'64', 'class':'form-control','readOnly':'true'}
		},
		{header:'显示列名', name:'columnComment', width:150, editable:true, edittype:'text',
			editoptions:{'maxlength':'200', 'class':'form-control required columnComment'}
		},
		{header:'<span title=""><input type="checkbox" id="saveChk1" onclick="onSelectAll()"/>&nbsp;</span>是否在列表中显示',
			name:"isShow", align:"center", width:100, editable: true, edittype: "checkbox",
			editoptions: {'class': 'form-control saveChk', 'value': '0', dataInit: function(element){
				$(element).uniform();
			}
		}},
		{header:'是否是导入导出列',
			name:"isExcel", align:"center", width:90, editable: true,  edittype: "select", editoptions: {'class': 'form-control',
				items: $.merge([{label:'&nbsp;',value:''}], ${fns:getDictListJson('form_query_columshow_isexcel')}),
				itemLabel: 'label', itemValue: 'value', dataInit: function(element){
					$(element).select2().on("change",function(){try{$(this).valid();}catch(e){}});
				}
			}
		},
		
		{header:'排序', name:'columnSort', width:30, align:'center', editable:true, edittype:'text', editoptions:{'maxlength':'8', 'class':'form-control required digits hide columnSort',
			dataInit: function(element){
				if ($(element).val() == ''){
					$(element).val($(element).closest('table').find('tr').length * 10);
				}
				$(element).parent().append('<i class="fa fa-arrows" style="color:#aaa;cursor:move"></i>');	
			},
			formatter:function (val,obj,row,act){
				$("#formQueryColumnDataGrid").tableDnD({
					onDragClass: "dragClass",
					dragHandle: "columnSort",
					onDrop: function(table, row){
						$(table).find('input.columnSort').each(function(i){
							$(this).val((i + 1) * 10);
						});
					}
				});
			}
		}, classes: 'columnSort' }
	],
	
	// 编辑表格参数
	editGrid: true,				// 是否是编辑表格
	editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
	//editGridAddRowBtn: $('#formTableColumnDataGridAddRowBtn'),	// 子表增行按钮
	//editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL},	// 新增行的时候初始化的数据
	// 编辑表格的提交数据参数
	editGridInputFormListName: 'formQueryColumnList', // 提交的数据列表名
	editGridInputFormListAttrs: 'id,status,columnName,columnComment,isShow,isReturn,columnSort,tableName,tableByName,isExcel', // 提交数据列表的属性字段
	ajaxSuccess: function(data){ // 加载成功后执行方法
		
	}
});
function onSelectAll(){
	$("#saveChk").click();
}
//多选
$(".chks").on("click",function(){
	debugger;
	var span = $(this).parent();
	var id = $(this).attr("id");
	if(span.hasClass('checked')){
		$.uniform.update($(this).removeAttr("checked"));
	}
	 if(this.checked){
		$("."+id).each(function(){
			$.uniform.update($(this).attr("checked",true));
		});
	}else{ 
		$("."+id).each(function(){
			$.uniform.update($(this).removeAttr("checked"));
		});
	}
});
</script>
