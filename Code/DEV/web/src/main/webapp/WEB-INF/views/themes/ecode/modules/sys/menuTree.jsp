<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<ul class="nav nav-list" id="menu-${not empty param.parentCode ? param.parentCode : '0'}">

	<%-- 一级菜单 --%>
	<c:set var="firstMenu" value="true"/>
	<c:set var="menuList" value="${fns:getMenuListByParentCode(not empty param.parentCode ? param.parentCode : '0')}"/>
	<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
		<c:if test="${menu.isMenu && menu.parentCode eq (not empty param.parentCode ? param.parentCode : '0') && menu.isShow eq '1'}">
			<%-- 二级菜单 --%>
			<c:set var="subMenu2">
				<ul class="submenu">
					<c:set var="existsSubMenu2" value="false"/>
					<c:forEach items="${fns:getMenuListByParentCode(menu.menuCode)}" var="menu2">
						<c:if test="${menu2.isMenu && menu2.parentCode eq menu.menuCode && menu2.isShow eq '1'}">
							<c:set var="existsSubMenu2" value="true"/>
							<%-- 三级菜单 --%>
							<c:set var="subMenu3">
								<ul class="submenu">
									<c:set var="existsSubMenu3" value="false"/>
									<c:forEach items="${fns:getMenuListByParentCode(menu2.menuCode)}" var="menu3">
										<c:if test="${menu3.isMenu && menu3.parentCode eq menu2.menuCode && menu3.isShow eq '1'}">
											<c:set var="existsSubMenu3" value="true"/>
											<%-- 四级菜单 --%>
											<c:set var="subMenu4">
												<ul class="submenu">
													<c:set var="existsSubMenu4" value="false"/>
													<c:forEach items="${fns:getMenuListByParentCode(menu3.menuCode)}" var="menu4">
														<c:if test="${menu4.isMenu && menu4.parentCode eq menu3.menuCode && menu4.isShow eq '1'}">
															<c:set var="existsSubMenu4" value="true"/>
															<%-- 五级菜单 - - % >
															<c:set var="subMenu5">
																<ul class="submenu">
																	<c:set var="existsSubMenu5" value="false"/>
																	<c:forEach items="${fns:getMenuListByParentCode(menu4.menuCode)}" var="menu5">
																		<c:if test="${menu5.isMenu && menu5.parentCode eq menu4.menuCode && menu5.isShow eq '1'}">
																			<c:set var="existsSubMenu5" value="true"/>
																			<li class="${menuStyle eq '3' ? 'hover' : ''}">
																				<a ${not empty menu5.target ? '' : 'href="javascript:" data-'}href="${not empty menu5.url ? menu5.url : 'blank'}" 
																					target="${not empty menu5.target ? menu5.target : ''}" class="${not empty menu5.target ? '' : 'addTab'}${existsSubMenu6 ? ' dropdown-toggle' : ''}" style="color:${menu5.color}">
																					<i class="menu-icon ${not empty menu5.icon ? menu5.icon : 'fa fa-caret-right'} green" style="color:${menu5.color}"></i>
																					${menu5.localeName}<c:if test="${existsSubMenu6}"><b class="arrow fa fa-angle-down"></b></c:if>
																				</a>
																				<c:if test="${existsSubMenu6}">${subMenu6}</c:if>
																			</li>
																		</c:if> 
																	</c:forEach>
																</ul>
															</c:set>
															< % - - 五级菜单 END --%>
															<li class="${menuStyle eq '3' ? 'hover' : ''}">
																<a data-id="${menu4.id}" ${not empty menu4.target ? '' : 'href="javascript:" data-'}href="${not empty menu4.url ? menu4.url : 'blank'}" 
																	target="${not empty menu4.target ? menu4.target : ''}" class="${not empty menu4.target ? '' : 'addTab'}${existsSubMenu5 ? ' dropdown-toggle' : ''}" style="color:${menu4.color}">
																	<i class="menu-icon ${not empty menu4.icon ? menu4.icon : 'fa fa-caret-right'} green" style="color:${menu4.color}"></i>
																	${menu4.localeName}<c:if test="${existsSubMenu5}"><b class="arrow fa fa-angle-down"></b></c:if>
																</a>
																<c:if test="${existsSubMenu5}">${subMenu5}</c:if>
															</li>
														</c:if> 
													</c:forEach>
												</ul>
											</c:set>
											<%-- 四级菜单 END --%>
											<li class="${menuStyle eq '3' ? 'hover' : ''}">
												<a data-id="${menu3.id}" ${not empty menu3.target ? '' : 'href="javascript:" data-'}href="${not empty menu3.url ? menu3.url : 'blank'}" 
													target="${not empty menu3.target ? menu3.target : ''}" class="${not empty menu3.target ? '' : 'addTab'}${existsSubMenu4 ? ' dropdown-toggle' : ''}" style="color:${menu3.color}">
													<i class="menu-icon ${not empty menu3.icon ? menu3.icon : 'fa fa-caret-right'}" style="color:${menu3.color}"></i>
													${menu3.localeName}<c:if test="${existsSubMenu4}"><b class="arrow fa fa-angle-down"></b></c:if>
												</a>
												<c:if test="${existsSubMenu4}">${subMenu4}</c:if>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</c:set>
							<%-- 三级菜单 END --%>
							<li class="${menuStyle eq '3' ? 'hover' : ''}">
								<a data-id="${menu2.id}" ${not empty menu2.target ? '' : 'href="javascript:" data-'}href="${not empty menu2.url ? menu2.url : 'blank'}" 
									target="${not empty menu2.target ? menu2.target : ''}" class="${not empty menu2.target ? '' : 'addTab'}${existsSubMenu3 ? ' dropdown-toggle' : ''}" style="color:${menu2.color}">
									<i class="menu-icon ${not empty menu2.icon ? menu2.icon : 'fa fa-caret-right'}" style="color:${menu2.color}"></i>
									${menu2.localeName}<c:if test="${existsSubMenu3}"><b class="arrow fa fa-angle-down"></b></c:if>
								</a>
								<c:if test="${existsSubMenu3}">${subMenu3}</c:if>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</c:set>
			<%-- 二级菜单 END --%>
			<li class="${not empty firstMenu && firstMenu ? 'open' : ''}${menuStyle eq '3' ? ' hover' : ''}">
				<a data-id="${menu.id}" ${not empty menu.target ? '' : 'href="javascript:" data-'}href="${not empty menu.url ? menu.url : 'blank'}" 
					target="${not empty menu.target ? menu.target : ''}" class="${not empty menu.target ? '' : 'addTab'}${existsSubMenu2 ? ' dropdown-toggle' : ''}" style="color:${menu.color}">
					<i class="menu-icon ${not empty menu.icon ? menu.icon : 'fa fa-caret-right'}" style="color:${menu.color}"></i>
					<span class="menu-text">${menu.localeName}</span>
					<span class="selected"></span>
					<c:if test="${existsSubMenu2}"><b class="arrow fa fa-angle-down ${not empty firstMenu && firstMenu ? 'open' : ''}"></b></c:if>
				</a>
				<c:if test="${existsSubMenu2}">${subMenu2}</c:if>
			</li>
			<c:set var="firstMenu" value="false"/>
		</c:if>
	</c:forEach>
	<%-- 一级菜单 END --%>
	
</ul><!-- /.nav-list -->