<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="id"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域名称（ID）"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="隐藏域值（ID）"%>
<%@ attribute name="labelName" type="java.lang.String" required="true" description="输入框名称（Name）"%>
<%@ attribute name="labelValue" type="java.lang.String" required="true" description="输入框值（Name）"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="选择框标题"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="树结构数据地址"%>
<%@ attribute name="isAll" type="java.lang.Boolean" required="false" description="是否列出全部数据，设置true则不进行数据权限过滤"%>
<%@ attribute name="allowInput" type="java.lang.Boolean" required="false" description="文本框可填写"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="class样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="multiple" type="java.lang.String" required="false" description="是否多选"%>
<%@ attribute name="returnCodeAttr" type="java.lang.String" required="false" description="选择后结果集中的Code属性名，返回到隐藏域的值"%>
<%@ attribute name="returnNameAttr" type="java.lang.String" required="false" description="选择后结果集中的Name属性名，返回到输入框的值"%>
<%@ attribute name="boxWidth" type="java.lang.Integer" required="false" description="弹出的对话框宽度，默认浏览器宽，减去150像素"%>
<%@ attribute name="boxHeight" type="java.lang.Integer" required="false" description="弹出的对话框宽度，默认浏览器高，减去150像素"%>
<div class="input-group" id="${id}Div" data-url="${!fn:startsWith(url, ctx) ? ctx : ''}${url}${fn:contains(url, '?') ? '&' : '?'}mul=${multiple}&isAll=${isAll}&showName=${returnNameAttr}">
	<input id="${id}Code" name="${name}" class="${cssClass}" type="hidden" value="${value}"/>
	<input id="${id}Name" name="${labelName}" ${allowInput?'':'readonly="readonly"'} type="text" ${disabled} value="${labelValue}" class="${cssClass}" style="${cssStyle}"
	/><span class="input-group-btn">
		<a id="${id}Button" href="javascript:" class="btn default ${disabled}" 
			style="display:inline-block;"><i class="fa fa-search"></i></a>
	</span>
</div>
<script type="text/javascript">
	$("#${id}Button, #${id}Name").click(function(){
		var $jBox = getJBox(), selectData = "";
		// <c:if test="${not empty returnCodeAttr && not empty returnNameAttr}"> 回显设置值
		var codes = $('#${id}Code').val();
		var names = $('#${id}Name').val();
		var codesArr = new Array();
		var namesArr = new Array();
		if(codes != null && codes != "" && names != null && names != ""){
			codesArr = codes.split(",");
			namesArr = names.split(",");
			var jsons = {}, str = "";
			for(var i=0; i<codesArr.length; i++) {
				str='{"${returnCodeAttr}":"'+codesArr[i]+'","${returnNameAttr}":"'+namesArr[i]+'"}';
				jsons[codesArr[i]] = JSON.parse(str);
			}
			if(codesArr.length>0){
				selectData = JSON.stringify(jsons);
				selectData = selectData.replace(new RegExp("\"","g"),"\'");
			}
		}
		// </c:if>
		if(typeof ${id}BeforeForMap == 'function'){
			selectData = ${id}BeforeForMap(selectData);
		}
		$jBox.open("iframe:"+$('#${id}Div').attr('data-url'), "选择${title}", 
			${not empty boxWidth ? boxWidth : '$(top.window).width() - 150'}, ${not empty boxHeight ? boxHeight : '$(top.window).height() - 150'}, { 
			ajaxData:{selectData:selectData},
            buttons: {
            	"<i class=\"glyphicon glyphicon-ok\"></i>&nbsp;确定":"ok",
            	/* "<i class=\"fa fa-eraser\"></i>&nbsp;清除":"clear", */
            	'<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭': "close" 
            }, submit:function(v, h, f){ // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
            	if(v=="ok"){
	           		var w = h.find("iframe")[0].contentWindow;
	           		// 废弃方法，不建议使用，see: ${id}CallbackToMap()
	            	if(typeof ${id}Callback == 'function'){
		           		var data = w.getDatas();
	            		${id}Callback(data, v, h, f);
					}
	           		if(typeof ${id}CallbackForMap == 'function'){
		           		var dataMap = w.getDataMap();
	            		${id}CallbackForMap(dataMap, v, h, f);
					}
	           		// <c:if test="${not empty returnCodeAttr && not empty returnNameAttr}"> 设置返回值
			   		var codes = [], names = [];
					$.each(w.getDataMap(), function(key, value){
						codes.push(value['${returnCodeAttr}']);
						names.push(value['${returnNameAttr}']);
					});
			   		$('#${id}Code').val(codes.join(','));
			   		$('#${id}Name').val(names.join(','));
					// </c:if>
            	}
                // 选择后回调
				if(typeof ${id}ListselectCallBack == 'function'){
					${id}ListselectCallBack(v, h, f);
				}
			}
        });  
	});
</script>
