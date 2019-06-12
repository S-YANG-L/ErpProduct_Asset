<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${link.category.categoryName}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-file-text-o"></i> ${link.category.categoryName}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
			<shiro:hasPermission name="cms:link:edit">
				<a href="javascript:" onclick="$(this).attr('href','${ctx}/cms/link/form?category.categoryCode='+$('#categoryCode').val()+'&fileDownload='+$('#fileDownload').val())" class="btn btn-default btn-sm btnTool" title="新增${article.category.categoryName}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="link" action="${ctx}/cms/link/listData" method="post" class="breadcrumb form-inline ${canAdmin ne 'true' ? 'hide' : ''}"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<input type="hidden" name="canAdmin" value="${canAdmin}">
			<input type="hidden" name="isAll" value="${isAll}">
			<input type="hidden" id="fileDownload" value="${param.fileDownload}">
			<form:hidden id="categoryCode" path="category.categoryCode"/>
			<%-- <div class="form-group">
				<label class="control-label">所属栏目：</label>
				<div class="input-inline width-160" >
					<sys:treeselect id="category" name="category.categoryCode" value="${link.category.categoryCode}" labelName="category.categoryName" labelValue="${link.category.categoryName}"
						title="栏目" url="/cms/category/treeData" module="link" notAllowSelectRoot="false" cssClass="input-small"/>
				</div>
			</div> --%>
			<div class="form-group">
				<label class="control-label">${fns:text('标题')}：</label>
				<div class="input-inline width-160" >
					<form:input path="title" htmlEscape="false" maxlength="255" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="${fns:text('查询')}"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="${fns:text('重置')}"/>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('状态')}：</label>
				<div class="input-inline width-200" >
					<div class="radio-list">
						<form:radiobuttons path="status" items="${fns:getDictList('cms_status')}" itemLabel="label" 
							itemValue="value" htmlEscape="false" class="form-control required" onclick="$('#searchForm').submit()"/>
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
	var dataGrid = new DataGrid({
			
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'${fns:text("标题")}', name:'title', index:'a.title', width:400, formatter: function(val, obj, row, act){
				//<c:if test="${canAdmin eq 'true'}">
				return '<a href="${ctx}/cms/link/form?id='+row.id+'&fileDownload='+$('#fileDownload').val()+'" class="btnList" data-title="${fns:text("编辑信息")}">'+(val ? val : row.id)+'</a>';
				//</c:if><c:if test="${!(canAdmin eq 'true')}">
				return '<a href="'+row.href+'" title="'+val+'" target="_blank">'+(val ? val : row.id)+'</a>';
				//</c:if>
			}},
			{header:'${fns:text("栏目")}', name:'category.categoryName', index:'c.category_name', width:130, align:'center'},
			{header:'${fns:text("权重")}', name:'weight', index:'a.weight', width:50, fixed:true, align:'center', fixed:true},
			{header:'${fns:text("状态")}', name:'status', index:'a.status', width:50, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('cms_status')}, val, '未知', true);
			}},
			{header:'${fns:text("创建者")}', name:'createByName', width:75, sortable:false, align:'center', fixed:true},
			//{header:'${fns:text("创建时间")}', name:'createDate', index:'a.create_date', width:95, align:"center", fixed:true},
			//{header:'${fns:text("更新者")}', name:'updateByName', width:75, sortable:false, align:'center', fixed:true},
			{header:'${fns:text("更新时间")}', name:'updateDate', index:'a.update_date', width:95, align:"center", fixed:true}
			//<c:if test="${canAdmin eq 'true'}">
			,{header:'${fns:text("操作")}', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="cms:link:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/cms/link/form?id='+row.id+'&fileDownload='+$('#fileDownload').val()+'" class="btnList" title="${fns:text("编辑信息")}"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/cms/link/delete?id='+row.id+'" class="btnList" title="${fns:text("删除该信息")}" data-confirm="${fns:text("确认要删除该信息吗")}？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}else if (row.status == Global.STATUS_DELETE){
					actions.push('<a href="${ctx}/cms/link/form?id='+row.id+'&fileDownload='+$('#fileDownload').val()+'" class="btnList" title="${fns:text("再次编辑信息")}"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/cms/link/delete?id='+row.id+'&isRe=true" class="btnList" title="${fns:text("撤销删除该信息")}" data-confirm="${fns:text("确认要撤销删除该信息吗")}？"><i class="fa fa-reply"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				actions.push('<a href="${pageContext.request.contextPath}${fns:getFrontPath()}/view-'+getVal(row, 'category.categoryCode')+'-'+row.id+'" target="_blank" data-click-binded="true" class="btnList" title="预览${link.category.categoryName}"><i class="fa fa-globe"></i></a>&nbsp;');
				return actions.join('');
			}}
			//</c:if>
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>