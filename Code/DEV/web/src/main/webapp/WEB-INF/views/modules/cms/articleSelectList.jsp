<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${article.category.categoryName}" extLibs="${extLibs}" />
<div class="portlet box">
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="article" action="${ctx}/cms/article/listData" method="post" class="breadcrumb form-inline"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">${fns:text('所属栏目')}：</label>
				<div class="input-inline width-160" >
					<sys:treeselect id="category" name="category.categoryCode" value="${article.category.categoryCode}" labelName="category.categoryName" labelValue="${article.category.categoryName}"
						title="栏目" url="/cms/category/treeData" module="article" notAllowSelectRoot="false" cssClass="input-small"/>
				</div>
			</div>
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
	var retIds = [], retRows = [];
	// 初始化DataGrid对象
	var dataGrid = new DataGrid({
			
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'${fns:text("标题")}', name:'title', index:'title', width:400, formatter: function(val, obj, row, act){
// 				return '<a href="${pageContext.request.contextPath}${fns:getFrontPath()}/view-'+getVal(row, 'category.categoryCode')+'-'+row.id+'" target="_blank" data-click-binded="true" class="btnList" title="浏览${article.category.categoryName}">'+(val ? val : row.id)+'</a>';
				return '<a href="${ctx}/cms/article/view?id='+row.id+'" title="'+val+'" onclick="return view(this.href);">'+(val ? val : row.id)+'</a>';
			}},
			{header:'${fns:text("栏目")}', name:'category.categoryName', index:'c.category_name', width:130, align:'center'},
			{header:'${fns:text("权重")}', name:'weight', index:'weight', width:50, fixed:true, align:'center', fixed:true},
			{header:'${fns:text("点击数")}', name:'hits', index:'hits', width:50, fixed:true, align:'center', fixed:true},
			{header:'${fns:text("状态")}', name:'status', index:'a.status', width:50, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('cms_status')}, val, '未知', true);
			}},
			{header:'${fns:text("创建者")}', name:'createByName', width:75, sortable:false, align:'center', fixed:true},
			//{header:'${fns:text("创建时间")}', name:'createDate', index:'a.create_date', width:95, align:"center", fixed:true},
			//{header:'${fns:text("更新者")}', name:'updateByName', width:75, sortable:false, align:'center', fixed:true},
			{header:'${fns:text("更新时间")}', name:'updateDate', index:'a.update_date', width:95, align:"center", fixed:true},
			{header:'${fns:text("行数据")}', name:'rowData', hidden:true, formatter: function(val, obj, row, act){
				return JSON.stringify(row);
			}}
		],
		multiboxonly: false,
		showCheckbox: '${param.mul}' == 'true',
		ajaxSuccess: function(data){ // 加载成功后执行方法
			// 选中默认值
			$.each(retIds, function(){
				dataGrid.setSelectRow(this);
			});
		},
		onSelectRow: function(id, sel, obj){
			// 如果是多选
			if ('${param.mul}' == 'true'){
				var idx = $.inArray(id, retIds);
				// 如果是选择，并没有添加过，则添加
				if (sel && idx == -1){ 
					retIds.push(id);
					retRows.push(JSON.parse(dataGrid.getRowData(id).rowData));
				}
				// 如果是取消选择，并添加过，则删除
				else if (!sel && idx != -1){
					retIds.splice(idx, 1);
					retRows.splice(idx, 1);
				}
			}
		},
		ondblClickRow: function(id, rownum, colnum, event){
			// 如果不是多选
			if ('${param.mul}' != 'true'){
				var $jBox = getJBox();
				$jBox.getBox().find("button[value='ok']").trigger("click");
			}
		}
	});
	function getDatas(){
		// 如果不是多选
		if('${param.mul}' != 'true'){
			var id = dataGrid.getSelectRow();
			if (id){
				retIds.push(id);
				retRows.push(JSON.parse(dataGrid.getRowData(id).rowData));
			}
		}
		return {ids: retIds, rows: retRows};
	}
	// 查看文章
	function view(href){
		var $jBox = getJBox();
		$jBox.open('iframe:'+href,'查看文档',$(top.document).width()-220,$(top.document).height()-120,{
			buttons:{"关闭":true},
			loaded:function(h){
				var cont = h.find('iframe').contents();
				cont.find('.portlet-title,.form-actions').hide();
			}
		});
		return false;
	}
</script>