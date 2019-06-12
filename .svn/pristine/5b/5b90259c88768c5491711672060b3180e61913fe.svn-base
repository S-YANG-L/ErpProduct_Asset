<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<c:set var="extHead">
<style type="text/css">
<!--
div.tagsinput { border:1px solid #ccc; background:#fff; margin-top:9px; padding:5px; padding-bottom:0; overflow-y: auto;width:auto;min-height:42px; height:42px;}
div.tagsinput span.tag { border: 1px solid #a5d24a; -moz-border-radius:2px; -webkit-border-radius:2px; display: block; float: left; padding: 5px; text-decoration:none; background: #cde69c; color: #638421; margin-right: 5px; margin-bottom:5px;}
div.tagsinput span.tag a { font-weight: bold; color: #82ad2b; text-decoration:none; font-size: 11px;  } 
div.tagsinput input { width:80px; margin:0px; font-family: helvetica; font-size: 13px; border:1px solid transparent; padding:5px; background: transparent; color: #000; outline:0px;  margin-right:5px; margin-bottom:5px; }
div.tagsinput div { display:block; float: left; } 
.tags_clear { clear: both; width: 100%; height: 0px; }
.not_valid {background: #fbd8db !important; color: #90111a !important;}
-->
</style>
</c:set>
<sys:header title="单位查询" extLibs="${extLibs}"  extHead="${extHead}"/>
<div class="portlet box">
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="btypeInfo" action="${ctx}/mdm/btypeInfo/listData" method="post" class="breadcrumb form-inline"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">单位名称：</label>
				<div class="input-inline width-160">
					<form:input path="btypeName" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
				</div>
			</div>
			<%-- <div class="form-group">
				<label class="control-label"> 所在区市：</label>
				<div class="input-inline width-160">
					<sys:treeselect id="areaCode" name="btypeExt.areaCode" value="${btypeInfo.btypeExt.areaCode}" labelName="btypeExt.areaName" labelValue="${btypeInfo.btypeExt.areaName}"
						title="所在区市" url="/sys/area/treeData" cssClass="" returnFullPath="true" allowClear="true" notAllowSelectParent="true"/>
					<span class="help-block">&nbsp;</span>
				</div>
			</div> --%>
			<div class="form-group" > &nbsp;&nbsp;
				
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置" onclick="$('#status').select2('val', Global.STATUS_NORMAL);$('#areaCodeCode').val('')"/>
				&nbsp;
				<shiro:hasPermission name="mdm:btypeInfo:operation">
				<input class="btn btn-primary btn-sm" id="btnOperation" value="新增往来单位"/>&nbsp;
				</shiro:hasPermission>
				
			</div>	
		</form:form>
		<table id="dataGrid"></table>
	    <div id="dataGridPage"></div>
		<div id="selectBtypes" class="tagsinput"></div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	var dataMap = {}, dataSize = 0; // 获取数据MAP
	$(document).ready(function() {
		//<c:if test="${not empty selectData && selectData!=''}">
		var selectData="${selectData}";
		selectData = selectData.replace(new RegExp("\'","g"),"\"");
		dataMap = JSON.parse(selectData);
		selectBtypes();
		//</c:if>
		//初始化DataGrid对象
		$('#dataGrid').dataGrid({
			
			// 当前页签编号
			tabPageId: '${param.tabPageId}',
			
			// 设置数据表格列
			columnModel: [
				{header:'单位编码', name:'btypeCode', index:'emp_name', width:100},
				{header:'单位名称', name:'btypeName', index:'emp_no', width:150},
				{header:'组织单位代码', name:'orgCode', index:'', width:100},
				{header:'注册类型编码', name:'btypeSortCode', index:'', width:80,hidden:true},
				{header:'注册类型 ', name:'btypeSortName', index:'', align:"center", width:80},
				{header:'联系人', name:'linkman', index:'mobile', width:80, sortable:false},
				{header:'联系人电话', name:'linkmanTel', index:'email', width:80, sortable:false},
				{header:'行数据', name:'rowData', hidden:true, formatter: function(val, obj, row, act){
					return JSON.stringify(row);
				}}
			],
			multiboxonly: false,
			showCheckbox: '${param.mul}' == 'true',
			ajaxSuccess: function(data){ // 加载成功后执行方法
				$.each(dataMap, function(key, value){
					$('#dataGrid').dataGrid('setSelectRow', key);
				});
			},
			onSelectRow: function(id, isSelect, event){
				if ('${param.mul}' == 'true'){
					if(isSelect){
						dataMap[id] = JSON.parse($('#dataGrid').dataGrid('getRowData', id).rowData);
					}else{
						delete dataMap[id];
					}
				}else{
					dataMap = {};
					dataMap[id] = JSON.parse($('#dataGrid').dataGrid('getRowData', id).rowData);
				}
				selectBtypes();
				
			},
			onSelectAll: function(ids, isSelect){
				if ('${param.mul}' == 'true'){
					for (var i=0; i<ids.length; i++){
						if(isSelect){
							dataMap[ids[i]] = JSON.parse($('#dataGrid').dataGrid('getRowData', ids[i]).rowData);
						}else{
							delete dataMap[ids[i]];
						}
					}
				}
				selectBtypes();
			},
			ondblClickRow: function(id, rownum, colnum, event){
				if ('${param.mul}' != 'true'){
					var $jBox = getJBox();
					$jBox.getBox().find("button[value='ok']").trigger("click");
				}
				selectBtypes();
			}
		});
		
	});
	
	// 废弃方法，不建议使用，see: getDataMap()
	function getDatas(){
		var retIds = [], retRows = [];
		if('${param.mul}' == 'false'){
			var id = $('#dataGrid').dataGrid('getSelectRow');
			if (id){
				retIds.push(id);
				retRows.push(JSON.parse($('#dataGrid').dataGrid('getRowData', id).rowData));
			}
		}else{
			var ids = $('#dataGrid').dataGrid('getSelectRows');
			for(var i=ids.length-1; i>=0; i--){
				retIds.unshift(ids[i]);
				retRows.unshift(JSON.parse($('#dataGrid').dataGrid('getRowData', ids[i]).rowData));
			}
		}
		return {ids: retIds, rows: retRows};
	}

	function selectBtypes(){
		dataSize = 0;
		var selectHtml = "";
		$.each(dataMap, function(key, value){
			dataSize ++;
			selectHtml += '<span class="tag" id="'+key+'_tagsinput"><span>'+value.btypeName+'&nbsp;&nbsp;</span><a href="#" onclick="removingTag(\''+key+'\');" title="Removing tag">x</a></span>';
		});
		selectHtml = '<span class="tag" style="border-color:#fff;background:#fff;"><span>&nbsp;当前已选择<span id="dataSize">'+dataSize+'</span>项：</span></span>' + selectHtml + '<div class="tags_clear"></div>';
		$('#selectBtypes').empty().append(selectHtml); 
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
	
	
	
	
	$("#btnOperation").click(function(){
		
		var url="${ctx}/mdm/btypeInfo/form";

		addTabPage($(this), "新增往来单位", url, '${param.tabPageId}');
		window.parent.window.jBox.close();
	});
</script>