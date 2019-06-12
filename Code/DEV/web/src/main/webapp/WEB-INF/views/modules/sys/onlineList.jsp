<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="在线人员" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-male"></i>在线人员</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="config" action="${ctx}/sys/online/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<!-- <div class="form-group">
				<label class="control-label">会话编码：</label>
					<input name="sessionId" maxlength="100" class="form-control input-sm width-160"/>
			</div> -->
			<div class="form-group">
				<label class="control-label">用户名称：</label>
				<div class="input-inline width-160" >
					<sys:treeselect id="user" name="userCode" value="" labelName="userName" labelValue=""
						title="用户" url="/sys/office/treeData?type=4" allowClear="true"
						cssClass="form-control input-sm"
						notAllowSelectParent="true" isAll="true"/>
				</div>
			</div>
			<div class="form-group">
				<div class="input-inline">
					<label class="control-label" for="excludeLeave" title="包含3分钟以上未操作的用户">
						<input id="excludeLeave" name="excludeLeave" type="checkbox" value="false"/>
						查询所有在线</label>
				</div>
			</div>
			<div class="form-group">
				<div class="input-inline" >
					<label class="control-label" for="excludeVisitor" title="包含未登录的用户">
						<input id="excludeVisitor" name="excludeVisitor" type="checkbox" value="false"/>
						查询游客用户</label>
				</div>
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
	//初始化DataGrid对象
	$('#dataGrid').dataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
// 		  	{header:'会话编码', name:'id', width:180, align:'center'},
  			{header:'用户编码', name:'userCode', width:100, align:'center'},
			{header:'用户名称', name:'userName', width:100, align:'center'},
			{header:'创建时间', name:'startTimestamp', width:100, align:'center'},
			{header:'最后访问', name:'lastAccessTime', width:100, align:'center'},
			{header:'超时时间', name:'timeout', width:100, align:'center'},
			{header:'客户主机', name:'host', width:70, align:'center'},
			/* {header:'用户类型', name:'userType', width:50, align:'center', formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('user_type')}, val, '员工', true);
			}}, */
			{header:'设备类型', name:'deviceType', width:50, align:'center', formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('device_type')}, val, 'PC', true);
			}}//<shiro:hasPermission name="sys:online:edit">
			,{header:'操作', name:'actions', width:50, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				actions.push('<a href="${ctx}/sys/online/tickOut?sessionId='+row.id+'" class="btnList" title="踢出在线用户" data-confirm="确认要踢出该用户在线状态吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				return actions.join('');
			}}//</shiro:hasPermission>
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	// 更新平台中的全部缓存，包含属性配置文件。
	$("#btnUpdateCache").click(function(){ 
		ajaxSubmit("${ctx}/sys/cache/clearAll", function(data){
			showMessage(data.message);
		});
	});
</script>