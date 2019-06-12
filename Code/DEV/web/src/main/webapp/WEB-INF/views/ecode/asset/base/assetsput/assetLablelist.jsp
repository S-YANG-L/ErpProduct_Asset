<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate"/>
<sys:header title="打印预览" extLibs="${extLibs}"/>
<div class="portlet-title" style="width: 100%;margin: auto;">
    <a href="#" style="float: right;background: #cfcfcf" class="btn btn-default btn-sm"
       id="btnExportSM" title="打印"><i
            class="fa fa-external-link"></i>打印</a>
</div>
<div style="width: 100%;height: 100%">
    <iframe id="" name="" src="${ctxPath}/ReportServer?reportlet=assetLablelist.cpt&ids=${assetCode}"
            style="width:100%; height:495px; " frameborder="0" align="middle">
    </iframe>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    $("#btnExportSM").click(function () {
        var url = "${ctx}/ass/assetInfo/assetPrint?assetCodes=${assetCode}";
        console.log("dsadasd",url);
        $.post(url, function (data) {
        if (data.message == "success") {
        showMessage("打印中");
        } else {
        showMessage("失败");
        }
        }, "json");
    });
</script>