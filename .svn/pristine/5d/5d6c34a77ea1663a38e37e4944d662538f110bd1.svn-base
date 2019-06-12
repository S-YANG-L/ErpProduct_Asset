<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产归还管理 - ${assetBorrowReturn.isNewRecord ? '新增' : '编辑'}资产归还" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${assetBorrowReturn.isNewRecord ? '新增' : '编辑'}资产归还</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="return:assetBorrowReturn:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="assetBorrowReturn" action="${ctx}/return/assetBorrowReturn/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								借用编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="borrowCode" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								借用人编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="borrowerCode" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 借用人：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="borrowerName" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 借用日期：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input name="borrowDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate required"
									value="<fmt:formatDate value="${assetBorrowReturn.borrowDate}" pattern="yyyy-MM-dd HH:mm"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								预计归还日期：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input name="expectedReturnDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate "
									value="<fmt:formatDate value="${assetBorrowReturn.expectedReturnDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								实际归还日期：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input name="factReturnDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate "
									value="<fmt:formatDate value="${assetBorrowReturn.factReturnDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								归还人编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="restituerCode" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								归还人：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="restituerName" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								审核状态：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="approvalStatus" htmlEscape="false" maxlength="1" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								说明：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="notes" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								扩展1：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="extendS1" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								扩展2：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="extendS2" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								扩展3：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="extendS3" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								备注信息：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1000" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								资产类别：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="assetClass" htmlEscape="false" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								资产类别编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="assetClassCode" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								借用数量：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="numberRecipients" htmlEscape="false" class="form-control number"/>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">资产借用（归还）子表</h4>
				<div class="ml10 mr10">
					<table id="assetBorrowReturnDtlDataGrid"></table>
					<shiro:hasPermission name="return:assetBorrowReturn:edit">
						<a href="#" id="assetBorrowReturnDtlDataGridAddRowBtn" class="btn btn-primary mt10 mb10"><i class="fa fa-plus"></i> 增行</a>
					</shiro:hasPermission>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="return:assetBorrowReturn:edit">
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
	//初始化资产借用（归还）子表DataGrid对象
	$("#assetBorrowReturnDtlDataGrid").dataGrid({

		data: ${fns:toJson(assetBorrowReturn.assetBorrowReturnDtlList)},
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
			{header:'借用编码', name:'borrowCode', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'64', 'class':'form-control'}},
			{header:'资产编码', name:'assetCode', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'64', 'class':'form-control required'}},
			{header:'资产名称', name:'assetName', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control required'}},
			{header:'资产分类编码', name:'sortCode', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'64', 'class':'form-control required'}},
			{header:'资产分类名称', name:'sortName', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control required'}},
			{header:'品牌', name:'brand', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control'}},
			{header:'型号', name:'version', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control'}},
			{header:'存放地点', name:'storagePlace', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control'}},
			{header:'公司编码', name:'companyCode', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'64', 'class':'form-control'}},
			{header:'公司名称', name:'companyName', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control'}},
			{header:'责任部门编码', name:'office', width:150, formatter: function(val, obj, row, act){
					return getVal(row, 'office.officeCode')+'|'+getVal(row, 'office.officeName');
				}, editable: true, edittype: "custom", editoptions: {
					custom_element: function(val, editOptions) {
						return template('treeselectTpl', {
							id: 'office_'+editOptions.id, title: '部门',
							name: 'office.officeCode', value: val.split('|')[0],
							labelName: 'office.officeName', labelValue: val.split('|')[1],
							url: '/sys/office/treeData?type=2', cssClass: ''
						});
					}
				}
			},
			{header:'责任部门', name:'officeName', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control'}},
			{header:'使用人编码', name:'user', width:150, formatter: function(val, obj, row, act){
					return getVal(row, 'user.userCode')+'|'+getVal(row, 'user.userName');
				}, editable: true, edittype: "custom", editoptions: {
					custom_element: function(val, editOptions) {
						return template('treeselectTpl', {
							id: 'user_'+editOptions.id, title: '用户',
							name: 'user.userCode', value: val.split('|')[0],
							labelName: 'user.userName', labelValue: val.split('|')[1],
							url: '/sys/office/treeData?type=3', cssClass: ''
						});
					}
				}
			},
			{header:'使用人名称', name:'userName', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control'}},
			{header:'扩展1', name:'extendS1', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control'}},
			{header:'扩展2', name:'extendS2', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control'}},
			{header:'扩展3', name:'extendS3', width:150, editable:true, edittype:'text', editoptions:{'maxlength':'100', 'class':'form-control'}},
			{header:'备注信息', name:'remarks', width:150, editable:true, edittype:'textarea', editoptions:{'maxlength':'1000', 'class':'form-control', 'rows':'1'}},
			{header:'操作', name:'actions', width:80, sortable:false, fixed:true, formatter: function(val, obj, row, act){
				var actions = [];
				if (val == 'new'){
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#assetBorrowReturnDtlDataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}else{
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#assetBorrowReturnDtlDataGrid\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}, editoptions: {defaultValue: 'new'}}
		],

		// 编辑表格参数
		editGrid: true,				// 是否是编辑表格
		editGridInitRowNum: 1,		// 编辑表格的初始化新增行数
		editGridAddRowBtn: $('#assetBorrowReturnDtlDataGridAddRowBtn'),	// 子表增行按钮
		editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL},	// 新增行的时候初始化的数据

		// 编辑表格的提交数据参数
		editGridInputFormListName: 'assetBorrowReturnDtlList', // 提交的数据列表名
		editGridInputFormListAttrs: 'id,status,borrowCode,assetCode,assetName,sortCode,sortName,brand,version,storagePlace,companyCode,companyName,office.officeCode,officeName,user.userCode,userName,extendS1,extendS2,extendS3,remarks', // 提交数据列表的属性字段

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
<script id="treeselectTpl" type="text/template">//<!--<div>
	<sys:treeselect id="{{id}}" name="{{name}}" value="{{value}}" labelName="{{labelName}}" labelValue="{{labelValue}}"
		title="{{title}}" url="{{url}}" cssClass="{{cssClass}}" allowClear="true" notAllowSelectParent="true"/>
</div>//--></script>
