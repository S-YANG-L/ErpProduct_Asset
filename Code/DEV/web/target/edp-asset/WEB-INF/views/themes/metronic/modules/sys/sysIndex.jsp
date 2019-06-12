<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="jbox"/>
<c:set var="extHead">
<link href="${ctxStatic}/assets/global/plugins/bootstrap-toastr/toastr.min.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/assets/admin/layout/css/layout.min.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/assets/admin/layout/css/themes/${not empty cookie.style_color.value ? cookie.style_color.value : fns:getConfigDefault('sys.home.defaultStyleColor', 'default')}.css?${_version}" rel="stylesheet" type="text/css" id="style_color"/>
<script type="text/javascript">
	// 如果主页面在框架中，则突破框架直接显示到顶部窗口
	if(self.frameElement && self.frameElement.tagName == "IFRAME"){
		top.location = location;
	}
</script>
</c:set>
<%-- DOC: Apply "page-header-fixed-mobile" and "page-footer-fixed-mobile" class to body element to force fixed header or footer in mobile devices -->
<!-- DOC: Apply "page-sidebar-closed" class to the body and "page-sidebar-menu-closed" class to the sidebar menu element to hide the sidebar by default -->
<!-- DOC: Apply "page-sidebar-hide" class to the body to make the sidebar completely hidden on toggle -->
<!-- DOC: Apply "page-sidebar-closed-hide-logo" class to the body element to make the logo hidden on sidebar toggle -->
<!-- DOC: Apply "page-sidebar-hide" class to body element to completely hide the sidebar on sidebar toggle -->
<!-- DOC: Apply "page-sidebar-fixed" class to have fixed sidebar -->
<!-- DOC: Apply "page-footer-fixed" class to the body element to have fixed footer 加上后ie出现滚动 -->
<!-- DOC: Apply "page-sidebar-reversed" class to put the sidebar on the right side -->
<!-- DOC: Apply "page-full-width" class to the body element to have full width page without the sidebar menu --%>
<sys:header title="" extLibs="${extLibs}" extHead="${extHead}" bodyClass="page-header-fixed page-sidebar-fixed ${fns:getConfig('sys.home.defaultSidebarClosed') eq 'true' ? 'page-sidebar-closed' : ''}"/>
<div class="page-header navbar navbar-fixed-top">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
			<%-- <a href="index.html">
			<img src="${ctxStatic}/assets/admin/layout/img/logo.png" alt="logo" class="logo-default"/>
			</a> --%>
			<span>资产管理系统</span>
		</div>
		<!-- END LOGO -->
		<%@ include file="../../include/topMenu.jsp"%>
	</div>
	<!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<div class="clearfix"></div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
	<%@ include file="../../include/leftMenu.jsp"%>
	<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content"></div>
	</div>
	<!-- END CONTENT -->
</div>
<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->
<div class="page-footer hide">
	<div class="page-footer-inner">
		 Copyright &copy; 2013-${fns:getConfig('copyrightYear')}&nbsp;${fns:getConfig('companyName')}
	</div>
	<div class="page-footer-tools hide">
		<span class="go-top">
			<i class="fa fa-angle-up"></i>
		</span>
	</div>
</div>
<!-- END FOOTER -->
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/assets/global/plugins/bootstrap-toastr/toastr.min.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/assets/admin/layout/scripts/layout.min.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/jerichotab/js/jquery.jerichotab.min.js?${_version}" type="text/javascript"></script>
<script type="text/javascript">
// 初始化加载方法
$(document).ready(function() {
	Layout.init();
	setTimeout(function(){
		// 打开首页页签
		addTabPage(null, '首页', '${ctx}${fns:getConfigDefault("sys.home.pageUrl", "/../desktop")}' , null, false, false); 
		// 绑定hash更改事件，刷新打开指定页面的页签。
	    $(window).bind("hashchange", function(e) {
	    	var hash = window.location.hash.replace('#', '');
	    	var addTab = $('a[data-href="' + hash + '"]:eq(0)');
	        if (hash && hash != '' && addTab && addTab.length > 0){
	        	addTab.click();
	        }else{
	    		//$('.page-sidebar-menu .sub-menu .addTab :eq(0)').click(); // 默认展开第一个菜单
	        }
	    }).trigger("hashchange").resize();
		// 密码修改提示
	    if ('${modifyPasswordTip}' != ''){
			confirmx("${modifyPasswordTip}", function(){
				$('#modifyPassword').click();
			});
		}
	}, Metronic.isIE8() ? 1000 : 0);
});
/**
 * 添加TAB页面
 * @param $this 		点击的对象
 * @param title 		提示标题
 * @param url   		访问的路径
 * @param parentTabPageId 来源页面ID
 * @param closeable	 	是否有关闭按钮
 * @param refresh 		打开后是否刷新重新加载
 */
function addTabPage($this, title, url, parentTabPageId, closeable, refresh){
	$.fn.jerichoTab.addTab({
        tabFirer: $this,
        title: title,
        closeable: (closeable == undefined ? true : closeable),
        data: {
            dataType: 'iframe',
            dataLink: url + (parentTabPageId == undefined || parentTabPageId == '' ? '' : 
            	((url.indexOf('?') == -1 ? '?' : '&') + 'parentTabPageId=' + parentTabPageId))
        }
    }).loadData(refresh);
}

/**
 * 关闭当前TAB页面，并激活上级页面
 * @param parentTabPageId 上级界面ID
 * @param callback(contents, contentWindow)	关闭时的回调方法，传入上级页面的contents和contentWindow
 */
function closeCurrentTabPage(parentTabPageId, callback){
	if (parentTabPageId && parentTabPageId != ''){
		var contents = $("#"+parentTabPageId).contents();
		if ($("#"+parentTabPageId)[0]){
			var contentWindow = $("#"+parentTabPageId)[0].contentWindow;
			if (typeof callback == 'function'){
				callback(contents, contentWindow);
			}
		}
	}
	$.fn.jerichoTab.closeCurrentTab();
	if (parentTabPageId && parentTabPageId != ''){
		var tabIndex = (parentTabPageId.replace('jerichotabiframe_',''));
		$.fn.setTabActive(tabIndex).loadData();
	}
}
</script>
