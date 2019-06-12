<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="Bug排名统计" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>Bug排名统计</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="bugState" action="${ctx}/sys/log/listDataBug" method="post" class="breadcrumb form-inline hide2"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="row">
				<div class="form-group">
					<label class="control-label">菜单名称：</label>
					<div class="input-inline">
						<form:input path="menuName" htmlEscape="false" maxlength="500" class="form-control input-sm width-120"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label">URL：</label>
					<div class="input-inline">
						<form:input path="url" htmlEscape="false" maxlength="64" class="form-control input-sm width-120"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label">日期范围：</label>
					<div class="input-inline">
						<input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="30" class="form-control input-sm Wdate-date"
							value="<fmt:formatDate value="${bugState.beginDate}" pattern="yyyy-MM-dd"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,onpicked:function(){endDate.click()}});"/>
						<label>&nbsp;--&nbsp;&nbsp;</label>
						<input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="30" class="form-control input-sm Wdate-date"
							value="<fmt:formatDate value="${bugState.endDate}" pattern="yyyy-MM-dd"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</div>
				</div>
				<label for="exception"> &nbsp; &nbsp; <input id="exception" name="exception" type="checkbox"${bugState.exception eq '1'?' checked':''} value="1"/>只查询异常信息</label>
				<div class="form-group" style="margin-left:10px;"> &nbsp; 
					<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
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
			{header:'菜单名称', name:'menuName', index:'a.title', width:150, align:"left", formatter: function(val, obj, row, act){
				return '<a href="javascript:void(0);" onclick="tabLog(\''+row.menuName+'\',\''+row.url+'\')" title="查询系统日志">'+val+($("#exception").is(":checked") ? '【有异常】' : '')+'</a>';
			}},
			{header:'URL', name:'url', index:'a.request_uri', width:200, align:"left"},
			{header:'Bug数/访问数', name:'bugNum', index:'a.bug_num', width:100, align:"center", formatter: function(val, obj, row, act){
				return '<a href="javascript:void(0);" onclick="tabLog(\''+row.menuName+'\',\''+row.url+'\')" title="查询系统日志">'+val+'</a>';
			}}
			
		],
		lazyLoad: true,
		ajaxSuccess: function(data){ // 加载成功后执行方法
			 //$('#dataGrid').dataGrid('mergeCell','menuName');
		}
	});
	// 跳转到系统日志界面
	function tabLog(title,url){
		var exception= '';
		if($("#exception").is(":checked")){
			exception = '1';
		}
		top.addTabPage(top.$(this), '系统访问日志','${ctx}/sys/log/list?title='+title+'&beginDate='+$("#beginDate").val()+'&endDate='+$("#endDate").val()+'&exception='+exception+'&requestUri='+url);
	}
</script>