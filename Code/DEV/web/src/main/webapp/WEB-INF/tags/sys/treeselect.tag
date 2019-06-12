<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域名称（ID）"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="隐藏域值（ID）"%>
<%@ attribute name="labelName" type="java.lang.String" required="true" description="输入框名称（Name）"%>
<%@ attribute name="labelValue" type="java.lang.String" required="true" description="输入框值（Name）"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="选择框标题"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="树结构数据地址"%>
<%@ attribute name="extCode" type="java.lang.String" required="false" description="排除掉的编号（不能选择的编号）用于修改树结构的时候不能交叉选择的问题"%>
<%@ attribute name="checked" type="java.lang.String" required="false" description="是否显示复选框，如果不需要返回父节点，请设置notAllowSelectParent为true"%>
<%@ attribute name="showLevel" type="java.lang.Integer" required="false" description="默认显示（展开）层次级别"%>
<%@ attribute name="isAll" type="java.lang.Boolean" required="false" description="是否列出全部数据，设置true则不进行数据权限过滤"%>
<%@ attribute name="isShowCode" type="java.lang.String" required="false" description="是否显示编码（true or 1：显示在左侧；2：显示在右侧；false or null：不显示）"%>
<%@ attribute name="notAllowSelectRoot" type="java.lang.Boolean" required="false" description="不允许选择根节点"%>
<%@ attribute name="notAllowSelectParent" type="java.lang.Boolean" required="false" description="不允许选择父节点"%>
<%@ attribute name="companyCode" type="java.lang.String" required="false" description="机构树，根据公司过滤机构（目前仅对Office有效）"%>
<%@ attribute name="module" type="java.lang.String" required="false" description="CMS模块，过滤栏目模型（只显示指定模型，仅针对CMS的Category树）"%>
<%@ attribute name="selectScopeModule" type="java.lang.Boolean" required="false" description="CMS模块，选择范围内的模型（控制不能选择公共模型，不能选择本栏目外的模型）（仅针对CMS的Category树）"%>
<%@ attribute name="allowClear" type="java.lang.Boolean" required="false" description="是否允许清除"%>
<%@ attribute name="allowInput" type="java.lang.Boolean" required="false" description="文本框可填写"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式，非空验证：required"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="controlSize" type="java.lang.String" required="false" description="控件大小（lg、sm、xs）"%>
<%@ attribute name="smallBtn" type="java.lang.Boolean" required="false" description="缩小按钮显示"%>
<%@ attribute name="hideBtn" type="java.lang.Boolean" required="false" description="是否显示按钮"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否限制选择，如果限制，设置为disabled"%>
<%@ attribute name="dataMsgRequired" type="java.lang.String" required="false" description="设置data-msg-required属性，不为空验证的提示信息"%>
<%@ attribute name="placeholder" type="java.lang.String" required="false" description="设置placeholder属性，文本提示信息"%>
<%@ attribute name="returnFullPath" type="java.lang.Boolean" required="false" description="是否返回全路径，包含所有上级信息，以 returnFullPathSplit 参数分隔"%>
<%@ attribute name="returnFullPathSplit" type="java.lang.String" required="false" description="是否返回全路径，的分隔符，默认 / "%>
<%@ attribute name="boxWidth" type="java.lang.Integer" required="false" description="弹出的对话框宽度，默认300像素"%>
<%@ attribute name="boxHeight" type="java.lang.Integer" required="false" description="弹出的对话框宽度，默认400像素"%>
<%@ attribute name="isReturnValue" type="java.lang.Boolean" required="false" description="是否返回value值，多级字典的时候用，true的时候返回value，不返回id"%>
<%@ attribute name="smallBtnStyle" type="java.lang.String" required="false" description="缩小按钮显示style"%>
<div class="input-group treeselect ${disabled}" id="${id}Div" data-url="${!fn:startsWith(url, ctx) ? ctx : ''}${url}">
	<input id="${id}Code" name="${name}" class="${cssClass} isReset" type="hidden" value="${value}" data-msg-required=""/><%-- 设置data-msg-required为空，代表：验证但不提示，因为下面的name会进行提示。 --%>
	<input id="${id}Name" name="${labelName}" ${allowInput?'':'readonly="readonly"'} type="text" value="${labelValue}" placeholder="${placeholder}"
		${not empty dataMsgRequired ? 'data-msg-required="' : ''}${dataMsgRequired}${not empty dataMsgRequired ? '"' : ''}
		class="form-control ${not empty controlSize ? 'input-' : ''}${not empty controlSize ? controlSize : ''} ${cssClass}" style="${cssStyle}"
	/><span class="input-group-btn">
		<a id="${id}Button" href="javascript:" class="btn default ${not empty controlSize ? 'btn-' : ''}${not empty controlSize ? controlSize : ''} ${disabled} ${hideBtn ? 'hide' : ''}" 
			style="display:inline-block;${smallBtn?'padding:4px 2px;':not empty smallBtnStyle?smallBtnStyle:''};"><i class="fa fa-search"></i></a>
	</span>
</div>
<script type="text/javascript">
	$("#${id}Button${allowInput?'':',#'}${allowInput?'':id}${allowInput?'':'Name'}").click(function(){
		// 是否限制选择，如果限制，设置为disabled
		if ($("#${id}Button").hasClass("disabled")
				|| $("#${id}Button").hasClass("readonly")){
			return true;
		}
		var $jBox = getJBox();
		$jBox.open("iframe:${ctx}/tag/treeselect?url="+encodeURIComponent($('#${id}Div').attr('data-url'))+"&extCode=${extCode}&checked=${checked}&showLevel=${showLevel}&isAll=${isAll}&isShowCode=${isShowCode}&module=${module}&companyCode=${companyCode}", "${fns:text('选择')}${title}", 
			${not empty boxWidth ? boxWidth : 300}, ${not empty boxHeight ? boxHeight : 400}, {ajaxData:{selectCodes: $("#${id}Code").val()}, /*persistent: true, 模态窗口 */ /*buttonsFocus:100, 第几个按钮获得焦点，因为没有100个按钮，代表不给按钮获取焦点，当box太高的时候，则不能向下滚动屏幕 */
			buttons:eval('({\''+$.jBox.languageDefaults.ok+'\':"ok", ${allowClear?"\\''+$.jBox.languageDefaults.clear+'\\':\"clear\", ":""}\''+$.jBox.languageDefaults.close+'\':true})'), 
			submit:function(v, h, f){ // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
				var ifr = h.find("iframe"), win = ifr[0].contentWindow, conts = ifr.contents();
				if (v=="ok"){
					win.$("#key").val('').change();
					var codes = [], names = [], nodes = [];
					if ("${checked}" == "true"){
						nodes = win.tree.getCheckedNodes(true);
					}else{
						nodes = win.tree.getSelectedNodes();
					}
					for(var i=0; i<nodes.length; i++) {
						if ("${checked}" == "true" && "${notAllowSelectParent}" == "true" && nodes[i].isParent){
							continue; // 如果为复选框选择，则过滤掉父节点
						}//<c:if test="${notAllowSelectRoot}">//
						if (nodes[i].level == 0){
							showMessage("不能选择根节点（"+nodes[i].name+"）请重新选择。");
							return false;
						}//</c:if><c:if test="${notAllowSelectParent}">//
						if (nodes[i].isParent){
							showMessage("不能选择父节点（"+nodes[i].name+"）请重新选择。");
							return false;
						}//</c:if><c:if test="${not empty module && selectScopeModule}">//
						if (nodes[i].module == ""){
							showMessage("不能选择公共模型（"+nodes[i].name+"）请重新选择。");
							return false;
						}else if (nodes[i].module != "${module}"){
							showMessage("不能选择当前栏目以外的栏目模型，请重新选择。");
							return false;
						}//</c:if><c:choose><c:when test="${returnFullPath}">//
 						var codePath = nodes[i].${isReturnValue?'value':'id'}, namePath = nodes[i].name, 
							pNode = nodes[i].getParentNode();
						while(!!pNode) {
							codePath =  pNode.${isReturnValue?'value':'id'} + '${not empty returnFullPathSplit ? returnFullPathSplit : '/'}' + codePath;
							namePath =  pNode.name + '${not empty returnFullPathSplit ? returnFullPathSplit : '/'}' + namePath;
						    pNode = pNode.getParentNode();
						}
						codes.push(nodes[i].${isReturnValue?'value':'id'}.replace(/^u_/g,""));
						names.push(namePath.replace(/\([0-9]*\)/g,""));
						//</c:when><c:otherwise>//
						codes.push(nodes[i].${isReturnValue?'value':'id'}.replace(/^u_/g,""));
 						names.push(nodes[i].name.replace(/\([0-9]*\)/g,""));
 						//</c:otherwise></c:choose>//
 						if ("${checked}" != "true"){
 							break; // 如果为非复选框选择，则返回第一个选择 
 						}
					}
					// 选择之后，设置输入框之前事件
					if(typeof ${id}TreeselectSelPre == 'function'){
						if(!${id}TreeselectSelPre(v, h, f, codes, names, nodes)){
							return false;
						}
					}
					$("#${id}Code").val(codes.join(",")).change();
					$("#${id}Name").val(names.join(",")).change();
					try { $('#${id}Code,#${id}Name').valid(); }catch(e){}
				}//<c:if test="${allowClear}">//
				else if (v=="clear"){
					$("#${id}Code").val("").change();
					$("#${id}Name").val("").change();
                }//</c:if>//
                // 选择后回调
				if(typeof ${id}TreeselectCallBack == 'function'){
					${id}TreeselectCallBack(v, h, f);
				}
			<%-- 默认iframe不显示滚动条，已在源码中实现，所以这里注释掉
			}, loaded:function(h){
                $(".jbox-content", $jBox.getBox()).css("overflow-y","hidden"); --%>
			}
		});
	});
</script>