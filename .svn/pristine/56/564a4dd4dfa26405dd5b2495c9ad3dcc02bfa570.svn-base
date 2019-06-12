<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${fns:text('员工管理')}" extLibs="${extLibs}" />
<div id="importBox" class="hide">
	<form id="importForm" action="${ctx}/sys/employee/import" method="post" enctype="multipart/form-data"
		class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
		<div class="form-group"><input id="uploadFile" name="file" type="file" style="width:350px"/><br/>
		<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
		<a href="${ctx}/sys/employee/import/template">${fns:text('下载模板')}</a>
		</div>
	</form>
</div>
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="glyphicon glyphicon-user"></i> ${fns:text('员工管理')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
			<shiro:hasPermission name="sys:employee:edit">
				<a href="${ctx}/sys/employee/form" class="btn btn-default btn-sm btnTool" title="${fns:text('新增员工')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
			</shiro:hasPermission>
			<div class="btn-group">
				<!-- <a class="btn btn-default btn-sm" href="#" data-toggle="dropdown"><i class="fa fa-cogs"></i> 工具 <i class="fa fa-angle-down"></i></a>
				<ul class="dropdown-menu pull-right" style="width:100px;">
					<li><a href="#" id="btnExport" > <i class="fa fa-external-link"></i> 导出</a></li>
					<li><a href="#"  id="btnImport" > <i class="fa fa-pencil-square-o"></i> 导入</a></li>
				</ul> -->
			</div>
		</div>
	</div>
	<div class="portlet-body list">
		<sys:message content="${message}"/>
		<form:form id="searchForm" modelAttribute="employee" action="${ctx}/sys/employee/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">${fns:text('员工姓名')}：</label>
					<form:input path="empName" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('所属公司')}：</label>
				<div class="input-inline width-160">
					<sys:treeselect id="company" name="companyCode" value="" labelName="company.companyName" labelValue="" 
						title="公司" url="/sys/company/treeData" controlSize="sm" allowClear="true"/>
				</div>
			</div>	
			<div class="form-group">
				<label class="control-label">${fns:text('岗位')}：</label>
				<form:select path="postCode" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
				    <form:option  value="">${fns:text('全部')}</form:option>
					<form:options items="${allPosts}" itemLabel="postName" itemValue="postCode" htmlEscape="false"/>
				</form:select>
			</div>	
			<div class="clearfix"></div>
			<div class="form-group">
				<label class="control-label">${fns:text('员工编码')}：</label>
					<form:input path="empNo" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('所属机构')}：</label>
				<div class="input-inline width-160">
					<sys:treeselect id="office" name="officeCode" value="" labelName="office.officeName" labelValue="" 
						title="${fns:text('机构')}" url="/sys/office/treeData" controlSize="sm" allowClear="true"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('状态')}：</label>
				<form:select path="status" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
				    <form:option  value="">${fns:text('全部')}</form:option>
					<form:options items="${fns:getDictList('emp_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>	
			<div class="form-group" > &nbsp;&nbsp;
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
	//初始化DataGrid对象
	$('#dataGrid').dataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'${fns:text("员工姓名")}', name:'empName', index:'emp_name', width:100, align:"center", frozen:true , formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/employee/form?empCode='+row.id+'" class="btnList" data-title="${fns:text("编辑员工")}">'+val+'</a>';
			}},
			{header:'${fns:text("员工编码")}', name:'empNo', index:'emp_no', width:100, align:"center"},
			//<c:if test="${fns:getModule('core_extend').isEnable}">
			{header:'${fns:text("所属公司")}', name:'company.companyNameSimple', index:'c3.company_name_simple', width:160, align:"center"},//</c:if>
			{header:'${fns:text("组织机构")}', name:'office.officeName', index:'o2.office_name', width:160, align:"center"},
			{header:'${fns:text("手机号码")}', name:'mobile', index:'mobile', width:130, sortable:false},
			{header:'${fns:text("电话号码")}', name:'officePhone', index:'office_phone', width:130, sortable:false},
			{header:'${fns:text("电子邮箱")}', name:'email', index:'email', width:180, sortable:false},
			{header:'${fns:text("状态")}', name:'status', index:'status', width:50, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('emp_status')}, val, '未知', true);
			}},
			{header:'${fns:text("操作")}', name:'actions', width:130, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:employee:edit">
				actions.push('<a href="${ctx}/sys/employee/form?empCode='+row.id+'" class="btnList" title="${fns:text("编辑员工")}"><i class="fa fa-pencil"></i></a>&nbsp;');
				//</shiro:hasPermission><shiro:hasPermission name="sys:employee:delete">
				actions.push('<a href="${ctx}/sys/employee/delete?empCode='+row.id+'" class="btnList" title="${fns:text("删除员工")}" data-confirm="${fns:text("确认要删除该员工吗")}？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				//</shiro:hasPermission><shiro:hasPermission name="sys:employee:leave">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/employee/leave?empCode='+row.id+'" class="btnList" title="${fns:text("员工离职")}" data-confirm="${fns:text("确认要离职该员工吗")}？"><i class="fa fa-stop"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				if (row.status == Global.STATUS_NORMAL){
					//<shiro:hasPermission name="sys:user:view">
					actions.push('<a href="${ctx}/sys/user/list?refCode='+row.id+'" class="btnList" title="查找'+row.empName+'员工的用户"><i class="fa fa-user"></i></a>&nbsp;');
					//</shiro:hasPermission><shiro:hasPermission name="sys:secAdminUser:view">
					actions.push('<a href="${ctx}/sys/secAdminUser/list?refCode='+row.id+'" class="btnList" title="查找'+row.empName+'员工的二级管理员"><i class="fa fa-user-md"></i></a>&nbsp;');
					//</shiro:hasPermission>
				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
	$("#btnExport").click(function(){
		top.$.jBox.confirm("确认要导出员工数据吗？","系统提示",function(v,h,f){
			if(v=="ok"){
				ajaxDownload('${ctx}/sys/employee/export',$("#searchForm").serialize());
			}
		},{buttonsFocus:1});
		top.$('.jbox-body .jbox-icon').css('top','55px');
	});
	
	$("#btnImport").click(function(){
		$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
			bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
	});

	/**
	 * Ajax 文件下载   ajaxDownload('ExcelDownload.do','find=commoncode','post' );
	 * @param url
	 * @param data
	 * @param method
	 */
	function ajaxDownload(url, data, method) {
		// 获取url和data
		if (url && data) {
			// data 是 string 或者 array/object
			data = typeof data == 'string' ? data : jQuery.param(data);
			// 把参数组装成 form的 input
			var inputs = '';
			$.each(data.split('&'), function() {
				var pair = this.split('=');
				inputs += '<input type="hidden" name="' + pair[0] + '" value="'
						+ pair[1] + '" />';
			});
			// request发送请求
			$('<form action="' + url + '" method="' + (method || 'post')
					+ '" >' + inputs + '</form>').appendTo('body').submit().remove();
		}
	}
</script>