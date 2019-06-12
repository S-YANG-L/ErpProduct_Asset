<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${fns:text('评论管理')}" extLibs="${extLibs}" />
<style type="text/css">
	.ui-jqgrid tr.jqgrow td {white-space: nowrap;width: 100%;overflow: hidden;-o-text-overflow: ellipsis;text-overflow: ellipsis;}
	.ui-jqgrid .tablediv {padding:8px;}
	.reply {padding:5px 10px;background:rgba(185, 185, 185, 0.2);}
</style>
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-bullhorn"></i> ${fns:text('评论管理')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="comment" action="${ctx}/cms/comment/listData" method="post" class="breadcrumb form-inline"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">${fns:text('文档标题')}：</label>
				<div class="input-inline width-160" >
					<form:input path="title" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
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
			{header:'${fns:text("评论内容")}', name:'content', index:'a.content', width:280},
			{header:'${fns:text("文档标题")}', name:'title', index:'a.title', width:230, sortable:false, formatter: function(val, obj, row, act){
// 				return '<a href="${ctxPath}${fns:getFrontPath()}/view-'+row.category.categoryCode+'-'+row.contentId+'${fns:getUrlSuffix()}" title="'+val+'" onclick="return view(this.href);">'+val+' </a>';	
				return '<a href="${ctx}/cms/article/${canAdmin eq "true" ? "form" : "view"}?id='+row.contentId+'" title="'+val+'" onclick="return view(this.href);">'+(val ? val : row.id)+'</a>';
			}},
			{header:'${fns:text("评论人")}', name:'name', index:'a.name', width:80, align:"center"},
			{header:'${fns:text("评论IP")}', name:'ip', index:'a.ip', width:80, align:"center"},
			{header:'${fns:text("评论时间")}', name:'createDate', index:'a.create_date', width:120, align:"center"},
			{header:'${fns:text("操作")}', name:'actions', width:60, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				//<shiro:hasPermission name="cms:comment:edit">
				var status=row.status;
				if (status == '4'){
					actions.push('<a href="${ctx}/cms/comment/save?id='+row.id+'" class="btnList" title="${fns:text("审核通过")}" data-confirm="${fns:text("确认要审核通过该评论吗")}？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/cms/comment/delete?id='+row.id+'" class="btnList" title="${fns:text("删除评论")}" data-confirm="${fns:text("确认要删除该审核吗")}？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}else{
					var url = status!=0  ? '&isRe=true' : '', t = status!=0  ? '${fns:text("恢复")}' : '${fns:text("删除")}';
					var icoclass = status!=0 ? 'glyphicon glyphicon-ok-circle' : 'fa fa-trash-o';
					actions.push('<a href="${ctx}/cms/comment/delete?id='+row.id+url+'" class="btnList" title="'+t+'${fns:text("该审核")}" data-confirm="${fns:text("确认要")}'+t+'${fns:text("该审核吗")}？"><i class="'+icoclass+'"></i></a>&nbsp;');
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
	// 显示子表格
	function showChildGrid(parentRowID, parentRowKey) {
		var row = dataGrid.getRowData(parentRowKey);
		$("#" + parentRowID).append(row.content);
    }
	// 查看文章
	function view(href){
		var $jBox = getJBox();
		$jBox.open('iframe:'+href,'${fns:text("查看文档")}',$(top.document).width()-220,$(top.document).height()-120,{
			buttons:{"${fns:text('关闭')}":true},
			loaded:function(h){
				var cont = h.find('iframe').contents();
				cont.find('.portlet-title,.form-actions').hide();
			}
		});
		return false;
	}
</script>