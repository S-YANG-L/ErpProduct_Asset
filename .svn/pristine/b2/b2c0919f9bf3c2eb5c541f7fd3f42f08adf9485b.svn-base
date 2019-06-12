<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="ztree"/>
<sys:header title="内容管理" extLibs="${extLibs}" />
<div id="content" class="row-fluid">
	<div id="left">
		<div class="portlet box white autoHeight">
			<div class="portlet-title dropdown">
				<div class="caption dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">
					${fnc:getSite(fnc:getCurrentSiteCode()).siteName} <b class="caret"></b>
				</div>
				<ul class="dropdown-menu">
					<c:forEach items="${fnc:getSiteList()}" var="site">
						<li><a href="${ctx}/cms/site/select?siteCode=${site.siteCode}&redirect=${fns:getAdminPath()}/cms/${empty canAdmin || canAdmin eq '' ? 'index' : 'view'}?tabPageId=${param.tabPageId}">
							<i class="fa fa-angle-right"></i> ${site.siteName}</a></li>
					</c:forEach>
				</ul>
				<div class="tools">
					<a href="#" id="treeA" onclick="tree.expandAll(true);$('#treeA').hide();$('#treeB').show();" title="${fns:text('展开')}" class="expand nobind" style="display:none;"></a>
					<a href="#" id="treeB" onclick="tree.expandAll(false);$('#treeA').show();$('#treeB').hide();" title="${fns:text('折叠')}" class="collapse nobind"></a>
					<a href="#" onclick="refreshTree()" class="reload"></a>
				</div>
			</div>
			<div class="portlet-body">
				<div id="tree" class="ztree"></div>
			</div>
		</div>
	</div>
	<div id="openClose" class="close">&nbsp;</div>
	<div id="right">
		<iframe id="mainFrame" name="mainFrame" src="${ctx}/cms/article/list?canAdmin=${empty canAdmin || canAdmin eq 'true'}" style="overflow:visible;"
			scrolling="yes" frameborder="no" width="100%"></iframe>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	// 加载栏目树
	var setting = {view:{selectedMulti:false},data:{key:{title:"title"},simpleData:{enable:true}},
		callback:{onClick:function(event, treeId, treeNode){
			var adminUrl = (treeNode.adminUrl && treeNode.adminUrl != '' ? treeNode.adminUrl : '');
			adminUrl += (adminUrl.indexOf('?') == -1 ? '?' : '&') + 'canAdmin=${empty canAdmin || canAdmin eq "true"}';
			adminUrl += '${not empty param.tabPageId ? "&tabPageId=" : ""}${param.tabPageId}';
			// 如果栏目展现方式，是展现第一条内容（2：简介类栏目，栏目第一条内容），则加上显示模式条件。
			adminUrl += (treeNode.showModes == "2" && treeNode.module == "article") ? '&category.showModes=2' : '';
			// 设置刷新内容管理列表
			var ifr = $("#mainFrame"), src = ifr.attr("src");
			if (src.indexOf("://") == -1 // 不是外部链接
				&& src.indexOf("category.showModes=2") == -1 // 原地址中，不是展现的栏目第一条内容
				&& adminUrl.indexOf("category.showModes=2") == -1 // 新地址中，不是展现的栏目第一条内容
				&& ((src.indexOf("article") > 0 && adminUrl.indexOf("article") > 0)
					|| (src.indexOf("link") > 0 && adminUrl.indexOf("link") > 0))){
				var win = ifr[0].contentWindow, conts = ifr.contents();
				conts.find('input[type=reset]').click();
				conts.find('#categoryCode').val(treeNode.id);
				conts.find('#outlineView').val(adminUrl.indexOf("outlineView=true") != -1); // 文章模型是否显示大纲视图
				conts.find('#fileDownload').val(adminUrl.indexOf("fileDownload=true") != -1); // 链接模型是否是下载栏目
				var caption = conts.find('.portlet-title .caption');
				caption.html(caption.find('i').prop("outerHTML") + " " + treeNode.name);
				win.page();
			}else{
				$('#mainFrame').attr("src", adminUrl);
			}
		}}
	}, tree;
	var refreshTree = function(){
		$.getJSON("${ctx}/cms/category/treeData", {canAdmin: true}, function(data){
			// 初始化树结构
			tree = $.fn.zTree.init($("#tree"), setting, data);//.expandAll(true);
			// 展开第一级节点
			var nodes = tree.getNodesByParam("level", 0);
			for(var i=0; i<nodes.length; i++) {
				tree.expandNode(nodes[i], true, false, false);
			}
			// 展开第二级节点
// 			nodes = tree.getNodesByParam("level", 1);
// 			for(var i=0; i<nodes.length; i++) {
// 				tree.expandNode(nodes[i], true, false, false);
// 			}
		});
	}
	refreshTree();
	
	// 调用子页分页函数
	function page(){
		mainFrame.page();
	}

	// 框架布局调整
	var leftWidth = "160"; // 左侧窗口大小
	var wSize = function(){
		var heightWidth = getWindowSize().toString().split(",");
		$("#mainFrame, #openClose").height(heightWidth[0]);
		$("#right").width(heightWidth[1] - $("#left").width()-$("#openClose").width() - 2);
		$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
	}
	// 鼠标移动到边界自动弹出左侧菜单
	$("#openClose").mouseover(function(){
		if($(this).hasClass("open")){
			$(this).click();
		}
	});
</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>