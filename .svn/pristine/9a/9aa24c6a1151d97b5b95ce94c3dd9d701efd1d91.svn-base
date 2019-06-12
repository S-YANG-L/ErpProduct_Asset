<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="数据字典管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 数据查询</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnDelete" title="批量删除"><i class="glyphicon glyphicon-remove"></i> 批量删除</a>
			<a href="#" class="btn btn-default btn-sm" id="btnTemplate" title="下载模板"><i class="glyphicon glyphicon-download-alt"></i> 下载模板</a>
			<a href="#" class="btn btn-default btn-sm" id="btnImport" title="导入数据"><i class="glyphicon glyphicon-import"></i> 导入数据</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="formTable" action="${ctx}/form/formTableData/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<input name="tableName" type="hidden" value="${param.tableName}"/>
			<div class="form-group">
				<label class="control-label">主键：</label>
				<div class="input-inline">
					<input name="id" maxlength="200" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">状态：</label>
				<div class="input-inline">
					<input name="status" maxlength="200" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>
		</form:form>
		<table id="dataGrid"></table>
		<div id="dataGridPage"></div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
// 初始化DataGrid对象
$("#dataGrid").dataGrid({
	
	searchForm: $("#searchForm"), // 数据来源表单
	tabPageId: '${param.tabPageId}',// 当前页签编号
	
	// 设置数据表格列
	columnModel: [
	    {header:'主键', name:'id', width:200, align:"center"},
	    //<c:forEach items="${formTable.formTableColumnList}" var="column"><c:if test="${column.optionMap.isNotShowQueryList ne '1'}">
	    {header:'${column.columnComment}', name:'${fn:toLowerCase(column.columnName)}', width:200, align:"left", formatter: function(val, obj, row, act){
			return <c:choose><c:when test="${column.columnType eq 'timestamp'}">dateToStr(new Date(val))</c:when><c:otherwise>val||''</c:otherwise></c:choose>;
		}},//</c:if></c:forEach>
// 	    {header:'状态', name:'status', width:200, align:"center"},
// 	    {header:'创建者', name:'create_by', width:200, align:"center"},
// 	    {header:'创建时间', name:'create_date', width:200, align:"center", formatter: function(val, obj, row, act){
// 			return dateToStr(new Date(val));
// 		}},
// 	    {header:'更新者', name:'update_by', width:200, align:"center"},
// 	    {header:'更新时间', name:'update_date', width:200, align:"center", formatter: function(val, obj, row, act){
// 			return dateToStr(new Date(val));
// 		}},
		{header:'操作', name:'actions', width:150, hidden:true, sortable:false, formatter: function(val, obj, row, act){
			var actions = [];
			actions.push('<a href="${ctx}/form/formTableData/view?tableName='+row.tableName+'" class="btnList" title="查看数据"><i class="fa fa-search"></i></a>&nbsp;');
			return actions.join('');
		}}
	],
	showCheckbox: true,
	ajaxSuccess: function(data){ // 加载成功后执行方法
		
	}
});
$('#btnDelete').click(function(){
	var rows = $("#dataGrid").dataGrid('getSelectRows');
	confirmx('您已选择'+rows.length+'条数据，是否要全部删除它？', '${ctx}/form/formTableData/delete',
			{tableName:'${param.tableName}',ids:rows.join()}, function(data){
		showMessage(data.message);
		page();
	});
});
$('#btnTemplate').click(function(){
	window.open('${ctx}/form/formTableData/downloadTemplate?tableName=${param.tableName}');
});
$('#btnImport').click(function(){
	var $jBox = getJBox();
	$jBox.open(template('importForm',{tableName:'${param.tableName}'}), "导入数据", 400, 150, { persistent:true,
		buttons:{'<i class=\"glyphicon glyphicon-ok\"></i>&nbsp;导入': 'ok', '<i class=\"glyphicon glyphicon-remove\"></i>&nbsp;取消': 'cancel'},
		submit:function(v, h, f){ // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
			if (v=='ok'){
			 	ajaxSubmitForm(h.find("form"), function(data){
			 		showMessage(data.message);
			 		$jBox.close();
			 		page();
			 	}, "json", false);
			 	return false;
			}
		}
	});
});
</script>
<script id="importForm" type="text/template">
	<form id="importForm" action="${ctx}/form/formTableData/importData" method="post" enctype="multipart/form-data" class="form-horizontal">
		<input type="hidden" name="tableName" id="tableName" value="{{tableName}}" />
		<div style="padding:3px 15px 0;border:0!important"><br/>
			<div class="row">
				<div class="col-xs-12">
					<input id="uploadFile" name="file" type="file" style="width:350px"/><br/>
					<font color="red">导入文件格式：支持“xls”或“xlsx”的文件！</font>
				</div>
			</div>
		</div>
	</form>
</script>