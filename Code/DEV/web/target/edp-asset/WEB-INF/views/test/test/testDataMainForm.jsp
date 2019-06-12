<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="主表管理 - ${testDataMain.isNewRecord ? '新增' : '编辑'}主表" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${testDataMain.isNewRecord ? '新增' : '编辑'}主表</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="test:testDataMain:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="testDataMain" action="${ctx}/test/testDataMain/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								归属用户：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<sys:treeselect id="user" name="user.userCode" value="${testDataMain.user.userCode}" labelName="user.userName" labelValue="${testDataMain.user.userName}"
									title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								归属部门：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<sys:treeselect id="office" name="office.officeCode" value="${testDataMain.office.officeCode}" labelName="office.officeName" labelValue="${testDataMain.office.officeName}"
									title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								归属区域：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<sys:treeselect id="area" name="area.areaCode" value="${testDataMain.area.areaCode}" labelName="area.areaName" labelValue="${testDataMain.area.areaName}"
									title="区域" url="/sys/area/treeData" cssClass="" allowClear="true" notAllowSelectParent="true"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="name" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								性别：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control"/>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								加入日期：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input name="inDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate "
									value="<fmt:formatDate value="${testDataMain.inDate}" pattern="yyyy-MM-dd HH:mm"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/>
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
				<h4 class="form-section">业务数据子表</h4>
				<div class="ml10 mr10">
					<table id="testDataChildDataGrid"></table>
					<shiro:hasPermission name="test:testDataMain:edit">
						<a href="#" id="testDataChildDataGridAddRowBtn" class="btn btn-primary mt10 mb10"><i class="fa fa-plus"></i> 增行</a>
					</shiro:hasPermission>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="test:testDataMain:edit">
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
<script type="text/javascript">
	//初始化业务数据子表DataGrid对象
	$("#testDataChildDataGrid").dataGrid({
	
		data: ${fns:toJson(testDataMain.testDataChildList)},
		datatype: "local", // 设置本地数据
		autoGridHeight: function(){return 'auto'}, // 设置自动高度
		
		// 设置数据表格列
		columnModel: [
			{header:'编号', name:'id', hidden:true, formatter: function(val, obj, row, act){
				var html = [];
				html.push('<input id="'+obj.rowId+'_id" name="id" type="hidden" value="'+val+'"/>');
				html.push('<input id="'+obj.rowId+'_status" name="status" type="hidden" value="'+row.status+'"/>');
				return html.join('');
			}},
			{header:'名称', name:'name', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control required'}},
			{header:'备注信息', name:'remarks', width:150, editable:true, edittype:'textarea', editoptions:{'maxlength':'255', 'class':'form-control', 'rows':'1'}},
			{header:'操作', name:'actions', width:80, sortable:false, fixed:true, formatter: function(val, obj, row, act){
				var actions = [];
				if (val == 'new'){
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#testDataChildDataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}else{
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#testDataChildDataGrid\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}, editoptions: {defaultValue: 'new'}}
		],
		
		// 编辑表格参数
		editGrid: true,				// 是否是编辑表格
		editGridInitRowNum: 1,		// 编辑表格的初始化新增行数
		editGridAddRowBtn: $('#testDataChildDataGridAddRowBtn'),	// 子表增行按钮
		editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL},	// 新增行的时候初始化的数据
		
		// 编辑表格的提交数据参数
		editGridInputFormListName: 'testDataChildList', // 提交的数据列表名
		editGridInputFormListAttrs: 'id,status,name,remarks', // 提交数据列表的属性字段
		
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
</script>
