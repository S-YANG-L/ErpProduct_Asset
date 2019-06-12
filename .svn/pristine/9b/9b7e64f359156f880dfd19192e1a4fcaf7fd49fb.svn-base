<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="__sid" value="__sid=${cookie[fns:getConfig('session.sessionIdCookieName')].value}" />
<!DOCTYPE HTML>
<html>
<head>
	<title>打印文档 - ${fns:getConfig('productName')}</title>
	<meta name="renderer" content="ie-stand"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="Expires" content="0">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-store">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style type="text/css">
		@media print {
			.noprint {display:none;}
		}
	</style>
</head>
<body>
	<div class="noprint">
		<strong>帆软打印</strong>
		<div id="toolbar" style="margin:8px 0;">        
		    <!-- <button type="button" onclick="reportWindow.contentPane.gotoFirstPage()">首页</button>        
		    <button type="button" onclick="reportWindow.contentPane.gotoPreviousPage()">上一页</button>         
		    <button type="button" onclick="reportWindow.contentPane.gotoNextPage()">下一页</button>          
		    <button type="button" onclick="reportWindow.contentPane.gotoLastPage()">末页</button>   
		    <input id="page" type="text" readonly="readonly" size="12" style="border:none">到<input id ="index" type ="text" size="3"/>页 
			<button type="button" onclick="gotopage()" >跳转</button> -->
			<!-- <button type="button" onclick="reportWindow.contentPane.exportReportToPDF()">导出PDF</button> 
			<button type="button" onclick="reportWindow.contentPane.flashPrint()">Flash打印</button>  -->
			<button type="button" onclick="webPrint()">Web打印</button> 
		</div>
	</div>
	<div style="width:100%;text-align:center;">
		<iframe id="reportFrame" style="width:800px;height:500px;border:0;text-align:left;"></iframe>
	</div>
	<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js" type="text/javascript"></script>
<%-- 	<script src="${ctxStatic}/webprint/jquery.PrintArea.js" type="text/javascript"></script> --%>
	<script type="text/javascript">
	
		var reportFrame = $("#reportFrame");
		var reportWindow = reportFrame[0].contentWindow;
// 		var reportContents = reportFrame.contents();
		
// 		var src = "${ctxPath}/ReportServer?reportlet=articleView.cpt&id=512614175457779712&__bypagesize__=false";
// 		var src = "${ctxPath}/ReportServer?reportlet=userView.cpt&userCode=system&__bypagesize__=false";
		var src = "${ctxPath}/ReportServer?reportlet=userList.cpt&__bypagesize__=false";
// 		var src = "${ctxPath}/ReportServer?formlet=userList.frm";
		
		reportFrame.attr("src", src).load(function(){

			// 获取框架参数
			var ifr = $(this), win = ifr[0].contentWindow, conts = ifr.contents();
			
			// 窗口调整大小事件
			$(win).resize(function() {

				// 设置报表无滚动条
				conts.find('html, body').css({'overflow':'hidden'});
				conts.find('.content-container').css({'overflow':'hidden'});
				
				// 设置表格框架高度(formlet)
// 				conts.find('.page-block table').each(function(){
// 					var tableHeight = $(this).outerHeight();
// 					$(this).parents('.fr-titlelayout:first').height(tableHeight);
// 					$(this).parents('.fr-quick-border-layout:first').height(tableHeight);
// 					$(this).parents('.reportContent:first').height(tableHeight);
// 				});
				
            }).resize();

			// 报表加载结束监听事件 (reportlet)
			if (win.contentPane){
				var pane = win.contentPane;
				pane.on("afterload", function() {
					
					// 设置分页信息
//	 				var cpi = pane.currentPageIndex; //每次加载完后重新获取当前页码   
//	 				var pv = "第" + cpi + "页/共" + pane.reportTotalPage + "页"; //重新生成页码信息    
//	 				document.getElementById("page").value = pv; //重新给page文本赋页码信息      
//	 				document.getElementById("index").value = cpi; // 设置跳转页面为当前页码
					
					// 调用窗口调整大小事件
					$(win).resize();
					
					// 设置自动高度
					var toolbarHieght = conts.find('.x-toolbar').height();
					var tableHeight = conts.find('.page-block table').outerHeight();
					ifr.height(toolbarHieght + tableHeight + 5);
					
					// 设置自动宽度
					var pageWidth = conts.find('.page-block table').outerWidth();
					ifr.width(pageWidth + 5);

				});
			}
		});
		
// 		function gotopage() {        
// 			var contentpane = reportWindow.contentPane;
// 			var page = document.getElementById("index").value;        
// 			if(page >= contentpane.reportTotalPage) {        
// 				contentpane.gotoLastPage();        
// 			}         
// 			contentpane.gotoPage(parseInt(page));        
// 		}

		function webPrint(){
// 			reportWindow.contentPane.gotoFirstPage();
// 			var options = {
// 				extraCss : '${ctxPath}/ReportServer?op=emb&resource=finereport.css',
// 			};
// 			var printContent = reportWindow.$('.page-block');
//             $( printContent ).printArea( options );
			window.print();
		}
		
	</script>
	<!-- <div style="font-size:13px;line-height:24px;margin-top:10px;">
		<button onclick="webPrn.PrintSetup();">打印设置</button> &nbsp;
		<button onclick="webPrn.PrintSetupWebPage()">打印当前页</button> &nbsp;
		<button onclick="webPrint()">开始批量打印</button> &nbsp;
		<p><strong>注意事项：</strong><br/>
		1、推荐使用IE浏览器，如果使用双核浏览器，请切换到IE模式下；<br/>
		2、然后点击浏览器上方会弹出黄色提示，选择“为此计算机上的所有用户安装此加载项”或点击浏览器下方“安装”按钮，弹出的对话框再点击“安装”即可。<br/>
		3、打印设置可设置纸张、方向和边距，以及选择打印机，否则系统会选用默认打印机进行打印。</p>
	</div> -->
</body>
</html>