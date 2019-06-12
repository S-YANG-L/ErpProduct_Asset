<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,gird"/>
<sys:header title="领用退库表" extLibs="${extLibs}"/>
<style>
    .nav_right ul li {
        margin-top: 10px;
        width: 100px;
        padding: 10px;
        border: 1px solid #e1e7f3;
        border-left: none;
        cursor: pointer;
        border-top-right-radius: 2px;
        border-bottom-right-radius: 2px;
        word-wrap: break-word;
        font-size: 14px;
        text-align: center;
        background-color: #fff;
        color: #019aff;
        display: block;
        float: left;
    }
    li{display:list-item;}
    ul,li{list-style:none !important}
    .nav_right ul li:hover {
        background-color: rgba(7, 115, 225, 1);
        border-color: rgba(39, 117, 190, 1);
        color: #ffffff;
        -moz-transition: background-color 300ms linear;
        -o-transition: background-color 300ms linear;
        -webkit-transition: background-color 300ms linear;
        transition: background-color 300ms linear;
    }
    .nav_right ul li.active {
        background-color: rgba(40, 139, 231, 1);
        color: #fff;
        border-color: rgba(39, 117, 190, 1);
    }
    #reportFrame {
        border: solid 10px #cfcfcf;
        background-color: white;
    }
</style>
<div class="nav_right nav2">
    <ul>
        <li class="active" onclick="showTab(this,'${ctx}/usedinfo/assetUsedInfo/form')"><span>领用</span></li>
        <li ><span>退库</span></li>
    </ul>
</div>
<iframe id="reportFrame" src="${ctx}/usedinfo/assetUsedInfo/form"></iframe>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    $(function () {
        var winHeight = $(window).height() - 20;
        var div = document.getElementById("reportFrame");
        div.style.cssText = "width:97%;height:" + winHeight + "px;border:none;"
    });
    function showTab(tabID, iframeUrl) {
        $(tabID).addClass("active").siblings().removeClass("active");
        $("#reportFrame").attr("src", iframeUrl);
    }
</script>