<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/jquery-plugin/jquery-timeago-1.4.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
// 获取未读消息（前5条）
$(function(){
	setTimeout(function(){
		$.get('${ctx}/sys/msg/login', function(data){
			var msgList = $("#msgList").empty();
			var num = data.count, list = data.list;
			for (i = 0; i < list.length; i++) {
				msgList.append(template('msgListTpl', list[i]));
			}
			if(num == 0){
				$("#msgNumber").empty().append(0);
				$("#msgTitle").empty().append("暂无最新消息");
			}else{
				$("#msgNumber").empty().append(num);
				$("#msgTitle").empty().append("您还有 " + num + " 项未读消息");
			}
			$(".timeago").timeago();
			// 获取推送池的消息
			refreshMsgPool();
			setInterval(refreshMsgPool, 60*2000);// 2分钟执行一次
		});
	}, 2000);
});
//获取推送池的消息
function refreshMsgPool(){
	var maxNum = ${fns:getConfigDefault("sys.msg.maxSingleMagPush", "5")};
	$.get('${ctx}/sys/msg/pool', function(list){
		var msgList = $("#msgList");
		for (i = 0; i < list.length; i++) {
			if (!(list.length > maxNum)){
		 		var msg = template('msgTipTpl', list[i])
		 		showMessage(msg, list[i].msgContentEntity.title, 'info', 1000*60);
			}
			if (list[i].id && list[i].id != ''){
				msgList.prepend(template('msgListTpl', list[i]));
			}
			doFlashTitle(); // 新消息标题闪动
		}
		// 最大单条消息推动个数，设置为5代表，超过5条，则合并为1条进行推送。
		if (list.length > maxNum){
			var d = {
				msgContentEntity: {
					title: '系统消息',
					content: '您当前有 ' + list.length + ' 条新消息，由于消息太多，这里为您合并，请点击查看按钮看详情。'
				},
				sendDate: dateToStr(new Date()),
				sendUserName: '系统管理员'
			}
			var msg = template('msgTipTpl', d);
			showMessage(msg, d.msgContentEntity.title, 'info', 1000*60);
		}
		var num = parseInt($("#msgNumber").text());
		if(num !== "" || num !== NaN){
			num += list.length;
		}else{
			num = msgList.find('li').length;
		}
		$("#msgNumber").text(num);
		$("#msgTitle").empty().append("您还有 " + num + " 项未读消息");
		$(".timeago").timeago();
	});
}
// 标题新消息闪动提醒，调用doFlashTitle()即可
var isWindowFocus = true; // 当前浏览器窗口是否处于焦点
if ("onfocusin" in document) {// for IE 
	document.onfocusin = function (){isWindowFocus = true};
	document.onfocusout = function (){isWindowFocus = false};
} else {
	window.onfocus = function (){isWindowFocus = true};
	window.onblur = function (){isWindowFocus = false};
}
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
	flashTitleRun = true; flashStep++;
	if (flashStep == 3) { flashStep = 1; }
	if (flashStep == 1) { document.title = "【新消息】" + normalTitle; }
	if (flashStep == 2) { document.title = "【　　　】" + normalTitle; }
	setTimeout("flashTitle()", 500); //循环
}
//调用这个执行标题闪烁，而不是直接调用flashTitle，保证多次调用只会执行一次。
function doFlashTitle() {
	if (!flashTitleRun){//没有执行时，才执行
		flashTitle();
	}
}
// 读取未读消息
function readMsg($this, title, recordId) {
	addTabPage($($this), title, $($this).data("href") , null, true, false);
	var msgRecord = $("#msg" + recordId);
	if (msgRecord.length > 0){
		var num = parseInt($("#msgNumber").text());
		$("#msgNumber").empty().append((--num)>0?num:0);
		$("#msgTitle").empty().append("您还有 " + num + " 项未读消息");
		msgRecord.remove();
	}
}
</script>
<script type="text/template" id="msgListTpl">
	<li id="msg{{id}}">
		<a href="javascript:" data-href="${ctx}/sys/msg/form?id={{id}}" onclick="readMsg(this, '消息详情', '{{id}}')" >
			<div class="clearfix">
				<span class="pull-left"><i class="btn btn-xs no-hover btn-pink fa fa-comment"></i> {{&msgContentEntity.content}}</span>
				<span class="pull-right"><abbr class="timeago" title="{{sendDate}}">{{sendDate}}</abbr></span>
			</div>
		</a>
	</li>
</script>
<script type="text/template" id="msgTipTpl">
	<abbr class="timeago" title="{{sendDate}}">{{time}}</abbr> 来自 {{sendUserName}} <br/> {{&msgContentEntity.content}} 
	<div style="margin:5px 0 2px;float:right;">
		{{#msgContentEntity.buttons}}
			<button class="btn btn-white btn-primary btn-sm" type="button" data-href="${ctxPath}{{href}}"
				 onclick="readMsg(this, '消息{{name}}', '{{id}}');">{{name}}</button>&nbsp;
		{{/msgContentEntity.buttons}}
		<button type="button" data-href="${ctx}/sys/msg/form?id={{id}}" onclick="readMsg(this, '消息详情', '{{id}}')"
			class="btn btn-white btn-primary btn-sm" >查看</button>&nbsp;
	</div>
</script>