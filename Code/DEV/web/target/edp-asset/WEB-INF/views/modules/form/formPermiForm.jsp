<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="表单权限配置管理 - ${formPermi.isNewRecord ? '新增' : '编辑'}表单权限" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${formPermi.isNewRecord ? '新增' : '编辑'}表单权限</div>
		<%-- <div class="actions">
			<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
			<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formPermi" action="${ctx}/form/formPermi/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<a href="javascript:void(0)" id="unfoldBtn" style="position: absolute;top: 85px;right: 44px;" title="显示或隐藏基础信息"><i class="fa fa-caret-down"></i></a>
				<form:hidden path="permiId"/>
				<form:hidden path="entityId"/>
				<form:hidden path="tableName"/>
				<input type="hidden" id="oldPermiKey" value="${formPermi.permiKey}" />
				<div class="row basicConfig" id="permiKeyDiv">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 权限名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="permiName" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 权限Key：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input id="permiKey" path="permiKey" htmlEscape="false" maxlength="64" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">授权角色</h4>
				<table id="dataGridRole"></table>
				<button id="btnAddRole" type="button" class="btn btn-primary" style="margin-top: 7px;"><i class="fa fa-plus"></i> 新增</button>&nbsp;
				<h4 class="form-section">字段权限配置</h4>
				<table id="dataGridColumn"></table>
			</div>
			 <div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
		<!-- 字段配置-查询字段 -->
		<form:form id="searchForm" modelAttribute="formPermi" action="${ctx}/form/formPermi/fieldListColumnData" method="post" class="breadcrumb form-inline hide">
			<input type="hidden" id="entityId" name="formEntity.entityId" value="${formPermi.entityId}" />
			<input type="hidden" name="permiId" value="${formPermi.permiId}" />
		</form:form>
		<!-- 授权角色-查询角色 -->
		<form:form id="searchFormRole" modelAttribute="formPermi" action="${ctx}/form/formPermi/fieldListRoleData" method="post" class="breadcrumb form-inline hide">
			<input type="hidden" name="permiId" value="${formPermi.permiId}" />
			<input type="hidden" name="permiKey" value="${formPermi.permiKey}" />
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/form/js/form-public.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/form/js/form-permi.js?${_version}" type="text/javascript"></script>
<script type="text/javascript">
	//初始化授权角色配置
	$("#dataGridRole").dataGrid({
		searchForm: $("#searchFormRole"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		autoGridHeight: function(){return 'auto'}, // 设置自动高度
		shrinkToFit: false,
		// 设置数据表格列
		columnModel: [
			{header:'角色名称', name:'roleCode', index:'a.role_name', width:200, 
				editable: true, edittype: "select", editoptions: {'class': 'form-control',
					items: $.merge([{roleName:'&nbsp;',roleCode:''}], ${fns:toJson(roleList)}),
					itemLabel: 'roleName', itemValue: 'roleCode', dataInit: function(element){
						$(element).select2().on("change",function(){});
					}
				},
				formatter: function(val, obj, row, act){
					return row.roleCode;
				}
			},
			{header:'<span title="是否可以保存"><input type="checkbox" id="saveChk" class="chks"/>&nbsp;保存按钮</span>',
				name:"optionMap['isSaveBtn']", align:"center", width:200, editable: true, edittype: "checkbox",
				editoptions: {'class': 'form-control saveChk', 'value': '1', dataInit: function(element){
					$(element).uniform();
				}
			}},
			{header:'操作', name:'actions', width:100,align:'center', sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				/* if (val == 'new'){
				} */
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGridRole\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				return actions.join('');
			}, editoptions: {defaultValue: 'new'}}
			],
		    // 编辑表格参数
		    editGrid: true,                // 是否是编辑表格
		    editGridInitRowNum: 0,     // 编辑表格的初始化新增行数
		    editGridInitAllRowEdit: true,		// 是否初始化就编辑所有行
			editGridAddRowBtn: $('#btnAddRole'),	// 子表增行按钮
			editGridAddRowInitData: function(){return {roleCode: ''}},	// 新增行的时候初始化的数据  
		    // 编辑表格的提交数据参数
		    editGridInputFormListName: 'permiRoleList', // 提交的数据列表名
		    editGridInputFormListAttrs: 'roleCode,optionMap[\'isSaveBtn\']', // 提交数据列表的属性字段
			ajaxSuccess: function(data){ // 加载成功后执行方法
			
			}
	});

	//初始化字段权限配置
	$("#dataGridColumn").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		autoGridHeight: function(){return 'auto'}, // 设置自动高度
		shrinkToFit: false,
		// 设置数据表格列
		columnModel: [
			{header:'物理表名', name:'tableName', index:'ftc.table_name', width:100, align:"center"},
			{header:'字段描述', name:'formTableColumn.columnComment', index:'ftc.column_comment', width:220, align:"center"},
			{header:'表名', name:'formTableColumn.tableName', index:'ftc.table_name',  width:220, align:"center",editable:true, edittype:'text',hidden:true},
			{header:'字段名', name:'formTableColumn.columnName', index:'a.column_name',width:220, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control required','readOnly':'true'}},
			{header:'字段类型', name:'formTableColumn.columnType', hidden:true, index:'a.column_type',width:100, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control','readOnly':'true'}},
			{header:'<span title="是否只读" style="vertical-align:top;"><input type="checkbox" id="readonlyChk" class="chks"/>&nbsp;是否只读</span>',
				name:"optionMap['isReadOnly']", align:"center", width:160, editable: true, edittype: "checkbox",
				editoptions: {'class': 'form-control readonlyChk', 'value': '1', dataInit: function(element){
					$(element).uniform();
				}
			}},
			{header:'<span title="是否隐藏" style="vertical-align:top;"><input type="checkbox" id="hiddenChk" class="chks"/>&nbsp;是否隐藏</span>',
				name:"optionMap['isHidden']", align:"center", width:160, editable: true, edittype: "checkbox",
				editoptions: {'class': 'form-control hiddenChk', 'value': '1', dataInit: function(element){
					$(element).uniform();
				}
			}}
			],
		sortname: 'tableName',
		grouping:true,
	    groupingView : {
	      groupField : ['tableName'],
	      groupColumnShow : [false],// 隐藏分组列
	      //groupOrder : ['asc'], 
	      groupText : ['<b>{0}</b>'],
	      groupDataSorted : true,
	      groupCollapse: false
	    },
	    // 编辑表格参数
	    editGrid: true,                // 是否是编辑表格
	    editGridInitRowNum: 1,     // 编辑表格的初始化新增行数
	    // 编辑表格的提交数据参数
	    editGridInputFormListName: 'entityColumnList', // 提交的数据列表名
	    editGridInputFormListAttrs: 'formTableColumn.tableName,formTableColumn.columnName,formTableColumn.columnType,optionMap[\'isReadOnly\'],optionMap[\'isHidden\']', // 提交数据列表的属性字段
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	$("#inputForm").validate({
		rules: {
			permiKey: {remote: "${ctx}/form/formPermi/checkFormPermiKey?oldPermiKey=${formPermi.permiKey}"}
		},
		messages: {
			permiKey: {remote: "权限key已存在"}
		},
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
	// 鼠标离开权限key时调用
	/* $('#permiKey').blur(function(){
		var permiKey = $(this).val();
		var oldPermiKey = $('#oldPermiKey').val();
		if(permiKey!='' && oldPermiKey!=permiKey){
			$.post('${ctx}/form/formPermi/checkFormPermiKey',{permiKey:permiKey},function(data){
				if(data!=''){
					$('#permiKey').focus();
					showMessage(data);
				}
			},'text');
		}
	}); */
	// 多选
	$(".chks").on("click",function(){
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
	})
</script>
