<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="panel panel-default" id="fileConfig" style="display: none;">
    <div class="panel-heading">
        <h3 class="panel-title">附件</h3>
    </div>
    <div class="panel-body">
    	<div class="row">
    		<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="业务表分类（一种业务下不能重复）">
	        		<span class="required">*</span>附件编号：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<input type="text" name="optionMap['bizCategory']" class="form-control required" readonly="readonly" value="${formEntityColumn.optionMap['bizCategory']}"/>
					</div>
	        	</div>
	        </div>
    		<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="指定上传文件类型">
	        		<span class="required">*</span>上传文件类型：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<select name="optionMap['uploadType']" class="form-control required" onchange="changeUploadFileType(this.value)">
							<c:forEach items="${fns:getDictList('form_file_type')}" var="dict">
								<option value="${dict.value}" <c:if test="${formEntityColumn.optionMap['uploadType'] eq dict.value}">selected="selected"</c:if>>${dict.label}</option>
							</c:forEach>
						</select>
					</div>
	        	</div>
	        </div>
    	</div>
    	<div class="row">
    		<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="勾选是否只读，则只能查看">
	        		是否只读：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<c:forEach items="${fns:getDictList('yes_no')}" var="dict">
							<input type="radio" name="optionMap['readonly']" value="${dict.value}"  <c:if test="${formEntityColumn.optionMap['readonly'] eq dict.value}">checked="checked"</c:if> />${dict.label}
						</c:forEach>
					</div>
	        	</div>
	        </div>
    		<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="指定最多上传几个文件，-1表示不限制">
	        		最大上传个数：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<input type="text" name="optionMap['maxUploadNum']" class="form-control" value="${formEntityColumn.optionMap['maxUploadNum']}" />
					</div>
	        	</div>
	        </div>
    	</div>
    	<div class="row" id="widthHeight" style="display: none;">
    		<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="最大宽度，上传文件类型为图片时生效">
	        		最大宽度：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<input id="imageMaxWidth" type="text" name="optionMap['imageMaxWidth']" class="form-control" value="${formEntityColumn.optionMap['imageMaxWidth']}"/>
					</div>
	        	</div>
	        </div>
    		<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="最大高度，上传文件类型为图片时生效">
	        		最大高度：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<input id="imageMaxHeight" type="text" name="optionMap['imageMaxHeight']" class="form-control" value="${formEntityColumn.optionMap['imageMaxHeight']}"/>
					</div>
	        	</div>
	        </div>
    	</div>
    	<div class="row">
    		<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="是否显示预览按钮, true:weboffice, ntko:ntko,false:不预览">
	        		预览方式：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<select name="optionMap['preview']" class="form-control ">
							<option value=""></option>
							<c:forEach items="${fns:getDictList('form_preview_type')}" var="dict">
								<option value="${dict.value}" <c:if test="${formEntityColumn.optionMap['preview'] eq dict.value}">selected="selected"</c:if>>${dict.label}</option>
							</c:forEach>
						</select>
					</div>
	        	</div>
	        </div>
    		<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="为‘是’则生成表单后为精简上传组件">
	        		是否为精简上传：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<c:forEach items="${fns:getDictList('yes_no')}" var="dict">
							<input type="radio" name="optionMap['isMini']" value="${dict.value}"  <c:if test="${formEntityColumn.optionMap['isMini'] eq dict.value}">checked="checked"</c:if> />${dict.label}
						</c:forEach>
					</div>
	        	</div>
	        </div>
    	</div>
    	<div class="row">
    		<div class="col-xs-12">
	        	<div class="form-group">
	        		<label class="control-label col-sm-2" title="指定允许上传的后缀，为空则不限制">
	        		允许上传的后缀：<i class="fa icon-question"></i></label>
					<div class="col-sm-10">
						<select name="optionMap['allowSuffixs']" class="form-control" multiple="multiple" id="imageFileSuffixs" >
							<optgroup label="文件">
							<c:forEach items="${fns:getDictList('form_file_allow_suffixs')}" var="dict">
								<option value="${dict.value}" <c:if test="${fn:contains(formEntityColumn.optionMap['allowSuffixs'],dict.value)}">selected="selected"</c:if>>${dict.label}</option>
							</c:forEach>
							</optgroup>
							<optgroup label="图片">
							<c:forEach items="${fns:getDictList('form_image_allow_suffixs')}" var="dict">
								<option value="${dict.value}" <c:if test="${fn:contains(formEntityColumn.optionMap['allowSuffixs'],dict.value)}">selected="selected"</c:if>>${dict.label}</option>
							</c:forEach>
							</optgroup>
							<optgroup label="视频">
							<c:forEach items="${fns:getDictList('form_media_allow_suffixs')}" var="dict">
								<option value="${dict.value}" <c:if test="${fn:contains(formEntityColumn.optionMap['allowSuffixs'],dict.value)}">selected="selected"</c:if>>${dict.label}</option>
							</c:forEach>
							</optgroup>
						</select>
					</div>
	        	</div>
	        </div>
    	</div>
    	<div class="row">
    		<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="设置为手动上传需要点击上传按钮才上传文件，否则选择后就直接上传">
	        		上传方式：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<select name="optionMap['lazyUpload']" class="form-control ">
							<option value=""></option>
							<c:forEach items="${fns:getDictList('form_lazy_upload')}" var="dict">
								<option value="${dict.value}" <c:if test="${formEntityColumn.optionMap['lazyUpload'] eq dict.value}">selected="selected"</c:if>>${dict.label}</option>
							</c:forEach>
						</select>
					</div>
	        	</div>
	        </div>
    		<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="设置data-msg-required属性，不为空验证的提示信息">
	        		验证提示信息：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<input type="optionMap['dataMsgRequired']" class="form-control " value="${formEntityColumn.optionMap['dataMsgRequired']}"/>
					</div>
	        	</div>
	        </div>
    	</div>
    </div>
</div>
    <div class="panel panel-default" >
		<div class="panel-heading">
		    <h3 class="panel-title">样式</h3>
		</div>
		<div class="panel-body">
		<div class="row">
			<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title="输入css类型，多个以空格分割">
						CSS类名：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<form:input path="cssClass" htmlEscape="false" maxlength="500" class="form-control"/>
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title="指定css样式，多个以英文分号分割">
						CSS样式：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<form:input path="cssStyle" htmlEscape="false" maxlength="500" class="form-control"/>
						</div>
					</div>
				</div>
			</div>	
		</div>
	</div>
<script type="text/javascript">
       
</script>	
<script type="text/javascript">
    if (window.Select2 !== undefined){
		$("#centerPage select:not(.noselect2)").select2().on('change', function(){
			try{$(this).valid();}catch(e){}//未定义抛异常
		});
	}
	if (jQuery().uniform) {
		$("#centerPage input[type=checkbox], #centerPage input[type=radio]").uniform();
    }
	// 只有当上传类型为图片时才显示高度、宽度
	function changeUploadFileType(val){
		if(val=='image'){
			$('#imageMaxWidth').val('1024');
			$('#imageMaxHeight').val('768');
			$("#widthHeight").show();
		}else{
			$('#imageMaxWidth').val('');
			$('#imageMaxHeight').val('');
			$("#widthHeight").hide();
		}
	}
</script>
		
