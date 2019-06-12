<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="目录权限管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa icon-users">目录权限管理</i></div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="role" action="${ctx}/file/fileDirRole/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">角色名称：</label>
				<div class="input-inline width-160" >
					<form:input path="roleName" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">状态：</label>
				<form:select path="isShow" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
					<form:options items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>	
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
	
	// 初始化DataGrid对象
	$('#dataGrid').dataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'角色名称', name:'roleName', index:'role_name', width:100, align:"center"},
  			{header:'角色编码', name:'roleCode', index:'a.role_code', width:100, align:"center"},
			{header:'备注', name:'remarks', index:'remarks', width:110, sortable:false},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				actions.push('<a href="${ctx}/file/fileDirRole/form?roleName='+row.roleName+'&roleCode='+row.id+'&ctrlType=view" class="btnList" title="授权查看"><i class="fa fa-check-square"></i></a>&nbsp;');
				actions.push('<a href="${ctx}/file/fileDirRole/form?roleName='+row.roleName+'&roleCode='+row.id+'&ctrlType=edit" class="btnList" title="授权编辑"><i class="fa fa-check-square-o"></i></a>&nbsp;');
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
</script>