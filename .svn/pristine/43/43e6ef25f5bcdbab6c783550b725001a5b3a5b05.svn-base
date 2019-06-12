<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxPath}/dwr/engine.js" type="text/javascript"></script>
<script src="${ctxPath}/dwr/util.js" type="text/javascript"></script>
<script src="${ctxPath}/dwr/interface/MsgPushService.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-plugin/jquery-timeago-1.4.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/msgPush.min.js" type="text/javascript"></script>
<script type="text/template" id="msgTipTpl">
	<abbr class="timeago" title="{{time}}">{{time}}</abbr> 来自 {{message.senderName}} <br/> {{&message.contentTitle}} 
	<div style="margin:5px 0 2px;float:right;">
		<button class="btn btn-white btn-primary btn-sm" type="button" data-href="${ctx}/msg/message/view?mrId={{id}}"
			onclick="readMsg(this, '消息详情', '{{id}}')">查看</button>&nbsp;
		{{#buttonList}}
			<button class="btn btn-white btn-primary btn-sm" type="button" data-href="${ctx}{{href}}"
				 onclick="readMsg(this, '消息{{name}}', '{{id}}');">{{name}}</button>&nbsp;
		{{/buttonList}}
	</div>
</script>
<script type="text/template" id="msgListTpl">
	<li id="msg{{id}}">
		<a href="javascript:" data-href="${ctx}/msg/message/view?mrId={{id}}" onclick="readMsg(this, '消息详情', '{{id}}')" >
			<div class="clearfix">
				<span class="pull-left"><i class="btn btn-xs no-hover btn-pink fa fa-comment"></i> {{&message.contentTitle}}</span>
				<span class="pull-right"><abbr class="timeago" title="{{time}}">{{time}}</abbr></span>
			</div>
		</a>
	</li>
</script>