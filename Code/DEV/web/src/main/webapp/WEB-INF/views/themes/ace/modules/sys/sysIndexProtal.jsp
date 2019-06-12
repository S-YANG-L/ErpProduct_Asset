<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html><html><head><meta charset="utf-8"/><meta content="webkit" name="renderer"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/><meta http-equiv="Expires" content="0"/>
<meta http-equiv="Cache-Control" content="no-cache"/><meta http-equiv="Cache-Control" content="no-store"/>
<meta content="width=device-width, initial-scale=1, user-scalable=1" name="viewport"/>
<meta content="${fns:getConfig('productName')}" name="description"/>
<meta content="http://www.ecode.net.cn" name="author"/>
<title>${fns:getConfig('productName')} - 门户首页</title>
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
<link href="${ctxStatic}/common/jeesite.css?${_version}" type="text/css" rel="stylesheet"/>
<!--[if lte IE 8]><script src="${ctxStatic}/common/respond.min.js"></script><![endif]-->
<script type="text/javascript">
	// 如果主页面在框架中，则突破框架直接显示到顶部窗口
	if(self.frameElement && self.frameElement.tagName == "IFRAME"){
		top.location = location;
	}
</script>
</head>
<body class="no-skin">
<!-- #section:basics/navbar.layout -->
<c:set var="menuStyle">${fns:getConfig('sys.home.menuStyle')}</c:set>
<div id="navbar" class="navbar navbar-default navbar-fixed-top2 navbar-collapse ${menuStyle eq '3' ? 'h-navbar' : '' }">
	<script type="text/javascript">
		try{ace.settings.check('navbar' , 'fixed')}catch(e){}
	</script>
	
	<div class="navbar-container" id="navbar-container">
		
		<!-- #section:basics/navbar.toggle -->
		<button id="navbar-toggler" class="navbar-toggle pull-right navbar-toggle-img2 collapsed2" type="button" 
				data-toggle="collapse" data-target=".navbar-buttons,.navbar-menu" onclick="setTimeout(function(){$(window).resize();
					setTimeout(function(){$(window).resize();setTimeout(function(){$(window).resize();},1500);},1000);},800);">
			<span class="sr-only">顶部栏菜单</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<%-- <c:set var="user" value="${fns:getUser()}"/>
			<c:if test="${not empty user.photo}">
				<img class="nav-user-photo" src="${user.photo}" alt="${user.userName}"/>
			</c:if><c:if test="${empty user.photo}">
				<img class="nav-user-photo" src="${ctxStatic}/images/userinfo.jpg" alt="${user.userName}"/>
			</c:if> --%>
		</button>
		
		<!-- #section:basics/sidebar.toggle -->
		<button id="menu-toggler" class="navbar-toggle menu-toggler pull-left" type="button"
				data-toggle="collapse" data-target="#sidebar">
			<span class="sr-only">侧边栏菜单</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		
		<div class="navbar-header pull-left" style="min-width:179px;">
			<!-- #section:basics/navbar.layout.brand -->
			<a href="#" class="navbar-brand">
				<small>
					<i class="fa fa-leaf"></i>
					${fns:getConfig('productName')} - 门户首页
				</small>
			</a>
		</div>
		
		<%@ include file="/WEB-INF/views/themes/ace/include/topMenu.jsp"%>
		
	</div><!-- /.navbar-container -->
	
</div>
<!-- /section:basics/navbar.layout -->

<div class="main-container" id="main-container">
	<script type="text/javascript">
		try{ace.settings.check('main-container' , 'fixed')}catch(e){}
	</script>

	<%@ include file="/WEB-INF/views/themes/ace/include/leftMenu.jsp"%>
	
	<div class="main-content">
		<div id="tabpanel"></div>
	
		<%--<div class="main-content-inner">
			<!-- #section:basics/content.breadcrumbs -->
			<div class="breadcrumbs breadcrumbs-fixed" id="breadcrumbs">
				<script type="text/javascript">
					try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
				</script>

				<ul class="breadcrumb">
					<li>
						<i class="ace-icon fa fa-home home-icon"></i>
						<a href="#">Home</a>
					</li>
				</ul><!-- /.breadcrumb -->

				<!-- #section:basics/content.searchbox -->
				<div class="nav-search" id="nav-search">
					<form class="form-search">
						<span class="input-icon">
							<input type="text" placeholder="Search ..." class="nav-search-input" id="nav-search-input" autocomplete="off" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</form>
				</div><!-- /.nav-search -->

				<!-- /section:basics/content.searchbox -->
			</div>

			<!-- /section:basics/content.breadcrumbs -->
			<div class="page-content">
				<!-- #section:settings.box -->
				<div class="ace-settings-container" id="ace-settings-container">
					<div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
						<i class="ace-icon fa fa-cog bigger-130"></i>
					</div>

					<div class="ace-settings-box clearfix" id="ace-settings-box">
						<div class="pull-left width-50">
							<!-- #section:settings.skins -->
							<div class="ace-settings-item">
								<div class="pull-left">
									<select id="skin-colorpicker" class="hide">
										<option data-skin="no-skin" value="#438EB9">#438EB9</option>
										<option data-skin="skin-1" value="#222A2D">#222A2D</option>
										<option data-skin="skin-2" value="#C6487E">#C6487E</option>
										<option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
									</select>
								</div>
								<span>&nbsp; Choose Skin</span>
							</div>

							<!-- /section:settings.skins -->

							<!-- #section:settings.navbar -->
							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
								<label class="lbl" for="ace-settings-navbar"> Fixed Navbar</label>
							</div>

							<!-- /section:settings.navbar -->

							<!-- #section:settings.sidebar -->
							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
								<label class="lbl" for="ace-settings-sidebar"> Fixed Sidebar</label>
							</div>

							<!-- /section:settings.sidebar -->

							<!-- #section:settings.breadcrumbs -->
							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" />
								<label class="lbl" for="ace-settings-breadcrumbs"> Fixed Breadcrumbs</label>
							</div>

							<!-- /section:settings.breadcrumbs -->

							<!-- #section:settings.rtl -->
							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
								<label class="lbl" for="ace-settings-rtl"> Right To Left (rtl)</label>
							</div>

							<!-- /section:settings.rtl -->

							<!-- #section:settings.container -->
							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
								<label class="lbl" for="ace-settings-add-container">
									Inside
									<b>.container</b>
								</label>
							</div>

							<!-- /section:settings.container -->
						</div><!-- /.pull-left -->

						<div class="pull-left width-50">
							<!-- #section:basics/sidebar.options -->
							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-hover" />
								<label class="lbl" for="ace-settings-hover"> Submenu on Hover</label>
							</div>

							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-compact" />
								<label class="lbl" for="ace-settings-compact"> Compact Sidebar</label>
							</div>

							<div class="ace-settings-item">
								<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-highlight" />
								<label class="lbl" for="ace-settings-highlight"> Alt. Active Item</label>
							</div>

							<!-- /section:basics/sidebar.options -->
						</div><!-- /.pull-left -->
					</div><!-- /.ace-settings-box -->
				</div><!-- /.ace-settings-container -->
				<!-- /section:settings.box -->
				<div class="page-content-area" data-ajax-content="true">
					<!-- ajax content goes here -->
				</div><!-- /.page-content-area -->
			</div><!-- /.page-content -->
		</div> --%>
	</div><!-- /.main-content -->

	<%--<div class="footer">
		<div class="footer-inner">
			<!-- #section:basics/footer -->
			<div class="footer-content">
				<span class="bigger-120">
					Copyright &copy; 2013-${fns:getConfig('copyrightYear')}&nbsp;${fns:getConfig('companyName')}
				</span>

				&nbsp; &nbsp;
				<span class="action-buttons">
					<a href="#">
						<i class="ace-icon fa fa-twitter-square light-blue bigger-150"></i>
					</a>

					<a href="#">
						<i class="ace-icon fa fa-facebook-square text-primary bigger-150"></i>
					</a>

					<a href="#">
						<i class="ace-icon fa fa-rss-square orange bigger-150"></i>
					</a>
				</span>
			</div>

			<!-- /section:basics/footer -->
		</div>
	</div>

	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
		<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
	</a> --%>
</div><!-- /.main-container -->
<script src="${ctxStaticTheme}/js/bootstrap.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/elements.scroller.js?${_version}"></script>
<%-- <script src="${ctxStaticTheme}/js/ace/elements.colorpicker.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/elements.fileinput.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/elements.typeahead.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/elements.wysiwyg.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/elements.spinner.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/elements.treeview.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/elements.wizard.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/elements.aside.js?${_version}"></script> --%>
<script src="${ctxStaticTheme}/js/ace/ace.js?${_version}"></script>
<%-- <script src="${ctxStaticTheme}/js/ace/ace.ajax-content.js?${_version}"></script> --%>
<script src="${ctxStaticTheme}/js/ace/ace.touch-drag.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/ace.sidebar.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/ace.sidebar-scroll-2.js?${_version}"></script>
<%-- <script src="${ctxStaticTheme}/js/ace/ace.submenu-hover.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/ace.widget-box.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/ace.settings.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/ace.settings-rtl.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/ace.settings-skin.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/ace.widget-on-reload.js?${_version}"></script> --%>
<%-- <script src="${ctxStaticTheme}/js/ace/ace.searchbox-autocomplete.js?${_version}"></script> --%>
<script src="${ctxStatic}/wdScrollTab/js/TabPanel.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-toastr/2.0/toastr.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/common/jeesite.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/common/tabPage.js?${_version}" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		// 初始化页签
		initTabPage('tabpanel', {
			height: function () {
				var hs = $('#sidebar.h-sidebar:visible').height();
				return $(window).height() - $('#navbar').height() - (hs ? hs : 0);
			}
		});

   		// 打开首页页签
		addTabPage(null, '<i class="ace-icon fa fa-home home-icon"'
			+'style="font-size:18px;vertical-align:middle;margin-top:-3px;"></i> 首页',
			'${ctx}${fns:getConfigDefault("sys.home.pageUrl", "/../desktop")}' , null, false, false);
		
		// 初始密码提示
		var modifyPasswordTip = function($this){
			if ('${modifyPasswordTip}' != ''){
				confirmx("${modifyPasswordTip}", function(){
					$('#modifyPassword').click();
				});
			}
		}
		modifyPasswordTip();
		
   		// 打开菜单方法
   		var openMenu = function($this){
			
   			// 初始密码提示
   			if ($this.attr('id') != 'modifyPassword'){
   				modifyPasswordTip($this);
   			}
   					
   			// 获取网页地址和标题
			var href = $this.data("href");
			var title = $this.data("title");
			
			// 打开页签页面
			if (href && href != ''){
				addTabPage($this, $.trim(title || $this.text()), href, null, true, false);
				window.location.hash = href.replace('#', '');
			}
			//<c:if test="${menuStyle eq '2'}">
			cookie('currentMenuId', $(".navbar-menu li.open a.menu").data("id")); // 保存当前一级菜单ID
			//</c:if>
			
			// 如果小窗口下，则选择菜单后，则折叠菜单
			$('#menu-toggler.display:visible').click();

   		}
   		
		//<c:if test="${menuStyle eq '2'}">
		// 绑定水平菜单单击事件
		$(".navbar-menu a.menu").click(function(){
			// 一级菜单焦点
			$('.navbar-menu li').removeClass('open');
			$(this).parents('li').addClass('open');
			
			// 如果一级菜单有链接，则打开链接隐藏侧边栏
			if ($(this).data('href') != ''){
				$('.sidebar').addClass('hide');
				$('.main-content').css('margin-left','0');
				$(window).resize();
				// 打开菜单地址
				openMenu($(this));
				// 如果小窗口下，点击一级菜单后，自动隐藏
				if ($('.navbar-menu').hasClass("in")){
					$('#navbar-toggler:visible').click();
				}
			}else{
				$('.sidebar').removeClass('hide');
				$('.main-content').css('margin-left','');
				$(window).resize();
				// 显示二级菜单
				var menuId = "#menu-" + $(this).data("id");
				if ($(menuId).length > 0){
					$("#sidebar .sidebar-menu > ul").hide();
					$(menuId).show();	
				}else{
					// 获取二级菜单数据
					$.ajax({type: "get", url: $(this).data("href2") 
							+ '&t=' + new Date().getTime(),
						async: false, success: function(data){
							$("#sidebar .sidebar-menu > ul").hide();
							$("#sidebar .sidebar-menu").append(data);
						}
					});
				}
				
				// 如果小窗口下，点击一级菜单后，显示二级菜单
				if ($('.navbar-menu').hasClass("in")){
					$('#navbar-toggler:visible').click();
					$('#menu-toggler:visible:not(.display)').click();
				}
			}
			// 重置侧边栏滚动条
			$('#sidebar').ace_sidebar_scroll('reset');
			return false;
		});
		// 刷新页面后激活上次的菜单状态位置
		var currentMenuId = cookie('currentMenuId');
		if (currentMenuId && currentMenuId != ''){
			var currentMenu = $(".navbar-menu a.menu[data-id="+currentMenuId+"]");
			if (currentMenu.length > 0 && window.location.hash != ''){
				currentMenu.click();
			}else{
				$(".navbar-menu a.menu:first").click(); 
			}
		}else{
			// 默认加载第一个一级菜单的二级菜单
			$(".navbar-menu a.menu:first").click(); 
		}
		//</c:if>
		
		//<c:if test="${fns:getConfig('sys.home.defaultSidebarClosed') eq 'true'}">
		// 默认折叠左侧菜单
		if (!$("#sidebar").hasClass("menu-min")){
			$("#sidebar-collapse").click();
		}
		//</c:if>
		
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
 			
			// 打开菜单
			openMenu($(this));
			
		});
		
		// 绑定窗口大小改变事件
		$(window).resize(function(){
			// 解决小窗口时，隐藏左侧栏的情况下，放大窗口侧边栏不显示的问题。
			$('#sidebar').removeClass('collapse');
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
			//<c:if test="${menuStyle eq '2'}">
			$('#navbar-toggler:visible:not(.display)').click();
			//</c:if><c:if test="${menuStyle ne '2'}">
			$('#menu-toggler:visible:not(.display)').click();
			//</c:if>
		}

   		// IE8下窗口修正
		setTimeout(function(){
			$(window).resize();
		},100); 
	});
</script>
<c:if test="${fns:getModule('msg').isEnable}">
	<!-- Message JS -->
	<script src="${ctxPath}/dwr/engine.js?${_version}" type="text/javascript"></script>
	<script src="${ctxPath}/dwr/util.js?${_version}" type="text/javascript"></script>
	<script src="${ctxPath}/dwr/interface/MsgPushService.js?${_version}" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-plugin/jquery-timeago-1.4.1.js?${_version}" type="text/javascript"></script>
	<script src="${ctxStatic}/common/msgPush.js?${_version}" type="text/javascript"></script>
	<script type="text/template" id="msgTipTpl">
		<abbr class="timeago" title="{{time}}">{{time}}</abbr> 来自 {{message.senderName}} <br/> {{&message.contentTitle}} 
		<div style="margin:5px 0 2px;float:right;">
			<button class="btn btn-white btn-primary btn-sm" type="button" data-href="${ctx}/msg/message/view?mrId={{id}}"
				onclick="readMsg(this, '消息详情', '{{id}}')">查看</button>&nbsp;
			{{#buttonList}}
				<button class="btn btn-white btn-primary btn-sm" type="button" data-href="${ctx}{{href}}"
					 onclick="readMsg(this, '消息{{name}}', '{{id}}');">{{name}}</button>&nbsp;
			{{/buttonList}}
		</div>
	</script>
	<script type="text/template" id="msgListTpl">
		<li id="msg{{id}}">
			<a href="javascript:" data-href="${ctx}/msg/message/view?mrId={{id}}" onclick="readMsg(this, '消息详情', '{{id}}')" >
				<div class="clearfix">
					<span class="pull-left"><i class="btn btn-xs no-hover btn-pink fa fa-comment"></i> {{&message.contentTitle}}</span>
					<span class="pull-right"><abbr class="timeago" title="{{time}}">{{time}}</abbr></span>
				</div>
			</a>
		</li>
	</script>
</c:if>
</body>
</html>