<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,jBox"/>
<sys:header title="流程详情" extLibs="${extLibs}"/>
<style>
.flowTable{width: 100%;border-collapse: collapse;background-color: #ecf0f5;}
.flowTable tr td{height: 29px;border: 1px solid #ccc;}
.flowTitle{text-align: center;font-weight: bold;}
</style>
<div class="portlet box ${boxStyleColor} autoHeight">
	<!-- <div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>流程详情</div>
	</div> -->
	<div class="portlet-body form">
		<table class="flowTable">
			<tr>
				<!-- <td class="flowTitle">节点名称</td> -->
				<td class="flowTitle">操作人</td>
				<td class="flowTitle">操作时间</td>
				<td class="flowTitle">审批意见</td>
			</tr>
			<c:choose>
				<c:when test="${fn:length(flowInfoList) > 0}">
					<c:forEach items="${flowInfoList}" var="info" varStatus="idx">
						<tr>
							<%-- <td align="center" width="34%">${info.stepName}</td> --%>
							<td align="center">
								<c:choose>
									<c:when test="${info.step eq -1}">
										${info.applicantName}
									</c:when>
									<c:otherwise>
										${info.approvalName}
									</c:otherwise>
								</c:choose>
							</td>
							<td align="center" width="33%">
								<c:choose>
									<c:when test="${info.step eq -1}">
										<fmt:formatDate value="${info.createDate}" pattern="yyyy-MM-dd"/>
									</c:when>
									<c:otherwise>
										<fmt:formatDate value="${info.approvalDate}" pattern="yyyy-MM-dd"/>
									</c:otherwise>
								</c:choose>
							</td>
							<td align="center" width="33%">
								<c:choose>
									<c:when test="${info.step eq -1}">
										${info.content}
									</c:when>
									<c:otherwise>
										${info.approvalMemo}
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td align="center" colspan="3">还未办理！</td>
						
					</tr>
				</c:otherwise>
			</c:choose>
			
		</table>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	
</script>