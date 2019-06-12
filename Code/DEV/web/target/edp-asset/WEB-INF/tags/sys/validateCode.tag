<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="验证码输入框ID"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="验证码输入框名称"%>
<%@ attribute name="inputCssStyle" type="java.lang.String" required="false" description="验证框样式"%>
<%@ attribute name="linkCssStyle" type="java.lang.String" required="false" description="看不清链接样式"%>
<%@ attribute name="isShowLink" type="java.lang.Boolean" required="false" description="是否显示文字连接，默认显示"%>
<%@ attribute name="isRequired" type="java.lang.Boolean" required="false" description="是否必填，默认必填"%>
<%@ attribute name="dataMsgRequired" type="java.lang.String" required="false" description="设置data-msg-required属性，必填验证的提示信息"%>
<%@ attribute name="isRemote" type="java.lang.Boolean" required="false" description="是否需要，实时远程验证"%>
<%@ attribute name="dataMsgRemote" type="java.lang.String" required="false" description="设置data-msg-remote属性，远程验证的提示信息"%>
<%@ attribute name="isLazy" type="java.lang.Boolean" required="false" description="是否懒加载验证码图片，原noRefresh参数"%>
<c:set var="id" value="${empty id ? name : id}"/>
<input type="text" id="${id}" name="${name}" class="txt" maxlength="5" onfocus="if($('#${id}Img').attr('src')==''){$('#${id}Img').click();}"
	<c:if test="${isRequired}"> required="true" data-msg-required="${not empty dataMsgRequired ? dataMsgRequired : '请填写验证码.'}"</c:if>
	<c:if test="${isRemote}"> remote="${ctxPath}/servlet/validateCodeServlet" data-msg-remote="${not empty dataMsgRemote ? dataMsgRemote : '验证码不正确.'}"</c:if>
	style="border:1px solid #ddd;height:26px;font-weight:bold;width:50px;margin-bottom:0;padding:2px 2px 3px 2px;vertical-align:middle;${inputCssStyle}"/>&nbsp;
<img src="" id="${id}Img" class="${id}Img hide" onclick="$('#${id}Refresh').click();$('#${id}').val('').focus();" style="vertical-align:middle;" title="看不清，点击图片刷新。"/>
<a href="javascript:" id="${id}Link" class="${not empty isShowLink && !isShowLink?'hide':''}" onclick="$('#${id}Img').click();" style="vertical-align:middle;${linkCssStyle}" >看不清</a>
<button type="button" id="${id}Refresh" class="${id}Refresh hide" onclick="$('#${id}Img').attr('src','${pageContext.request.contextPath}/servlet/validateCodeServlet?'+new Date().getTime()).removeClass('hide');"></button>
<c:if test="${!isLazy}"><script>setTimeout(function(){$('#${id}Refresh').click()}, 1000);</script></c:if>