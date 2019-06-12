<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="custom,jquery,ztree,jeesite,pinyin"/>
<c:set var="urlParam">
	${not empty isAll ? '&isAll=' : ''}${isAll}
	${not empty isShowCode ? '&isShowCode=' : ''}${isShowCode}
	${not empty companyCode ? '&companyCode=' : ''}${companyCode}
	${not empty extCode ? '&extCode=' : ''}${extCode}
	${not empty module ? '&module=' : ''}${module}
</c:set>
<sys:header title="数据选择" bodyClass="nobg" extLibs="${extLibs}"/>
<div style="position:absolute;right:8px;top:2px;cursor:pointer;font-size:12px;color:#333;" onclick="search();">
	<label id="txt1" style="display:none;" title="展开搜索">︾</label><label id="txt2" title="隐藏搜索">︽</label>
</div>
<div id="search" style="padding:13px 0 0 20px;">
	<label for="key" style="padding:5px 0 3px 0;font-size:13px;vertical-align:middle;">关键字：</label>
	<input type="text" class="empty" id="key" maxlength="50" style="width:115px;vertical-align:middle;line-height:24px;height:24px;border:1px solid #bbb;padding:0 4px;" />
	<button class="btn" id="btn" onclick="searchNode()" style="border:1px solid #bbb;vertical-align:middle;height:26px;height:26px\9;font-size:13px;background:#efefef;padding:0 8px;"> 搜索 </button>
</div>
<div style="float:right;padding:13px;font-size:12px;color:#bbb;">
	<a href="javascript:" onclick="tree.expandAll(true);" style="text-decoration:none;color:#aaa">展开</a>/<a
		href="javascript:" onclick="tree.expandAll(false);" style="text-decoration:none;color:#aaa">折叠</a>
</div>
<div id="tree" class="ztree" style="padding:10px 20px;"></div>
<sys:footer extLibs="${extLibs}"/>
<%-- <script src="${ctxStatic}/assets/global/plugins/jquery-select2/pinyin.js?${_version}" type="text/javascript"></script> --%>
<script type="text/javascript">
	var key, lastValue = "", nodeList = [], type = getQueryString("type", "${url}");
	var tree, setting = {view:{selectedMulti:false,dblClickExpand:false},check:{enable:"${checked}"=="true",nocheckInherit:true},
		async:{enable:(type==3),url:"${ctx}/sys/user/treeData?t=" + new Date().getTime() + "${urlParam}",autoParam:["id=officeCode"]},
		data:{simpleData:{enable:true}},callback:{<%--
			beforeClick: function(treeId, treeNode){
				if("${checked}" == "true"){
					//tree.checkNode(treeNode, !node.checked, true, true);
					tree.expandNode(treeNode, true, false, false);
				}
			}, --%>
			onClick:function(event, treeId, treeNode){
				tree.expandNode(treeNode);
			},
			// 先注释掉，否则会造成折叠后选择其他节点，误展开刚折叠的节点情况（目前没有懒加载，所以选中节点暂时不需要展开了）
// 			onCheck: function(e, treeId, treeNode){
// 				var nodes = tree.getCheckedNodes(true);
// 				for (var i=0, l=nodes.length; i<l; i++) {
// 					tree.expandNode(nodes[i], true, false, false);
// 				}
// 				return false;
// 			},
			onAsyncSuccess: function(event, treeId, treeNode, msg){
				var nodes = tree.getNodesByParam("pId", treeNode.id, null);
				for (var i=0, l=nodes.length; i<l; i++) {
					try{tree.checkNode(nodes[i], treeNode.checked, true);}catch(e){}
					//tree.selectNode(nodes[i], false);
				}
				selectCheckNode();
			},
			onDblClick: function(){//<c:if test="${!checked}">
				var $jBox = getJBox();
				$jBox.getBox().find("button[value='ok']").trigger("click");
				//$("input[type='text']", top.mainFrame.document).focus();//</c:if>//
			}
		}
	};
	
	$(document).ready(function(){
		$.get("${url}${fn:indexOf(url,'?')==-1?'?':'&'}t=" + new Date().getTime() + "${urlParam}", function(zNodes){
			// 初始化树结构
			tree = $.fn.zTree.init($("#tree"), setting, zNodes);//.expandAll(true);
			
			// 默认展开一级节点
			var nodes = tree.getNodesByParam("level", ${not empty showLevel ? showLevel : 0});
			for(var i=0; i<nodes.length; i++) {
				tree.expandNode(nodes[i], true, false, false);
			}
			//后台异步加载子节点（加载用户）
			if (type==3){
				var nodesOne = tree.getNodesByParam("isParent", true);
				for(var j=0; j<nodesOne.length; j++) {
					tree.reAsyncChildNodes(nodesOne[j],"!refresh",true);
				}
			}
			selectCheckNode();
		});
		// 搜索输入框绑定
		key = $("#key");
		key.bind("focus", focusKey).bind("blur", blurKey).bind("change cut input propertychange", searchNode);
		key.bind('keydown', function (e){if(e.which == 13){searchNode();}});
	});
	
	// 默认选择节点
	function selectCheckNode(){
		var ids = "${selectCodes}".split(",");
		for(var i=0; i<ids.length; i++) {
			var node = tree.getNodeByParam("id", (type==3||type==4?"u_":"")+ids[i]);
			if("${checked}" == "true"){
				try{tree.checkNode(node, true, false);}catch(e){}
				tree.selectNode(node, false);
			}else{
				tree.selectNode(node, true);
			}
		}
	}
	
	// ======================== 搜索开始 ========================
	// 关键词输入框获取焦点
  	function focusKey(e) {
		if (key.hasClass("empty")) {
			key.removeClass("empty");
		}
	}
	
	// 关键词输入框焦点离开
	function blurKey(e) {
		if (key.get(0).value === "") {
			key.addClass("empty");
		}
		searchNode(e);
	}
	
	var time1;
	//搜索节点
	function searchNode() {
		window.clearTimeout(time1);
		// 取得输入的关键字的值
		var value = $.trim(key.get(0).value);
		// 按名字查询
		var keyType = "name";
		// 如果和上次一次，就退出不查了。
		if (lastValue === value) {
			return;
		}
		
		// 保存最后一次
		lastValue = value;
		
		var nodes = tree.getNodes();
		// 如果要查空字串，就退出不查了。
		if (value == "") {
			showAllNode(nodes);
			return;
		}
		//汉字查询
		var reg = new RegExp("[\\u4E00-\\u9FFF]+","g");
		if(reg.test(value)){
			hideAllNode(nodes);
			nodeList = tree.getNodesByParamFuzzy(keyType, value);
			updateNodes(nodeList);
		}else{
			time1=window.setTimeout(function (){
				//增加支持拼音首字母、全拼  裴孝峰 by 2017-10-11
				nodes = tree.transformToArray(nodes);
				var nodeList=new Array();
				var index=0;
				var val=new RegExp(hzConvertPinyin(value).toUpperCase());
				for(var i=0;i<nodes.length;i++){
					var node=pinyinChnToPy(nodes[i].name);
					//判断相等添加到数组中
					if(val.test(node)==true){
						nodeList[index]=nodes[i]
						index++;
					}else{
						tree.hideNode(nodes[i]);
					}
				}
				updateNodes(nodeList);
			},500);
		}
	}
	
	
	//隐藏所有节点
	function hideAllNode(nodes){			
		nodes = tree.transformToArray(nodes);
		for(var i=nodes.length-1; i>=0; i--) {
			tree.hideNode(nodes[i]);
		}
	}
	
	//显示所有节点
	function showAllNode(nodes){			
		nodes = tree.transformToArray(nodes);
		for(var i=nodes.length-1; i>=0; i--) {
			if(nodes[i].getParentNode()!=null){
				tree.expandNode(nodes[i],false,false,false,false);
			}else{
				tree.expandNode(nodes[i],true,true,false,false);
			}
			tree.showNode(nodes[i]);
			showAllNode(nodes[i].children);
		}
	}
	
	//更新节点状态
	function updateNodes(nodeList) {
		tree.showNodes(nodeList);
		for(var i=0, l=nodeList.length; i<l; i++) {
			var treeNode = nodeList[i];
			
			//显示当前节点的子节点 
			showChildren(treeNode);
			
			//显示当前节点所有的父节点
			showParent(treeNode)
		}
	}
	
	// 显示所有子节点
	function showChildren(treeNode){
		if (treeNode.isParent){
			for(var idx in treeNode.children){
				var node = treeNode.children[idx];
				tree.showNode(node);
				showChildren(node);
			}
		}
	}
	
	// 显示所有子节点
	function showParent(treeNode){
		var parentNode;
		while((parentNode = treeNode.getParentNode()) != null){
			tree.showNode(parentNode);
			tree.expandNode(parentNode, true, false, false);
			treeNode = parentNode;
		}
	}
	
	// 开始搜索
	function search() {
		$("#search").slideToggle(200);
		$("#txt1").toggle();
		$("#txt2").toggle();
		$("#key").focus();
	}
	// ======================== 搜索结束 ========================
	
</script>