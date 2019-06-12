<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="custom,jquery,fonts,jbox,tabpanel,jeesite"/>
<sys:header title="" extLibs="${extLibs}" useTheme="true" bodyClass="no-skin"/>
<link href="${ctxStatic}/jquery-toastr/2.0/toastr.css?${_version}" rel="stylesheet"/>
<link href="${ctxStaticTheme}/css/ecode-style.css?${_version}" rel="stylesheet"/>
<script>
	// 如果主页面在框架中，则突破框架直接显示到顶部窗口
	if(self.frameElement && self.frameElement.tagName == "IFRAME"){
		top.location.reload();
	}
</script>
<!-- #section:basics/navbar.layout -->
<c:set var="menuStyle">${fns:getConfig('sys.home.menuStyle')}</c:set>
<div id="navbar" class="navbar navbar-default navbar-fixed-top2 navbar-collapse ${menuStyle eq '3' ? 'h-navbar' : '' }">
	<script>
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
		
		<div class="navbar-header pull-left logo" style="width:auto;min-width:189px;">
			<c:choose>
				<c:when test="${fns:getConfig('productName') eq 'Ecode JUDP'}">
					<img src="${ctxStaticTheme}/images/logo2.png"
						style="width:180px;height:40px;margin:3px 0 0 2px;">
				</c:when>
				<c:otherwise>
					<a href="#" class="navbar-brand">
						<small>
							<i class="fa icon-layers"></i>
							&nbsp;资产管理系统
						</small>
					</a>
				</c:otherwise>
			</c:choose>
		</div>
		
		<%@ include file="../../include/topMenu.jsp"%>
		
	</div><!-- /.navbar-container -->
	
</div>
<!-- /section:basics/navbar.layout -->

<div class="main-container" id="main-container">
	<script>
		try{ace.settings.check('main-container' , 'fixed')}catch(e){}
	</script>

	<%@ include file="../../include/leftMenu.jsp"%>
	
	<div class="main-content">
		<div id="tabpanel"></div>

	</div><!-- /.main-content -->
</div><!-- /.main-container -->
<sys:footer extLibs="${extLibs}" useTheme="true"/>
<script src="${ctxStaticTheme}/js/ace/elements.scroller.js"></script>
<script src="${ctxStaticTheme}/js/ace/ace.touch-drag.js"></script>
<script src="${ctxStaticTheme}/js/ace/ace.sidebar.js"></script>
<script src="${ctxStaticTheme}/js/ace/ace.sidebar-scroll-2.js"></script>
<script src="${ctxStatic}/jquery-toastr/2.0/toastr.js?${_version}"></script>
<script src="${ctxStatic}/common/tabPage.js?${_version}"></script>
<script>
	$(document).ready(function(){
		
		// 初始化页签
		initTabPage('tabpanel', {
			tabWidth: 183,
			height: function () {
				var hs = $('#sidebar.h-sidebar:visible').height();
				return $(window).height() - $('#navbar').height() - (hs ? hs : 0);
			}
		});

   		// 打开首页页签
		addTabPage(null, '<i class="ace-icon fa fa-home home-icon"'
			+'style="font-size:18px;vertical-align:middle;margin-top:-3px;"></i> ${fns:text("首页")}',
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
   			
			// 标记为菜单单击，防止重复调用
			isMenuClickFlag = true;
			
   			// 初始密码提示
   			//if ($this.attr('id') != 'modifyPassword'){
   			//	modifyPasswordTip($this);
   			//}
   			
   			// 获取网页地址和标题
			var href = $this.data("href");
			var title = $this.data("title");
			var id = $this.data("id");
			// 打开页签页面
			if (href && href != '' && href != 'blank'){
				addTabPage($this, $.trim(title || $this.text()), href, null, true, false);
				window.location.hash = href.replace('#', '');
			}
			//<c:if test="${menuStyle eq '2'}">
			cookie('currentMenuId', $(".navbar-menu li.open_menu a.menu").data("id")); // 保存当前一级菜单ID
			//</c:if>
			
			// 如果小窗口下，则选择菜单后，则折叠菜单
			$('#menu-toggler.display:visible').click();
			
			// 菜单不为空时，ajax保存当前操作的菜单id
			if(href!=''){
				$.post('${ctx}/sys/usedMenu/saveUsedMenu',{menuId:id},function(data){},'json');
			}
   		}
   		
		//<c:if test="${menuStyle eq '2'}">
		// 绑定水平菜单单击事件
		$(".navbar-menu a.menu").click(function(){
			// 一级菜单焦点
			$('.navbar-menu li').removeClass('open').removeClass('open_menu');
			$(this).parents('li').addClass('open_menu');
			
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
		
		$('#sidebar .userinfo img').click(function(){
			$("#sidebar-collapse").click();
		});
		
		// 是否是单击的菜单，防止打开菜单重复调用。
		var isMenuClickFlag = false;
		
		// 绑定菜单按钮事件
		$(document).on('click', 'a.addTab', function (e) {

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
				if (hash && hash != '' && hash != window.location.pathname){
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
<c:if test="${fns:getModule('msgim').isEnable}">
	<%@ include file="/WEB-INF/views/include/layim.jsp" %>
</c:if>
<c:if test="${fns:getModule('msg').isEnable}">
	<%@ include file="../../include/msgPushV2.jsp" %>
</c:if>