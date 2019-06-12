<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="选择出库" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="outboundBillDtl" action="${ctx}/outbound/outboundBill/findoutboundCode" method="post" class="breadcrumb form-inline"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">单号：</label>
				<div class="input-inline">
					<form:input path="sysCode" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
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
	var dataMap = {};
	var  dataSize = 0; // 获取数据MAP
	$(document).ready(function() {
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		showCheckbox : true, // 是否显示复选框
		
		// 设置数据表格列
		columnModel: [
			{header:'sysid', name:'sysId', width:200, align:"center", hidden:true},
			{header:'办公用品名称', name:'articlesName', index:'a.articlesName', width:200, align:"center"},
			{header:'办公用品分类名称', name:'sortName', index:'a.sortName', width:200, align:"center"},
			{header:'品牌名称', name:'brand', index:'a.brand', width:200, align:"center"},
			{header:'规格型号', name:'version', index:'a.version', width:200, align:"center"},
			{header:'数量', name:'qty', index:'a.qty', width:200, align:"center"},
			{header:'单价', name:'price', index:'a.price', width:200, align:"center"},
			{header:'合计金额', name:'sumMoney', index:'a.sum_money', width:200, align:"center"},
			{header:'行数据', name:'rowData', hidden:true, formatter: function(val, obj, row, act){
                return JSON.stringify(row);
            }}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		},
		onSelectRow: function(id, isSelect, event){//单选
			if(isSelect){
				dataMap[id] = JSON.parse($('#dataGrid').dataGrid('getRowData', id).rowData);
				
			}else{
				delete dataMap[id];
			}
		selectProjects();
	},
	onSelectAll: function(ids, isSelect){//全选
	    console.log(ids);
			for (var i=0; i<ids.length; i++){
				if(isSelect){
					dataMap[id] = JSON.parse($('#dataGrid').dataGrid('getRowData',id).rowData);
				}else{
					delete dataMap[ids[i]];
				}
			}
		selectProjects();
	}
	});
	
});
	
	function selectProjects(){
		dataSize = 0;
		var selectHtml = "";
		$.each(dataMap, function(key, value){

			dataSize ++;
			selectHtml += '<span class="tag" id="'+key+'_tagsinput"><span>'+value.assetCode+'&nbsp;&nbsp;</span><a href="#" onclick="removingTag(\''+key+'\');" title="Removing tag">x</a></span>';
		});
		selectHtml = '<span class="tag" style="border-color:#fff;background:#fff;"><span>&nbsp;当前已选择<span id="dataSize">'+dataSize+'</span>项：</span></span>' + selectHtml + '<div class="tags_clear"></div>';
		$('#selectProjects').empty().append(selectHtml); 
	}

	function removingTag(key){
		$('#dataGrid').dataGrid('resetSelection', key);
		delete dataMap[key];
		$('#dataSize').html(--dataSize);
		$('#'+key+'_tagsinput').remove();
	}

	function getDataMap(){
		return dataMap;
	}
</script>