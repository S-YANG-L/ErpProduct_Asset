<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="SQL日志查询 " extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>查看日志详情</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="sys:logSql:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="logSql" action="${ctx}/sys/logSql/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 命令类型：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="cmdType" htmlEscape="false" maxlength="10" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								执行的SQL：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="executeSql" htmlEscape="true" rows="5" maxlength="4000" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<%-- <div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								参数映射属性：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="paramMapping" htmlEscape="true" rows="1" maxlength="2000" class="form-control"/>
							</div>
						</div>
					</div>
				</div> --%>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								提交的数据：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="paramObject" htmlEscape="true" rows="3" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								源码位置：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:input path="mapperId" htmlEscape="false" maxlength="2000" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								创建者：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="createBy.userCode" htmlEscape="false" maxlength="200" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								创建者姓名：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="createBy.userName" htmlEscape="false" maxlength="200" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								请求URI：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:input path="requestUri" htmlEscape="false" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								操作IP地址：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="remoteAddr" htmlEscape="false" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">响应时间</label>
							<div class="col-sm-8">
								<form:input path="executeTimeFormat" htmlEscape="false" maxlength="255" class="form-control" />
							</div>
						</div>
					</div>
				</div>
				<c:if test="${not empty tableName}">
					<h4 class="form-section">修改前的记录</h4>
					<table id="dataGrid"></table>
					<div id="dataGridPage"></div>
				</c:if>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:logSql:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
		<c:if test="${not empty tableName}">
			<form:form id="searchForm" modelAttribute="logSql" action="${ctx}/sys/logSql/listBackupData" method="post" class="breadcrumb form-inline hide"
					data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
				<input name="tableName" type="hidden" value="${tableName}"/>
				<input name="logSqlId" type="hidden" value="${logSql.id}"/>
			</form:form>
		</c:if>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
<c:if test="${not empty tableName}">
//初始化DataGrid对象
$("#dataGrid").dataGrid({
	
	searchForm: $("#searchForm"), // 数据来源表单
	tabPageId: '${param.tabPageId}',// 当前页签编号
	
	// 设置数据表格列
	columnModel: [
	    //<c:forEach items="${tableColumnList}" var="column">
	    {header:'${column.nameAndComments}', name:'${fn:toLowerCase(column.columnName)}', width:100, align:"left", formatter: function(val, obj, row, act){
			return 	<c:choose>
						<c:when test="${column.columnType eq 'timestamp'}">val?dateToStr(new Date(val)):''</c:when>
						<c:when test="${column.columnType eq 'datetime'}">val?dateToStr(new Date(val)):''</c:when>
						<c:otherwise>val||''</c:otherwise>
					</c:choose>;
		}},//</c:forEach>
		{header:'操作', name:'actions', width:150, hidden:true, sortable:false, formatter: function(val, obj, row, act){
			var actions = [];
			return actions.join('');
		}}
	],
	showCheckbox: true,
	shrinkToFit: false,
	ajaxSuccess: function(data){ // 加载成功后执行方法
		
	}
});
</c:if>
$("#inputForm").validate({
	submitHandler: function(form){
		ajaxSubmitForm($(form), function(data){
			showMessage(data.message);
			if(data.result == Global.TRUE){
				closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
					contentWindow.page();
				});
			}
		}, "json");
    }
});
</script>
