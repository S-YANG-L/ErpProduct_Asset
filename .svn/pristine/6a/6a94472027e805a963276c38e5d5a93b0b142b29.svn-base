<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,fileupload,grid"/>
<sys:header title="单表管理 - ${testData.isNewRecord ? '新增' : '编辑'}单表" extLibs="${extLibs}" htmlClass="scroll"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="testData" action="${ctx}/test/testData/save" method="post" class="form-horizontal">
			<div class="table-fdiv width-960">
<!-- 				<h3>平台信息情况</h3> -->&nbsp;
				<table class="table-form">
					<tr class="table-caption"><td colspan="6">基本信息</td></tr>
					<tr>
						<td class="lbl" width="30%"><span class="red">*</span> 平台名称</td>
						<td>
							<form:input path="user" htmlEscape="false" maxlength="255" class="form-control required"/>
						</td>
						<td class="lbl" width="20%"><span class="red">*</span> 申请单位</td>
						<td>
							<form:input path="office" htmlEscape="false" maxlength="255" class="form-control required"/>
						</td>
						<td rowspan="4" style="width:110px;height:120px;">
							<div style="width:110px;height:120px;">
								<sys:fileupload id="image" bizCategory="image" bizKey="${testData.remarks}" 
									returnPath="true" uploadType="image" maxUploadNum="1" isMini="true"
									imageStyle="width:100px;height:110px;"/>
							</div>
						</td>
					</tr>
					<tr>
						<td class="lbl">地址</td>
						<td>
							<form:input path="area" htmlEscape="false" maxlength="255" class="form-control required"/>
						</td>
						<td class="lbl">邮编</td>
						<td>
							<form:input path="name" htmlEscape="false" maxlength="255" class="form-control required"/>
						</td>
					</tr>
					<tr>
						<td class="lbl">组建时间</td>
						<td>
							<input name="inDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate "
									value="<fmt:formatDate value="${testData.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
						</td>
						<td class="lbl">网址</td>
						<td>
							<form:input path="name" htmlEscape="false" maxlength="255" class="form-control required"/>
						</td>
					</tr>
					<tr>
						<td class="lbl">申报计划类别</td>
						<td>
							<form:select path="createBy" class="form-control required">
							    <form:option value="">&nbsp;</form:option>
								<form:options items="${fns:getDictList('color')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</td>
						<td class="lbl">依托单位性质</td>
						<td>
							<form:input path="name" htmlEscape="false" maxlength="255" class="form-control required"/>
						</td>
					</tr>
					<tr>
						<td rowspan="2" class="lbl">平台负责人</td>
						<td class="lbl">姓名</td>
						<td>
							<form:input path="name" htmlEscape="false" maxlength="255" class="form-control required"/>
						</td>
						<td class="lbl">性别</td>
						<td>
							<div class="radio-list">
								<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control"/>
							</div>
						</td>
					</tr>
					<tr>
						<td class="lbl">出生年月</td>
						<td>
							<input name="inDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate "
									value="<fmt:formatDate value="${testData.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
						</td>
						<td class="lbl">学历</td>
						<td>
							<div class="checkbox-list">
								<form:checkboxes path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control"/>
							</div>
						</td>
					</tr>
					<tr>
						<td class="lbl">平台人数</td>
						<td colspan="4">共 <input id="sumPer" class="text-center width-60"/> 人。其中专职服务团队人数
							 <input id="sumPer2" class="text-center width-60 digits"/> 人。
						</td>
					</tr>
					<tr>
						<td class="lbl">负责部门</td>
						<td width="200">
							<sys:treeselect id="office" name="office.officeCode" value="${testData.office.officeCode}" labelName="office.officeName" labelValue="${testData.office.officeName}"
								title="机构" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
						</td>
						<td class="lbl">平台所在地</td>
						<td colspan="2">
							<form:input path="name" htmlEscape="false" maxlength="255" class="form-control required"/>
						</td>
					</tr>
					<tr>
						<td class="lbl">服务场所面积</td>
						<td><input class="width-60 number"/> M²</td>
						<td class="lbl">年服务用户数</td>
						<td colspan="2"><input class="width-60 digits"/> 家</td>
					</tr>
					<tr>
						<td class="lbl">仪器设备</td>
						<td><input class="width-60"/> 台/套</td>
						<td class="lbl">仪器设备原值</td>
						<td colspan="2"><input class="width-60 number"/> 万元</td>
					</tr>
					<tr>
						<td class="lbl">科技资源量</td>
						<td>
							<form:input path="name" htmlEscape="false" maxlength="255" class="form-control required"/>
						</td>
						<td class="lbl">上年服务收入</td>
						<td colspan="2"><input class="width-60 number"/> 万元</td>
					</tr>
					<tr>
						<td class="lbl">申请补助资金</td>
						<td><input class="width-60"/> 万元</td>
						<td class="lbl">自筹经费</td>
						<td colspan="2"><input class="width-60 number"/> 万元</td>
					</tr>
					<tr class="table-caption"><td colspan="6">详细信息</td></tr>
					<tr>
						<td colspan="6">
							<table class="table-form">
								<tr>
									<td class="lbl">项目编号</td>
									<td><form:input path="name" htmlEscape="false" maxlength="255" class="form-control required"/></td>
									<td class="lbl">项目名称</td>
									<td><form:input path="name" htmlEscape="false" maxlength="255" class="form-control required"/></td>
									<td class="lbl">完成时间</td>
									<td><form:input path="name" htmlEscape="false" maxlength="255" class="form-control required"/></td>
								</tr>
								<tr>
									<td colspan="6">中试及产业化阶段项目目前规模</td>
								</tr>
								<tr>
									<td class="lbl">产品年新增产值</td>
									<td><input class="width-60"/> 万元</td>
									<td class="lbl">年新增销售额</td>
									<td><input class="width-60"/> 万元</td>
									<td class="lbl">年新增交税总额</td>
									<td><input class="width-60"/> 万元</td>
								</tr>
								<tr>
									<td class="lbl">年新增利润</td>
									<td colspan="2"><input class="width-60"/> 万元</td>
									<td class="lbl">年新增创汇</td>
									<td colspan="2"><input class="width-60"/> 万美元</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="lbl">平台建设内容简介</td>
						<td colspan="4">
							<form:textarea path="remarks" htmlEscape="false" rows="4" class="form-control required"/>
						</td>
					</tr>
					<tr class="tr-last">
						<td class="lbl">预期成果及考核指标</td>
						<td colspan="4">
							<textarea name="remarks" rows="4" class="form-control">自动高度1
自动高度2
自动高度3
自动高度4
自动高度5
自动高度6
自动高度7</textarea>
						</td>
					</tr>
					<tr>
						<td class="lbl" nowrap="nowrap">平台建设大纲概要</td>
						<td colspan="4">
							<table id="dataGrid"></table>
							<a href="#" id="dataGridAddRowBtn" class="btn btn-primary mt10 mb10"><i class="fa fa-plus"></i> 增行</a>
						</td>
					</tr>
				</table>
				<table class="table-form mt10">
					<tr class="table-caption"><td colspan="4">附件</td></tr>
					<tr>
						<td colspan="4" class="row-lbl">
							1、可行性研究报告
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<sys:fileupload id="fileupload1" bizCategory="testData1" bizKey="${testData.id}" readonly="false"/>
							
						</td>
					</tr>
					<tr>
						<td colspan="4" class="row-lbl">
							2、工商注册证明及组织机构代码证
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<sys:fileupload id="fileupload2" bizCategory="testData2" bizKey="${testData.id}" uploadType="image" readonly="false" maxUploadNum="5"/>
						</td>
					</tr>
				</table>
				<div class="form-actions">
<%-- 					<shiro:hasPermission name="test:testData:edit"> --%>
<%-- 					<flow:commandList /> --%>
						<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
<%-- 					</shiro:hasPermission> --%>
					<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		data: [],
		datatype: "local",
		autoGridHeight: function(){return 'auto'},	// 设置自动高度
		autoGridWidth: function(){return 780}, 		// 设置自动宽度
		
		columnModel: [
  			{header:'编号', name:'id', hidden:true, formatter: function(val, obj, row, act){
				var html = [];
				html.push('<input id="'+obj.rowId+'_id" name="id" type="hidden" value="'+val+'"/>');
				html.push('<input id="'+obj.rowId+'_status" name="status" type="hidden" value="'+row.status+'"/>');
				return html.join('');
			}},
			{header:'备注', name:'remarks', index:'a.remarks', width:150, 
				editable: true, edittype:'text', editoptions: { 'class' : 'form-control required'}
			},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:150,
				editable: true, edittype:"text", editoptions: { 'class' : 'form-control Wdate',
					dataInit: function (element) {
						$(element).attr('readonly', true).click(function(){
							WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});
						});
					}
			}},
			{header:'操作', name:'actions', width:20, align:'center', sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (val == 'new'){
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}else{
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'setRowData\',\''+obj.rowId+'\',null,{display:\'none\'})});$(\'#'+obj.rowId+'_status\').val(\''+Global.STATUS_DELETE+'\');return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}}
		],
		
		// 编辑表格参数
		editGrid: true,				// 是否是编辑表格
		editGridInitRowNum: 4,		// 编辑表格的初始化新增行数
		editGridAddRowBtn: $('#dataGridAddRowBtn'),	// 子表增行按钮
		editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL},	// 新增行的时候初始化的数据
		
		// 编辑表格的提交数据参数
		editGridInputFormListName: 'childList', // 提交的数据列表名
		editGridInputFormListAttrs: 'id,status,remarks,updateDate', // 提交数据列表的属性字段
		
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