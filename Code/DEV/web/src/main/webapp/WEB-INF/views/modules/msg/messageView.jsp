<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,ueditor"/>
<sys:header title="消息详情" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<!-- <div class="portlet-title">
		<div class="caption"><i class="fa fa-bullhorn"></i>消息详情</div>
	</div> -->
	<div class="portlet-body form">
		<div id="inputForm" class="form-horizontal">
			<div class="form-body content-view">
				<h2 class="title">${message.contentTitle}</h2>
					<blockquote>
                   	<p>${message.receiverNames}</p>
                   	<small>接受者(<cite>${fns:getDictLabel(message.receiverType, 'msg_receiver_type', '')}</cite>)</small>
                 	</blockquote>  
				<div class="content-text">
					${message.contentText}
				</div>
				<ul class="content-info">
					<li><i class="fa fa-user"></i>发送者：${ message.senderName}</li>
					<%-- <li><i class="fa fa-users"></i>发送对象：${fns:getDictLabel( message.receiverType, 'msg_receiver_type', '')}</li> --%>
					<li><i class="fa fa-calendar"></i>发送时间： <fmt:formatDate value="${message.sendDate}" pattern="yyyy-MM-dd HH:mm:ss"/></li>
					<c:if test="${not empty message.msgStatis}">
						<li><i class="fa fa-comments"></i>查阅：
								未送达(${message.msgStatis.unDelivered})
								未读(${message.msgStatis.unRead})
								已读(${message.msgStatis.read})
								总数(${message.msgStatis.count})
						</li>
					</c:if>
					<c:if test="${not empty message.contentType}">
						<li><i class="fa fa-tags"></i>等级：${fns:getDictLabel(message.contentLevel, 'msg_level', '')},
							分类：${fns:getDictLabel(message.contentType, 'msg_content_type', '')}</li>
					</c:if>
				</ul>
				<c:if test="${not empty message.messageRecordList}">
				<shiro:hasPermission name="user">
				<div class="portlet ">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-envelope"></i>查阅记录
						</div>
						<div class="tools">
							<a class="collapse" title="" href="javascript:;" data-original-title=""></a>
						</div>
					</div>
					<div class="portlet-body">
						<table class="table table-bordered table-hover table-condensed">
							<thead>
								<tr>
									<th class="text-center">序号</th>
									<th class="text-center">接收者</th>
									<th class="text-center">接收者姓名</th>
									<th class="text-center">送达日期</th>
									<th class="text-center">查看日期</th>
									<th class="text-center">状态</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${message.messageRecordList}" var="messageRecord" varStatus="status">
								<tr>
									<td class="text-center">${status.index + 1}</td>
									<td class="text-center">${messageRecord.receiver}</td>
									<td class="text-center">${messageRecord.receiverName}</td>
									<td class="text-center"><fmt:formatDate value="${messageRecord.receiveDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
									<td class="text-center"><fmt:formatDate value="${messageRecord.readDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
									<td class="text-center">
										<c:choose>
											<c:when test="${messageRecord.status == '0'}"><span class="label  label-sm label-warning"> 未达 </span></c:when>
											<c:when test="${messageRecord.status == '1'}"> <span class="label label-sm label-danger"> 未读 </span></c:when>
											<c:when test="${messageRecord.status == '2'}"> <span class="label label-sm label-success"> 已读 </span></c:when>
											<c:when test="${messageRecord.status == '3'}"> <span class="label label-sm label-danger"> 失败 </span></c:when>
											<c:otherwise></c:otherwise>
										</c:choose> 
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				</shiro:hasPermission>
				</c:if>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<c:forEach items="${message.buttonList}" var="button">
							<button class="btn btn-primary" type="button" onclick="addTabPage($(this), '消息${button.name}', '${ctx}${button.href}' , null, true, false);"><i class="fa fa-check"></i> ${button.name}</button>&nbsp;
						 </c:forEach>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
