<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
		<!-- footer -->
	    <div id="footer">
	       <div class="footer_in">
	           <div class="footer_left">
	              <p><img src="${ctxStaticTheme}/img/logo_02.png" width="94" height="33"></p>
	              <p class="weixin_img"><img src="${ctxStaticTheme}/img/weixin.png" width="123" height="124"></p>
	              <p>${site.copyright}</p>
	              <p>${fns:getDate('yyyy年MM月dd日 E')}</p>
	           </div>
	           <div class="footer_right">
	              <div class="footer_right_box">
	                  <div class="footer_right_tt">
	                      <h2>常规问题</h2>
	                      <a href="#">开发技巧</a>
	                      <a href="#">快速入门</a>
	                      <a href="#">推荐阅读</a>
	                  </div>
	                  <div class="footer_right_tt">
	                      <h2>技术文档</h2>
	                      <a href="#">云端代码</a>
	                      <a href="#">JavaScript</a>
	                      <a href="#">实例与代码</a>
	                  </div>
	                  <div class="footer_right_tt">
	                      <h2>关于我们</h2>
	                      <a href="#">公司简介</a>
	                      <a href="#">服务条款</a>
	                      <a href="#">隐私政策</a>
	                  </div>
	              </div>
	              <div class="footer_right_menu">
					<a href="${ctx}/guestbook" target="_blank">公共留言</a>|<a
					href="${ctx}/search" target="_blank">全站搜索</a>|<a
					href="${ctx}/map-${site.siteCode}${fns:getUrlSuffix()}"
					target="_blank">站点地图</a>|<a href="mailto:thinkgem@163.com">技术支持</a>|<a
					href="${pageContext.request.contextPath}${fns:getAdminPath()}"
					target="_blank">进入管理系统</a>
				 </div>
	          </div>
	       </div>
	    </div>
    	<!-- footer end -->
	</div>