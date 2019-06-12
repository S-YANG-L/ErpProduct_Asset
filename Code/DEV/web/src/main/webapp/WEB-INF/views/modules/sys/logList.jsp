<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid,jBox"/>
<sys:header title="系统访问日志" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>系统访问日志</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCleanUpLog" title="清理日志"><i class="fa fa-refresh"></i> 清理日志</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="sysLog" action="${ctx}/sys/log/listData" method="post" class="breadcrumb form-inline hide2"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="row">
				<div class="form-group">
					<label class="control-label">操作菜单：</label>
					<div class="input-inline">
						<form:input path="title" htmlEscape="false" maxlength="500" class="form-control input-sm width-120"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label">操作用户：</label>
					<div class="input-inline">
						<form:input path="createBy.userCode" htmlEscape="false" maxlength="64" class="form-control input-sm width-120"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label">访问地址：</label>
					<div class="input-inline">
						<form:input path="requestUri" htmlEscape="false" maxlength="255" class="form-control input-sm width-120"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label">使用设备</label>
					<div class="input-inline">
						<form:input path="userAgent" htmlEscape="false" maxlength="100" class="form-control input-sm width-120"/>
					</div>
				</div>
				<label for="exception"> &nbsp; &nbsp; <input id="exception" name="exception" type="checkbox"${log.exception eq '1'?' checked':''} value="1"/>只查询异常</label>
				<label for="isUpdate"> &nbsp; &nbsp; <input id="isUpdate" name="isUpdate" type="checkbox"${log.isUpdate eq 'true'?' checked':''} value="true"/>只查询更新</label>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="control-label">操作者IP：</label>
					<div class="input-inline">
						<form:input path="remoteAddr" htmlEscape="false" maxlength="100" class="form-control input-sm width-120"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label">业务主键：</label>
					<div class="input-inline">
						<form:input id="bizKey" path="bizKey" htmlEscape="false" maxlength="100" class="form-control input-sm width-120"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label">业务类型：</label>
					<div class="input-inline">
						<form:input id="bizType" path="bizType" htmlEscape="false" maxlength="100" class="form-control input-sm width-120"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label">日期范围：</label>
					<div class="input-inline">
						<input name="beginDate" type="text" readonly="readonly" maxlength="30" class="form-control input-sm Wdate-date"
							value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,onpicked:function(){endDate.click()}});"/>
						<label>&nbsp;--&nbsp;&nbsp;</label>
						<input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="30" class="form-control input-sm Wdate-date"
							value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</div>
				</div>
				<div class="form-group" style="margin-left:10px;"> &nbsp; 
					<input class="btn btn-primary btn-sm" type="submit" id="btnSubmitSearch" value="查询"/>&nbsp;
					<input class="btn default btn-sm" type="reset" value="重置"/>
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
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
			{header:'操作功能菜单', name:'title', index:'a.title', width:230, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/log/form?id='+row.id+'" class="btnList" data-title="查看日志详情">'
						+ (val ? val : row.id) + (row.exception ? '【有异常】' : '') + '</a>';
			}},
			{header:'访问地址与单号', name:'requestUri', index:'a.request_uri', width:250, align:"left", formatter: function(val, obj, row, act){
				return (val ? val : row.id) + (row.bizKey ? '?id=' + row.bizKey : '');
			}},
			{header:'业务主键', name:'bizKey', index:'a.biz_key', width:80, align:"center", formatter: function(val, obj, row, act){
				return '<a href="javascript:void(0);" onclick="relatedLog(\''+(row.bizKey||'')+'\',\''+row.bizType+'\')" data-title="查看相关日志">'+(val?val:'')+'</a>';
			}},
			{header:'业务类型', name:'bizType', index:'a.biz_type', width:80, align:"center", formatter: function(val, obj, row, act){
				return '<a href="javascript:void(0);" onclick="relatedLog(\'\',\''+row.bizType+'\')" data-title="查看相关日志">'+(val?val:'')+'</a>';
			}},
			{header:'操作用户', name:'createByName', index:'a.create_by', width:80, align:"center"},
			{header:'操作者IP', name:'remoteAddr', index:'a.remote_addr', width:100, align:"center"},
			{header:'操作时间', name:'createDate', index:'a.create_date', width:100, align:"center"},
			{header:'使用设备', name:'deviceName', index:'a.device_name', width:80, align:"center"},
			{header:'浏览器', name:'browserName', index:'a.browser_name', width:80, align:"center"},
			{header:'响应时间', name:'executeTimeFormat', index:'a.execute_time', width:80, align:"center"}
		],
		lazyLoad: true,
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	// 清理日志
	$("#btnCleanUpLog").click(function(){
		jBox.confirm('确认要清理一年以内无参数的日志数据吗?', '提示', function (v, h, f) {
            if (v == 'ok') {
            	$.post("${ctx}/sys/log/cleanUpLog",function(data){
            		if(data.result == Global.TRUE){
            			$('#dataGrid').dataGrid("reloadGrid");
            		}
    				showMessage(data.message);
    			},"json");
				return true; 
            }
		});	
	});
	// 查看相关日志
	function relatedLog(bizKey,bizType){
		$("#bizKey").val(bizKey);
		$("#bizType").val(bizType);
		$("#btnSubmitSearch").click();
	}
	// 如果查询参数有地址，则直接查询
	if ('${log.requestUri}'!=''){
		$('#searchForm').submit();
	}
</script>