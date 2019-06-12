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
			<i class="fa fa-gear"></i> <span id='fz'>公共组</span> <b class="caret"></b>
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
			<a href="#" class="btn btn-default btn-sm" id="btnImportZy" title="确定移到"><i class="fa fa-search"></i> 确定移到</a>
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
			{header:'名称', name:'dirName', index:'a.dir_name', width:200, align:"center", frozen:true},
			{header:'归属部门', name:'office.officeName', index:'a.office_code', width:200, align:"center"},
			{header:'排序（升序）', name:'sorts', index:'a.sorts', width:200, align:"center"},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:200, align:"center"},
			{header:'dirId', name:'dirId', index:'a.dir_id', width:200, align:"center", frozen:true,hidden:true},
			{header:'备注', name:'remarks', index:'a.remarks', width:200, align:"center"}
		],
		treeGrid: true,			// 启用树结构表格
		defaultExpandLevel: 0,	// 默认展开的层次
		ajaxSuccess: function(data){ // 加载成功后执行方法

		}
	});
    function chaxun(group,name){
    	$("#globalId").val(group);
    	$("#fz").text(name);
    	$("#searchForm").submit();
    	$("#addDir").attr("href",'${ctx}/file/fileDir/form?globalId='+$("#globalId").val());
    }
  	//文件移到
	$("#btnImportZy").click(function(){
		var file = $('#dataGrid').dataGrid('getRowData');
	    if(0==file.length){
	    	showMessage("请选择移到的目录");
			return;
	    }
	    console.info(file);
	    alert(file.dirId);
		//$.jBox("iframe:${ctx}/file/fileUserShare/form?fileUserId="+fileUserIds,{title:"文件分享", width: 800, height: 350, buttons:{ '关闭': true },bottomText:""});  
	});
</script>