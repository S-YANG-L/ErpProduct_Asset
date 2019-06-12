<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid,jbox"/>
<sys:header title="文件管理管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-user"></i> 文件管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm isEdit" id="btnImport" title="文件上传"><i class="fa fa-cloud-upload"></i> 文件上传</a>
			<a href="#" class="btn btn-default btn-sm isEdit" id="btnImportFx" title="文件分享"><i class="fa fa-share-square-o"></i> 文件分享</a>
			<a href="#" class="btn btn-default btn-sm isEdit" id="btnImportZy" title="文件移到"><i class="fa fa-retweet"></i> 文件移到</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="fileUser" action="${ctx}/file/fileEntityListData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<form:hidden path="dirId"/>
			<form:hidden path="fileDir.globalId"/>
			<div class="form-group">
				<label class="control-label">文件名称：</label>
				<div class="input-inline width-160" >
					<form:input path="fileName" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">上传时间：</label>
				<div class="input-inline width-260" >
					<input name="createDate" type="text" readonly="readonly" maxlength="20" class="Wdate-date"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="float:left;"/>--
					<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="Wdate-date"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="float:;"/>
				</div>
			</div>
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="查询" id="serchBtn"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>
		</form:form>
		<table id="dataGrid"></table>
	    <div id="dataGridPage"></div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
    var doc = [".doc",".docx",".rtf"];
    var jpg = [".jpg",".bmp",".gif",".pic",".png",".tif"];
    var mp3 = [".wav",".mp3",".ram",".wma",".mmf",".amr"];
    var mv = [".avi",".mpg",".mov",".swf"];
    var pdf = [".doc",".docx"];
    var ppt = [".ppt",".pptx"];
    var rar = [".rar",".zip"];
    var xls = [".xls",".xlsx"];
    var txt = [".txt"];
    var isEdit = true;
	// 初始化DataGrid对象
	var dataGrid = new DataGrid({
			
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		multiselect:true,
		// 设置数据表格列
		columnModel: [
			/* {header:'文件图标', name:'fileType', index:'file_type', width:200}, */
			/* /static/ueditor/1.4.3/dialogs/attachment/fileTypeImages */
			{header:'fileUserId', name:'fileUserId', index:'f.file_suffix', width:50,align:'center',hidden:true},
			{header:'&nbsp;', name:'fileEntity.fileSuffix', fixed:true, sortable:true,frozen:true,index:'f.file_suffix', width:30,align:'center',formatter: function(val, obj, row, act){
				var cc = "";
				if(doc.indexOf(val)>-1){
					cc="doc.gif";
				}else if(jpg.indexOf(val)>-1){
					cc="jpg.gif";
				}else if(mp3.indexOf(val)>-1){
					cc="mp3.gif";
				}else if(mv.indexOf(val)>-1){
					cc="mv.gif";
				}else if(pdf.indexOf(val)>-1){
					cc="pdf.gif";
				}else if(ppt.indexOf(val)>-1){
					cc="ppt.gif";
				}else if(rar.indexOf(val)>-1){
					cc="rar.gif";
				}else if(xls.indexOf(val)>-1){
					cc="xls.gif";
				}else{
					cc="txt.gif";
				}
				return "<img src=${ctxStatic}/ueditor/1.4.3/dialogs/attachment/fileTypeImages/icon_"+cc+"/>";
			}},
			{header:'文件名称', name:'fileName', index:'file_name', width:150,align:'left',formatter:function(val,obj,row,act){
				return '<a href="${ctx}/file/download/'+row.fileUserId+'" target="_blank">'+row.fileName+'</a>';
			}},
			{header:'所属文件目录', name:'fileDir.dirName', index:'file_name', width:110,align:'center'},
			{header:'文件大小', name:'fileEntity.fileSizeFormat', index:'f.file_size', width:100,align:'right'},
			{header:'上传时间', name:'createDate', index:'a.create_date', width:120,align:'center'},
			{header:'上传人', name:'createByName', index:'a.create_by', width:90,align:'center'},
			{header:'操作', name:'actions', width:80, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				actions.push('<a class="btn default btn-xs" href="${ctxPath}'+row.fileEntity.fileDownloadPath+'?fileName='+row.fileName+'&preview=true" target="_blank"><i class="fa fa-eye"></i> 预览 </a>');
				if (row.status == Global.STATUS_NORMAL){
					//actions.push('<a href="${ctx}/file/fileEntity/form?fileId='+row.fileId+'" class="btnList" title="编辑文件管理"><i class="fa fa-pencil"></i></a>&nbsp;');
					if(isEdit){
						actions.push('<a href="${ctx}/file/delFileUpload?fileUserId='+row.fileUserId+'" class="btnList isEdit" title="删除文件" data-confirm="确认要删除该文件吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
					}
				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
	//文件上传
	$("#btnImport").click(function(){
		if(null==$("#dirId").val()||""==$("#dirId").val()){
			showMessage("请在左侧选择文件上传的目录");
			return;
		}
		top.$.jBox("iframe:${ctx}/file/fileUpload?dirId="+$("#dirId").val(),{title:"", width: 800, height: 300, buttons:{ '关闭': true },bottomText:"",
			closed:function (){
				$("#serchBtn").click();
            }
		  }
		);  
	});
	
	//文件分享
	$("#btnImportFx").click(function(){
		var fileUserIds = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
	    if(0==fileUserIds.length){
	    	showMessage("请选择要分享的文件");
			return;
	    }
	    var submit = function (v, h, f) {
	    	var ifr = h.find("iframe"), win = ifr[0].contentWindow, conts = ifr.contents();
	    	if(v == true){
	    		win.btnSubmit.click();
	    		if(undefined!=win.userCode&&null!=win.userCode&&null!=win.userCode.value&&'undefined'!=win.userCode.value&&''!=win.userCode.value){
		    		return true;
	    		}else{
	    			return false;
	    		}
	    	}else{
	    		return true;
	    	}
	    };
	    top.$.jBox("iframe:${ctx}/file/fileUserShare/form?fileUserId="+fileUserIds,{title:"文件分享", width: 600, height: 300, submit:submit,buttons:{ '分享':true,'关闭': false },bottomText:""});  
	});
	
	//文件转移
	$("#btnImportZy").click(function(){
		var fileUserIds = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
	    if(0==fileUserIds.length){
	    	showMessage("请选择要转移的文件");
			return;
	    }
	    var submit = function (v, h, f) {
	    	var ifr = h.find("iframe"), win = ifr[0].contentWindow, conts = ifr.contents();
	    	if(v == true){
	    		win.btnSubmit.click();
	    		if(undefined!=win.dirIdCode&&null!=win.dirIdCode&&null!=win.dirIdCode.value&&'undefined'!=win.dirIdCode.value&&''!=win.dirIdCode.value){
		    		return true;
	    		}else{
	    			return false;
	    		}
	    	}else{
	    		return true;
	    	}
	    };
	    //alert($("#fileDir\\.globalId").val());
	    top.$.jBox("iframe:${ctx}/file/fileMove?fileUserId="+fileUserIds+"&fileDir.globalId="+$("#fileDir\\.globalId").val(),{title:"文件移到", width: 430, height: 240, submit:submit,buttons:{ '确定':true,'关闭': false },bottomText:"",
	    	closed:function (){
				$("#serchBtn").click();
	    	 }
		  }
		);  
	    //$("#parent").click();
	}); 
</script>