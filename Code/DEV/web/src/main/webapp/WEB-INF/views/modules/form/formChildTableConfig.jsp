<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="子表配置" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-body form">
		<form id="inputForm" action="${ctx}/form/formEntity/saveChild" method="post" class="form-horizontal">
			<input type="hidden" name="entityId" value="${formDef.entityId}" />
			<input type="hidden" name="optionMap['dataGridId']" value="${formEntity.optionMap['dataGridId']}" readonly="readonly"/>
			<input type="hidden" id="subTableName" name="optionMap['subTableName']" value="${formEntity.optionMap['subTableName']}" readonly="readonly"/>
			<input type="hidden" id="subTableFk" name="optionMap['subTableFk']" value="${formEntity.optionMap['subTableFk']}" readonly="readonly"/>
			
			<div class="form-body" id="form-body-child">
				<h4 class="form-section basicConfig">基础配置</h4> <!-- caret-up -->
				<a href="javascript:void(0)" id="unfoldBtn" style="position: absolute;top: 24px;right: 49px;" title="显示或隐藏子表基础配置"><i class="fa fa-caret-down"></i></a>
				<div class="row basicConfig">
					<div class="col-xs-6 subTableId">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 子表名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<select id="entitySubId" name="optionMap[entitySubId]" class="form-control required" >
									<option value=""></option>
									<c:forEach items="${entitySubList}" var="sub">
										<option value="${sub.entitySubId}"<c:if test="${formEntity.optionMap['entitySubId'] eq sub.entitySubId}"> selected="selected"</c:if> tbname="${sub.subTableName}" >${sub.subTableComment}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 初始化新增行数：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input type="text" id="init_add_row" name="optionMap[initAddRow]" value="${formEntity.optionMap['initAddRow']}" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row basicConfig">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 增行按钮名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input type="text" id="buttonName" name="optionMap[buttonName]" class="form-control required" value="${formEntity.optionMap['buttonName']}"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 自动表格宽度：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<span class="radio-list">
									<c:forEach items="${fns:getDictList('yes_no')}" var="dict" varStatus="idx">
										<input type="radio" id="${dict.value}_${idx.index}" class="required" name="optionMap[autoGridWidth]" value="${dict.value}"<c:if test="${formEntity.optionMap['autoGridWidth'] eq dict.value}"> checked="checked"</c:if> />${dict.label}
									</c:forEach>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row basicConfig">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 初始化编辑所有行：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<span class="radio-list" id="initAllRowEditSpan">
									<c:forEach items="${fns:getDictList('yes_no')}" var="dict" varStatus="idx">
										<input type="radio" id="${dict.value}_${idx.index}" class="required" name="optionMap[initAllRowEdit]" value="${dict.value}"<c:if test="${formEntity.optionMap['initAllRowEdit'] eq dict.value}"> checked="checked"</c:if> />${dict.label}
									</c:forEach>
								</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 自动表格高度：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<span class="radio-list" id="autoGridHeightSpan">
									<c:forEach items="${fns:getDictList('yes_no')}" var="dict" varStatus="idx">
										<input type="radio" id="autoGridHeight" class="required" name="optionMap[autoGridHeight]" value="${dict.value}"<c:if test="${formEntity.optionMap['autoGridHeight'] eq dict.value}"> checked="checked"</c:if> />${dict.label}
									</c:forEach>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row basicConfig">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								是否显示合计：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<span class="radio-list" id="isShowSumRowSpan">
									<c:forEach items="${fns:getDictList('yes_no')}" var="dict" varStatus="idx">
										<input type="radio" id="isShowSumRow" class="required" name="optionMap[isShowSumRow]" value="${dict.value}"<c:if test="${formEntity.optionMap['isShowSumRow'] eq dict.value}"> checked="checked"</c:if> />${dict.label}
									</c:forEach>
								</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 合计行标题：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input type="text" id="sumRowTitle" name="optionMap[sumRowTitle]" class="form-control required" value="${formEntity.optionMap['sumRowTitle']}"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row" id="tableHeightDiv" style="display: none;">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								固定表格高度：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input type="text" id="table_height" name="optionMap[tableHeight]" class="form-control " value="${formEntity.optionMap['tableHeight']}"/>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">子表配置</h4>
				<table id="dataGrid"></table>
				
			<div class="form-actions fluid hide">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="form:formDef:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</div>
		</form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/layoutit/js/childTableConfig.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/jqGrid/4.7/plugins/jquery.tablednd.js?${_version}"></script>
<script type="text/javascript">
	if($("#entitySubId").val() != ''){
		init();
	}
	if("${formEntity.optionMap['autoGridHeight']}"!='1'){
		$('#tableHeightDiv').show();
	}
	$("#dataGrid").dataGrid({
		data: ${fns:toJson(formEntity.childConfigList)},
		datatype: "local", // 设置本地数据
		autoGridHeight: function(){return 'auto'}, // 设置自动高度
		shrinkToFit: true,
		// 设置数据表格列
		columnModel: [
			{header:'validType', name:"validType", width:50,editable:true, edittype:'text',hidden:true},
			/* {header:'表名', name:'tableName', width:170,hidden:true, formatter: function(val, obj, row, act){
				return row.formTableColumn.tableName;
			}}, */
			{header:'实体id', name:'entityId', width:170,hidden:true, formatter: function(val, obj, row, act){
				return row.formEntity.entityId;
			}},
			{header:'字段名', name:'columnName', width:170,hidden:true, formatter: function(val, obj, row, act){
				return row.formTableColumn.columnName;
			}},
			{header:'entity_id', name:'formEntity.entityId', index:'ftc.column_comment', width:170, editable:true, edittype:'text',hidden:true},
			{header:'entity_sub_id', name:'formSubEntity.entityId', index:'ftc.column_comment', width:170, editable:true, edittype:'text',hidden:true},
			{header:'字段名', name:'formTableColumn.columnName', index:'a.column_name',width:130, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'required','readOnly':'true','style':'background-color: #eee'}},
			{header:'字段描述', name:'formTableColumn.columnComment', index:'ftc.column_comment', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'required'}},
			/* {header:'是否必填', name:"optionMap['isRequired']", width:50, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'text-center','readOnly':'true','style':'background-color: #eee'}}, */
			/* {header:'<span title="字段为必填的不能隐藏、不能只读!">是否必填</span>', name:"optionMap['isRequired']", width:70,align:'center'}, */
			{header:'<span title="字段为必填的不能隐藏、不能只读!">是否必填</span>', name:'isRequired',align:"center", width:80, formatter: function(val, obj, row, act){
				return row.optionMap.isRequired;
			}},
			{header:'<span title="打勾则生成表单之后显示，否则隐藏" style="vertical-align:top;"><input type="checkbox" id="isCellShow" class="chks"/>&nbsp;是否列表显示</span>',
				name:"optionMap['isCellShow']", align:"center", width:160, editable: true, edittype: "checkbox",
				editoptions: {'class': 'form-control isCellShow', 'value': '1', dataInit: function(element){
					$(element).uniform();
				},
				dataEvents: [{type: 'change',fn: function(e,row) {
					var rowId = $(this).parent().parent().parent().parent().attr("id");
					var data = $('#dataGrid').dataGrid('getRowData', rowId);
					//var isReq = $(this).parent().parent().parent().prev().text();
					var isReq = data.isRequired;
					if(isReq=="是"){
						if(!$(this).is(":checked")){
							$(this).parent().addClass("checked");
							$(this).attr("checked","true");
							showMessage("该字段为必填项，不能隐藏!");
						}
					}
				   }}
				]
			}},
			{header:'<span title="打勾则生成表单之后可编辑，否则只读" style="vertical-align:top;"><input type="checkbox" id="isEdit" class="chks"/>&nbsp;是否可编辑</span>',
				name:"optionMap['isEdit']", align:"center", width:160, editable: true, edittype: "checkbox",
				editoptions: {'class': 'form-control isEdit', 'value': '1', dataInit: function(element){
					$(element).uniform();
				},
				dataEvents: [{type: 'change',fn: function(e,row) {
					var rowId = $(this).parent().parent().parent().parent().attr("id");	
					var data = $('#dataGrid').dataGrid('getRowData', rowId);
					//var isReq = $(this).parent().parent().parent().prev().text();
					var isReq = data.isRequired;
					if(isReq=="是"){
						if(!$(this).is(":checked")){
							$(this).parent().addClass("checked");
							$(this).attr("checked","true");
							showMessage("该字段为必填项，不能为只读!");
						}
					}
				   }}
				]
			}},
			{header:'<span title="打勾后该字段显示合计行" style="vertical-align:top;"><input type="checkbox" id="isSumRow" class="chks"/>&nbsp;是否合计行</span>',
				name:"optionMap['isSumRow']", align:"center", width:160, editable: true, edittype: "checkbox",
				editoptions: {'class': 'form-control isSumRow', 'value': '1', dataInit: function(element){
					$(element).uniform();
				},
				dataEvents: [{type: 'change',fn: function(e,row) {
					var rowId = $(this).parent().parent().parent().parent().attr("id");
					var data = $('#dataGrid').dataGrid('getRowData', rowId);
					// 检查该字段是否为数值列
					var res = checkTableColumnType($("#subTableName").val(),data.columnName);
					if(!res){
						if($(this).is(":checked")){
							$(this).parent().removeClass("checked");
							$(this).removeAttr("checked");
							showMessage("该字段不是数值类型，不能为合计行!");
						}
					}
				   }}
				]
			}},
			{header:'<span title="选择对齐方式">对齐方式</span>', name:"optionMap['textAlign']", width:120, 
				editable: true, edittype: "select", editoptions: {'class': 'form-control required',
					items: $.merge([{label:'&nbsp;',value:''}], ${fns:getDictListJson('form_design_child_text_align')}),
					itemLabel: 'label', itemValue: 'value', dataInit: function(element){
						$(element).select2().on("change",function(){});
					}
				},
				formatter: function(val, obj, row, act){
					return row.optionMap.textAlign;
				}
			},
			{header:'宽度', name:"optionMap['cellWidth']",width:120, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control'}},
			{header:'排序', name:'columnSort', width:50, align:'center', editable:true, edittype:'text', editoptions:{'maxlength':'8', 'class':'form-control required digits hide columnSort',
				dataInit: function(element){
					if ($(element).val() == ''){
						$(element).val($(element).closest('table').find('tr').length * 10);
					}
					$(element).parent().append('<i class="fa fa-arrows" style="color:#aaa;cursor:move"></i>');	
				},
				formatter:function (val,obj,row,act){
					$("#dataGrid").tableDnD({
						onDragClass: "dragClass",
						dragHandle: "columnSort",
						onDrop: function(table, row){
							$(table).find('input.columnSort').each(function(i){
								$(this).val((i + 1) * 10);
							});
						}
					});
				}
			}, classes: 'columnSort'}
			,
			{header:'操作', name:'actions', width:60,align:'center', sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				actions.push('<a href="#" title="删除之后不参与生成子表" onclick="confirmx(\'删除之后不参与生成子表，确认要删除吗？\', function(){$(\'#dataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				return actions.join('');
			}, editoptions: {defaultValue: 'new'}}
			],
		    // 编辑表格参数
		    editGrid: true,                // 是否是编辑表格
		    editGridInitRowNum: 0,     // 编辑表格的初始化新增行数
		    editGridInitAllRowEdit: true,		// 是否初始化就编辑所有行
			editGridAddRowInitData: function(){},	// 新增行的时候初始化的数据  
		    // 编辑表格的提交数据参数
		    editGridInputFormListName: 'childConfigList', // 提交的数据列表名
		    editGridInputFormListAttrs: 'validType,columnSort,formEntity.entityId,formSubEntity.entityId,formTableColumn.columnComment,formTableColumn.columnName,optionMap[\'isCellShow\'],optionMap[\'isEdit\'],optionMap[\'isEdit\'],optionMap[\'textAlign\'],optionMap[\'cellWidth\'],optionMap[\'isSumRow\']', // 提交数据列表的属性字段
			ajaxSuccess: function(data){ // 加载成功后执行方法
			
			}
	});
	//多选
	$(".chks").on("click",function(){
		var reqNum = 0;		// 必填项个数
		var notReqNum = 0;	// 非必填项个数
		var numericNum = 0;	// 数值类型个数
		var notNumericNum = 0;  // 非数值类型个数
		var span = $(this).parent();
		var id = $(this).attr("id");
		if(span.hasClass('checked')){
			$.uniform.update($(this).removeAttr("checked"));
		}
		if(this.checked){
			$("."+id).each(function(){
				if("isSumRow"==id){
					var rowId = $(this).parent().parent().parent().parent().attr("id");
					var data = $('#dataGrid').dataGrid('getRowData', rowId);
					// 检查该字段是否为数值列
					var res = checkTableColumnType($("#subTableName").val(),data.columnName);
					if(!res){
						notNumericNum++;
						if($(this).is(":checked")){
							$(this).parent().removeClass("checked");
							$(this).removeAttr("checked");
						}
					}else{
						numericNum++;
						$.uniform.update($(this).attr("checked",true));
					}
				}else{
					$.uniform.update($(this).attr("checked",true));
				}
			});
			if("isSumRow"==id){
				if(numericNum > 0 && notNumericNum > 0){
					showMessage("已选择，非数值类型，不能为合计行!");
				}else if(numericNum > 0 && notNumericNum == 0){
					showMessage("已选择!");
				}else if(numericNum == 0 && notNumericNum > 0){
					showMessage("非数值类型，不能为合计行!");
				}
			}
		}else{
			$("."+id).each(function(){
				var rowId = $(this).parent().parent().parent().parent().attr("id");
				var data = $('#dataGrid').dataGrid('getRowData', rowId);
				/* if("isEdit" == id){
					isReq = $(this).parent().parent().parent().prev().prev().text();
				}else if("isCellShow" == id){
					isReq = $(this).parent().parent().parent().prev().text();
				} */
				var isReq = '';
				if("isSumRow"!=id){
					isReq = data.isRequired;
					if(isReq != "是"){
						notReqNum++;
						$.uniform.update($(this).removeAttr("checked"));
					}else{
						reqNum++;
					}
				}
			
			});
			if("isSumRow"!=id){
				if(notReqNum==0 && reqNum > 0){
					showMessage("必填项无法取消选择!");
				}else if(notReqNum > 0 && reqNum > 0){
					showMessage("已取消非必填项的选择!");
				}
			}
		}
	});
	var result = '';
	function saveChild(){
		$("#btnSubmit").click();
		return result;
	}
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				result = data;
			}, "json", false);
	    }
	});
</script>
