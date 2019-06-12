<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,fileupload"/>
<sys:header title="资产卡片" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="assetinfo" action="" method="post" class="form-horizontal">
			<div class="form-body">
				<form:hidden path="id"/>
				<table width="80%" border="1" cellspacing="0" cellpadding="0" align="center">
				  <tr height="30">
				    <td colspan="4"><div align="center"><strong>资产卡片</strong></div></td>
				  </tr>
				  <tr height="25">
				    <td width="40%"><div align="center"><strong>资产编码</strong></div></td>
				    <td width="60%">${assetinfo.assetCode}</td>
				    </tr>
				  <tr height="25">
				    <td><div align="center"><strong>资产名称</strong></div></td>
				    <td>${assetinfo.assetName}</td>
				  </tr>
				  <tr height="25">
				    <td><div align="center"><strong>资产分类</strong></div></td>
				    <td>${assetinfo.sortName}</td>
				  </tr>
				  <tr height="25">
				    <td><div align="center"><strong>规格型号</strong></div></td>
				    <td>${assetinfo.version}</td>
				  </tr>
				  <tr height="25">
				    <td><div align="center"><strong>计量单位</strong></div></td>
				    <td>${assetinfo.unit}</td>
				  </tr>
				  <tr height="25">
				    <td><div align="center"><strong>存放地点</strong></div></td>
				    <td>${assetinfo.storagePlace}</td>
				  </tr>
				</table>
				<br/>
				<br/>
				<table width="50%" border="0" cellspacing="0" cellpadding="0" align="center">
                    <c:choose>
                        <c:when test="${assetinfoStatus=='1'}">
                                    <tr>
                                        <td colspan="4"><div align="center"><button id="btnSubmit"class="btn btn-primary"><i class="fa fa-check"></i>确认</button>&nbsp;</div></td>
                                    </tr>
                        </c:when>
                    </c:choose>
				</table>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    $('#btnSubmit').click(function () {
        var url = "updateAssetCheckStatus?assetCode=${assetinfo.assetCode}";
        $.post(url, function (data) {
            showMessage(data.message);
            if (data.code == "200") {
                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                    contentWindow.page();
                });
            }
        }, "json");
    })
</script>
