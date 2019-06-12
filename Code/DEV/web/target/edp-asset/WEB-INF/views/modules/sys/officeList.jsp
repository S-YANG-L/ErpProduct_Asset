<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid"/>
<sys:header title="机构管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${fns:text('机构管理')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="刷新"><i class="fa fa-refresh"></i> ${fns:text('全部')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExpandTreeNode" title="展开一级"><i class="fa fa-angle-double-down"></i> ${fns:text('展开')}</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCollapseTreeNode" title="折叠全部"><i class="fa fa-angle-double-up"></i> ${fns:text('折叠')}</a>
			<shiro:hasPermission name="sys:office:edit">
				<a href="${ctx}/sys/office/form" class="btn btn-default btn-sm btnTool" title="${fns:text('新增机构')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
			</shiro:hasPermission>
			<div class="btn-group">
				 <a class="btn btn-default btn-sm" href="#" data-toggle="dropdown"><i class="fa fa-cogs"></i> ${fns:text('工具')} <i class="fa fa-angle-down"></i></a>
				<ul class="dropdown-menu pull-right" style="width:100px;">
					<!-- <li><a href="#"> <i class="fa fa-pencil"></i> 导出</a></li> -->
					<li><a href="#" id="btnImport"> <i class="fa fa-pencil-square-o"></i> ${fns:text('导入')}</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div id="importBox" class="hide">
        <form:form id="importDataForm" action="${ctx}/sys/office/import" method="post" enctype="multipart/form-data"
                class="form-search" style="padding-left:20px;text-align:center;" onsubmit="" ><br/>
           <input id="uploadFile" name="file" type="file" style="width:330px;margin-left:100px;" /><br/><br/>
           <input id="btmImportSubmit" class="btn btn-primary" onclick="upload();" type="submit" value="${fns:text('导入数据')}" style="margin-left:43px;" />&nbsp;&nbsp;&nbsp;&nbsp;
           <a href="${ctxStatic}/modules/sys/office/机构导入模板.xlsx" style="margin-right:0px;" >${fns:text('下载模板')}</a>
        </form:form>
   </div>
   <sys:message content="${message}"></sys:message>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="office" action="${ctx}/sys/office/listData?managerDataScope=true" method="post" class="breadcrumb form-inline ${empty office.company.companyCode ? 'hide' : ''}">
			<div class="form-group">
				<label class="control-label">${fns:text('机构编码')}：</label>
				<div class="input-inline">
					<form:input path="id" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('机构名称')}：</label>
				<div class="input-inline">
					<form:input path="officeName" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('机构全称')}：</label>
				<div class="input-inline">
					<form:input path="fullName" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
				</div>
			</div>
			<c:if test="${fns:getModule('core_extend').isEnable}">
				<div class="form-group">
					<label class="control-label">${fns:text('所属公司')}：</label>
					<div class="input-inline width-160">
						<sys:treeselect id="officeCompany" name="company.companyCode" value="${office.company.companyCode}" labelName="company.companyName" labelValue="${office.company.companyName}" 
							title="${fns:text('公司')}" url="/sys/company/treeData" controlSize="sm" allowClear="true" notAllowSelectParent="false"/>
					</div>
				</div>
			</c:if>
			<div class="form-group"> &nbsp;&nbsp;
				<label class="control-label">${fns:text('状态')}：</label>
				<form:select path="status" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
				    <form:option  value="">${fns:text('全部')}</form:option>
					<form:options items="${fns:getDictList('search_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
			<div class="form-group" > &nbsp; &nbsp;
				<input class="btn btn-primary btn-sm" type="submit" value="${fns:text('查询')}"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="${fns:text('重置')}"/>
			</div>	
		</form:form>
		<table id="dataGrid"></table>
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
			{header:'${fns:text("机构名称")}', name:'officeName', width:200, formatter: function(val, obj, row, act){
				return '<span'+(row.status=='2'?' style="color:#aaa"':'')+'>( '+row.viewCode+' )</span> '
						+'<a href="${ctx}/sys/office/form?officeCode='+row.id+'" class="btnList"'
						+(row.status=='2'?' style="color:#aaa"':'')+' data-title="${fns:text("编辑机构")}">'+val+'</a>';
			}},
			{header:'${fns:text("机构全称")}', name:'fullName', width:150},
			{header:'${fns:text("备注")}', name:'remarks', width:100},
			{header:'${fns:text("排序")}', name:'sorts', width:50, align:"center"},
			{header:'${fns:text("类型")}', name:'type', width:90, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('sys_office_type')}, val, '${fns:text("未知")}', true);
			}},
			{header:'${fns:text("状态")}', name:'status', width:50, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('status')}, val, '${fns:text("未知")}', true);
			}},
			{header:'${fns:text("操作")}', name:'actions', width:120, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:office:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/office/form?officeCode='+row.id+'" class="btnList" title="${fns:text("编辑机构")}"><i class="fa fa-pencil"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:office:enable">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/office/disable?officeCode='+row.id+'" class="btnList" title="${fns:text("停用机构")}" data-confirm="${fns:text("确认要停用该机构吗")}？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:office:disable">
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/sys/office/enable?officeCode='+row.id+'" class="btnList" title="${fns:text("启用机构")}" data-confirm="${fns:text("确认要启用该机构吗")}？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:office:edit">
				actions.push('<a href="${ctx}/sys/office/delete?officeCode='+row.id+'" class="btnList" title="${fns:text("删除机构")}" data-confirm="${fns:text("确认要删除该机构及所有子机构吗？")}" data-confirm-success="$(\'#dataGrid\').dataGrid(\'delTreeNode\',\''+row.id+'\');"><i class="fa fa-trash-o"></i></a>&nbsp;');
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/office/form?parentCode='+row.id+'" class="btnList" title="${fns:text("新增下级机构")}"><i class="fa fa-plus-square"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		treeGrid: true,			// 启用树结构表格
		defaultExpandLevel: 0,	// 默认展开的层次
		ajaxSuccess: function(data){ // 加载成功后执行方法

		}
	});
	
</script>
<!-- 导入按钮js -->
<script type="text/javascript">
    $("#btnImport").click(function(){
         $.jBox($("#importBox").html(),{title:"${fns:text('导入数据')}",buttons:{"${fns:text('关闭')}":true},bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件"});
    });
	//导入loading
	function upload(){
		$.jBox.tip("正在检查数据合法性并导入数据到数据库，请稍后...", 'loading');
	}
</script>
		