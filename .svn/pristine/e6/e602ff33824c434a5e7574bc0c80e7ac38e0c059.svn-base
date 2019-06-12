<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="流水号规则管理" extLibs="${extLibs}" />
<style>
	.tag1{
		border: 1px solid #a5d24a;
		background: #cde69c;
    	color: #638421;
    	padding: 2px;
	}
</style>
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="formSerialNum" action="${ctx}/form/formSerialNum/listData" method="post" class="breadcrumb form-inline"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">生成类型：</label>
				<div class="input-inline">
					<form:select path="genType" class="form-control">
						<form:option value="" label="全部"/>
						<form:options items="${fns:getDictList('form_serial_gen_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">流水号名称：</label>
				<div class="input-inline">
					<form:input path="serialName" htmlEscape="false" maxlength="50" class="form-control input-sm width-120"/>
				</div>
			</div>
			<div class="form-group" style="margin-left:10px;">
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>
			</div>
		</form:form>
		<table id="dataGrid"></table>
		<div id="selectSerialNum" style="height: 30px;margin-top: 6px;"></div>
		<!-- <div id="dataGridPage"></div> -->
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	// 选择之后再次进入回显
	var serialId = '${formSerialNum.id}';
	var dataMap = {};
	if('${formSerialNum.id}' != ''){
		selectSerialNum('${formSerialNum.id}','${formSerialNum.showSerialName}');
		dataMap['serialId'] = '${formSerialNum.id}';
		dataMap['serialName'] = '${formSerialNum.showSerialName}';
		dataMap['serialRule'] = '${formSerialNum.serialRule}';
		dataMap['otherSerialRule'] = '${formSerialNum.otherSerialRule}';
	}
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		// 设置数据表格列
		columnModel: [
			{header:'id', name:'id', index:'a.id', width:200, align:"left", frozen:true, hidden:true},
			{header:'流水号名称', name:'serialName', index:'a.serial_name', width:200, align:"left", frozen:true},
			{header:'流水号标识', name:'serialKey', index:'a.serial_key', width:200, align:"left"},
			{header:'流水号规则', name:'serialRule', index:'a.serial_rule', width:200, align:"left"},
			{header:'生成类型', name:'genType', index:'a.gen_type', width:200, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('form_serial_gen_type')}, val, '未知', true);
			}},
			{header:'流水号长度', name:'serialLength', index:'a.serial_length', width:200, align:"center"},
			{header:'流水号初始值', name:'initNum', index:'a.init_num', width:200, align:"center"},
			{header:'流水号步长', name:'step', index:'a.step', width:200, align:"center"},
			{header:'其它规则', name:'otherSerialRule', hidden:true, width:200, align:"center"}
		],
		onSelectRow: function(id, isSelect, event){
			var rowData = $('#dataGrid').dataGrid('getRowData', id);
			serialId = rowData.id;
			dataMap['serialId'] = rowData.id;
			dataMap['serialName'] = rowData.serialName;
			dataMap['serialRule'] = rowData.serialRule;
			dataMap['otherSerialRule'] = rowData.otherSerialRule;
			selectSerialNum(rowData.id,rowData.serialName);
		},
		ondblClickRow: function(id, rownum, colnum, event){
			var rowData = $('#dataGrid').dataGrid('getRowData', id);
			serialId = rowData.id;
			dataMap['serialId'] = rowData.id;
			dataMap['serialName'] = rowData.serialName;
			dataMap['serialRule'] = rowData.serialRule;
			dataMap['otherSerialRule'] = rowData.otherSerialRule;
			selectSerialNum(rowData.id,rowData.serialName);
			var $jBox = getJBox();
			$jBox.getBox().find("button[value='ok']").trigger("click");
		},
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	// 选择后加入到div中
	function selectSerialNum(key,value){
		var selectHtml = '<span class="tag1" id="'+key+'_tagsinput"><span>'+value+'&nbsp;&nbsp;</span><a href="#" onclick="removingTag(\''+key+'\');" title="Removing tag">x</a>&nbsp;</span>';
		selectHtml = '<span><span style="color:#638421;">当前已选择：</span></span>' + selectHtml + '<div class="tags_clear"></div>';
		
		$('#selectSerialNum').empty().append(selectHtml);
	}
	
	function removingTag(key){
		serialId='';
		dataMap={};
		$('#selectSerialNum').empty();
	}
	// 获取选择的流水号规则id
	function getSerialNumId(){
		if(serialId==''){
			showMessage('请先选择流水号规则');
		}else{
			return dataMap;
		}
	}
</script>