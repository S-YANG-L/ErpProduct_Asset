<%@ page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid,jBox,ueditor" />
<sys:header title="表单预览" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-coffee"></i>表单预览
		</div>
	</div>
	<div class="portlet-body form">
		<form id="inputForm" action="" method="post" class="form-horizontal">
			<div class="form-body">
				${formDef.formContent}
			</div>
		</form>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	$(document).ready(function(){
		$('.Wdate').attr('onclick','WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});');
		resolveHtml();
	});
	
	function resolveHtml(){
		$('.preview').remove();
		$('.remove').remove();
		$('.drag').remove();
		$('.lyrow .configuration').remove();
		console.info('1=================');
		
		var n = $('.lyrow').children();
		console.info('1=================');
		$('.form-body').empty();
		for(var i=0;i<n.length;i++){
			$('.form-body').append(n.eq(i).html());
		}
		var n1 = $('.row').children();
		console.info('=================');
		console.info(n1.html());
		console.info('=================');
		var n2 = n1.children().children();
		for(var i=0;i<n1.length;i++){
			console.info(n2.eq(i));
			console.info(n2.eq(i).html());
			n1.eq(i).html(n2.eq(i).html());
		}
		// 移除以下样式
		$('.clearfix').removeClass('clearfix');
		$('.ui-sortable').removeClass('ui-sortable');
		$('.column').removeClass('column');
		// 给所有的select进行美化
		$('.noselect2').select2();
		$('.noselect2').removeClass('.noselect2');
		// 该隐藏的隐藏
		$('.hideDomain').addClass('hide');
		// 有富文本的添加富文本
		$.each($('.textarea'),function(idx,data){
			$(this).removeClass('form-control');
			var width = $(this).attr('width');
			var height = $(this).attr('height');
			var contentUE = UE.getEditor($(this).attr('id'), {maximumWords:2000, /* toolbars: 
				[['fullscreen', 'source', 'undo', 'redo', '|', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 
				  'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 
				  'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc']], */initialFrameWidth:width,initialFrameHeight: height});
		});
	}
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				
			}, "json");
	    }
	});
</script>


