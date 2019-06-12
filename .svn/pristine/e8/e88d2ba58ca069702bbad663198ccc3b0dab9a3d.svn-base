<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,ueditor"/>
<sys:header title="查看消息" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<!-- <div class="portlet-title">
		<div class="caption"><i class="fa fa-bullhorn"></i>消息详情</div>
	</div> -->
	<div class="portlet-body form">
		<div id="inputForm" class="form-horizontal">
			<div class="form-body content-view">
				<h2 class="title">${msgPush.msgContentEntity.title}</h2>
				<div class="content-text">
					${msgPush.msgContentEntity.content}
				</div>
				<ul class="content-info">
					<li><i class="fa fa-user"></i>发送者：${msgPush.sendUserName}</li>
					<li><i class="fa fa-calendar"></i>发送时间：<fmt:formatDate value="${msgPush.sendDate}" pattern="yyyy-MM-dd HH:mm"/></li>
				</ul>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<c:if test="${msgPush.msgType eq 'pc'}">
							<c:forEach items="${msgPush.msgContentEntity.buttons}" var="button">
								<button class="btn btn-primary" type="button" onclick="addTabPage($(this), '消息${button.name}', '${ctxPath}${button.href}' , null, true, false);"><i class="fa fa-check"></i> ${button.name}</button>&nbsp;
							</c:forEach>
						</c:if>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>