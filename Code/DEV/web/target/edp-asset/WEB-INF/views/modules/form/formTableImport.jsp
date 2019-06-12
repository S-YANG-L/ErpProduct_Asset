<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="数据字典管理 - ${formTable.isNewRecord ? '导入' : '编辑'}数据字典" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${formTable.isNewRecord ? '导入' : '编辑'}数据字典</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formTable" action="${ctx}/form/formTable/save" method="post" class="form-horizontal">
			<form:hidden path="isWaitSync" value="0"/>
			<form:hidden path="tableType" value="1"/>
			<form:hidden path="isNewRecord"/>
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 分类：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<sys:treeselect id="formCategory" name="formCategory.categoryCode" value="${formTable.formCategory.categoryCode}"
									labelName="formCategory.categoryName" labelValue="${formTable.formCategory.categoryName}" 
									title="表单分类" url="/form/formCategory/treeData" cssClass="form-control required" allowClear="false"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 表名：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<c:if test="${formTable.isNewRecord==true }">
									<form:select path="tableName" class="form-control" onchange="tableChange(this.value);">
										<form:option value="">请选择</form:option>
										<c:forEach items="${tableList}" var="tb">
											<form:option value="${tb.tableName }" dir="${tb.comments }">${tb.nameAndComments}</form:option>
										</c:forEach>
									</form:select>
								</c:if>
								<c:if test="${formTable.isNewRecord==false }">
									<form:input path="tableName"  htmlEscape="false"  class="form-control required" readonly="true"/>
								</c:if>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 表描述：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="tableComment" htmlEscape="false" maxlength="200" class="form-control required"/>
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
				<h4 class="form-section">数据字典字段</h4>
				<div class="ml10 mr10">
					<table id="formTableColumnDataGrid"></table>
					<shiro:hasPermission name="form:formTable:edit">
						<a href="#" id="formTableColumnDataGridAddRowBtn" class="btn btn-primary mt10 mb10 hide"><i class="fa fa-plus"></i> 增行</a>
					</shiro:hasPermission>
				</div>
				<h4 class="form-section">其它选项</h4>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required hide">*</span> 数据实体字段：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<div><label><input type="checkbox" id="DataEntity" name="optionMap['DataEntity']" value="1"/>
									status、createBy、createDate、updateBy、updateDate、remarks</label></div>
								<input type="hidden" name="_optionMap['DataEntity']" value="on"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required hide">*</span> 树结构实体字段：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<div><label><input type="checkbox" id="treeEntity" name="optionMap['TreeEntity']" value="1"/>
									parentCode、parentCodes、sorts、hasnext、sortGrade</label></div>
								<input type="hidden" name="_optionMap['TreeEntity']" value="on"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6 treeEntity ${formTable.optionMap['TreeEntity'] == '1' ? '' : 'hide'}">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required hide">*</span> 树节点编码字段：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<select id="treeEntityNodeCode" name="optionMap['TreeEntityNodeCode']"
									class="form-control width-200" data-value="${formTable.optionMap['TreeEntityNodeCode']}">
									<option value="${formTable.optionMap['TreeEntityNodeCode']}" selected>${formTable.optionMap['TreeEntityNodeCode']}</option>
								</select>
							</div>
						</div>
					</div>
					<div class="col-xs-6 treeEntity ${formTable.optionMap['TreeEntity'] == '1' ? '' : 'hide'}">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required hide">*</span> 树节点名称字段：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<select id="treeEntityNodeName" name="optionMap['TreeEntityNodeName']"
									class="form-control width-200" data-value="${formTable.optionMap['TreeEntityNodeName']}">
									<option value="${formTable.optionMap['TreeEntityNodeName']}" selected>${formTable.optionMap['TreeEntityNodeName']}</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required hide">*</span> 第三方业务字段：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<div><label><input type="checkbox" id="DsfEntity" name="optionMap['DsfEntity']" value="1"/>
									collect_office采集部门(string)、collect_category采集类别(string)、
									collect_cycle采集周期(int)</label></div>
								<input type="hidden" name="_optionMap['DsfEntity']" value="on"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="form:formTable:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/jqGrid/4.7/plugins/jquery.tablednd.js?${_version}"></script>
<script src="${ctxStatic}/js/form-table.js?${_version}"></script>
<script type="text/javascript">
	var dataEntity = '${formTable.optionMap.DataEntity}';
	var treeEntity = '${formTable.optionMap.TreeEntity}';
	var dsfEntity = '${formTable.optionMap.DsfEntity}';
	var tableIsExist = '${tableIsExist}';
	var isNewRecord = '${formTable.isNewRecord}';
	//初始化数据字典列DataGrid对象
	$("#formTableColumnDataGrid").dataGrid({
		data: ${fns:toJson(formTable.formTableColumnList)},
		datatype: "local", // 设置本地数据
		autoGridHeight: function(){return 'auto'}, // 设置自动高度
		
		// 设置数据表格列
		columnModel: [
			{header:'编号', name:'id', hidden:true, formatter: function(val, obj, row, act){
				var html = [];
				html.push('<input id="'+obj.rowId+'_id" name="id" type="hidden" value="'+val+'"/>');
				html.push('<input id="'+obj.rowId+'_status" name="status" type="hidden" value="'+row.status+'"/>');
				html.push('<input id="'+obj.rowId+'_isNewOrDel" name="isNewOrDel" type="hidden" value="'+row.isNewOrDel+'"/>');
				return html.join('');
			}},
			{header:'字段描述', name:'columnComment', width:150, editable:true, edittype:'text',
				editoptions:{'maxlength':'200', 'class':'form-control required columnComment',
				dataInit: function(element){
					$(element).change(function(){
						$.post('${ctx}/form/pinyin', {text: $(this).val()}, function(data){
							var td = $(element).closest('td').next();
							var input = td.find('input:eq(0)');
							if(input.val() == ''){
								input.val(data).valid();
							}
						}, 'text');
					});
				}
			}},
			{header:'字段名', name:'columnName', width:150, editable:true, edittype:'text',
				editoptions:{'maxlength':'64','readonly' : 'true', 'class':'form-control required abcd columnUnique columnName'}},
			{header:'可为空', name:'isNull', width:50, fixed:true, align:'center', 
				editable:true, edittype:'checkbox', editoptions:{value:'1:0',
				dataInit:function(element){
					var td = $(element).closest('td');
					var name = $(element).attr('name');
					var val = $(element).is(":checked") ? '1' : '0';
					$('<input type="hidden" name="'+name+'" value="'+val+'">').appendTo(td);
					$(element).attr('name', '_' + name).change(function(){
						td.find('input[type=hidden]').val($(this).is(":checked") ? '1' : '0');
					}).uniform();
				}}
			},
			{header:'类型', name:'columnType', width:150, 
				editable:true, edittype:'select', editoptions:{'class':'form-control required','readonly' : true,
					items: [
					    {label:'字符串',value:'nvarchar'},{label:'数值类型',value:'numeric'},
						{label:'日期时间',value:'timestamp'},{label:'大文本',value:'clob'}
					],
					itemLabel: 'label', itemValue: 'value', dataInit: function(element){
						$(element).select2().on("change",function(){
							var csTd = $(this).closest('td').next();
							var csInput = csTd.find('input:eq(0)');
							var val = $(this).val();
							if (val == 'numeric'){
								csInput.addClass('required');
								csInput.attr('type', 'hidden');
								var vals = csInput.val().split(',');
								if (vals[0] == ''){ vals[0] = '10'; }
								if (vals[0] > 30){ vals[0] = '30'; }
								if (vals.length <= 1){ vals[1] = '0'; }
								csInput.val(vals[0] + ',' + vals[1]);
								$('<input name="lenA" type="text" class="form-control input-inline required digits" rowid="'+csInput.attr('rowid')+'" style="width:45%">')
									.val(vals[0]).change(function(){
										csInput.val($(this).val() + ',' + $(this).next().val());
								}).appendTo(csTd);
								csTd.append(' . ');
								$('<input name="lenB" type="text" class="form-control input-inline required digits" rowid="'+csInput.attr('rowid')+'" style="width:45%">')
									.val(vals[1]).change(function(){
										csInput.val($(this).prev().val() + ',' + $(this).val());
								}).appendTo(csTd);
								csTd.find("input").each(function(dt){
									if($(this).attr('type')!='hidden'){
										$(this).bind('blur',function(){
											var rowid = $(this).attr('rowid');
											// 编辑状态，且已同步到库
											if(rowid != '' && rowid.indexOf('jqg')==-1 && '${tableIsExist}'=='true'){
												var oldVals = $(this).parent().attr('title');
												var arrs = oldVals.split(',');
												var inputName = $(this).attr('name');
												var value = $(this).val();
												if(arrs.length==2){
													var arr_2 = arrs[1];
													if(inputName=='lenA'){
														if(parseInt(value) < parseInt(arrs[0])){
															$(this).val(arrs[0]);
															showMessage('表已同步到库，长度只允许增加，不允许减小');
														}
													}else if(inputName=='lenB'){
														if(parseInt(value) < parseInt(arrs[1])){
															$(this).val(arrs[1]);
															showMessage('表已同步到库，长度只允许增加，不允许减小');
														}
													}
												}else{
													if(inputName=='lenA'){
														if(parseInt(value) < parseInt(arrs[0])){
															$(this).val(arrs[0]);
															showMessage('表已同步到库，长度只允许增加，不允许减小');
														}
													}
												}
											}
										});
									}
								});
							}
							else if (val == 'nvarchar'){
								csInput.addClass('required');
								csInput.attr('readonly', false);
								csInput.attr('type', 'text');
								var vals = csInput.val().split(',');
								if (vals[0] == ''){ vals[0] = '50'; }
								csInput.val(vals[0]);
								csTd.html(csInput);
							}
							else{
								csInput.removeClass('required');
								csInput.attr('readonly', true);
								csInput.attr('type', 'text');
								csInput.val('');
								csTd.html(csInput);
							}
							$(this).valid();
							if($(element).attr('rowid').indexOf('jqg')==-1 && '${tableIsExist}'=='true'){
								$(element).attr("readonly",true);
							}
						});
					}
				}
			},
			{header:'长度', name:'columnSize', width:120, editable:true, edittype:'text', editoptions:{'maxlength':'20', 'class':'form-control required',
				dataInit: function(element){
					var ctTd = $(element).closest('td').prev();
					ctTd.find('select:eq(0)').change();
				},dataEvents: [{type: 'blur',fn: changeColumnSizeAfter}]
			}},
			{header:'默认值', name:'defaultValue', width:100, editable:true, edittype:'text', editoptions:{'maxlength':'2000', 'class':'form-control'}},
			{header:'排序', name:'columnSort', width:30, align:'center', editable:true, edittype:'text', editoptions:{'maxlength':'8', 'class':'form-control required digits hide columnSort',
				dataInit: function(element){
					if ($(element).val() == ''){
						$(element).val($(element).closest('table').find('tr').length * 10);
					}
					$(element).parent().append('<i class="fa fa-arrows" style="color:#aaa;cursor:move"></i>');	
				},
				formatter:function (val,obj,row,act){
					$("#formTableColumnDataGrid").tableDnD({
						onDragClass: "dragClass",
						dragHandle: "columnSort",
						onDrop: function(table, row){
							$(table).find('input.columnSort').each(function(i){
								$(this).val((i + 1) * 10);
							});
						}
					});
				}
			}, classes: 'columnSort'}/* ,
			{header:'操作', name:'actions', width:80, sortable:false, fixed:true, formatter: function(val, obj, row, act){
				var actions = [];
				if (val == 'new'){
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除该字段吗？\', function(){$(\'#formTableColumnDataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}else{
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除该字段吗？\', function(){$(\'#formTableColumnDataGrid\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'})});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}, editoptions: {defaultValue: 'new'}} */
		],
		
		// 编辑表格参数
		editGrid: true,				// 是否是编辑表格
		editGridInitRowNum: 1,		// 编辑表格的初始化新增行数
		editGridAddRowBtn: $('#formTableColumnDataGridAddRowBtn'),	// 子表增行按钮
		editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL, isNull: '1',isNewOrDel:'yes'},	// 新增行的时候初始化的数据
		
		// 编辑表格的提交数据参数
		editGridInputFormListName: 'formTableColumnList', // 提交的数据列表名
		editGridInputFormListAttrs: 'id,status,columnName,columnComment,isPk,isNull,_isNull,columnType,columnSize,lenA,lenB,defaultValue,columnSort,isNewOrDel', // 提交数据列表的属性字段
		
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
	
	
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
					});
				}
			}, "json");
	    }
	});
	
	
	setTimeout(function(){
		$('#treeEntity').change();
	}, 1000);
	
	//初始化页面
	$(document).ready(function(){
		var tableName='${formTable.tableName}';
		if(tableName!=''){
			getTableColumnList(tableName,'0');
		}
		
	});
</script>
