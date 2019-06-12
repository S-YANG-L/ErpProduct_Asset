<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate"/>
<sys:header title="打印预览" extLibs="${extLibs}"/>

<div style="width: 90%;margin: auto;">
    <iframe id="" name="" src="${ctxPath}/ReportServer?reportlet=assetLable.cpt&assetCode=${assetCode}"
            style="width:100%; height:495px; " frameborder="0" align="middle">
    </iframe>
</div>

<sys:footer extLibs="${extLibs}"/>