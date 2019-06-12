<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>在线预览 - ${fns:getConfig('productName')}</title>
	<meta http-equiv="Expires" content="0">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-store">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script language="javascript">
		var docType = "${docType}";
		var docPath = window.location.href.replace('?preview=true&', '?')
				.replace('?preview=true', '').replace('&preview=true', '');
		function WebOffice1_NotifyCtrlReady() {
			
			var webObj = document.all.WebOffice1;
			
			if (docType != 'doc' && docType != 'xls' && docType != 'ppt' && docType != 'wps'){
				webObj.ShowToolBar = !webObj.ShowToolBar; // 隐藏工具栏
			}else{
				webObj.HideMenuItem(0x01); // 隐藏新建按钮
				webObj.HideMenuItem(0x02); // 隐藏开始按钮
			}

			webObj.OptionFlag |= 128;
			webObj.LoadOriginalFile(docPath, docType); // 加载文档
			
			webObj.HideMenuArea('','','','');			// Office03菜单设置  隐藏所有 
			webObj.HideMenuArea('hideall','','','');	// Office07菜单设置  隐藏所有 
		}
	</script>
	<script language="javascript" event=NotifyCtrlReady for=WebOffice1>
//     	WebOffice_Event_Flash("NotifyCtrlReady");
    	WebOffice1_NotifyCtrlReady();
	</script>
</head>
<body style="margin:0">
	<script language="javascript">
		if (docType == 'doc' || docType == 'xls' || docType == 'ppt' || docType == 'wps' || docType == 'pdf'){
			var s = "", clsid = "E77E049B-23FC-4DB8-B756-60529A35FAD5",
				attrs = "id='WebOffice1' style='left: 0px; width: 100%; top: 0px; height:96%'"
					+ " codebase='${ctxStatic}/weboffice/WebOffice.cab#V7.0.0.8'";
			if(navigator.userAgent.indexOf("MSIE")>0 || navigator.userAgent.indexOf("rv:11")>0){
				s = "<object align='middle' classid='clsid:" + clsid + "' " + attrs + ">" 
					+ " <param name='_ExtentX' value='6350'><param name='_ExtentY' value='6350'>" 
					+ "</object>";
			}
			if(navigator.userAgent.indexOf("Chrome")>0 || navigator.userAgent.indexOf("Firefox")>0){
				s = "<object type='application/x-itst-activex' align='baseline' border='0'"
					+ " clsid='{" + clsid + "}' " + attrs 
			        + ' param_ExtentX="6350" param_ExtentY="6350"'
					+ " event_NotifyCtrlReady='WebOffice1_NotifyCtrlReady'>"
					+ "</object>";
			}
			document.write(s);
		}else if (docType == 'img'){
			document.write('<center><img src="'+docPath+'" style="padding:30px;width: 80%; top: 0px; height:80%"/></center>');
		}
	</script>
	<div style="font-size:13px;line-height:24px;">
		&nbsp; <a href="javascript:" onclick="window.location.href=docPath;return false;">下载文件到本地硬盘</a>
		&nbsp; <a href="javascript:" onclick="window.location.href='${ctxStatic}/weboffice/weboffice7-exe.rar';return false;">下载360火狐谷歌浏览器预览插件</a>
		&nbsp; <a href="javascript:" onclick="window.location.href='${ctxStatic}/weboffice/weboffice7-pdf.rar';return false;" >如不能预览PDF文件，请下载该软件并安装</a>
	</div>
</body>
</html>