<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="信息量统计" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title dropdown">
		&nbsp;<div class="caption dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">
			<i class="fa fa-gear"></i> ${fnc:getSite(fnc:getCurrentSiteCode()).siteName} <b class="caret"></b>
		</div>
		<ul class="dropdown-menu">
			<c:forEach items="${fnc:getSiteList()}" var="site">
				<li><a href="${ctx}/cms/site/select?siteCode=${site.siteCode}&redirect=${fns:getAdminPath()}/cms/stats/article">
					<i class="fa fa-angle-right"></i> ${site.siteName}</a></li>
			</c:forEach>
		</ul>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="刷新"><i class="fa fa-refresh"></i> 全部</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExpandTreeNode" title="展开一级"><i class="fa fa-angle-double-down"></i> 展开</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCollapseTreeNode" title="折叠全部"><i class="fa fa-angle-double-up"></i> 折叠</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="category" action="${ctx}/cms/stats/articleData" method="post" class="breadcrumb form-inline "
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">访问时间：</label>
				<div class="input-inline">
					<input name="beginVisitTime" id="beginVisitTime" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate-date"
						value="${fns:formatDate(beginVisitTime, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					&nbsp;--&nbsp;
					<input name="endVisitTime" id="endVisitTime" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate-date"
						value="${fns:formatDate(endVisitTime, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					&nbsp;
					<div class="radio-list2 input-inline">
						<span><input id="quick1" name="quick" onclick="quickSelectDate(this.value, 'beginVisitTime', 'endVisitTime');" type="radio" value="1"/><label for="quick1">今日</label></span>
						<span><input id="quick2" name="quick" onclick="quickSelectDate(this.value, 'beginVisitTime', 'endVisitTime');" type="radio" value="2"/><label for="quick2">本周</label></span>
						<span><input id="quick3" name="quick" onclick="quickSelectDate(this.value, 'beginVisitTime', 'endVisitTime');" type="radio" value="3" checked="checked"/><label for="quick3">本月</label></span>
						<span><input id="quick4" name="quick" onclick="quickSelectDate(this.value, 'beginVisitTime', 'endVisitTime');" type="radio" value="4"/><label for="quick4">本季度</label></span>
						<span><input id="quick5" name="quick" onclick="quickSelectDate(this.value, 'beginVisitTime', 'endVisitTime');" type="radio" value="5"/><label for="quick5">上月</label></span>
					</div>
				</div>
			</div>
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>
		</form:form>
		<div class="row">
			<div class="col-sm-6">
				<div id="myChart"></div>
			</div>
			<div class="col-sm-6">
				<table id="dataGrid"></table>
			</div>
		</div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script src="${ctxStatic}/echarts/3.2/echarts.common.min.js"></script>
<script type="text/javascript">

	// 存放当前Grid加载的数据
	var dataMap = {},
	
	// 当前父栏目编码
	parentCode = '0',
	
	// 初始化DataGrid对象
	dataGrid = new DataGrid({
			
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		autoGridHeight: function(){
			var height = $(window).height() - $('#searchForm').height()
				- $('.portlet-title').height() - 105;
			$('#myChart').height(height + 30);
			if(myChart){ myChart.resize(); }
			return height;
		},
		
		// 设置数据表格列
		columnModel: [
	 		{header:'栏目名称', name:'categoryName', width:200, formatter: function(val, obj, row, act){
				return '( '+row.categoryCode+' ) '+(val ? val : row.id);
			}},
			{header:'信息量', name:'articleNum', width:80, align:"center"},
			{header:'访问量', name:'articleVisitNum', width:80, align:"center"},
			{header:'父栏目编码', name:'parentCode', hidden: true}
		],
		treeGrid: true,			// 启用树结构表格
		defaultExpandLevel: 0,	// 默认展开的层次
		onSelectRow: function(id, isSelect, event) {
			if (id){
				// 获取当前选择行的父栏目编码
				parentCode = $('#dataGrid').dataGrid('getRowData', id).parentCode;
			}
		 	// 获取当前栏目所在级别数据
		 	var data = dataMap[parentCode]; 
		 	myChartOpt.xAxis.data = [];
		 	myChartOpt.series[0].data = [];
		 	myChartOpt.series[1].data = [];
			for (var i=0; i<data.length; i++){
				myChartOpt.xAxis.data.push(data[i].categoryName);
				myChartOpt.series[0].data.push(data[i].articleNum);
				myChartOpt.series[1].data.push(data[i].articleVisitNum);
			}
			// 刷新图表
		 	myChart.setOption(myChartOpt);
		},
		ajaxSuccess: function(data){ // 加载成功后执行方法
			if(data.length > 0){
				// 当前级别栏目的父栏目编码
				parentCode = data[0].parentCode;
				// 存储当前级别栏目的数据
				dataMap[parentCode] = data;
				// 如果是根节点，则初始化设置并显示图表
				if (parentCode == '0'){
					$('#dataGrid').dataGrid('getParam', 'onSelectRow')();
				}
			}
		}
	}),
	
	// 初始化ECharts图表
	myChart = echarts.init(document.getElementById('myChart')),
	
	// ECharts配置选项
	myChartOpt = {
		color: ['#367FA9', '#3398DB', '#00A65A'],
		tooltip: {
	        trigger: 'axis', axisPointer : { type : 'shadow' }
		},
	    grid: {
	        left: '4%', right: '4%', bottom: '3%', containLabel: true
	    },
	    title: {
	        text: '栏目访问统计', x: '15px', y: '10px',
	    },
		legend: {
		    data:['信息量','访问量'], x: 'center', y: '12px',
		},
		xAxis: {
		    data: [],
		},
		yAxis: {},
		series: [{
		    name: '信息量', type: 'bar', data: []
		},{
		    name: '访问量', type: 'bar', data: []
		}]
	};
	
</script>