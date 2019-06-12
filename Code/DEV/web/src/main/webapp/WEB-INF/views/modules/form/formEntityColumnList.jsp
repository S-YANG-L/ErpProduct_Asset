<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="字段管理" extLibs="${extLibs}" />
<style>
<!--
.ui-jqgrid-bdiv{height: 100%;}
-->
.portlet.box.default .portlet-tabs>.tab-content1 {
    padding: 0 0 10px 0!important;
}
.portlet-tabs>.tab-content1 {
    margin: 0;
    margin-top: -52px!important;
}
</style>
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 业务实体字段</div>
	</div>
	<div class="portlet-tabs">
		<ul class="nav nav-tabs">
			<li><a id="btn_portlet_tab3" href="${ctx}/form/formPermi/list?entityId=${formEntityColumn.entityId}">权限配置</a></li>
			<li class="active"><a id="btn_portlet_tab2" href="#portlet_tab2" data-toggle="tab">字段配置</a></li>
			<li><a id="btn_portlet_tab1" href="${ctx}/form/formEntity/form?entityId=${formEntityColumn.entityId}">业务实体 </a></li>
		</ul>
		<div class="tab-content1">
			<div class="tab-pane active" id="portlet_tab2">
				<div id="content" class="row-fluid">
					<div id="left">
						<div class="portlet box white autoHeight">
							<form:form id="searchForm" modelAttribute="formEntityColumn" action="${ctx}/form/formEntityColumn/listData" method="post" class="breadcrumb form-inline "
								data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
									<form:hidden path="entityId" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
									<div class="form-group">
										<label class="control-label">字段名：</label>
										<div class="input-inline">
											<form:input path="columnName" htmlEscape="false" maxlength="64" class="form-control input-sm width-110"/>
										</div>
									</div>
									<div class="form-group" style="margin-left:10px;"> 
										<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
									</div>
								</form:form>
								
							<!-- <div class="portlet-body">	 -->
								<table id="dataGrid"></table>
							<!-- </div> -->
						</div>
					</div>
					<!-- <div id="openClose" class="close">&nbsp;</div> -->
					<div id="right">
						<iframe id="mainFrame" name="mainFrame" src="${ctx}/form/formEntityColumn/form"
									style="overflow:visible;" scrolling="yes" frameborder="no" width="100%"></iframe>
					</div>
				</div>
			</div>
		</div>
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
// 			{header:'实体编号', name:'entityId', index:'a.entity_id', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
// 				return '<a href="${ctx}/form/formEntityColumn/form?id='+row.id+'" class="btnList" data-title="编辑字段">'+(val ? val : row.id)+'</a>';
// 			}},
// 			{header:'实体描述', name:'formEntity.entityName', index:'fe.entity_name', width:200, align:"center"},
			{header:'物理表名', name:'id', hidden:true, width:200, align:"center"},
			{header:'物理表名', name:'tableName', index:'aa.table_name', width:200, align:"center"},
//			{header:'子表名', name:'formSubEntity.entityName', index:'fes.sub_table_name', width:200, align:"center"},
			{header:'字段描述', name:'formTableColumn.columnComment', index:'aa.column_comment', width:200, align:"center", formatter: function(val, obj, row, act){
 				if(row.formTableColumn.columnComment == undefined){
 					return row.formTableColumn.columnName;
 				}else{
 					if(row.entityColumnType=='1'){
 	 					return val+"[扩展]";
 	 				}
 				}
				
 				return val;
	 		}},
			{header:'字段名', name:'formTableColumn.columnName', index:'aa.column_name', width:200, align:"center"},
			{header:'是否虚拟字段', name:'isVirtual', index:'aa.is_virtual', width:100, hidden:true, align:"center"}
// 			{header:'控件显示类型', name:'showType', index:'a.show_type', width:200, align:"left"},
// 			{header:'显示类型选项', name:'showOptions', index:'a.show_options', width:200, align:"left"},
// 			{header:'默认值', name:'defaultValue', index:'a.default_value', width:200, align:"left"},
// 			{header:'默认值是否是脚本', name:'defaultValueIsScript', index:'a.default_value_is_script', width:200, align:"left"},
// 			{header:'字段验证类型', name:'validType', index:'a.valid_type', width:200, align:"left"},
// 			{header:'验证正则表达式', name:'validRegx', index:'a.valid_regx', width:200, align:"left"},
// 			{header:'CSS类名', name:'cssClass', index:'a.css_class', width:200, align:"left"},
// 			{header:'CSS样式', name:'cssStyle', index:'a.css_style', width:200, align:"left"},
// 			{header:'操作', name:'actions', width:60, fixed:true, sortable:false, formatter: function(val, obj, row, act){
// 				var actions = [];//<shiro:hasPermission name="form:formEntityColumn:edit">
// 				if (row.status == Global.STATUS_NORMAL){
// // 					actions.push('<a href="${ctx}/form/formEntityColumn/form?id='+row.id+'" class="btnList" title="编辑字段"><i class="fa fa-pencil"></i></a>&nbsp;');
// 					actions.push('<a href="${ctx}/form/formEntityColumn/delete?id='+row.id+'" class="btnList" title="删除该字段" data-confirm="确认要删除该字段吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
// 				}//</shiro:hasPermission>
// 				return actions.join('');
// 			}}
		],
		sortname: 'tableName',
		grouping:true,
        groupingView : {
          groupField : ['tableName'],
          groupColumnShow : [false],// 隐藏分组列
          //groupOrder : ['asc'], 
          groupText : ['<b>{0}</b>'],
          groupDataSorted : true 
        },
		onSelectRow: function(id, isSelect, event){
			var rowData = $('#dataGrid').jqGrid('getRowData',id);
			if(rowData.isVirtual=='1'){
				$('#mainFrame').attr("src", '${ctx}/form/formEntityColumn/extendForm?id='+id+'&tableName='+rowData.tableName);
			}else{
				$('#mainFrame').attr("src", '${ctx}/form/formEntityColumn/form?id='+id+'&tableName='+rowData.tableName);
			}
			$(window).resize();
		},
		ajaxSuccess: function(data){ // 加载成功后执行方法
			setTimeout(function(){
				$(window).resize().resize();
			},100);
		}
	});
	
	// 框架布局调整
	var leftWidth = "30%"; // 左侧窗口大小
	var wSize = function(){
		var heightWidth = getWindowSize().toString().split(",");
		//$("#mainFrame, #openClose").height(heightWidth[0]);
		//$("#right").width(heightWidth[1] - $("#left").width()-$("#openClose").width() - 32);
		$("#right").width(heightWidth[1] - $("#left").width() - 25);
		$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
	}	
	$(window).resize(function(){
		$('#mainFrame').height($('#searchForm').parent().height());
		//$('#mainFrame').height("450px");
	});
</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>