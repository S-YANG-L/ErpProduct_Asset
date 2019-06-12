<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="站点管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-sitemap"></i> ${fns:text('站点管理')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
			<shiro:hasPermission name="cms:site:edit">
				<a href="${ctx}/cms/site/form" class="btn btn-default btn-sm btnTool" title="${fns:text('新增站点')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="site" action="${ctx}/cms/site/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">${fns:text('站点名称')}：</label>
				<div class="input-inline width-160" >
					<form:input path="siteName" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('站点标题')}：</label>
				<div class="input-inline width-160" >
					<form:input path="title" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="${fns:text('查询')}"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="${fns:text('重置')}"/>
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
		{header:'${fns:text("站点名称")}', name:'siteName', index:'site_name', width:200, frozen:true, formatter: function(val, obj, row, act){
			return '<a href="${ctx}/cms/site/form?siteCode='+row.siteCode+'" class="btnList" data-title="${fns:text("编辑站点")}">'+(val ? val : row.id)
				+/*(row.isCurrentSite ? ' <font color="red">[当前站点]</font>' : '')+*/'</a>';
		}},
		{header:'${fns:text("站点编码")}', name:'siteCode', index:'site_code', width:130, align:"center"},
		{header:'${fns:text("站点标题")}', name:'title', index:'title', width:200},
		{header:'${fns:text("站点域名")}', name:'domain', index:'domain', width:200},
		{header:'${fns:text("描述")}', name:'description', index:'description', width:200},
		{header:'${fns:text("主题")}', name:'theme', index:'theme', width:200, align:"center", formatter: function(val, obj, row, act){
			return getDictLabel(${fns:getDictListJson('cms_theme')}, val, '未知', true);
		}},
		{header:'${fns:text("操作")}', name:'actions', width:125, sortable:false, fixed:true, formatter: function(val, obj, row, act){
			var actions = [];//<shiro:hasPermission name="cms:site:edit">
			if (row.status == Global.STATUS_NORMAL){
// 				actions.push('<a href="${ctx}/cms/site/select?siteCode='+row.siteCode+'" class="btnList" title="切换到当前站点" data-confirm="确认要切换到该站点吗？"><i class="fa fa-retweet"></i></a>&nbsp;');
				actions.push('<a href="${ctx}/cms/site/form?siteCode='+row.siteCode+'" class="btnList" title="${fns:text("编辑站点")}"><i class="fa fa-pencil"></i></a>&nbsp;');
				actions.push('<a href="${ctx}/cms/site/delete?siteCode='+row.siteCode+'" class="btnList" title="${fns:text("删除站点")}" data-confirm="${fns:text("确认要删除该站点吗")}？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				//<shiro:hasPermission name="cms:site:editIndex">
				actions.push('<a href="${ctx}/cms/site/editIndex?siteCode='+row.siteCode+'" class="btnList" title="${fns:text("重建该站点索引")}" data-confirm="${fns:text("确认重建该站点文章索引吗")}？"><i class="fa fa-crosshairs"></i></a>&nbsp;');
				//</shiro:hasPermission>
				actions.push('<a href="${pageContext.request.contextPath}${fns:getFrontPath()}/index-'+row.id+'" target="_blank" title="${fns:text("浏览站点")}"><i class="fa fa-globe"></i></a>&nbsp;');
			}//</shiro:hasPermission>
			return actions.join('');
		}}
	],
	ajaxSuccess: function(data){ // 加载成功后执行方法
		
	}
});
</script>