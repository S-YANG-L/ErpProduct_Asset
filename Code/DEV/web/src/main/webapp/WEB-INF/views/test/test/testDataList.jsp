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
<%-- 			<shiro:hasPermission name="test:testData:edit"> --%>
				<a href="${ctx}/test/testData/form" class="btn btn-default btn-sm btnTool" title="新增单表"><i class="fa fa-plus"></i> 新增</a>
<%-- 			</shiro:hasPermission> --%>
			<a href="#" class="btn btn-default btn-sm" id="btnAddRow" title="新增行"><i class="fa fa-plus-square"></i> 新增行</a>
			<a href="#" class="btn btn-default btn-sm" id="btnSaveData" title="保存数据"><i class="fa fa-save"></i> 保存数据</a>
			<a href="${ctx}/test/testData/demoForm" class="btn btn-default btn-sm btnTool" title="表单演示">表单演示</a>
			<a href="${ctx}/test/testData/groupList" class="btn btn-default btn-sm btnTool" title="分组列表">分组列表</a>
			<a href="${ctx}/test/testData/editGrid" class="btn btn-default btn-sm btnTool" title="表格编辑">表格编辑</a>
			<a href="${ctx}/test/testData/treeList" class="btn btn-default btn-sm btnTool" title="树表编辑">树表编辑</a>
			<a href="${ctx}/test/testData/helpIndex" class="btn btn-default btn-sm " target="_blank" title="在线帮助">在线帮助</a>
			<a href="${ctx}/stepIndex?parentCode=0&title=演示标题#/judp-web/a/test/testData/tableForm?id=708182630277857280" class="btn btn-default btn-sm " target="_blank" title="大表单编辑">大表单编辑</a>
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
					&nbsp;
					<form:select path="" style="width:150px;margin-top:-2px">
						<form:option value=""></form:option>
						<form:options items="${fns:getOfficeAllList()}" itemLabel="officeName" itemValue="officeCode"/>
					</form:select>
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
	
// 	// 最后选择的行id（用于单行编辑）
// 	var lastSelection;
	
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({

		searchForm: $('#searchForm'), 		// 数据来源表单
		dataGridPage: $('#dataGridPage'),	// 分页显示容器
		tabPageId: '${param.tabPageId}',	// 当前页签编号（作为addTabPage的参数）
		
// 		autoGridHeight: function(){return '100%'}, // 设置自动高度（子表中可能需要）
		
		// 设置数据表格列
		columnModel: [
  			{header:'编号', name:'id', index:'a.id', width:120, align:'center', frozen:true,
	  			// 格式化数据，显示到单元格上的数据。
	  			formatter: function(val, obj, row, act){
					return val == '新增行' ? val : '<a href="${ctx}/test/testData/form?id='+row.id+'" class="btnList" data-title="编辑单表">'+(val ? val : row.id)+'</a>';
				},
				// 撤销格式化，在$('#dataGrid').dataGrid('getRowData')的时候获取的数据。
				unformat: function(val, obj, cell){return $(cell).attr('title');},
				// 编辑单元格，若不指定值时的默认值。
				editoptions: {defaultValue: '新增行'}
			},

			// 编辑类型为文本框（单行编辑，多行编辑）
			{header:'名称', name:'name', index:'a.name', width:150,
				// 货币格式格式化示例
				// formatter:'currency', formatoptions:{thousandsSeparator:',', decimalSeparator:'.', decimalPlaces:2, defaulValue:'', prefix:'￥'},  
				editable: true, edittype: 'text', editoptions:{'class': 'form-control required moneyMask'}
			},
			
			// 编辑类型为文本域
			{header:'备注', name:'remarks', index:'a.remarks', width:150, 
				editable: true, edittype:'textarea', editoptions:{'class':'form-control required', 'rows':'1'}
			},
			
			// 编辑类型为下拉框
			{header:'性别', name:'sex', index:'a.sex', width:100, 
				editable: true, edittype: "select", editoptions: {'class': 'form-control required',
					items: $.merge([{label:'&nbsp;',value:''}], ${fns:getDictListJson('sex')}),
					itemLabel: 'label', itemValue: 'value', dataInit: function(element){
						$(element).select2().on("change",function(){try{$(this).valid();}catch(e){}});
					}
				}
			},
			
			// 编辑类型为下拉框
// 			{header:'项目名称', name:'sex', index:'a.sex', width:100, 
// 				editable: true, edittype: "select", editoptions: {'class': 'form-control required',
// 					items: $.merge([{viewProjectName:'&nbsp;',projectCode:''}], ${fns:toJson(projectList)}),
// 					itemLabel: 'viewProjectName', itemValue: 'projectCode', dataInit: function(element){
// 						$(element).select2().on("change",function(){try{$(this).valid();}catch(e){}});
// 					}
// 				}
// 			},
			
			// 编辑类型为文本框，以日期选择控件举例
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:160, 
				formatter:'date', formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i'}, // 日期格式化，将日期中的秒去掉
				editable: true, edittype:"text", editoptions: {'class':'form-control Wdate','readonly':'true',
					dataInit: function(element){ $(element).on('focus', function(){
						WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});
					});
				}}
			},
			
			// 树选择控件，以部门选择举例
			{header:'部门选择', name:'remarks2', index:'', width:150,
				formatter: function(val, obj, row, act){
					return getVal(row, 'office.officeCode')+'|'+getVal(row, 'office.officeName');
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
					return getVal(row, 'user.userCode')+'|'+getVal(row, 'user.userName');
				},
				editable: true, edittype: "custom", editoptions: {
					custom_element: function(val, editOptions) {
						var html = [];
						html.push('<input id="'+editOptions.id+'" class="form-control required" value="'+val.split('|')[0]+'"/>');
						html.push('<scr'+'ipt>selectQueryInput("'+editOptions.id+'","'+val.split('|')[1]+'");</scr'+'ipt>');
						return html.join('');
					}
				}
			},
			
			// 编辑类型为附件上传（待优化）
			/* {header:'附件上传', name:'remarks4', index:'', width:150,
				formatter: function(val, obj, row, act){
					return getVal(row, 'remarks');
				}, editable: true, edittype: "custom", editoptions: {
					custom_element: function(val, editOptions) {
						return template('fileuploadTpl', {
							id: 'file_'+editOptions.id, bizCategory: 'remarks', bizKey: val
						});
					}
				}
			}, */
			
			// 当val返回‘new'时，代表是新增列，对新增列特殊设置操作
			{header:'操作', name:'actions', width:100, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<%--<shiro:hasPermission name="test:testData:edit">--%>
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/test/testData/form?id='+row.id+'" class="btnList" title="编辑单表"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/test/testData/tableForm?id='+row.id+'" class="btnList" title="编辑单表"><i class="fa fa-edit"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/test/testData/delete?id='+row.id+'" class="btnList" title="删除该单表" data-confirm="确认要删除该单表吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//<%--</shiro:hasPermission>--%>
				if (val == 'new'){
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}, editoptions: {defaultValue: 'new'}}
		],
		// 选择行后，设置选择行为编辑行
		onSelectRow: function(id) {
			if (id){
				var dg = $('#dataGrid');
				
				// 表单行验证（用于单行编辑）
//             	if (lastSelection){
//             		var editRow = dg.find('#'+lastSelection);
//         			if(editRow.find('input[name="remarks"]').val() == ''){
//             			showMessage('备注不能为空！', '警告', 'warning');
//             			return false;
//             		}
//             	}
				
    			// 调用此方法新增一行空数据，按回车焦点向下获取，到最后一列时也调用此方法（单行编辑，多行编辑）
				if (id == 'new'){
					var dg = $('#dataGrid');
					dg.dataGrid('addRow', {position: 'last', 
						addRowParams: {keys:true, focusField:true},
						initdata: {'name': '123'}
					});
				}
				// 选择行后，编辑此行数据（用于单行编辑）
//				else if (lastSelection != id){
//					dg.dataGrid('saveRow', lastSelection);
//					dg.dataGrid('editRow', id, {keys:true});
//					lastSelection = id;
//				}
				
			}
		},
		
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
			// 初始化后编辑所有行（多行编辑）
			$(function(){
				var dg = $("#dataGrid");
				var ids = dg.dataGrid('getDataIDs');
				for (var i = 0; i < ids.length; i++) {
					dg.dataGrid('editRow', ids[i], {keys:true, focusField:false});
				}
			});
			
//			// 合并单元格（参数：需要合并的列名，多个用逗号分隔，如：'company.companyNameSimple,office.officeName'）
//			$('#dataGrid').dataGrid('mergeCell', 'company.companyNameSimple,office.officeName');

		 	$("#dataGrid .moneyMask").inputmask({alias:"money",autoUnmask:true}); // 金额数据格式（自动恢复）
		}
	});
	
	// 新增行按钮（单行编辑，多行编辑）
	$('#btnAddRow').click(function(){
		$('#dataGrid').dataGrid('getParam', 'onSelectRow')('new');
	});
	
	// 提交保存数据按钮
	$('#btnSaveData').click(function(){
		var dg = $('#dataGrid');
		
// 		// 保存最后一个编辑行数据时的验证（lastSelection），验证失败返回false（用于单行编辑）
// 		if(dg.dataGrid('getParam', 'onSelectRow')('save') == false){
// 			return false;
// 		}
		
		// 获取全部行的数据（用于单行编辑）
    	var rows = dg.dataGrid('getRowData');
    	for (var i=0; i<rows.length; i++){
        	log(rows[i])
		}
    	showMessage('请打开浏览器控制台，看数据！');
    	log(dg.dataGrid('getParam', 'rowData'));

// 		// 保存全部编辑的行（批量保存，暂时无用）
// 		var dg = $("#dataGrid");
// 		var ids = dg.dataGrid('getDataIDs');
// 		for (var i = 0; i < ids.length; i++) {
// 			dg.dataGrid('saveRow', ids[i]);
// 		}
		
    	$("#inputForm").submit();
	});

	// 表单提交前执行
	$("#inputForm").submit(function(){
		
		var dg = $('#dataGrid');
		// 提交前更新列表字段名字，用于前端验证并方便后台接受（多行编辑）
		dg.dataGrid('updateListFieldName', 'list', 'name');
		dg.dataGrid('updateListFieldName', 'list', 'sex');
		dg.dataGrid('updateListFieldName', 'list', 'remarks');
		dg.dataGrid('updateListFieldName', 'list', 'remarks2');
		dg.dataGrid('updateListFieldName', 'list', 'remarks3');
		dg.dataGrid('updateListFieldName', 'list', 'officeCode');
		dg.dataGrid('updateListFieldName', 'list', 'officeName');
	
	})
	// 表单字段数据验证
	.validate({
		submitHandler: function(form){
			// 这里编写提交表单代码，模拟提交弹出信息
	    	showMessage('表单提交！');
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
<script id="fileuploadTpl" type="text/template">//<!--<div>
	<sys:fileupload id="{{id}}" bizCategory="{{bizCategory}}" bizKey="{{bizKey}}" readonly="false" returnPath="true" isMini="true"/>
</div>//--></script>