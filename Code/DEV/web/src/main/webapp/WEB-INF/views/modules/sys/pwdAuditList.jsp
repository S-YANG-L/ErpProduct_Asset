<%@ page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid" />
<sys:header title="密码审计" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"> <i class="fa fa-coffee"></i> 密码审计</div>
	</div>
	<div class="portlet-tabs" style="height: 0px">
		<ul class="nav nav-tabs">
			<li class=""><a href="#" onclick="refreshGrid(0)" data-toggle="tab">以上全部</a></li>
			<li class=""><a href="#" onclick="refreshGrid(4)" data-toggle="tab">长期未登录</a></li>
			<li class=""><a href="#" onclick="refreshGrid(3)" data-toggle="tab" title="未修改时间：与修改密码周期相同">定期未修改密码</a></li>
			<li class=""><a href="#" onclick="refreshGrid(2)" data-toggle="tab">使用简单密码 </a></li>		
			<li class="active"><a href="#" onclick="refreshGrid(1)" data-toggle="tab">未修改初始密码</a></li>			
		</ul>
 	</div>
	<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="actions">							
			<a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出">
				<i class="fa fa-external-link"></i> 导出
			</a>			
		</div>
	</div>
	<div class="portlet-body list">
		<sys:message content="${message}" />
		<form:form id="searchForm" modelAttribute="safetyAudit" action="${ctx}/sys/safetyAudit/pwdAudit/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
				<form:hidden path="auditType" />
		</form:form> 
		<table id="dataGrid"></table>
	    <div id="dataGridPage"></div>
	</div>
</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	//初始化DataGrid对象
	$("#dataGrid").dataGrid({
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		columnModel: [
			{header:'登录账号', name:'userCode', index:'u.user_code', width:90, align:"left"},
			{header:'用户名称', name:'userName', index:'u.user_name', width:80, align:"left"},
			{header:'组织机构', name:'officeName', index:'o.office_name', width:100, align:"left"},
			{header:'审计结果', name:'auditResult', sortable:false, width:200, align:"left"},
			{header:'账号创建时间', name:'createDate', index:'u.create_date', width:140, align:"center"},
		    {header:'密码最后修改时间', name:'pwdUpdateDate',index:'u.pwd_update_date', align:"center", width:140},
		    {header:'最后登录时间', name:'loginDate',index:'u.login_date', align:"center", width:140}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法	
		}
	});
	function refreshGrid(auditType){
		$("#auditType").val(auditType);
		$('#dataGrid').dataGrid("reloadGrid");
	};
	//数据导出
	$("#btnExport").click(function(){
		top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){			
			if(v=="ok"){
				ajaxDownload('${ctx}/sys/safetyAudit/pwdAudit/export',$("#searchForm").serialize());
			}
		},{buttonsFocus:1});
		top.$('.jbox-body .jbox-icon').css('top','55px');
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