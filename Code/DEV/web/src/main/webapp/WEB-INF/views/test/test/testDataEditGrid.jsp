<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid,validate,fileupload,inputmask"/>
<sys:header title="单表管理" extLibs="${extLibs}" />
<%-- <style>
.ui-jqgrid input{border:0}
.ui-jqgrid .ui-row-ltr td input,
.ui-jqgrid tr.ui-state-highlight.ui-row-ltr td,
.ui-jqgrid tr.ui-state-highlight.ui-row-ltr td input {
  background-color:#FFFFFF !important;
}
.ui-jqgrid .ui-row-ltr.ui-priority-secondary td input,
.ui-jqgrid tr.ui-state-highlight.ui-row-ltr.ui-priority-secondary td,
.ui-jqgrid tr.ui-state-highlight.ui-row-ltr.ui-priority-secondary td input {
  background-color:#F9F9F9 !important;
}
</style> --%>
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 单表编辑行演示</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnAddRow" title="新增行"><i class="fa fa-plus-square"></i> 新增行</a>
			<a href="#" class="btn btn-default btn-sm" id="btnSaveData" title="保存数据"><i class="fa fa-save"></i> 保存数据</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="testData" action="${ctx}/test/testData/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">名称：</label>
				<div class="input-inline">
					<form:input path="name" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">日期：</label>
				<div class="input-inline">
					<sys:dateselect id="inDate" name="inDate" value="${testData.inDate}" dateType="2"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">日期范围：</label>
				<div class="input-inline">
					<input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate-date"
						value="${fns:formatDate(testData.inDate, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					&nbsp;--&nbsp;
					<input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate-date"
						value="${fns:formatDate(testData.inDate, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					&nbsp;
					<select onchange="quickSelectDate(this.value, 'beginDate', 'endDate');" style="width:75px;margin-top:-2px">
						<option value="0">&nbsp;</option><option value="1">今日</option><option value="2">本周</option>
						<option value="3">本月</option><option value="4">本季度</option><option value="5">上月</option>
					</select>
				</div>
			</div>
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>
		</form:form>
		<form:form id="inputForm" modelAttribute="testData" action="${ctx}/test/testData/list" method="post" class="form-horizontal">
			<table id="dataGrid"></table>
		    <div id="dataGridPage"></div>
	    </form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({

		searchForm: $('#searchForm'), 		// 数据来源表单
		dataGridPage: $('#dataGridPage'),	// 分页显示容器
// 		autoGridHeight: function(){return '100%'}, // 设置自动高度（子表中可能需要）
		
		// 设置数据表格列
		columnModel: [

    		{header:'编号', name:'id', hidden:true, unformat: inputUnformat, editable: true, edittype: 'text'},
  			{header:'状态', name:'status', hidden:true, unformat: inputUnformat, editable: true, edittype: 'text'},
  			
			// 编辑类型为文本框
			{header:'名称', name:'name', index:'a.name', width:150,
				//formatter:'currency', formatoptions:{thousandsSeparator:',',decimalSeparator:'.',decimalPlaces:2,defaulValue:'',prefix:'￥'}, // 货币格式格式化  
				editable: true, edittype: 'text', editoptions:{'class': 'form-control required moneyMask',
					dataInit: function(element){
						$(element).inputmask({alias:"money",autoUnmask:true});
					}
				}
			},
			
			// 编辑类型为文本域
			{header:'备注', name:'remarks', index:'a.remarks', width:150, 
				editable: true, edittype:'textarea', editoptions:{'class':'form-control required', 'rows':'1'}
			},
			
			// 编辑类型为下拉框
			{header:'性别', name:'sex', index:'a.sex', width:100,
				formatter: function(val, obj, row, act){
					return getDictLabel(${fns:getDictListJson('sex')}, val, '未知', true);
				}, 
				editable: true, edittype: "select", editoptions: {'class': 'form-control required',
					items: $.merge([{label:'&nbsp;',value:''}], ${fns:getDictListJson('sex')}),
					itemLabel: 'label', itemValue: 'value', dataInit: function(element){
						$(element).select2().on("change",function(){try{$(this).valid();}catch(e){}});
					}
				}
			},
			
			// 编辑类型为文本框，以日期选择控件举例
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:160, 
				formatter:'date', formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i'}, // 日期格式化，将日期中的秒去掉
				editable: true, edittype:"text", editoptions: {'class':'form-control required Wdate','readonly':'true',
					dataInit: function(element){ $(element).on('focus', function(){
						WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});
					});
				}}
			},
			
			// 树选择控件，以部门选择举例
			{header:'部门选择', name:'office', index:'', width:150,
				formatter: function(val, obj, row, act){
// 					obj.colModel.data[obj.rowId+"_code"] = row.officeCode;
// 					obj.colModel.data[obj.rowId+"_name"] = row.officeName;
// 					return obj.colModel.data[obj.rowId+"_name"];
					return getVal(obj.colModel.data[obj.rowId], 'officeName');
				},
				unformat: function(val, obj, cell){
// 					$(cell).find('#office_'+obj.rowId+'_officeCode').each(function(){
// 						obj.colModel.data[obj.rowId]['officeCode'] = $(this).val();
// 					});
// 					$(cell).find('#office_'+obj.rowId+'_officeName').each(function(){
// 						obj.colModel.data[obj.rowId]['officeName'] = $(this).val();
// 					});
// 					return obj.colModel.data[obj.rowId+"_code"] + '|'
// 						+ obj.colModel.data[obj.rowId+"_name"];
					return getVal(obj.colModel.data[obj.rowId], 'officeCode') + '|'
						+ getVal(obj.colModel.data[obj.rowId], 'officeName');
				},
				editable: true, edittype: "custom", editoptions: {
					custom_element: function(val, editOptions) {
						return template('treeselectTpl', {
							id: 'office_'+editOptions.id, 
							name: 'officeCode', value: val.split('|')[0], 
							labelName: 'officeName', labelValue: val.split('|')[1],
							title: '机构', url: '/sys/office/treeData', cssClass: 'required'
						});
					}
				}
			},
			
			// 编辑类型为自定义，以文本框举例
			{header:'联想输入', name:'remarks3', index:'', width:150, 
				formatter: function(val, obj, row, act){
					obj.colModel.data[obj.rowId+'_code'] = getVal(row, 'user.userCode');
					obj.colModel.data[obj.rowId+'_name'] = getVal(row, 'user.userName');
					return obj.colModel.data[obj.rowId+'_name'];
				},
				unformat: function(val, obj, cell){
// 					$(cell).find('#select_'+obj.rowId+'').each(function(){
// 						obj.colModel.data[obj.rowId+'_code'] = $(this).val();
// 						obj.colModel.data[obj.rowId+'_name'] = $(this).text();
// 					});
					return (obj.colModel.data[obj.rowId+'_code'] || '') + '|'
						+ (obj.colModel.data[obj.rowId+'_name'] || '');
				},
				editable: true, edittype: "custom", editoptions: {
					custom_element: function(val, editOptions) {
						var html = [];
						html.push('<input id="select_'+editOptions.id+'" value="'+val.split('|')[0]+'" class="form-control required"/>');
						html.push('<scr'+'ipt>selectQueryInput("'+editOptions.id+'","'+val.split('|')[1]+'");</scr'+'ipt>');
						return html.join('');
// 					},
// 					custom_value: function(elem, oper, value) {
// 						if (oper === "get") {
// 							return $(elem).find("input").val();
// 						}
					}
				}
			},
			
			// 当val返回‘new'时，代表是新增列，对新增列特殊设置操作
			{header:'操作', name:'actions', width:100, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
// 				actions.push('<a href="#" onclick="$(\'#inputForm\').submit();return false;"><i class="fa fa-save"></i></a>&nbsp;');
				if (val == 'new'){
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}else{
// 					actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/test/testData/delete?id='+row.id+'" class="btnList" title="删除该单表" data-confirm="确认要删除该单表吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}, editoptions: {defaultValue: 'new'}}
		],
		
		// 双击行，设置选择行为编辑行
		ondblClickRow: function(id) {
			if (id){
				var dg = $('#dataGrid');
				var rowData = dg.dataGrid('getRowData', id);
				if (rowData.status == '0'){
					dg.dataGrid('editRow', id, {keys:true});
				}else{
					showMessage('数据“' + rowData.name + '”不能修改');
				}
			}
		},
		
		// 编辑表格参数
		editGrid: true,				// 是否是编辑表格
		editGridInitRowNum: 1,		// 编辑表格的初始化新增行数
		editGridInitAllRowEdit: false,		// 是否初始化就编辑所有行
		editGridAddRowBtn: $('#btnAddRow'),	// 子表增行按钮
// 		editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL},	// 新增行的时候初始化的数据
		editGridAddRowInitData: function(){return {id: '', status: Global.STATUS_NORMAL}},	// 新增行的时候初始化的数据
		
		// 编辑表格的提交数据参数
		editGridInputFormListName: 'testDataChildList', // 提交的数据列表名
		editGridInputFormListAttrs: 'id,name,remarks,sex,updateDate,officeCode,officeName', // 提交数据列表的属性字段
		
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});

	// 基本输入框，撤销格式化数据
	function inputUnformat(val, obj, cell){
		$(cell).find('input').each(function(){
			obj.colModel.data[obj.rowId] = $(this).val();
		});
		return (obj.colModel.data[obj.rowId] || '');
	}

	// 提交保存数据按钮
	$('#btnSaveData').click(function(){
    	$("#inputForm").submit();
	});

	// 表单提交前执行
	$("#inputForm").validate({
		submitHandler: function(form){
			
			// 提交表单数据
			log("=== submit")
			log($(form).serializeArray())
	    	showMessage('表单提交！');

			// 如果保存成功，则从新加载Grid数据
			page();
			
			return false;
		}
	});
	
	// 下拉选择联想输入查询绑定方法
	function selectQueryInput(id, name){
		$("#" + id).select2({
		    ajax: {
		        url: "${ctx}/sys/user/listData",
		        dataType: 'json',
		        quietMillis: 200, // 延迟
		        data: function (text, page) {
		            return {loginCode:text, pageSize:10, pageNo:page};
		        },
		        results: function (data, page) {
		            return {results:data.list, more:(page * data.pageSize) < data.count};
		        }
		    },
		    formatResult: function (data) {
		        return data.userName; // 下拉查询结果项里的值
		    },
		    formatSelection: function (data) {
		        return data.userName; // 选择项后里显示在框的值
		    },
		    id: function (data) {
		    	return data.loginCode; // 提交到后台的值(隐藏域)
		    },
		    initSelection : function (element, callback) {
		        callback({loginCode:element.val(), userName:name}); // 初始化设置值
		    },
		    placeholder: "", 		// 输入框提示信息
		    minimumInputLength: 1,	// 输入长度大于这个数值后开始查询
		    escapeMarkup: function (m) { return m; }
		})
		// 值变更后进行表单验证
		.on("change",function(){
			try{$(this).valid();}catch(e){}
		});
	}
</script>
<script id="treeselectTpl" type="text/template">//<!--<div>
<sys:treeselect id="{{id}}" name="{{name}}" value="{{value}}" labelName="{{labelName}}" labelValue="{{labelValue}}" 
		title="{{title}}" url="{{url}}" cssClass="{{cssClass}}" allowClear="true"/>
</div>//--></script>