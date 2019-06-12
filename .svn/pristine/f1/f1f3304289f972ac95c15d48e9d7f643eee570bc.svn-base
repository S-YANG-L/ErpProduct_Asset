<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate" />
<sys:header title="Chat" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>即时聊天</div>
	</div>
	<div class="portlet-body form">
		<form class="form-horizontal">
			<div class="form-body">
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">发送人：</label>
							<div class="col-sm-6">
								<input type="text" name="senduser" value="${fns:getUser().userName}" 
									class="form-control" readonly="readonly"/> 
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<span id="loginmsg" style="line-height:30px"></span>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">收到的消息：</label>
							<div class="col-sm-6">
								<div id="msg" class="form-control" style="height:200px;overflow-y:auto;"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">接受人：</label>
							<div class="col-sm-6">
								<select name="users" id="users" class="form-control noselect2"></select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">发送消息：</label>
							<div class="col-sm-6">
								<textarea rows="3" cols="50" name="message" id="message" 
									 class="form-control"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<button id="btnSubmit" type="button" class="btn btn-primary" onclick="sendMsg();" >发送消息</button>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<sys:footer extLibs="validate" />
<script type="text/javascript" src="${ctxPath}/dwr/engine.js" /></script>
<script type="text/javascript" src="${ctxPath}/dwr/util.js"></script>
<script type="text/javascript" src="${ctxPath}/dwr/interface/MsgPushService.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		dwr.engine.setActiveReverseAjax(true);
		dwr.engine.setNotifyServerOnPageUnload(true);
		dwr.engine.setErrorHandler(function(e){log(e)});
		login();
	});
	
	//登录
	function login() {
		var sender = dwr.util.getValue('senduser');
		if (sender == "") {
			alert("未登录");
			return;
		}
		MsgPushService.login(function(data) {
			if (data){
				document.getElementById("loginmsg").innerHTML = "登录成功";
			}else{
				document.getElementById("loginmsg").innerHTML = "登录失败";
			}
		});
	}

	/** 
	 * 发送消息 
	 */
	function sendMsg() {
		var receiver = $("#users").val();
		var message = $("#message").val();
		if ($.trim(message) == "") {
			message = "这是测试消息内容 " + timeStamp2String(new Date()) + " ";
		}
		MsgPushService.sendMsg(receiver, message, function(data) {
			if (data) {
				var str = "<div style=\"border: 1px solid green;margin:5px 5px 5px 5px;text-align:right;\">";
				str += "<font color=green> 我自己     " + timeStamp2String(new Date()) + " </font><br>";
				str += message + "<br>";
				str += "</div>";
				$("#msg").append(str);
			}else{
				$("#msg").append(data);
			}
			$("#msg").scrollTop($("#msg")[0].scrollHeight);//滚动条置底
			$("#message").val("");
		});
	}

	//接收消息  
	function receiveMsg(sender, message, time) {
		var str = "<div style=\"border: 1px solid red;margin:5px 5px 5px 5px;text-align:left;\">";
		str += "<font color=red> " + sender + " " + time.toLocaleString() + " </font><br>";
		str += message + "<br>";
		str += "</div>";
		$("#msg").append(str);
		$("#msg").scrollTop($("#msg")[0].scrollHeight);//滚动条置底
		// 标题新消息闪动
		doFlashTitle();
	}

	//格式化日期
	function timeStamp2String(time) {
		var datetime = new Date();
		datetime.setTime(time);
		var year = datetime.getFullYear();
		var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
		var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
		var hour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime.getHours();
		var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
		var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
		return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
	}
	
	// 注册焦点变化监听器
	var isWindowFocus = true; // 当前浏览器窗口是否处于焦点
	if ("onfocusin" in document) {// for IE 
		document.onfocusin = function (){isWindowFocus = true};
		document.onfocusout = function (){isWindowFocus = false};
	} else {
		window.onfocus = function (){isWindowFocus = true};
		window.onblur = function (){isWindowFocus = false};
	}
	// 实现标题闪动效果
	var flashStep = 0; // 交替变量
	var flashTitleRun = false; // 是否正在执行
	var normalTitle = document.title; // 保存原标题
	var flashTitle = function() {
		//仅窗口不在焦点时闪烁title，回到焦点时停止闪烁并将title恢复正常
		if (isWindowFocus) {// 当前处于焦点
			document.title = normalTitle;
			flashTitleRun = false;
			return;// 退出循环
		}
		flashTitleRun = true;
		flashStep++;
		if (flashStep == 3) {
			flashStep = 1;
		}
		if (flashStep == 1) {
			document.title = "【新消息】" + normalTitle;
		}
		if (flashStep == 2) {
			document.title = "【　　　】" + normalTitle;
		}
		setTimeout("flashTitle()", 500); //循环
	}
	//调用这个执行标题闪烁，而不是直接调用flashTitle，保证多次调用只会执行一次。
	function doFlashTitle() {
		if (!flashTitleRun){//没有执行时，才执行
			flashTitle();
		}
	}
</script>