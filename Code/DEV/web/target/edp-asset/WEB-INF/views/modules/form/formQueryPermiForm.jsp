<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="列表权限管理 - ${formQueryPermi.isNewRecord ? '新增' : '编辑'}列表权限" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${formQueryPermi.isNewRecord ? '新增' : '编辑'}列表权限</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formQueryPermi" action="${ctx}/form/formQueryPermi/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="permiId"/>
				<form:hidden path="queryId" />
				<form:hidden path="queryKey" />
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								权限名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="permiName" htmlEscape="false" maxlength="100" class="form-control" onblur="setPermiKey();"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								权限key：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<c:choose>
								   <c:when test="${formQueryPermi.isNewRecord}">
								   		<form:input path="permiKey" htmlEscape="false" maxlength="64" class="form-control required abcd"
										remote="${ctx}/form/formQueryPermi/checkPermiKeyIsExist" data-msg-remote="权限Key已存在，请重新填写"/>
								   </c:when>
								   <c:otherwise>
								   		<form:input path="permiKey" htmlEscape="false" maxlength="64" class="form-control required abcd" readonly="true"/>
								   </c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">授权角色</h4>
				<table id="dataGridRole"></table>
				<a href="#" id="btnAddRole" class="btn btn-primary mt10 mb10"><i class="fa fa-plus"></i> 增行</a>
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
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/form/js/form-public.js?${_version}" type="text/javascript"></script>

<script type="text/javascript">
	var queryId = $("#queryId").val();
//初始化授权角色配置
$("#dataGridRole").dataGrid({
	data: ${fns:toJson(permiRoleList)}||[],
	datatype: "local", // 设置本地数据
	autoGridHeight: function(){return 'auto'}, // 设置自动高度
	// 设置数据表格列
	columnModel: [
		{header:'编号', name:'id', hidden:true, formatter: function(val, obj, row, act){
			var html = [];
			html.push('<input id="'+obj.rowId+'_status" name="status" type="hidden" value="0"/>');
			return html.join('');
		}},
		{header:'角色名称', name:'roleCode', width:160, 
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
		<c:forEach items="${btnList}" var="btn">
		{header:'${btn.btnName}', width:80, 
			name:"btnOptionsMap['${btn.btnId}']", align:"center", editable: true, edittype: "checkbox",
			editoptions: {'class': 'form-control', 'value': '1', dataInit: function(element){
				$(element).uniform();
			}
		}},
		</c:forEach>
		{header:'不可见列', name:'columnConfig', width:200,
			editable: true, edittype: "custom", editoptions: {
				custom_element: function(val, editOptions) {
					return template('treeselectTpl', {
						id: 'columnConfig_'+editOptions.id, 
						name: 'columnConfig', value: val, 
						labelName: 'columnConfig_', labelValue: val,
						title: '表字段', url: '/form/formQueryColumn/treeData?queryId='+queryId,
						cssClass: '', allowClear: 'true',checked: 'true'
					});
				}
			}	
		},
		{header:'操作', name:'actions', width:80,align:'center', sortable:false, formatter: function(val, obj, row, act){
			var actions = [];
			if (val == 'new'){
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGridRole\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}else{
				actions.push('<a href="#" onclick="confirmx(\'你确认要删除该字段吗？\', function(){$(\'#dataGridRole\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'})});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}
			return actions.join('');
		}, editoptions: {defaultValue: 'new'}}
		],
	    // 编辑表格参数
	    editGrid: true,                // 是否是编辑表格
	    editGridInitRowNum: 0,     // 编辑表格的初始化新增行数
	    editGridInitAllRowEdit: true,		// 是否初始化就编辑所有行
		editGridAddRowBtn: $('#btnAddRole'),	// 子表增行按钮
		//editGridAddRowInitData: function(){return {roleCode: ''}},	// 新增行的时候初始化的数据  
		editGridAddRowInitData: { roleCode:'',status: Global.STATUS_NORMAL},	// 新增行的时候初始化的数据
	    // 编辑表格的提交数据参数
	    editGridInputFormListName: 'fqproleList', // 提交的数据列表名
	    editGridInputFormListAttrs: '<c:forEach items="${btnList}" var="btn">btnOptionsMap[\'${btn.btnId}\'],</c:forEach>roleCode,columnConfig,status', // 提交数据列表的属性字段
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
	
	function setPermiKey(){
		var permiName = $("#permiName").val();
		var queryKey=$('#queryKey').val();
		var lastVal=permiName;
		if(queryKey!=''&&typeof(queryKey)!="undefined"){
			lastVal=queryKey+"_"+permiName;
		}
		genPinyin("permiKey",lastVal);
	}
</script>
<script id="treeselectTpl" type="text/template">//<!--<div>
<sys:treeselect id="{{id}}" name="{{name}}" value="{{value}}" labelName="{{labelName}}" labelValue="{{labelValue}}" 
		title="{{title}}" url="{{url}}" cssClass="{{cssClass}}" checked="{{checked}}" allowClear="{{allowClear}}"/>
</div>
//--></script>