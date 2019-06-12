<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<c:set var="extHead">
<style type="text/css">
.dashboard-stat .details .number {padding-top:16px;line-height:40px;;}
.dashboard-stat.mini .details .number {font-size:20px;line-height:28px;padding-top:10px;}
.dashboard-stat.mini .details .desc {font-size:14px;}
</style>
</c:set>
<sys:header title="访问概况" extLibs="${extLibs}" extHead="${extHead}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa icon-bar-chart"></i> 访问概况</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="cms:visitLog:edit">
				<a href="${ctx}/cms/visitLog/form" class="btn btn-default btn-sm btnTool" title="新增日志"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="visitLog" action="${ctx}/cms/visitLog/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<%-- <div class="form-group">
				<label class="control-label">访问来源类型（1直接访问 2搜索引擎 3外部链接 4内部访问）：</label>
				<div class="input-inline">
					<form:select path="sourceType" class="form-control input-sm width-160">
						<form:option value="" label="全部"/>
						<form:options items="${fns:getDictList('cms_visit_source_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div> --%>
			<div class="form-group">
				<label class="control-label">访问时间：</label>
				<div class="input-inline">
					<input name="beginVisitTime" id="beginVisitTime" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate-date"
						value="${fns:formatDate(visitLog.beginVisitTime, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					&nbsp;--&nbsp;
					<input name="endVisitTime" id="endVisitTime" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate-date"
						value="${fns:formatDate(visitLog.beginVisitTime, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					&nbsp;
					<div class="radio-list2 input-inline">
						<span><input id="quick1" name="quick" onclick="quickSelectDate(this.value,'beginVisitTime','endVisitTime');$(this).parents('form').submit()" type="radio" value="1" checked="checked"/><label for="quick1">今日</label></span>
						<span><input id="quick2" name="quick" onclick="quickSelectDate(this.value,'beginVisitTime','endVisitTime');$(this).parents('form').submit()" type="radio" value="2"/><label for="quick2">本周</label></span>
						<span><input id="quick3" name="quick" onclick="quickSelectDate(this.value,'beginVisitTime','endVisitTime');$(this).parents('form').submit()" type="radio" value="3"/><label for="quick3">本月</label></span>
						<span><input id="quick4" name="quick" onclick="quickSelectDate(this.value,'beginVisitTime','endVisitTime');$(this).parents('form').submit()" type="radio" value="4"/><label for="quick4">本季度</label></span>
						<span><input id="quick5" name="quick" onclick="quickSelectDate(this.value,'beginVisitTime','endVisitTime');$(this).parents('form').submit()" type="radio" value="5"/><label for="quick5">上月</label></span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">站点名称：</label>
				<div class="input-inline">
					<select name="siteCode" class="form-control input-sm width-160" onchange="$(this).parents('form').submit()">
						<option value="">全部站点</option>
						<c:forEach items="${fnc:getSiteList()}" var="site">
							<option value="${site.siteCode}">${site.siteName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>
		</form:form>
		<div class="row">
			<div class="col-sm-2 col-xs-4">
				<div class="dashboard-stat blue-madison">
					<div class="visual">
						<i class="fa fa-comments"></i>
					</div>
					<div class="details">
						<div class="number" id="count_pv">*</div>
						<div class="desc" title="即通常说的Page View(PV)，用户每打开一个网站页面就被记录1次。用户多次打开同一页面，浏览量值累计。">浏览量（PV）</div>
					</div>
				</div>
			</div>
			<div class="col-sm-2 col-xs-4">
				<div class="dashboard-stat green-haze">
					<div class="visual">
						<i class="fa fa-bar-chart-o"></i>
					</div>
					<div class="details">
						<div class="number" id="count_fv">*</div>
						<div class="desc" title="访客在您网站上的会话(Session)次数，一次会话过程中可能浏览多个页面。
如果访客连续30分钟没有新开和刷新页面，或者访客关闭了浏览器，则当访客下次访问您的网站时，访问次数加1。">访问次数</div>
					</div>
				</div>
			</div>
			<div class="col-sm-2 col-xs-4">
				<div class="dashboard-stat red-intense">
					<div class="visual">
						<i class="fa fa-group"></i>
					</div>
					<div class="details">
						<div class="number" id="count_uv">*</div>
						<div class="desc" title="一天之内您网站的独立访客数(以Cookie为依据)，一天内同一访客多次访问您网站只计算1个访客。">访客数（UV）</div>
					</div>
				</div>
			</div>
			<div class="col-sm-2 col-xs-4">
				<div class="dashboard-stat purple-plum">
					<div class="visual">
						<i class="fa fa-tag"></i>
					</div>
					<div class="details">
						<div class="number" id="count_nv">*</div>
						<div class="desc" title="独立访客中，历史第一次访问您网站的访客数。 ">新访客数</div>
					</div>
				</div>
			</div>
			<div class="col-sm-2 col-xs-4">
				<div class="dashboard-stat blue-madison">
					<div class="visual">
						<i class="fa fa-globe"></i>
					</div>
					<div class="details">
						<div class="number" id="count_ipNum">*</div>
						<div class="desc" title="一天之内您网站的独立访问ip数。">IP 数</div>
					</div>
				</div>
			</div>
			<div class="col-sm-2 col-xs-4">
				<div class="dashboard-stat green-haze mini">
					<div class="visual">
						<i class="fa fa-tachometer"></i>
					</div>
					<div class="details">
						<div class="number">
							<span id="count_tiaochuPerc">0</span>%
							<br/> 
							<span id="count_shichangAvg">00:00:00</span></div>
						<div class="desc" title="跳出率：只浏览了一个页面便离开了网站的访问次数占总的访问次数的百分比。
平均访问时长：总访问页面的平均值"> 跳出率/平均访问时长</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row"><div class="col-xs-12">&nbsp;</div></div>
		<table id="dataGrid"></table>
	    <div id="dataGridPage"></div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	$('#searchForm').submit(function(){
		totalCount();
	});
	totalCount();
	function totalCount(){
		var data = $('#searchForm').serializeArray();
		$.post('${ctx}/cms/visitLog/totalCount', data,function(data){
			$('#count_pv').text(data.pv);
			$('#count_fv').text(data.fv);
			$('#count_uv').text(data.uv);
			$('#count_nv').text(data.nv);
			$('#count_ipNum').text(data.ipNum);
			$('#count_tiaochuPerc').text(data.tiaochuPerc);
			$('#count_shichangAvg').text(formatTime(data.shichangAvg));
		});
	}
	function formatTime(second) {
	    var h=0,i=0,s=parseInt(second) || 0;
	    if(s > 60){
	        i = parseInt(s/60);
	        s = parseInt(s%60);
	        if(i > 60) {
	            h = parseInt(i/60);
	            i = parseInt(i%60);
	        }
	    }
	    var zero=function(v){
	        return (v>>0)<10?"0"+v:v;
	    };
	    return [zero(h),zero(i),zero(s)].join(":");
	}
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
			{header:'页面标题', name:'title', index:'a.title', width:120, align:"left"},
			{header:'访问地址', name:'requestUrl', index:'a.request_url', width:130, align:"left"},
			{header:'访问来源', name:'sourceType', index:'a.source_type', width:30, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('cms_visit_source_type')}, val, '未知', true);
			}},
			{header:'新访问', name:'isNewVisit', index:'a.is_new_visit', width:25, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('yes_no')}, val, '未知', true);
			}},
			{header:'停留时间', name:'totalRemainTime', index:'a.total_remain_time', width:70, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return formatTime(val);
			}},
			{header:'访客IP', name:'remoteAddr', index:'a.remote_addr', width:110, fixed:true, align:"center"},
			{header:'访问时间', name:'visitTime', index:'a.visit_time', width:145, fixed:true, align:"center"},
			{header:'访问用户', name:'visitUserName', index:'a.visit_user_name', width:40, align:"center", formatter: function(val, obj, row, act){
				return val ? val : '匿名';
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>