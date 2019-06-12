<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入框值"%>
<i id="${id}Icon" class="${not empty value?value:' hide'}"></i>
<input id="${id}" name="${name}" type="text" value="${value}" style="border:1px solid #ddd;padding:3px;width:90px;vertical-align:middle;"/>
<a id="${id}Button" href="javascript:" class="btn default btn-sm">选择</a>&nbsp;&nbsp;
<script type="text/javascript">
	$("#${id}Button").click(function(){
		var $jBox = getJBox();
		$jBox.open("iframe:${ctx}/tag/iconselect?value="+$("#${id}").val(), "选择图标", 
				$(document, $jBox).width() - 100, $(document, $jBox).height() - 100, {
			bottomText:"<font color='red'>提示：双击选择图标。</font>",
            buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
                if (v=="ok"){
                	var icon = h.find("iframe")[0].contentWindow.$("#icon").val();
                	$("#${id}Icon").attr("class", icon);
	                $("#${id}").val(icon);
                }else if (v=="clear"){
	                $("#${id}Icon").attr("class", "");
	                $("#${id}").val("");
                }
            }
        });
	});
</script>