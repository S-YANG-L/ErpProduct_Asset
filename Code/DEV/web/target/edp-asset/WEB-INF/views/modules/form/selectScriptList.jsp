<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="脚本管理管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-body list">
		<table>
			<tr>
				<td style="width: 80%;vertical-align: top;padding-right: 6px;">
					<textarea name="scriptContent" id="scriptContent" style="width: 100%;height: 240px;">${formScript.scriptContent}</textarea>					
					<div id="scriptGroovy" class="editorcss" style="width: 100%;height: 347px;"></div>
				</td>
				<td style="width: 30%;">
					<form:form id="searchForm" modelAttribute="formScript" action="${ctx}/form/formScript/listData" method="post" class="breadcrumb form-inline"
						data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
					<div class="form-group hide">
						<label class="control-label">脚本语言：</label>
						<div class="input-inline">
							<form:select path="scriptLanguage" class="form-control input-sm" cssStyle="width:90px;">
								<form:option value="" label="全部"/>
								<form:options items="${fns:getDictList('form_entity_language')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label">脚本类别：</label>
						<div class="input-inline">
							<form:select id="scriptType" path="scriptType" class="form-control input-sm" cssStyle="width:90px;">
								<form:option value="" label="全部"/>
								<form:options items="${fns:getDictList('form_entity_script_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
					<%-- <div class="form-group">
						<label class="control-label">脚本名称：</label>
						<div class="input-inline">
							<form:input path="scriptName" htmlEscape="false" maxlength="100" class="form-control input-sm" cssStyle="width:100px;"/>
						</div>
					</div> --%>
					<!-- <div class="form-group hide" style="margin-left:10px;"> 
						<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
						<input class="btn default btn-sm" type="reset" value="重置"/>
					</div> -->
				</form:form>
					<table id="dataGrid"></table>
				</td>
			</tr>
		</table>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<!-- ace -->
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/ext-language_tools.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/theme-monokai.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/ext-settings_menu.js"></script>
<style>
.editorcss {
    /**position: absolute;**/
    width: 100%;
    height: 360px;
}
pre {
	white-space: pre-wrap;       /* css-3 */
	white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
	white-space: -pre-wrap;      /* Opera 4-6 */
	white-space: -o-pre-wrap;    /* Opera 7 */
	word-wrap: break-word;       /* Internet Explorer 5.5+ */
	word-break:break-all;
	overflow:hidden;
	width:100%;
	height:360px
}
</style>
<script type="text/javascript">
var editor = ace.edit("scriptGroovy");
editor.focus();
editor.setOptions({  
   enableBasicAutocompletion: true,  
   enableSnippets: true,  
   enableLiveAutocompletion: true,//只能补全  
});
//editor.setTheme("ace/theme/twilight");
var language = '${formScript.scriptLanguage}';
if(language == "Groovy"){
	editor.session.setMode("ace/mode/groovy");
}else if(language == "CSS"){
	editor.session.setMode("ace/mode/css");
}else if(language == "JS"){
	editor.session.setMode("ace/mode/js");
}

var textarea = $('textarea[name="scriptContent"]').hide();
//alert(textarea.val());
editor.getSession().setValue(textarea.val());
//alert(editor.getSession().getValue());
editor.getSession().on('change', function(){
textarea.val(editor.getSession().getValue());
});
/* var init=function(id,setM){
	var editor = ace.edit(id);
	editor.focus();
	editor.setOptions({  
	   enableBasicAutocompletion: true,  
	   enableSnippets: true,  
	   enableLiveAutocompletion: true,//只能补全  
	});
	// editor.setTheme("ace/theme/twilight");
	editor.session.setMode("ace/mode/"+setM);
	
	var textarea = $('textarea[name="'+id+'"]').hide();
	editor.getSession().setValue(textarea.val());
	editor.getSession().on('change', function(){
	  textarea.val(editor.getSession().getValue());
	});
} */
</script>
<script type="text/javascript">
	//脚本对象
	var scriptVal;
	var dataMap = {};
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		//showCheckbox: true,
		// 设置数据表格列
		columnModel: [
			{header:'id', name:'id', index:'a.id', width:160, align:"left", hidden:true},
			{header:'脚本语言', name:'scriptLanguage', index:'a.script_language', width:120, align:"center", hidden:true, frozen:true, formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('form_entity_language')},val,'',true);
			}},
			{header:'脚本类别', name:'scriptType', index:'a.script_type', width:120, align:"center", frozen:true, formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('form_entity_script_type')},val,'',true);
			}},
			{header:'脚本名称', name:'scriptName', index:'a.script_name', width:160, align:"left"}
		],
		onSelectRow: function(id, isSelect, event){
			var rowData = $('#dataGrid').dataGrid('getRowData', id);
			searchScriptContent(rowData);
		},
		ondblClickRow: function(id, rownum, colnum, event){
			var rowData = $('#dataGrid').dataGrid('getRowData', id);
			searchScriptContent(rowData);
			var $jBox = getJBox();
			$jBox.getBox().find("button[value='ok']").trigger("click");
		},
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	// 查询脚本内容
	function searchScriptContent(rowData){
		var id = rowData.id;
		var name = rowData.scriptName;
		$.post('${ctx}/form/formScript/getScriptContent',{id:id},function(data){
			$("#scriptContent").val(data);
			dataMap['scriptContent'] = data;
			dataMap['scriptName'] = name;
			editor.getSession().setValue(data);
		},'text');
	}
	// 选择脚本
	function getScriptContent(){
		if($("#scriptContent").val() == ''){
			showMessage('请选择脚本!');
		}else{
			//return $("#scriptContent").val();
			return dataMap;
		}
	}
	$("#scriptType").change(function(){
		$("#searchForm").submit();
	});
</script>