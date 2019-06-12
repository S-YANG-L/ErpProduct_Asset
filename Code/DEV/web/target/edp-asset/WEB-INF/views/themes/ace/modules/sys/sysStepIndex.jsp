<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html><html><head><meta charset="utf-8"/><meta content="webkit" name="renderer"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/><meta http-equiv="Expires" content="0"/>
<meta http-equiv="Cache-Control" content="no-cache"/><meta http-equiv="Cache-Control" content="no-store"/>
<meta content="width=device-width, initial-scale=1, user-scalable=1" name="viewport"/>
<meta content="${fns:getConfig('productName')}" name="description"/>
<meta content="http://www.ecode.net.cn" name="author"/>
<title>${param.title} - ${fns:getConfig('productName')}</title>
<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="${ctxStaticTheme}/css/bootstrap.min.css?${_version}" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ace-fonts.min.css?${_version}" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ace.min.css?${_version}" class="ace-main-stylesheet" id="main-ace-style" />
<!--[if lte IE 9]><link rel="stylesheet" href="${ctxStaticTheme}/css/ace-part2.min.css?${_version}" class="ace-main-stylesheet" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ace-ie.min.css?${_version}" /><![endif]-->
<script src="${ctxStaticTheme}/js/ace-extra.min.js?${_version}"></script>
<link href="${ctxStatic}/fonts/fonts-common.min.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/jquery-toastr/2.0/toastr.min.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/common/jeesite.css?${_version}" type="text/css" rel="stylesheet"/>
<!--[if lte IE 8]><script src="${ctxStatic}/common/respond.min.js"></script><![endif]-->
<style type="text/css">
.no-skin .sidebar {border-color:#999C9E;}
.sidebar .sidebar-shortcuts {text-align:right;}
.sidebar .sidebar-shortcuts-large {background:url(${ctxStatic}/demo/fileupload/images/globlinks_title.jpg);height:40px;}
.sidebar .sidebar-shortcuts-large > .btn {position:absolute;top:4px;right:5px;width:25px;height:13px;color:#8EC8E5!important;font-size:12px;padding:0px!important;}
.sidebar .sidebar-shortcuts-large > .btn.down{top:15px;height:20px;}
.main-container .menu-toggler {width:16px;height:17px;padding:9px 8px;margin:5px;}
.navbar, .navbar.navbar-collapse .navbar-container {background-color:#065380;}
.sidebar-menu{margin-top:5px;}
</style>
</head>
<body class="no-skin">
<!-- #section:basics/navbar.layout -->
<div id="navbar" class="navbar navbar-default navbar-fixed-top2 navbar-collapse">
	<script type="text/javascript">
		try{ace.settings.check('navbar' , 'fixed')}catch(e){}
	</script>
	
	<div class="navbar-container" id="navbar-container">
		
		<button class="btn btn-minier pull-right btn-info mt10" onclick="executeStep('next')">
			<i class="fa fa-caret-down"></i> 下一步
		</button>
		<span class="pull-right">&nbsp;&nbsp;</span>
		<button class="btn btn-minier pull-right btn-info mt10" onclick="executeStep('prev')">
			<i class="fa fa-caret-up"></i> 上一步
		</button>
		
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
					<i class="fa fa-leaf"></i>&nbsp;
					${param.title}
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
	
	<!-- #section:basics/sidebar.mobile.toggle -->
	<!-- <button id="menu-toggler" class="navbar-toggle menu-toggler pull-left" type="button"
			data-target="#sidebar">
	</button> -->
	
	<!-- #section:basics/sidebar -->
	<div id="sidebar" class="sidebar responsive sidebar-fixed" data-sidebar-scroll="true">
		<script type="text/javascript">
			try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
		</script>
	
		<%-- /section:basics/sidebar -->
		<div class="sidebar-shortcuts" id="sidebar-shortcuts">
			<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
				<!-- <button class="btn btn-success">
					<i class="ace-icon fa fa-signal"></i>
				</button>
				<button class="btn btn-info">
					<i class="ace-icon fa fa-pencil"></i>
				</button>
				<button class="btn btn-warning">
					<i class="ace-icon fa fa-users"></i>
				</button>
				<button class="btn btn-danger">
					<i class="ace-icon fa fa-cogs"></i>
				</button> -->
				<button class="btn btn-link" onclick="executeStep('prev')">
					<i class="fa fa-caret-up"></i>
				</button>
				<button class="btn btn-link down" onclick="executeStep('next')">
					<i class="fa fa-caret-down"></i>
				</button>
				&nbsp;
			</div>
			<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
				<span class="btn btn-success"></span>
				<span class="btn btn-info"></span>
				<span class="btn btn-warning"></span>
				<span class="btn btn-danger"></span>
			</div>
		</div><!-- /.sidebar-shortcuts --%>
		
		<div class="sidebar-menu">
			<%@ include file="/WEB-INF/views/themes/ace/modules/sys/menuTree.jsp"%>
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
		<iframe id="mainFrame" src="" width="100%" height="100%" frameborder="0"></iframe>
	</div>
	
</div><!-- /.main-container -->
<script src="${ctxStaticTheme}/js/bootstrap.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/elements.scroller.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/ace.min.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/ace.touch-drag.min.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/ace.sidebar.min.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/ace.sidebar-scroll-2.min.js?${_version}"></script>
<script src="${ctxStatic}/jquery-toastr/2.0/toastr.min.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/common/jeesite.js?${_version}" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){

		// 是否是单击的菜单，防止打开菜单重复调用。
		var isMenuClickFlag = false;
		
		// 绑定菜单按钮事件
		$(document).on('click', 'a.addTab', function (e) {
			
			// 标记为菜单单击，防止重复调用
			isMenuClickFlag = true;

			// 设置侧边栏菜单选中
			if ($(this).parents('#sidebar').length > 0){
				$('#sidebar li').removeClass('open active');
				$('#sidebar ul.nav-show').removeClass('nav-show').addClass('nav-hide').hide();
				$(this).parents('li').addClass('active').parents('li').addClass('open')
					.find('ul.nav-hide').removeClass('nav-hide').addClass('nav-show').show();
			}
			
			// 重置侧边栏滚动条
 			$('#sidebar').ace_sidebar_scroll('reset');
			
			// 获取网页地址和标题
			var href = $(this).data("href");
			var title = $(this).data("title");
			
			// 打开页签页面
			if (href && href != ''){
				closeLoading();loading();
				$('#mainFrame').attr("src", href);
				window.location.hash = href.replace('#', '');
			}
			
			// 如果小窗口下，则选择菜单后，则折叠菜单
			$('#menu-toggler.display:visible').click();
			
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
						closeLoading();loading();
						$('#mainFrame').attr("src", hash);
					}
				}else{
					// 默认打开第一个菜单
					executeStep('next');
				}
			}
			// 恢复标记
			isMenuClickFlag = false;
		}).trigger("hashchange");
       	
		// 如果在小窗口下，则自动点击“显示或隐藏菜单”按钮，并显示菜单
		if (window.location.hash == ''){
			$('#menu-toggler:visible:not(.display)').click();
		}

		// 加载完成之后关闭加载提示信息
		$('#mainFrame').load(function(){
			closeLoading();
		});
		
		// 调整网页大小，自动设置iframe高度
		$(window).resize(function(){
			$("#mainFrame").height((document.compatMode === "CSS1Compat" && document.documentElement
				.clientHeight || document.body.clientHeight) - $("#navbar").height());
			$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
		}).resize();
		
	});
	
	/**
	 * 步骤执行（下一步或上一步按钮）
	 * @param prevNext prev(向上) next(向下)
	 * @param currentLi 当前展开和执行的li元素
	 * @example 向上：executeStep('prev') 向上：executeStep('next')
	 */
	function executeStep(prevNext, currentLi){
		// 获得当前选中菜单
		var active = $('#sidebar li.active:last');
		// 根据执行的方向，是取第一个还是取最后一个
		var firstLast = (prevNext == 'next') ? 'first' : 'last';
		// 如果没有设置下一个菜单，则根根据选择选择获取
		if (currentLi == undefined){
			if(active.size() == 0){
				// 如果没有选中的菜单，则获取第一个菜单
				currentLi = $('#sidebar li:'+firstLast); 
			}else{
				// 获取选中菜单的下一个菜单
				if (prevNext == 'next'){
					currentLi = active.next(); 
				}else{
					currentLi = active.prev(); 
				}
			}
		}
		// 如果有子菜单，则获取最末的子菜单元素，并展开父级
		while(currentLi.find('> .submenu > li:'+firstLast).size() > 0){
			currentLi = currentLi.find('> .submenu > li:'+firstLast);
		}
		currentLi.find('> a:first').click();
		// 如果没有下一个菜单了，则往上级找
		if (currentLi.size() ==0){
			if (prevNext == 'next'){
				currentLi = active.parents('li').next();
			}else{
				currentLi = active.parents('li').prev();
			}
			if(currentLi.size() > 0){
				executeStep(prevNext, currentLi.eq(0));
// 			}else{ // 循环查找，如果到最后，则调转到第一位
// 				executeStep(prevNext, $('#sidebar li:'+firstLast));
			}
		}
	}
       
</script>
</body>
</html>