<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html><html><head><meta charset="utf-8"/><meta content="webkit" name="renderer"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/><meta http-equiv="Expires" content="0"/>
<meta http-equiv="Cache-Control" content="no-cache"/><meta http-equiv="Cache-Control" content="no-store"/>
<meta content="width=device-width, initial-scale=1, user-scalable=1" name="viewport"/>
<meta content="${fns:getConfig('productName')}" name="description"/>
<meta content="http://www.ecode.net.cn" name="author"/>
<title>${fns:getConfig('productName')} 在线帮助</title>
<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="${ctxStaticTheme}/css/bootstrap.min.css?${_version}" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ace-fonts.css?${_version}" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ace.css?${_version}" class="ace-main-stylesheet" id="main-ace-style" />
<!--[if lte IE 9]><link rel="stylesheet" href="${ctxStaticTheme}/css/ace-part2.css?${_version}" class="ace-main-stylesheet" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ace-ie.css?${_version}" /><![endif]-->
<script src="${ctxStaticTheme}/js/ace-extra.js?${_version}"></script>
<link href="${ctxStatic}/wdScrollTab/css/bootstrap/TabPanel.css?${_version}" rel="stylesheet" type="text/css" />
<link href="${ctxStatic}/fonts/fonts-common.min.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/jquery-toastr/2.0/toastr.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.css?${_version}" rel="stylesheet" type="text/css"/>
<%-- <link href="${ctxStatic}/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.css?${_version}" rel="stylesheet" type="text/css"/> --%>
<link href="${ctxStatic}/jquery-ztree/3.5.12/css/simple/zTreeStyle.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/common/jeesite.css?${_version}" type="text/css" rel="stylesheet"/>
<!--[if lte IE 8]><script src="${ctxStaticTheme}/js/html5shiv.min.js"></script>
<script src="${ctxStaticTheme}/js/respond.min.js"></script><![endif]-->
<style type="text/css">
.navbar, .navbar.navbar-collapse .navbar-container {background-color:#065380!important;}
.main-container .menu-toggler {width:16px;height:17px;padding:9px 8px;margin:5px;}
/* .no-skin .sidebar {border-color:#999C9E;}
.sidebar .sidebar-shortcuts {text-align:right;}
.sidebar .sidebar-shortcuts-large {background:url(${ctxStatic}/demo/fileupload/images/globlinks_title.jpg);height:40px;}
.sidebar .sidebar-shortcuts-large > .btn {position:absolute;top:4px;right:5px;width:25px;height:13px;color:#8EC8E5!important;font-size:12px;padding:0px!important;}
.sidebar .sidebar-shortcuts-large > .btn.down{top:15px;height:20px;} */
.no-skin .sidebar, .no-skin .sidebar-toggle {background-color:#F9F9F9;}
.sidebar .sidebar-shortcuts {border-bottom:1px solid #ddd;min-height:41px;}
.sidebar.menu-min .sidebar-shortcuts {overflow:hidden;}
.sidebar .sidebar-menu {margin-top:0;overflow:auto;}
.sidebar .sidebar-menu .ztree {margin:5px 10px;}
.sidebar .sidebar-search {width:170px;vertical-align:middle;font-size:13px;line-height:26px;height:26px;padding:0 4px;margin-top:7px;}
.navbar-form {width:auto;border:0;margin-left:0;margin-right:0;padding-top:0;padding-bottom:0;-webkit-box-shadow:none;box-shadow:none;}
.navbar-form.form-search input[type=text] {width:100%}
.navbar-form .form-group {width:auto}
</style>
</head>
<body class="no-skin">
<!-- #section:basics/navbar.layout -->
<div id="navbar" class="navbar navbar-default navbar-fixed-top navbar-collapse">
	<script type="text/javascript">
		try{ace.settings.check('navbar' , 'fixed')}catch(e){}
	</script>
	
	<div class="navbar-container" id="navbar-container">
		
		<form id="form-search" action="${ctxPath}${fns:getAdminPath()}/cms/search"
				class="navbar-form navbar-right pull-right form-search" target="_blank">
			<div class="form-group">
				<input type="text" name="q" placeholder="输入关键字回车搜索...">
			</div>
			<button type="submit" class="btn btn-mini btn-info2">
				<i class="ace-icon fa fa-search icon-only bigger-110"></i>
			</button>
		</form>
		
		<a href="${ctx}/logout" title="退出登录" style="color:#065380">退出登录</a>
						
		<!-- #section:basics/sidebar.mobile.toggle -->
		<button id="menu-toggler" class="navbar-toggle menu-toggler pull-left" type="button"
				data-target="#sidebar">
			<span class="sr-only">侧边栏菜单</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
	
		<!-- /section:basics/sidebar.mobile.toggle -->
		<div class="navbar-header pull-left" style="min-width:179px;">
			<!-- #section:basics/navbar.layout.brand -->
			<a href="#" class="navbar-brand">
				<small>
<!-- 					<i class="fa fa-leaf"></i> -->
					${fns:getConfig('productName')} 在线帮助
				</small>
			</a>
		</div>
		
	</div><!-- /.navbar-container -->
	
</div>
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<script type="text/javascript">
		try{ace.settings.check('main-container' , 'fixed')}catch(e){}
	</script>

	<!-- #section:basics/sidebar -->
	<div id="sidebar" class="sidebar responsive sidebar-fixed" data-sidebar-scroll="true">
		<script type="text/javascript">
			try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
		</script>
	
		<div class="sidebar-shortcuts" id="sidebar-shortcuts">
			<!-- <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
				<button class="btn btn-success">
					<i class="ace-icon fa fa-user"></i>
				</button>
				<button class="btn btn-info">
					<i class="ace-icon fa fa-key"></i>
				</button>
				<button class="btn btn-warning">
					<i class="ace-icon fa fa-comments-o"></i>
				</button>
				<button class="btn btn-danger">
					<i class="ace-icon fa fa-sign-out"></i>
				</button>
			</div>
			<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
				<span class="btn btn-success"></span>
				<span class="btn btn-info"></span>
				<span class="btn btn-warning"></span>
				<span class="btn btn-danger"></span>
			</div> -->
			<input type="text" id="key" maxlength="50" placeholder="输入关键字搜索导航..."  class="sidebar-search empty"/>
		</div><!-- /.sidebar-shortcuts -->

		<div class="sidebar-menu">
			<div id="tree" class="ztree"></div>
		</div>
		
		<!-- #section:basics/sidebar.layout.minimize -->
		<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
			<i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
		</div>
	
		<!-- /section:basics/sidebar.layout.minimize -->
		<script type="text/javascript">
			try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
		</script>
	</div>
	
	<div class="main-content">
		<div id="tabpanel"></div>
	</div><!-- /.main-content -->

</div><!-- /.main-container -->
<script src="${ctxStaticTheme}/js/bootstrap.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/elements.scroller.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/ace.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/ace.touch-drag.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/ace.sidebar.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/ace.sidebar-scroll-2.js?${_version}"></script>
<script src="${ctxStatic}/wdScrollTab/js/TabPanel.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-toastr/2.0/toastr.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/common/jeesite.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/common/tabPage.js?${_version}" type="text/javascript"></script>
<script type="text/javascript">

	// 树结构用到的全局变量
	var tree, setting, key, lastValue = "", nodeList = [];
	
	$(document).ready(function(){
		
		// 初始化页签
		initTabPage('tabpanel', {
			height: function () {
				return $(window).height() - $('#navbar').height();
			}
		});

   		// 打开首页页签
// 		addTabPage(null, '<i class="ace-icon fa fa-home home-icon"'
// 			+'style="font-size:18px;vertical-align:middle;margin-top:-3px;"></i> 首页',
// 			'${ctx}${fns:getConfigDefault("sys.home.pageUrl", "/../desktop")}' , null, false, false);

		// 是否是单击的菜单，防止打开菜单重复调用。
		var isMenuClickFlag = false;
		
		// 加载栏目树
		setting = {view:{
			showLine: false, showIcon: false,
			addDiyDom: function(treeId, treeNode) {
				var switchObj = $("#" + treeNode.tId + "_switch"),
					icoObj = $("#" + treeNode.tId + "_ico");
				switchObj.remove();
				icoObj.before(switchObj);
				if (treeNode.level > 0) {
					switchObj.before("<span style='display: inline-block;width:" + (8 * treeNode.level)+ "px'></span>");
				}
			},
			selectedMulti:false},data:{key:{title:"title"},simpleData:{enable:true}},
			callback:{
				beforeClick:function(treeId, treeNode) {
					if (treeNode.isParent) {
						tree.expandNode(treeNode, null, false, false, true);
						return false;
					}
				},
				onClick:function(event, treeId, treeNode){
					// 获取栏目地址
					var adminUrl = (treeNode.adminUrl && treeNode.adminUrl != '' ? treeNode.adminUrl : '');
					adminUrl += (adminUrl.indexOf('?') == -1 ? '?' : '&') + 'isAll=true';
					adminUrl += '${not empty param.tabPageId ? "&tabPageId=" : ""}${param.tabPageId}';
					// 标记为菜单单击，防止重复调用
					isMenuClickFlag = true;
					// 打开页签页面
					addTabPage($('#'+treeNode.tId), $.trim(treeNode.name), adminUrl, null, true, false);
					window.location.hash = (adminUrl).replace('#', '');
				},
				onExpand:function(){
					// 重置侧边栏滚动条
					sidebarScrollReset();
				},
				onCollapse:function(){
					// 重置侧边栏滚动条
					sidebarScrollReset();
				}
			}
		};
		$.getJSON("${ctx}/cms/category/treeData", {siteCode: '1', canAdmin: true, isAll: true}, function(data){
			if(data['result'] == 'false'){
				alert(data.message);
				location = '${ctx}/login?__url='+location.href;
				return;
			}
			// 初始化树结构
			tree = $.fn.zTree.init($("#tree"), setting, data);//.expandAll(true);
			// 展开第一级节点
			var nodes = tree.getNodesByParam("level", 0);
			for(var i=0; i<nodes.length; i++) {
				tree.expandNode(nodes[i], true, false, false, true);
			}
			// 展开第二级节点
// 			nodes = tree.getNodesByParam("level", 1);
// 			for(var i=0; i<nodes.length; i++) {
// 				tree.expandNode(nodes[i], true, false, false);
// 			}
		});
   		
		// 绑定hash更改事件，刷新打开指定页面的页签。
		$(window).bind("hashchange", function(e) {
			// 防止重复调用，当单击菜单的时候不调用
			if(!isMenuClickFlag){
				var hash = window.location.hash.replace('#', '');
				var addTab = $('a[data-href="' + hash + '"]:eq(0)');
				if (hash && hash != ''){
					if(addTab && addTab.length > 0){
						addTab.click();
					}else{
						// 找不到则直接打开到新建页签
						addTabPage(null, '新建页签', hash);
					}
				}else{
					// 默认打开第一个菜单
					//$('.page-sidebar-menu .sub-menu .addTab :eq(0)').click();
				}
			}
			// 恢复标记
			isMenuClickFlag = false;
		}).trigger("hashchange");
		
		// 如果在小窗口下，则自动点击“显示或隐藏菜单”按钮，并显示菜单
		if (window.location.hash == ''){
			$('#menu-toggler:visible:not(.display)').click();
		}
		
		// 鼠标移动到左侧栏自动弹出左侧菜单
		$('#sidebar').mouseover(function(){
			if($(this).hasClass('menu-min')){
				$('#sidebar-collapse').click();
			}
		});
		
		// 左上角查询表单提交事件绑定
   		$('#form-search').submit(function(){
			var url = $(this).attr('action') + '?q=' + $(this).find('input[name=q]').val();
   			addTabPage(null, '文章搜索', url + '&siteCode=1', null, true, false);
   			return false;
   		});

   		// IE8下窗口修正
		setTimeout(function(){
			$(window).resize();
		},100);
   		
		// 搜索输入框绑定
		key = $("#key");
		key.bind("focus", focusKey).bind("blur", blurKey).bind("change cut input propertychange", searchNode);
		key.bind('keydown', function (e){if(e.which == 13){searchNode();}});
	});
	
	// 重置侧边栏滚动条
	function　sidebarScrollReset(){
		$('#sidebar').ace_sidebar_scroll('reset');
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
	
	//搜索节点
	function searchNode() {
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
		hideAllNode(nodes);
		nodeList = tree.getNodesByParamFuzzy(keyType, value);
		updateNodes(nodeList);
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
	// ======================== 搜索结束 ========================
</script>
</body>
</html>