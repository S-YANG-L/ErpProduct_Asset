<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extHead">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/reset.css">
	<link rel="stylesheet" type="text/css" href="css/color_red.css">
	<script src="js/foxbpmframework.js?${_version}"></script>
</c:set>
<sys:header title="选择数据" extLibs="custom,jquery" extHead="${extHead}"/>
<div id="flowNodeList" class="content" style="padding:10px;"></div>
<%-- <div class="btn-normal" style="padding:10px;text-align:center;">
	<a href="javascript:void(0)" id="ok">确定</a>
</div> --%>
<script type="text/javascript">
function applyData(params){
	$.ajax({
        type: "get",//使用get方法访问后台
        dataType: "json",//返回json格式的数据
        url: params.url,//要访问的后台地址
        data:params.queryData,
        success: function(msg){//msg为返回的数据，在这里做数据绑定
        	var columnInfo = params.columnInfo;
        	var returnData = params.returnData;
            var data = msg.data;
            var dataTable = $("<table id='dataList' width='100%' class='fix-table'></table>");
            var dataThead = $("<thead></thead>");
			for(var i in columnInfo){
				if (i=='nodeId'){
					continue;
				}
        		var dataTh = $(" <th></th>").append(columnInfo[i]);
        		dataThead.append(dataTh);
        	}
            dataThead.appendTo(dataTable);
            var dataTbody = $("<tbody></tbody>");
            //画任务命令
            $.each(data, function(i, n){
                var dataTr = $("<tr></tr>");
                for(var k in returnData){
                	dataTr.attr(k,n[returnData[k]]);
                }
               
               	dataTr.attr("rollBackAssignee",n.assignee);
               	
               	for(var j in columnInfo){
    				if (j=='nodeId'){
    					continue;
    				}
            		var dataTd = $("<td align='center'></td>").append(n[j]);
            		dataTr.append(dataTd);
            	}
                dataTbody.append(dataTr);
            });
            
            dataTable.append(dataTbody);
            $("#flowNodeList").html(dataTable);
            $("table#dataList tr").click(function() {
        		$("table#dataList tr.selected").removeClass("selected");
        		$(this).addClass("selected");
        	});
        },
        error:function(mes){
        	alert(mes);
        }
	 });
}
<%--
// $(document).ready(function() {
// 	var dialog = frameElement.dialog; 
// 	var obj = dialog.get("data");
// 	applyData(obj.params);
// 	$("#ok").click(function() {
// 		var rv = null;
// 		$("table#dataList tr.selected").each(function(index) {
// 			rv = {};
// 			var returnData = obj.params.returnData;
// 			for(var i in returnData){
// 				rv[i] = $(this).attr(i);
// 			}
// 		});
// 		dialog.close()
// 		if(obj.fn){
// 			obj.fn(obj.params, rv);
// 		}
// 	});
// });
--%>
var data = ${param.data};

applyData(data);

function selectData(){
	var rv;
	$("table#dataList tr.selected").each(function(index) {
		rv = {};
		var returnData = data.returnData;
		for(var i in returnData){
			rv[i] = $(this).attr(i);
		}
	});
	return rv;
}
</script>