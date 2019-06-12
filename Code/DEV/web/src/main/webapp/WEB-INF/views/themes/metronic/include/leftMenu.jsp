<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- BEGIN SIDEBAR -->
<div class="page-sidebar-wrapper">
	<div class="page-sidebar navbar-collapse collapse"><!-- BEGIN SIDEBAR MENU -->
		<ul class="page-sidebar-menu page-sidebar-menu-closed">
			<%-- DOC: To remove the sidebar toggler from the sidebar you just need to completely remove the below "sidebar-toggler-wrapper" LI element --%>
			<li class="sidebar-toggler-wrapper" style="margin-bottom:10px;">
				<!-- BEGIN SIDEBAR TOGGLER BUTTON -->
				<div class="sidebar-toggler"></div>
				<!-- BEGIN SIDEBAR TOGGLER BUTTON -->
			</li>
			<%-- <!-- DOC: To remove the search box from the sidebar you just need to completely remove the below "sidebar-search-wrapper" LI element -->
			<li class="sidebar-search-wrapper hidden-xs">
				<!-- BEGIN RESPONSIVE QUICK SEARCH FORM -->
				<!-- DOC: Apply "sidebar-search-bordered" class the below search form to have bordered search box -->
				<!-- DOC: Apply "sidebar-search-bordered sidebar-search-solid" class the below search form to have bordered & solid search box -->
				<form class="sidebar-search" action="#" method="POST">
					<a href="javascript:;" class="remove">
					</a>
					<div class="input-group">
						<input type="text" class="form-control" placeholder="搜索...">
						<span class="input-group-btn">
						<!-- DOC: value=" ", that is, value with space must be passed to the submit button -->
						<input class="btn submit" type="button" type="button" value=" "/>
						</span>
					</div>
				</form>
				<!-- END RESPONSIVE QUICK SEARCH FORM -->
			</li> --%>
			<c:set var="menuList" value="${fns:getMenuList()}"/>
			<c:set var="firstMenu" value="true"/>
			<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
				<c:if test="${menu.isMenu && menu.parentCode eq '0' && menu.isShow eq '1'}">
					<li class="${not empty firstMenu && firstMenu ? 'start active' : ''}">
						<a ${not empty menu.target ? '' : 'data-'}href="${not empty menu.url ? menu.url : 'blank'}" 
								target="${not empty menu.target ? menu.target : 'mainFrame'}" class="${not empty menu.target ? '' : 'addTab'}" style="color:${menu.color}">
							<i class="icon ${not empty menu.icon ? menu.icon : 'icon-arrow-right'}" style="color:${menu.color}"></i>
							<span class="title">${menu.name}</span><span class="selected"></span>
							<span class="arrow ${not empty firstMenu && firstMenu ? 'open' : ''}"></span>
						</a>
						<!-- 二级菜单 -->
						<ul class="sub-menu">
							<c:forEach items="${menuList}" var="menu2">
								<c:if test="${menu2.isMenu && menu2.parentCode eq menu.menuCode && menu2.isShow eq '1'}">
									<c:set var="subMenu3">
										<!-- 三级菜单 -->
										<ul class="sub-menu">
											<c:set var="existsSubMenu3" value="false"/>
											<c:forEach items="${menuList}" var="menu3">
												<c:if test="${menu3.isMenu && menu3.parentCode eq menu2.menuCode && menu3.isShow eq '1'}">
													<c:set var="existsSubMenu3" value="true"/>
													<li>
														<c:set var="subMenu4">
															<!-- 四级菜单 -->
															<ul class="sub-menu">
																<c:set var="existsSubMenu4" value="false"/>
																<c:forEach items="${menuList}" var="menu4">
																	<c:if test="${menu4.isMenu && menu4.parentCode eq menu3.menuCode && menu4.isShow eq '1'}">
																		<c:set var="existsSubMenu4" value="true"/>
																		<li>
																			<a ${not empty menu4.target ? '' : 'data-'}href="${not empty menu4.url ? menu4.url : 'blank'}" 
																				target="${not empty menu4.target ? menu4.target : 'mainFrame'}" class="${not empty menu4.target ? '' : 'addTab'}" style="color:${menu4.color}">
																			<i class="icon ${not empty menu4.icon ? menu4.icon : 'icon-arrow-right'}" style="color:${menu4.color}"></i>
																			${menu4.name}</a>
																		</li>
																	</c:if>
																</c:forEach>
															</ul>
															<!-- 四级菜单 END -->
														</c:set>
														<a ${not empty menu3.target ? '' : 'data-'}href="${not empty menu3.url ? menu3.url : 'blank'}" 
															target="${not empty menu3.target ? menu3.target : 'mainFrame'}" class="${not empty menu3.target ? '' : 'addTab'}" style="color:${menu3.color}">
														<i class="icon ${not empty menu3.icon ? menu3.icon : 'icon-arrow-right'}" style="color:${menu3.color}"></i>
														${menu3.name}<c:if test="${existsSubMenu4}"><span class="arrow"></span></c:if></a>${subMenu4}
													</li>
												</c:if>
											</c:forEach>
										</ul>
										<!-- 三级菜单 END -->
									</c:set>
									<li>
										<a ${not empty menu2.target ? '' : 'data-'}href="${not empty menu2.url ? menu2.url : 'blank'}" 
												target="${not empty menu2.target ? menu2.target : 'mainFrame'}" class="${not empty menu2.target ? '' : 'addTab'}" style="color:${menu2.color}">
										<i class="icon ${not empty menu2.icon ? menu2.icon : 'icon-arrow-right'}" style="color:${menu2.color}"></i>
										${menu2.name}<c:if test="${existsSubMenu3}"><span class="arrow"></span></c:if></a>${subMenu3}
									</li>
								</c:if>
							</c:forEach>
						</ul>
						<!-- 二级菜单 END -->
					</li>
					<c:set var="firstMenu" value="false"/>
				</c:if>
			</c:forEach>
		</ul>
		<!-- END SIDEBAR MENU -->
	</div>
</div>
<!-- END SIDEBAR -->