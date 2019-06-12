<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,gird"/>
<sys:header title="资产清理还原表" extLibs="${extLibs}"/>
<style>
    .nav_right ul li {
        margin-top: 10px;
        padding: 5px 30px 5px 30px;
        border: 1px solid #cfcfcf;
        cursor: pointer;
        border-top-right-radius: 2px;
        border-bottom-right-radius: 2px;
        word-wrap: break-word;
        font-size: 14px;
        text-align: center;
        background-color: #fff;
        color: rgba(39, 117, 190, 1);
        display: block;
        float: left;
    }
    li{display:list-item;}
    ul,li{list-style:none !important}
    .nav_right ul li:hover {
        color: rgb(39, 172, 190);
        -moz-transition: background-color 300ms linear;
        -o-transition: background-color 300ms linear;
        -webkit-transition: background-color 300ms linear;
        transition: background-color 300ms linear;
    }
    .nav_right ul li.active {
        color: rgba(39, 117, 190, 1);
        border-color:#cfcfcf;
        border-bottom: #ffffff;
    }
    #reportFrame {
        border: solid 10px #cfcfcf;
        background-color: white;
    }
</style>
<div class="nav_right nav2">
    <ul>
        <li class="active" onclick="showTab(this,'${ctx}/assetsclean/assetClean/list')"><span>清理</span></li>
        <li onclick="showTab(this,'${ctx}/assetsclean/assetClean/list2')"><span>还原</span></li>
    </ul>
</div>
<iframe id="reportFrame" src="${ctx}/assetsclean/assetClean/list"></iframe>
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