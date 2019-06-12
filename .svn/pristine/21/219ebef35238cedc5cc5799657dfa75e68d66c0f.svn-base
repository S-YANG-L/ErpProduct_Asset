<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>打印文档 - ${fns:getConfig('productName')}</title>
	<meta name="renderer" content="ie-stand"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="Expires" content="0">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-store">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script language="javascript">
	
		// 批量打印地址
		var urls = [], baseUrl = document.location.protocol + "//" + window.location.host + "${ctx}";
// 		urls.push(baseUrl + "/sys/user/info;JSESSIONID=${cookie['SSESSIONID'].value}?qtype=0");
		urls.push(baseUrl + "/prg/project/clinic/projectPandect?projectInfo.projectCode=525908836604391424");
		urls.push(baseUrl + "/prg/project/society/projectPandect?projectInfo.projectCode=538166144698589184");
		
		function init(){

			// 设置控件大小
			resize(); 
			
			// 设置打印参数
// 	 		webPrn.SetPaperSize(9);  //a4 
// 	 		webPrn.SetCopies(1);     //2份 
// 	 		webPrn.SetTopMargin("2.0"); 
// 	 		webPrn.SetLeftMargin("2.0"); 
// 	 		webPrn.SetRightMargin("2.0"); 
// 	 		webPrn.SetBottomMargin("2.0"); 
// 	 		webPrn.SetPaperInfo();  //使设置生效 
			
			// 默认打开URL
			webPrn.LoadUrl = urls[0];
			webPrn.OpenUrl();
		}
		function webPrint(){

			// 批量打印
			webPrn.LoadBatchUrl = urls.join(','); //要打印的地址
			webPrn.PrintBatchWebPage(); //开始批量打印 
		
// 			// 单页打印
// 	 		webPrn.openUrl = urls[0]; //要打印的地址 
// 	 		webPrn.PrintWebPage(); //开始打印
		} 
// 		function getPrintStatus(){
// 			webPrn.MonitorPrinterStart(); //启动打印机状态监控
// 			setTimeout(function(){
// 				alert(webPrn.JobStatus);  //弹出打印机状态,在此处解析返回的状态,并作判定,决定下一步业务处理,这里示例只是简单的弹出,不作处理
// // 				alert(webPrn.JobCurrId);  //弹出打印队列中最后一个打印id 
// 			}, 500);
// 			webPrn.MonitorPrinterStop(); //中止打印机状态监控
// 		}
		function resize(){
			var webPrnObj = document.getElementById('webPrn');
			if (webPrn && webPrnObj){
				webPrnObj.style.height = document.documentElement.clientHeight - 230;
				setTimeout(function(){
					webPrn.ResizeWindow(document.body.clientWidth, document.documentElement.clientHeight - 230);
				}, 500);
			}
		}
		window.onresize = resize;
	</script> 
</head>
<body onload="init();">
	<strong>批量打印</strong>
	<script language="javascript">
		var s = "", clsid = "C204BA3C-EBEA-454B-BD4E-4F6A73E79CFD",
			attrs = "id='webPrn' style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT:70%'"
				+ " codebase='${ctxStatic}/webprint/vWebPrint.CAB#version=2,0,0,6'", 
			params = '<param name="lUser" value="系统管理员"></param>'
				+ '<param name="lUserNumer" value="30000"></param>'
				+ '<param name="lUserEndDate" value="2015-1-25"></param>'
				+ '<param name="showToolbar" value="false"></param>'
				+ '<param name="userId" value="system"></param>'; 
		if(navigator.userAgent.indexOf("MSIE")>0 || navigator.userAgent.indexOf("rv:11")>0){
			s = "<OBJECT align='middle' classid='clsid:" + clsid + "' " + attrs + ">" 
				+ params 
				+ "</OBJECT>";
		}
		if(navigator.userAgent.indexOf("Chrome")>0 || navigator.userAgent.indexOf("Firefox")>0){
			s = "<object type='application/x-itst-activex' align='baseline' border='0'"
				+ " clsid='{" + clsid + "}' " + attrs + ">"
				+ params
				+ "</object>";
		}
		document.write(s);
	</script>
	<div style="font-size:13px;line-height:24px;margin-top:10px;">
		<button onclick="webPrn.PrintSetup();">打印设置</button> &nbsp;
<!-- 		<button onclick="webPrn.PrintSetupWebPage()">打印当前页</button> &nbsp; -->
		<button onclick="webPrint()">开始批量打印</button> &nbsp;
		<p><strong>注意事项：</strong><br/>
		1、推荐使用IE浏览器，如果使用双核浏览器，请切换到IE模式下；<br/>
		2、首次使用需要安装打印插件，请先点击<a href="${ctxStatic}/webprint/vWebPrint.cer">这里下载</a>并安装数字证书；
			安装到第二步，请选择“将所有证书放入一下存储”选项，点击“浏览”，选择“受新人的根证书颁发机构”，完成安装。<br/>
		3、然后点击浏览器上方会弹出黄色提示，选择“为此计算机上的所有用户安装此加载项”或点击浏览器下方“安装”按钮，弹出的对话框再点击“安装”即可。<br/>
		4、打印设置可设置纸张、方向和边距，以及选择打印机，否则系统会选用默认打印机进行打印。</p>
	</div>
</body>
</html>