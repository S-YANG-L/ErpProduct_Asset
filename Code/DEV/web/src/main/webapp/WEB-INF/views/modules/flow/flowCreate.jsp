<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="新建事宜" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i> 新建事宜</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="刷新"><i class="fa fa-refresh"></i> 刷新</a>
			<shiro:hasPermission name="flow:manager">
				<a href="#" class="btn btn-default btn-sm" id="btnUpdateCache" title="清理工作流缓存"><i class="fa fa-refresh"></i> 清理缓存</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body">
	    <c:forEach items="${result}" var="row" varStatus="status">
		    <div class="portlet " style="margin-bottom:20px;">
				<div class="portlet-title">
					<div class="caption"><i class="fa fa-cogs"></i> ${row.key}</div>
				</div>
				<div class="portlet-body">
		        	<c:forEach items="${row.value}" var="process" varStatus="status">
		        		<a class="btn default processStart" href="#" data-form-url="${ctx}${process.startFormUri}" 
		        			data-key="${process.key}" data-name="${process.name}"> <i class="fa fa-cogs"></i> ${process.name}</a> &nbsp;
		        	</c:forEach>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	$("#btnRefreshTree").click(function(){
		showMessage("页面已刷新。");
		location = "${ctx}/flow/create";
	});
	$(".portlet .processStart").click(function(){
		var key = $(this).data("key");
		var name = $(this).data("name");
		var formUrl = $(this).data("formUrl");
		var url = formUrl + (formUrl.indexOf("?")!= -1 ? "&" : "?") + "processDefinitionKey=" + key;
		addTabPage($(this), name, url, '${param.tabPageId}');
	});
	$("#btnUpdateCache").click(function(){
		ajaxSubmit("${ctx}/flow/clearCache", function(data){
			showMessage(data.message);
			location = "${ctx}/flow/create";
		});
	});
</script>