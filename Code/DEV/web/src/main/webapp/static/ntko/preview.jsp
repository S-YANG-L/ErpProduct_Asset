<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>在线预览 - ${fns:getConfig('productName')}</title>
	<meta http-equiv="Expires" content="0">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-store">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctxStatic}/ntko/officecontrol/ntkoofficecontrol.js"></script>
	<script type="text/javascript">
		var ctxStatic = '${ctxStatic}';
		var docType = "${docType}";
		var docPath = window.location.href.replace('?preview=ntko&', '?')
				.replace('?preview=ntko', '').replace('&preview=ntko', '');
	</script>
</head>
<body style="margin:0">
	<div id="officeControl">
		<script type="text/javascript">
			if (docType == 'doc' || docType == 'xls' || docType == 'ppt'
					|| docType == 'wps' || docType == 'pdf' || docType == 'tif'){
				var ntko = ntkoOfficeControl({
					props: {
						WebUserName: "Ecode",
						Menubar: "true",
						ToolBars: "false",
						Statusbar: "false",
						ProductCaption: "山东易科德开发版",
						ProductKey: "9861616DD0444E1DCC56D157063FC89C7D1A98B0"
					}
				});
				// 异步打开一个文档
				ntko.BeginOpenFromURL(docPath, true, true);
				// 自动调整控件高度
				$(document).ready(function(){
					$(window).resize(function(){
						$('#officeControl').height($(window).height()-28);
					}).resize();
				});
			}else if (docType == 'img'){
				//document.write('<center><img src="'+docPath+'" style="padding:30px;width: 80%; top: 0px; height:80%"/></center>');
				document.write('<center><img src="'+docPath+'" style="padding:10px;max-width:800px;height:auto;"/></center>');
			}
		</script>
	</div>
	<div style="font-size:13px;line-height:24px;">
		&nbsp; <a href="javascript:" onclick="window.location.href=docPath;return false;">下载文件到本地硬盘</a>
		&nbsp; <a href="javascript:" onclick="window.location.href='${ctxStatic}/ntko/officecontrol/OfficeControl.zip';return false;">下载浏览器预览插件</a>
	</div>
</body>
</html>