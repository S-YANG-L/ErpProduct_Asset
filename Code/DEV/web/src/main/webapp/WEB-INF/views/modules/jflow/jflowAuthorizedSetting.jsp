<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="代理人设置" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i>代理人设置</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" action="${ctx}/jflow/authorized/setting" method="get" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">授权情况</h4>
				<div class="row">
					<div class="col-xs-2">
					</div>
					<div class="col-xs-10">
						<c:choose>
							<c:when test="${!au.authorIsOK}">
								<p>
									未授权 - <a href="${ctxPath}/WF/ToolsWap.jsp?RefNo=Auto" class="addTab">执行授权</a>。
								</p>
							</c:when>
							<c:otherwise>
								<p>
									授权情况：授权给：<font color="green">${au.author}</font>，
									授权日期：<font color="green">${au.authorDate}</font>，
									收回授权日期：<font color="green">${au.authorToDate}</font>。
								</p>
								<p>
									我要：<a href="javascript:TakeBack('${au.author}')">取消授权</a>；
									授权方式：<font color="green">${au.authorWay eq 1 ? '全部授权' : '指定流程范围授权'}</font>，
									<a href="${ctxPath}/WF/ToolsWap.jsp?RefNo=AutoDtl&FK_Emp=${au.author}"
										class="addTab">我要修改授权信息</a>。
								</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 刷 新</button>&nbsp;
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	$('.addTab').click(function(){
		addTabPage(null, '执行授权', this.href);
		return false;
	});
	function TakeBack(fk_emp) {
		if (window.confirm('您确定要取消对[' + fk_emp + ']的授权吗？') == false)
			return;
		var url = '${ctxPath}/WF/Do.jsp?DoType=TakeBack';
		ajaxSubmit(url, function(data){
			alert('您已经成功的取消。');
			window.location.reload();
		}, 'text');
	}
</script>