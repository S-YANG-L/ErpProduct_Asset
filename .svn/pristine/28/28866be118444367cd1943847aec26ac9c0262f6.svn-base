<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><%-- 使用该组件请在header.tag和footer.tag中引入ueditor类库 --%>
<%@ attribute name="id" type="java.lang.String" required="true" description="组件的ID"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="文本名称（name）"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="文本域值（value）"%>
<%@ attribute name="readonly" type="java.lang.Boolean" required="false" description="编辑器是否是只读"%>
<%@ attribute name="maxlength" type="java.lang.String" required="false" description="编辑器最大输入数"%>
<%@ attribute name="height" type="java.lang.String" required="false" description="编辑器高度"%>
<%@ attribute name="simpleToolbars" type="java.lang.Boolean" required="false" description="使用简单toolbars"%>
<%@ attribute name="options" type="java.lang.String" required="false" description="UE选项，逗号隔开。"%>
<%@ attribute name="outlineView" type="java.lang.Boolean" required="false" description="是否显示大纲视图"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式，非空验证：required"%>
<%--
	调用实例：
	<sys:ueditor id="content" name="contentText" value="${message.contentText}" maxlength="2000" height="130" simpleToolbars="true"/>
	
	空值验证：
	$("#inputForm").validate({
		submitHandler: function(form){
			// 验证content内容是否为空
			if (!contentUE.hasContents()){
           		contentUE.focus();
            	showMessage('请填写正文内容！', '警告', 'warning');
                return false;
            }
            // 以下为提交表单及后续代码
            ajaxSubmitForm($(form), function(data){
			}, "json");
        }
	});
--%>
<c:if test="${outlineView}">
	<div class="row edui-outline" id="${id}OutlineView">
		<div class="col-xs-9 left">
			<textarea id="${id}" name="${name}" rows="4" class="${cssClass}" style="position:absolute;z-index:-1000;top:43%;right:10%;"></textarea>
			<script type="text/plain" id="${id}UE" style="width:100%;height:${not empty height ? height : 200}px;">${value}</script>
		</div>
		<div id="${id}OpenClose" class="open-close toc-close">&nbsp;</div>
		<div class="col-xs-3 right">
		    <div class="wrapper" id="${id}Wrapper">
		        <div class="wrapperTitle">目录标题：</div>
		        <div class="wrapperContainer" id="${id}Container"></div>
		        <div class="clearfix"></div>
		    </div>
		</div>
	</div>
</c:if>
<c:if test="${!outlineView}">
	<textarea id="${id}" name="${name}" rows="4" class="${cssClass}" style="position:absolute;z-index:-1000;top:10%;right:5%;"></textarea>
	<script type="text/plain" id="${id}UE" style="width:100%;height:${not empty height ? height : 200}px;">${value}</script>
</c:if>
<script type="text/javascript">
var ${id}UE;
$(function() {
	${id}UE = UE.getEditor('${id}UE', {
		<c:if test="${not empty maxlength}">maximumWords: ${maxlength}, </c:if>
		<c:if test="${not empty simpleToolbars}">toolbars: 
			[['fullscreen', 'undo', 'redo', '|', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 
			  'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 
			  'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|', 'simpleupload', 'insertimage', 
			  'emotion', 'scrawl', 'insertvideo', 'music', 'attachment']], </c:if>${options}
		readonly: ${not empty readonly ? readonly : false}, initialFrameHeight: ${not empty height ? height : 200},
	});
	// 更新编辑器内容    ${id}UE.updateContent();
	${id}UE.updateContent = function(){
		$('#${id}').val((!${id}UE.hasContents()) ? "" : ("<!--HTML-->" + (${id}UE.getContent()).replace('<!--HTML-->','')));
		if (typeof webuploaderRefresh == 'function'){
			webuploaderRefresh(); // 编辑器高度变化时，重新计算上传控件位置
		}
	};
	<c:if test="${outlineView}">
	// 刷新目录表题树    ${id}UE.refreshDirectiontion();
	${id}UE.refreshDirection = function(){
	    var dirmap = {}, dir = ${id}UE.execCommand('getsections');
	    // 更新目录树
	    $('#${id}Container').html(traversal(dir) || '暂无大纲标题.');
	    // 点击章节触发
	    $('#${id}Container .sectionItem').click(function(e){
	        var $target = $(this), address = $target.attr('data-address');
	        ${id}UE.execCommand('selectsection', dirmap[address], true);
	    });
		// 生成更新目录树
	    function traversal(section) {
	        var $list, $item, $itemContent, child, childList;
	        if(section.children.length) {
	            $list = $('<ul>');
	            for(var i = 0; i< section.children.length; i++) {
	                child = section.children[i];
	                //设置目录节点内容标签
	                $itemContent = $('<span class="sectionItem">' + child['title'] + '</span>');
	                $itemContent.attr('data-address', child['startAddress'].join(','));
	                dirmap[child['startAddress'].join(',')] = child;
	                //设置目录节点容器标签
	                $item = $('<li>');
	                $item.append($itemContent);
	                //继续遍历子节点
	                if($item.children.length) {
	                    childList = traversal(child);
	                    childList && $item.append(childList);
	                }
	                $list.append($item);
	            }
	        }
	        return $list;
	    }
		// 重设大纲视图宽度
    	$('#${id}Wrapper').css('width', $('#${id}OutlineView .right').width()+'px');
	};
	// 页面网上滚动时，让目录固定在顶部
    $(window).scroll(function(e) {
    	var scrollTop = (document.body.scrollTop||document.documentElement.scrollTop), leftTop = $('.left').offset().top,
    		wrapperHeight = ($('#${id}Wrapper').height()), wrapperHeight = (wrapperHeight > 0 ? wrapperHeight : 200);
    	if(leftTop < scrollTop && leftTop + $('.left').height() - scrollTop - wrapperHeight > 0) {
            $('#${id}Wrapper').addClass('fixTop');
            $('#${id}OpenClose').addClass('fixTop');
        } else {
            $('#${id}Wrapper').removeClass('fixTop');
            $('#${id}OpenClose').removeClass('fixTop')
        }
		// 重设大纲视图宽度
    	$('#${id}Wrapper').css('width', $('#${id}OutlineView .right').width()+'px');
    }).resize(function(){
		// 重设大纲视图宽度
    	$('#${id}Wrapper').css('width', $('#${id}OutlineView .right').width()+'px');
    });
    // 显示或隐藏目录树
    $('#${id}OpenClose').click(function(){
    	if($(this).hasClass("toc-close")){
    		$(this).removeClass("toc-close");
    		$(this).addClass("toc-open");
    		$("#${id}OutlineView .right").hide();
    		$("#${id}OutlineView .left").removeClass('col-xs-9');
    		$("#${id}OutlineView .left").addClass('col-xs-12');
    	}else{
    		$(this).addClass("toc-close");
    		$(this).removeClass("toc-open");
    		$("#${id}OutlineView .right").show();
    		$("#${id}OutlineView .left").removeClass('col-xs-12');
    		$("#${id}OutlineView .left").addClass('col-xs-9');
    	}
    	${id}UE.fireEvent('keydown', 0); // 重置工具栏大小
    });
    </c:if>
    // 编辑器加载完成事件
	${id}UE.ready(function(){
		${id}UE.addListener('contentchange', function(){
			${id}UE.updateContent();
		});
		<c:if test="${outlineView}">
		${id}UE.addListener('updateSections', function(){
			${id}UE.refreshDirection();	
		});
		${id}UE.refreshDirection();
		</c:if>
		${id}UE.updateContent();
    });
});
$('#${id}').parents('form').submit(function(){
	${id}UE.updateContent();
});
</script>