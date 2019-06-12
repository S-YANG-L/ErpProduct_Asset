<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="留言管理" extLibs="${extLibs}" />
<style type="text/css">
		.ui-jqgrid tr.jqgrow td {
			white-space: nowrap;
			width: 100%;
			overflow: hidden;
			-o-text-overflow: ellipsis;
			text-overflow: ellipsis;
		}
	</style>
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-bullhorn"></i> ${fns:text('留言管理')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="guestbook" action="${ctx}/cms/guestbook/listData" method="post" class="breadcrumb form-inline"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">${fns:text('分类')}：</label>
				<form:select id="type" path="type" class="form-control width-95 input-sm" onchange="$(this).parents('form').submit()">
					<form:option value="" label="${fns:text('全部')}"/>
					<form:options items="${fns:getDictList('cms_guestbook')}" itemValue="value" itemLabel="label" htmlEscape="false"/>
				</form:select>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('内容')}：</label>
				<div class="input-inline width-80" >
					<form:input path="content" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
			<label class="control-label">${fns:text('状态')}：</label>
				<div class="input-inline width-320" >
					<form:radiobuttons path="status" onclick="$('#searchForm').submit();" items="${fns:getDictList('cms_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
			{header:'${fns:text("留言分类")}', name:'type', index:'type', width:80, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('cms_guestbook')}, val, '未知', true);
			}},
			{header:'${fns:text("留言内容")}', name:'content',sortable:false, title:false,width:200},
			{header:'${fns:text("留言人")}', name:'name', width:80, sortable:false,align:"center"},
			{header:'${fns:text("留言时间")}', name:'createDate', index:'a.create_date', width:150, align:"center"},
			{header:'${fns:text("回复内容")}', name:'reContent', sortable:false,title:false,width:200},
			{header:'${fns:text("回复人")}', name:'reUser.userName', sortable:false,width:80, align:"center"},
			{header:'${fns:text("回复时间")}', name:'reDate', index:'a.re_date', width:150, align:"center"},
			{header:'${fns:text("操作")}', name:'actions', width:110, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				//<shiro:hasPermission name="cms:guestbook:edit">
				var status=row.status;
				if (status == '4'){
					actions.push('<a href="${ctx}/cms/guestbook/form?id='+row.id+'" class="btnList" title="${fns:text("审核")}"><i class="fa fa-pencil"></i></a>&nbsp;');
				}else{
					var url =status!=0  ? '&isRe=true' : '';
					var t=status!=0  ? '${fns:text("恢复")}' : '${fns:text("删除")}';
					var icoclass=status!=0  ? 'glyphicon glyphicon-ok-circle' : 'fa fa-trash-o';
					actions.push('<a href="${ctx}/cms/guestbook/delete?id='+row.id+url+'" class="btnList" title="'+t+'${fns:text("该审核")}" data-confirm="${fns:text("确认要")}'+t+'${fns:text("该审核吗")}？"><i class="'+icoclass+'"></i></a>&nbsp;');
				}
				//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		showRownum: false,
		subGrid: true,
		subGridRowExpanded: showChildGrid,
		ajaxSuccess: function(data){ // 加载成功后执行方法
		}
	});
	 function showChildGrid(parentRowID, parentRowKey) {
			var row=dataGrid.getRowData(parentRowKey);
			html=
				'<div class="form-body" style="overflow-x: hidden; overflow-y: auto;">' +
				'<div class="row">' + 
				'<div class="col-sm-12" ><b>${fns:text("留言内容")}：</b>' + row.content+'</div>' + 
				'</div>' + 
				'<div class="row">' + 
				'<div class="col-sm-12"><b>${fns:text("回复内容")}：</b>' + row.reContent+'</div>' + 
				'</div>' + 
				'</div>';

		 $("#" + parentRowID).append(html);
     }
</script>