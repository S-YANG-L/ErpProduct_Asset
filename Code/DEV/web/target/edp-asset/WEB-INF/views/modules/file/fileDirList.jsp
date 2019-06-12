<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="文件目录管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title dropdown">
		<%-- <div class="caption"><i class="fa fa-coffee"></i> 文件目录管理
			<select class="input-sm width-160 noselect2" id="globalIdx" style="margin:0px 0px 0px 0px;">
				<c:forEach var="value" items="${fns:getDictList('sys_file_group')}">  
                    <option value="${value.value}">  
                    	${value.label}  
                    </option>  
                </c:forEach>  
			</select>
		</div> --%>
		&nbsp;<div class="caption dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">
			<i class="fa fa-gear"></i> <span id='fz'>公共文件柜</span> <b class="caret"></b>
		</div>
		<ul class="dropdown-menu">
			<c:forEach items="${fns:getDictList('sys_file_group')}" var="value">
				<li><a href="#" onclick="chaxun('${value.value}','${value.label}')">
					<i class="fa fa-angle-right"></i> ${value.label}</a></li>
			</c:forEach>
		</ul>
		<div class="actions">
			
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="刷新"><i class="fa fa-refresh"></i> 全部</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExpandTreeNode" title="展开一级"><i class="fa fa-angle-double-down"></i> 展开</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCollapseTreeNode" title="折叠全部"><i class="fa fa-angle-double-up"></i> 折叠</a>
			<shiro:hasPermission name="file:fileDir:edit">
				<a href="${ctx}/file/fileDir/form?globalId=global" id="addDir" class="btn btn-default btn-sm btnTool" title="新增文件目录管理"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="fileDir" action="${ctx}/file/fileDir/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">名称：</label>
				<div class="input-inline">
					<form:hidden path="globalId" htmlEscape="false" value="global" maxlength="30" class="form-control input-sm"/>
					<form:input path="dirName" htmlEscape="false" maxlength="30" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">归属部门：</label>
				<div class="input-inline width-160" >
					<sys:treeselect id="office" name="office.officeCode" value="${fileDir.office.officeCode}" labelName="office.officeName" labelValue="${fileDir.office.officeName}"
						title="部门" url="/sys/office/treeData?type=2" controlSize="sm" isAll="true" allowClear="true" notAllowSelectParent="false"/>
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
			{header:'名称', name:'dirName', index:'a.dir_name', width:120, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/file/fileDir/form?dirId='+row.dirId+'" class="btnList" data-title="编辑文件目录管理">'+(val ? val : row.dirId)+'</a>';
			}},
			{header:'归属部门', name:'office.officeName', index:'a.office_code', width:120, align:"center"},
			{header:'排序（升序）', name:'sorts', index:'a.sorts', width:100, align:"center"},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:130, align:"center"},
			{header:'备注', name:'remarks', index:'a.remarks', width:140, align:"center"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				//<shiro:hasPermission name="file:fileDir:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/file/fileDir/form?dirId='+row.dirId+'" class="btnList" title="编辑文件目录管理"><i class="fa fa-pencil"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="file:fileDir:enable">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/file/fileDir/disable?dirId='+row.dirId+'" class="btnList" title="停用文件目录管理" data-confirm="确认要停用该文件目录管理吗？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="file:fileDir:disable">
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/file/fileDir/enable?dirId='+row.dirId+'" class="btnList" title="启用文件目录管理" data-confirm="确认要启用该文件目录管理吗？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="file:fileDir:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/file/fileDir/delete?dirId='+row.dirId+'"  class="btnList" title="删除文件目录管理" data-confirm="确认要删除该文件目录管理及所有子文件目录管理吗？" data-confirm-success="$(\'#dataGrid\').dataGrid(\'delTreeNode\',\''+row.dirId+'\');"><i class="fa fa-trash-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/file/fileDir/form?parentCode='+row.dirId+'&globalId='+row.globalId+'" class="btnList" title="新增下级文件目录管理"><i class="fa fa-plus-square"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		treeGrid: true,			// 启用树结构表格
		defaultExpandLevel: 0,	// 默认展开的层次
		expandNodeClearPostData:'dirName,office.officeCode',
		ajaxSuccess: function(data){ // 加载成功后执行方法

		}
	});
    function chaxun(group,name){
    	$("#globalId").val(group);
    	$("#fz").text(name);
    	$("#searchForm").submit();
    	$("#addDir").attr("href",'${ctx}/file/fileDir/form?globalId='+$("#globalId").val());
    }
</script>