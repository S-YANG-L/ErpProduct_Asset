<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><%-- 使用该组件请在header.tag和footer.tag中引入uploadfile类库 --%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="bizCategory" type="java.lang.String" required="true" description="name, 业务表分类（一种业务下不能重复）"%>
<%@ attribute name="bizKey" type="java.lang.String" required="true" description="value, 业务表的主键值（与附件关联的业务数据）"%>
<%@ attribute name="dirId" type="java.lang.String" required="false" description="id, 文件目录ID"%>
<%@ attribute name="returnPath" type="java.lang.Boolean" required="false" description="是否是返回文件路径到输入框（默认false）"%>
<%@ attribute name="filePathInputId" type="java.lang.String" required="false" description="设置文件路径存放的输入框的ID，当returnPath为true的时候，返回文件路径到这个输入框"%>
<%@ attribute name="fileNameInputId" type="java.lang.String" required="false" description="设置文件名称存放的输入框的ID，当returnPath为true的时候，返回文件名称到这个输入框"%>
<%@ attribute name="uploadType" type="java.lang.String" required="false" description="上传文件类型 all、file、image、media"%>
<%@ attribute name="allowSuffixs" type="java.lang.String" required="false" description="允许上传的后缀。"%>
<%@ attribute name="readonly" type="java.lang.Boolean" required="false" description="只读模式为，查看模式"%>
<%@ attribute name="imageMaxWidth" type="java.lang.Integer" required="false" description="最大宽度(uploadType为image生效)"%>
<%@ attribute name="imageMaxHeight" type="java.lang.Integer" required="false" description="最大高度(uploadType为image生效)"%>
<%@ attribute name="allowServerSelect" type="java.lang.Boolean" required="false" description="是否允许从服务器上选（暂未实现）"%>
<%@ attribute name="maxUploadNum" type="java.lang.Integer" required="false" description="多文件下允许最多上传几个 -1为不限制"%>
<%@ attribute name="lazyUpload" type="java.lang.Boolean" required="false" description="设置为ture需要点击上传按钮才上传文件，否则选择后就直接上传"%>
<%@ attribute name="isMini" type="java.lang.Boolean" required="false" description="是否是精简上传窗口，上传单个文件，如证件或照片时用"%>
<%@ attribute name="imageStyle" type="java.lang.String" required="false" description="设置图片框的样式，例如：设置图片显示的宽高：width:130px;height:180px;"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式，非空验证：required"%>
<%@ attribute name="dataMsgRequired" type="java.lang.String" required="false" description="设置data-msg-required属性，不为空验证的提示信息"%>
<%@ attribute name="preview" type="java.lang.String" required="false" description="是否显示预览按钮, true:weboffice, ntko:ntko"%>
<c:if test="${not empty imageStyle}"><style type="text/css">
	#image_wup .web_uploader_img .filelist li, #image_wup .web_uploader_img .filelist li p.imgWrap{${imageStyle}}
</style></c:if>
<input id="${id}" name="${bizCategory}" type="text" class="${cssClass}" style="position:absolute;z-index:-1000;top:43%;left:10%;"
	data-msg-required="${not empty dataMsgRequired ? dataMsgRequired : '请上传文件'}" value="${not empty returnPath && returnPath ? bizKey : ''}"/>
<div id="outerdiv" style="position:fixed;top:0;left:0; background:rgba(0,0,0,0.7); z-index:99999;width:100%;height:100%;display:none;">
	<div id="innerdiv"style="position:fixed;"><img id="bigimg" style="border:2px solid #fff;" src="" /></div>
</div>
<div id="${id}_wup" class="wup_container ${isMini ? 'mini' : ''}">
	<div class="area">
		<c:choose>
			<c:when test="${uploadType =='image'}">
				<div id="${id}Uploader" class="web_uploader_img">
				    <div class="statusBar" style="display:none;">
						<c:if test="${!isMini}">
					        <div class="progress">
					            <span class="text">0%</span>
					            <span class="percentage"></span>
					        </div>
					    	<div class="info"></div>
					    </c:if>
					    <c:if test="${isMini && maxUploadNum gt 1}">
					    	<div class="info"></div><%-- 如果是mini界面并上传个数大于1，则显示出来上传信息和继续上传按钮 --%>
					    </c:if>
				        <div class="btns">
				            <div id="${id}filePicker2" class="webuploader-container"></div>
			            	<div class="uploadBtn state-pedding">开始上传 </div>
				        </div>
			    	</div>
				    <div class="queueList">
				    	<ul id="${id}fileLists" class="filelist"></ul>
				        <c:if test="${empty readonly || !readonly}">
				        	<div id="${id}dndArea" class="placeholder">
					            <div id="${id}filePicker" class="webuploader-container"></div>
					            <c:if test="${!isMini}">
					            	<p>或将照片拖到这里，最多可选${not empty maxUploadNum ? maxUploadNum : 300}张</p>
					            </c:if>
					        </div>
				        </c:if>
				    </div>
				</div> 
			</c:when>
			<c:otherwise>
				<div id="${id}Uploader" class="web_uploader_wrap">
					<div class="statusBar" style="display: none;">
						<div class="progress">
							<span class="text">0%</span>
							<span class="percentage"></span>
						</div>
						<div class="info"></div>
						<div class="btns">
							<div id="${id}filePicker2" class="webuploader-container"></div>
							<div class="uploadBtn">开始上传</div>
						</div>
					</div>
					<div class="queueList">
						<div class="table-scrollable">
							<table class="table table-striped filetable table-hover">
								<tbody id="${id}fileLists"></tbody>
							</table>
						</div>
						<c:if test="${empty readonly || !readonly}">
							<div id="${id}dndArea" class="placeholder">
								<div id="${id}filePicker" class="webuploader-container"></div>
								<p>或将文件拖到这里，最多可选${not empty maxUploadNum ? maxUploadNum : 300}个</p>
							</div>
						</c:if>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<script type="text/javascript">
	$(function() {
		$('#${id}Uploader').webuploader({
			id: '${id}',
			bizCategory : '${bizCategory}',
			bizKey : '${bizKey}',
			dirId : '${dirId}',
			returnPath : ${not empty returnPath ? returnPath : false},
			filePathInputId : '${filePathInputId}',
			fileNameInputId : '${fileNameInputId}',
			uploadType : '${uploadType}',
			readonly : ${not empty readonly ? readonly : false},
			imageMaxWidth : ${not empty imageMaxWidth ? imageMaxWidth : 1024},
			imageMaxHeight : ${not empty imageMaxHeight ? imageMaxHeight : 768},
			allowServerSelect : ${not empty allowServerSelect ? allowServerSelect : false},
			lazyUpload : ${not empty lazyUpload ? lazyUpload : false},
			maxUploadNum : ${not empty maxUploadNum ? maxUploadNum : 300},
			maxFileSize : ${fns:getConfigDefault('file.maxFileSize', '100*1024*1024')},
			maxFilesSize : ${fns:getConfigDefault('file.maxFilesSize', '500*1024*1024')},
			imageAllowSuffixs: '${not empty allowSuffixs ? allowSuffixs : fns:getConfigDefault("file.imageAllowSuffixs", "")}',
			mediaAllowSuffixs: '${not empty allowSuffixs ? allowSuffixs : fns:getConfigDefault("file.mediaAllowSuffixs", "")}',
			fileAllowSuffixs: '${not empty allowSuffixs ? allowSuffixs : fns:getConfigDefault("file.fileAllowSuffixs", "")}',
			preview: '${not empty preview ? preview : ''}',
		  	ctxPath:'${ctxPath}',
		  	ctx:'${ctx}',
			ctxStatic :'${ctxStatic}'
		});
	}); 
</script>