<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="测试管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 测试管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="${ctx}/form/form/formPreview?formKey=abdlslsdf123123&permiKey=form:abc:edit" class="btn btn-default btn-sm btnTool" title="新增测试"><i class="fa fa-plus"></i> 新增</a>
			<a href="${ctx}/form/form/cleanData?formKey=abdlslsdf123123&permiKey=form:abc:edit" class="btn btn-default btn-sm" title="数据清洗"><i class="fa fa-plus"></i> 数据清洗</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="bizTestFormData" action="${ctx}/biz/bizTestFormData/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">dh_text：</label>
				<div class="input-inline">
					<form:input path="dhText" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
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
			{header:'dh_text', name:'dhText', index:'a.dh_text', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/biz/bizTestFormData/form?id='+row.id+'" class="btnList" data-title="编辑测试">'+(val ? val : row.id)+'</a>';
			}},
			{header:'dh_textarea', name:'dhTextarea', index:'a.dh_textarea', width:200, align:"left"},
			{header:'update_date', name:'updateDate', index:'a.update_date', width:200, align:"left"},
			{header:'remarks', name:'remarks', index:'a.remarks', width:200, align:"left"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/form/form/formPreview?formKey=abdlslsdf123123&permiKey=form:abc:edit&id='+row.id+'" class="btnList" title="编辑测试"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/form/delete?formKey=abdlslsdf123123&permiKey=form:abc:edit&id='+row.id+'" class="btnList" title="删除该测试" data-confirm="确认要删除该测试吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>