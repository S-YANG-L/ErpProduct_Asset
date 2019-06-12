<%@ page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="row">
	<div class='container-fluid'>
		<div class='tabbable tabs-left'>
			<!-- 选项卡：通过BS的类来控制选项卡的样式 -->
			<ul class='nav nav-tabs'>
				<li class='active'><a href='#tab1' name="tab1" data-toggle='tab'>增强Groovy</a></li>
				<li><a href='#tab2' name="tab2" data-toggle='tab'>增强CSS样式</a></li>
				<li><a href='#tab3' name="tab3" data-toggle='tab'>增强JS脚本</a></li>
			</ul>
			<!--选项卡的内容定义-->
			<div class='tab-content'>
				<div class='tab-pane active' id='tab1'>
					<div class="row feature">
						<div class="form-group">
							<div class="col-md-8">
								<textarea name="extGroovy">${formQuery.extGroovy}</textarea>
								<div id="extGroovy" class="editorcss"></div>
								<div>
									<a href="javascript:void(0);" onclick="openSelectScriptDef('extGroovy')">选择脚本</a>&nbsp;
									<a href="javascript:void(0);" class="openScript" title="进入脚本管理">脚本管理</a>
								</div>
								<div>
									<font style="display: inline-block; height: 20px;" color="red">说明：增强Groovy(页面显示前执行)</font>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class='tab-pane' id='tab2'>
					<div class="row feature">
						<div class="form-group">
							<div class="col-md-8">
								<textarea name="extCss">${formQuery.extCss}</textarea>
								<div id="extCss" class="editorcss"></div>
								<div>
									<a href="javascript:void(0);" onclick="openSelectScriptDef('extCss')">选择脚本</a>&nbsp;
									<a href="javascript:void(0);" class="openScript" title="进入脚本管理">脚本管理</a>
								</div>
								<div>
									<font style="display: inline-block; height: 20px;" color="red">说明：增强CSS样式(表单/列表前)</font>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class='tab-pane' id='tab3'>
					<div class="row feature">
						<div class="form-group">
							<div class="col-md-8">
								<textarea name="extJs">${formQuery.extJs}</textarea>
								<div id="extJs" class="editorcss"></div>
								<div>
									<a href="javascript:void(0);" onclick="openSelectScriptDef('extJs')">选择脚本</a>&nbsp;
									<a href="javascript:void(0);" class="openScript" title="进入脚本管理">脚本管理</a>
								</div>	
								<div>
									<font style="display: inline-block; height: 20px;" color="red">说明：增强JS脚本(表单/列表后)</font>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<sys:footer extLibs="${extLibs}" />
<!-- ace -->
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/ext-language_tools.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/theme-monokai.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxStatic}/ace-1.2.7/ace-builds/src-noconflict/ext-settings_menu.js"></script>
<script src="${ctxStatic}/form/js/form-public.js?${_version}" type="text/javascript"></script>

<style>
.editorcss {
	width: 130%;
	height: 200px;
}

pre {
	white-space: pre-wrap; /* css-3 */
	white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
	white-space: -pre-wrap; /* Opera 4-6 */
	white-space: -o-pre-wrap; /* Opera 7 */
	word-wrap: break-word; /* Internet Explorer 5.5+ */
	word-break: break-all;
	overflow: hidden;
	width: 100%;
	height: 300px
}
</style>
<script>
    var editor = ace.edit("extGroovy");
    
    editor.focus();
    editor.setOptions({  
       enableBasicAutocompletion: true,  
       enableSnippets: true,  
       enableLiveAutocompletion: true,//只能补全  
    });
    
    editor.session.setMode("ace/mode/groovy");
    var textarea = $('textarea[name="extGroovy"]').hide();
    editor.getSession().setValue(textarea.val());
	editor.getSession().on('change', function(){
	  textarea.val(editor.getSession().getValue());
	});
    
    
    var init=function(id,setM){
    	var editor = ace.edit(id);
    	editor.focus();
    	editor.setOptions({  
    	   enableBasicAutocompletion: true,  
    	   enableSnippets: true,  
    	   enableLiveAutocompletion: true,//只能补全  
    	});
    	editor.session.setMode("ace/mode/"+setM);
    	var textarea = $('textarea[name="'+id+'"]').hide();
    	editor.getSession().setValue(textarea.val());
    	editor.getSession().on('change', function(){
    	  textarea.val(editor.getSession().getValue());
    	});
    	
    }
    
    $(function(){
        $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
            // 获取已激活的标签页的名称
            var activeTab = $(e.target).text();
            // 获取前一个激活的标签页的名称
            var previousTab = $(e.relatedTarget).text();
			// 获取渲染ID
			var id = $("#"+this.name).find("textarea").attr("name");
            if(activeTab.indexOf("Groovy")>-1){
            	init(id,"groovy");
            }else if(activeTab.indexOf("JS")>-1){
            	init(id,"javascript");
            }else if(activeTab.indexOf("CSS")>-1){
            	init(id,"css");
            }
        });
    });
    
    
    

    var aceVal='';
    /**
     * 选择脚本
     * @param val 容器name名称
     * @returns
     */
    function openSelectScriptDef(val){
    	aceVal = val;
    	var textarea = $("textarea[name='"+val+"']").val();
    	var language = '';
    	if(isNotBlank(val)){
    		if(val.indexOf("Groovy")>-1){
    			language = "Groovy";
            }else if(val.indexOf("Js")>-1){
            	language = "JS";
            }else if(val.indexOf("Css")>-1){
            	language = "CSS";
            }
    	}
    	openSelectScript(textarea,language);
    }

    function selectScriptCallback(resultData){
    	if(isNotBlank(aceVal)){
    		$("textarea[name='"+aceVal+"']").val(resultData.scriptContent);
    		// 给ace编辑器赋值
//    		editor.getSession().setValue(scriptContent);
    		if(aceVal.indexOf("Groovy")>-1){
    			init(aceVal,"groovy");
            }else if(aceVal.indexOf("Js")>-1){
            	init(aceVal,"javascript");
            }else if(aceVal.indexOf("Css")>-1){
            	init(aceVal,"css");
            }
    	}
    }
</script>