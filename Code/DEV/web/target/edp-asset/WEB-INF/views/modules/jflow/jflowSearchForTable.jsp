<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="流程发起" extLibs="${extLibs}" />
<style type="text/css">
	table {margin: 0px;padding: 0px;}
	table tr>td,table tr>th {background-color:#F9F9F9;}
	table tr:nth-child(odd)>td,table tr:nth-child(odd)>th {background-color:#F2F2F2;}
	table td{font-family:Microsoft YaHei;padding:10px;}
	table th{font-family:Microsoft YaHei;padding:5px 10px;}
	ul {margin-left: -10px;margin-top: 2px;font: 12px 宋体, Arial, Verdana;}
	ul li {list-style-image: url(Port/Img/li_q_4.gif);line-height: 22px;height: 22px;margin-top: 3px;}
	span {font-size: 16px;font-family: Vijaya;margin-right: 5px;}
	.noHaveIt {color: Red;} .haveIt {color: Blue;}
	caption {background: url(Port/Img/TitleBG.png);}
	.CaptionMsg {background: url(Port/Img/TitleMsg.png);}
</style>
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i> 流程发起</div>
	</div>
	<div class="portlet-body list">
		${listString }
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	//页面链接统一调用方法，JZFlowModel封装方法       裴孝峰  BY  2016-6-15
    function winOpen(url,tbName) {
        addTabPage(null, tbName,url);
    }
</script>