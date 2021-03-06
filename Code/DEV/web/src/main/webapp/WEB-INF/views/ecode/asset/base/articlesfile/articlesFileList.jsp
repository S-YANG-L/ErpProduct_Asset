<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="办公用品档案管理管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 办公用品档案</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="articlesfile:articlesFile:edit">
				<a href="${ctx}/articlesfile/articlesFile/form" class="btn btn-default btn-sm btnTool" title="新增办公用品档案"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="articlesFile" action="${ctx}/articlesfile/articlesFile/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">	
		            <div class="row">
		            
		            <div class="col-xs-4">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								办公用品分类：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
							  <sys:treeselect url="${ctx}/articlesfile/articlesFile/sortTreeData" id="sortCode"
                                   value="${articlesFile.sortName}" labelName="sortName"
                                   labelValue="${articlesFile.sortName}" title="办公用品分类" name="sortCode"
                                   cssClass="rightBorder" allowClear="true"
                                   notAllowSelectParent="true" isAll="true">
                                </sys:treeselect>
							</div>
						</div>
					</div>
		            
		             <div class="col-xs-4">
						<div class="form-group">
							<label class="control-label col-sm-5" title="">
								办公用品名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-7">
								<form:input path="articlesName" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					
					<div class="col-xs-4">
						<div class="form-group">
							<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				            <input class="btn default btn-sm" type="reset" value="重置"/>
						</div>
					</div>
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
			{header:'办公用品编码', name:'articlesCode', index:'a.articles_code', width:180, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/articlesfile/articlesFile/form?id='+row.id+'" class="btnList" data-title="编辑办公用品档案管理">'+(val ? val : row.id)+'</a>';
			}},
			{header:'办公用品分类', name:'sortName', index:'a.sort_name', width:120, align:"left"},
			{header:'办公用品名称', name:'articlesName', index:'a.articles_name', width:150, align:"left"},
	
			{header:'品牌名称', name:'brand', index:'a.brand', width:150, align:"left"},
			{header:'规格型号', name:'version', index:'a.version', width:90, align:"left"},
			{header:'单位', name:'unit', index:'a.unit', width:90, align:"left"},
			{header:'安全上限', name:'upperLimit', index:'a.upper_limit', width:90, align:"left"},
			{header:'安全下限', name:'lowerLimit', index:'a.lower_limit', width:90, align:"left"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false,align:"center", formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="articlesfile:articlesFile:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/articlesfile/articlesFile/form?id='+row.id+'" class="btnList" title="编辑办公用品档案管理"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/articlesfile/articlesFile/delete?id='+row.id+'" class="btnList" title="删除该办公用品档案管理" data-confirm="确认要删除该办公用品档案管理吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});

</script>