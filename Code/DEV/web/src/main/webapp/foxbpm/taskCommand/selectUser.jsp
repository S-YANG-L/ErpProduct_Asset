<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extHead">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/color_red.css">
	<script src="js/foxbpmframework.js?${_version}"></script>
</c:set>
<sys:header title="选择用户" extLibs="custom,jquery" extHead="${extHead}"/>
<div id="search" class="search">
	<input type="hidden" name="action" value="selectUserList" />
	<table width="100%">
		<tr>
			<td class="title-r">用户姓名：</td>
			<td style="width: 120px">
				<input type="text" id="userName" class="fix-input" style="width: 100px;" value="" />
			</td>
			<td class="title-r">用户编号：</td>
			<td style="width: 120px">
				<input type="text" id="userId" class="fix-input" style="width: 100px;" value="" />
			</td>
			<td style="width: 70px">
				<div class="btn-normal">
					<a href="javascript:void(0)" id="searchBtn">查找</a>
				</div>
			</td>
			<td>
				<div class="btn-normal">
					<a href="javascript:void(0)" id="ok">确定</a>
				</div>
			</td>
		</tr>
	</table>
</div>
<div id="userList" class="content"></div>
<script type="text/javascript">
	function applyData(params){
		$.ajax({
	        type: "get",//使用get方法访问后台
	        dataType: "json",//返回json格式的数据
	        url: params.url,//要访问的后台地址_bpmServiceUrl + "/identity/allUsers"
	        data: params,
	        success: function(msg){//msg为返回的数据，在这里做数据绑定
	            var data = msg.data;
	            var dataTable = $("<table id='dataList' width='100%' class='fix-table'></table>");
	            var dataThead = $("<thead><th style='width: 50%;'>用户姓名</th><th style='width: 50%;'>用户编号</th></thead>");
	            dataThead.appendTo(dataTable);
	            var dataTbody = $("<tbody></tbody>");
	            //画任务命令
	            $.each(data, function(i, n){
	                var dataTr = $("<tr></tr>");
	               	dataTr.attr("data-rowData",n.userId);
	                dataTr.append($("<td align='center'></td>").append(n.userName)).append($("<td align='center'></td>").append(n.userId));
	                dataTbody.append(dataTr);
	            });
	            
	            dataTable.append(dataTbody);
	            $("#userList").html(dataTable);
	            $("table#dataList tr").click(function() {
	        		$("table#dataList tr.selected").removeClass("selected");
	        		$(this).addClass("selected");
	        	});
	        },
	        error:function(mes){
	       	 	alert(mes.responseText);
	        }
		 });
	}
	$(document).ready(function() {
		var dialog = frameElement.dialog; 
		var obj = dialog.get("data");
		var params = {};
		params.url = obj.params.url;
		applyData(params);
		$("#ok").click(function() {
			var rv = null;
			$("table#dataList tr.selected").each(function(index) {
				rv = $(this).attr("data-rowData");
			});
			if(obj.fn){
				obj.fn(obj.params, rv);
			}
			dialog.close()
		});
		
		$("#searchBtn").click(function(){
			var params = {};
			params["id"] = $("#userId").val();
			params["name"] = $("#userName").val();
			params["url"] = obj.params.url;
			applyData(params);
		});
	});
</script>