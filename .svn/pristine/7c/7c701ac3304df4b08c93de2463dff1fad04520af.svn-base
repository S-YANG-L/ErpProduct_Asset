<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="文件分享管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 文件分享管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="fileUserShare" action="${ctx}/file/fileUserShare/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">分享类型：</label>
				<div class="input-inline width-160" >
					<form:radiobutton path="shareType" value="0" checked="true" class="input-sm" onclick="$('#serchBtn').click();"/>我分享
					<form:radiobutton path="shareType" value="1" class="input-sm" onclick="$('#serchBtn').click();"/>分享给我<br/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">文件名称：</label>
				<div class="input-inline width-160" >
					<form:input path="fileUser.fileName" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">上传时间：</label>
				<div class="input-inline width-260" >
					<input name="fileUser.createDate" type="text" readonly="readonly" maxlength="20" class="Wdate-date"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="float:left;"/><span style="margin-left:3px;margin-right:0px">--</span>
					<input name="fileUser.updateDate" type="text" readonly="readonly" maxlength="20" class="Wdate-date"
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
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
			{header:'分享编码', name:'shareId', index:'a.share_id', width:200, align:"center", frozen:true,hidden:true},
			{header:'分享的用户文件id', name:'fileUserId', index:'a.file_user_id', width:200, align:"center",hidden:true},
			{header:'&nbsp;', name:'fileEntity.fileSuffix', index:'f.file_suffix',frozen:true,fixed:true,sortable:false,width:30,align:'center',formatter: function(val, obj, row, act){
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
			{header:'文件名称', name:'fileUser.fileName', index:'file_name', width:150,align:'left',formatter:function(val,obj,row,act){
				return '<a href="${ctx}/file/download/'+row.fileUserId+'" target="_blank">'+row.fileUser.fileName+'</a>';
			}},
			{header:'所属文件目录', name:'fileUser.fileDir.dirName', index:'file_name', width:130,align:'center'},
			{header:'文件大小', name:'fileEntity.fileSizeFormat', index:'f.file_size', width:90,align:'right'},
			{header:'上传时间', name:'fileUser.createDate', index:'a.create_date', width:120,align:'center'},
			{header:'上传人', name:'fileUser.createByName', index:'a.create_by', width:80,align:'center'},
			{header:'分享给', name:'user.userName', index:'a.create_by', width:80, align:"center"},
			{header:'分享人', name:'createByName', index:'a.create_by', width:80, align:"center"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				console.info(row);
				var actions = [];//<shiro:hasPermission name="file:fileUserShare:edit">
				if (row.status == Global.STATUS_NORMAL){
					//actions.push('<a href="${ctx}/file/fileUserShare/form?shareId='+row.shareId+'" class="btnList" title="编辑文件分享"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/file/fileUserShare/delete?shareId='+row.shareId+'" class="btnList" title="删除该文件分享" data-confirm="确认要删除该文件分享吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>