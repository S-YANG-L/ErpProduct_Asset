<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="立方体查询" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-user"></i> 立方体查询</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" action="${url}" method="post" class="breadcrumb form-inline hide">
			<div class="form-group" > &nbsp; &nbsp;
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
	var dataGrid; // 定义全局表格对象。
	$(document).ready(function() {
		
		// 初始化DataGrid对象
		dataGrid = new DataGrid({
			
			// 当前页签编号
			tabPageId: '${param.tabPageId}',
			
			// 设置数据表格列
			columnModel: [
				{header:'立方体名称', name:'cubeName', width:100},
				{header:'立方体权限标识', name:'cubeId', width:200, formatter: function(val, obj, row, act){
					return 'rsbi:cube:' + val;
				}},
				{header:'所属报表名称', name:'fileName', width:100},
// 				{header:'报表权限标识', name:'fileId', width:200, formatter: function(val, obj, row, act){
// 					return 'rsbi:page:' + val;
// 				}},
				{header:'备注', name:'note', width:80},
				{header:'行数据', name:'rowData', hidden:true, formatter: function(val, obj, row, act){
					return JSON.stringify(row);
				}}
			],
			sortable: false,
			multiboxonly: false,
			showCheckbox: '${param.mul}' == 'true',
			ajaxSuccess: function(data){ // 加载成功后执行方法
				
			},
			ondblClickRow: function(id, rownum, colnum, event){
				if ('${param.mul}' != 'true'){
					var $jBox = getJBox();
					$jBox.getBox().find("button[value='ok']").trigger("click");
				}
			}
		});
		
	});
	function getDatas(){
		var retIds = [], retRows = [];
		if('${param.mul}' == 'false'){
			var id = dataGrid.getSelectRow();
			if (id){
				retIds.push(id);
				retRows.push(JSON.parse(dataGrid.getRowData(id).rowData));
			}
		}else{
			var ids = dataGrid.getSelectRows();
			for(var i=ids.length-1; i>=0; i--){
				retIds.unshift(ids[i]);
				retRows.unshift(JSON.parse(dataGrid.getRowData(ids[i]).rowData));
			}
		}
		return {ids: retIds, rows: retRows};
	}
</script>