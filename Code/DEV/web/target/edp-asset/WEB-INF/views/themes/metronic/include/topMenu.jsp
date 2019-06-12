<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:if test="false">
	<!-- BEGIN HORIZANTAL MENU  DOC: Body add class page-full-width -->
	<!-- DOC: Remove "hor-menu-light" class to have a horizontal menu with theme background instead of white background -->
	<!-- DOC: This is desktop version of the horizontal menu. The mobile version is defined(duplicated) in the responsive menu below along with sidebar menu. So the horizontal menu has 2 seperate versions -->
	<div class="hor-menu hor-menu-light hidden-sm hidden-xs">
		<ul class="nav navbar-nav">
		
			<c:set var="menuList" value="${fns:getMenuList()}"/>
			<c:set var="firstMenu" value="false"/>
			<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
				<c:if test="${menu.isMenu && menu.parentCode eq '0' && menu.isShow eq '1'}">
					<li class="${not empty firstMenu && firstMenu ? 'start active' : ''} classic-menu-dropdown">
						<a ${not empty menu.target ? '' : 'data-'}href="${not empty menu.url ? menu.url : 'blank'}" 
								target="${not empty menu.target ? menu.target : 'mainFrame'}" class="${not empty menu.target ? '' : 'addTab'}" style="color:${menu.color}"
								data-toggle="dropdown" data-hover="dropdown">
							<i class="icon ${not empty menu.icon ? menu.icon : 'icon-arrow-right'}" style="color:${menu.color}"></i>
							<span class="title">${menu.name}<i class="fa fa-angle-down"></i></span><span class="selected"></span>
							<span class="arrow ${not empty firstMenu && firstMenu ? 'open' : ''}"></span>
						</a>
						<!-- 二级菜单 -->
						<ul class="sub-menu dropdown-menu">
							<c:forEach items="${menuList}" var="menu2">
								<c:if test="${menu2.isMenu && menu2.parentCode eq menu.menuCode && menu2.isShow eq '1'}">
									<c:set var="subMenu3">
										<!-- 三级菜单 -->
										<ul class="sub-menu dropdown-menu">
											<c:set var="existsSubMenu3" value="false"/>
											<c:forEach items="${menuList}" var="menu3">
												<c:if test="${menu3.isMenu && menu3.parentCode eq menu2.menuCode && menu3.isShow eq '1'}">
													<c:set var="existsSubMenu3" value="true"/>
													<c:set var="subMenu4">
														<!-- 四级菜单 -->
														<ul class="sub-menu dropdown-menu">
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
													<li class="${existsSubMenu4 ? 'dropdown-submenu' : ''}">
														<a ${not empty menu3.target ? '' : 'data-'}href="${not empty menu3.url ? menu3.url : 'blank'}" 
															target="${not empty menu3.target ? menu3.target : 'mainFrame'}" class="${not empty menu3.target ? '' : 'addTab'}" style="color:${menu3.color}">
														<i class="icon ${not empty menu3.icon ? menu3.icon : 'icon-arrow-right'}" style="color:${menu3.color}"></i>
														${menu3.name}</a>${subMenu4}
													</li>
												</c:if>
											</c:forEach>
										</ul>
										<!-- 三级菜单 END -->
									</c:set>
									<li class="${existsSubMenu3 ? 'dropdown-submenu' : ''}">
										<a ${not empty menu2.target ? '' : 'data-'}href="${not empty menu2.url ? menu2.url : 'blank'}" 
												target="${not empty menu2.target ? menu2.target : 'mainFrame'}" class="${not empty menu2.target ? '' : 'addTab'}" style="color:${menu2.color}">
										<i class="icon ${not empty menu2.icon ? menu2.icon : 'icon-arrow-right'}" style="color:${menu2.color}"></i>
										${menu2.name}</a>${subMenu3}
									</li>
								</c:if>
							</c:forEach>
						</ul>
						<!-- 二级菜单 END -->
					</li>
					<c:set var="firstMenu" value="false"/>
				</c:if>
			</c:forEach>
			
			<%-- <c:if test="false">
				<!-- DOC: Remove data-hover="dropdown" and data-close-others="true" attributes below to disable the horizontal opening on mouse hover -->
				<li class="classic-menu-dropdown active">
					<a href="${ctx}">
						工作首页 <span class="selected"></span>
					</a>
				</li>
				<li class="mega-menu-dropdown">
					<a data-toggle="dropdown" href="javascript:;" class="dropdown-toggle">
						复杂菜单 <i class="fa fa-angle-down"></i>
					</a>
					<ul class="dropdown-menu">
						<li>
							<!-- Content container to add padding -->
							<div class="mega-menu-content">
								<div class="row">
									<ul class="col-md-4 mega-menu-submenu">
										<li>
											<h3>Layouts</h3>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Dashboard & Mega Menu </a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Horizontal & Sidebar Menu </a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Layout with Simple Line Icons <span class="badge badge-roundless badge-success">new</span></a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Layout with Glyphicon</a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Full Height Portlet <span class="badge badge-roundless badge-danger">new</span></a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Full Height Content <span class="badge badge-roundless badge-warning">new</span></a> 
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Horizontal Mega Menu 1 </a>
										</li>
									</ul>
									<ul class="col-md-4 mega-menu-submenu">
										<li>
											<h3>More Layouts</h3>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Horizontal Mega Menu 2 </a>
										</li>				
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Search Box On Header 1 </a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Search Box On Header 2 </a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Sidebar Search Option 1 </a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Sidebar Search Option 2 </a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Right Sidebar Page </a>
										</li>										
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Sidebar Fixed Page </a>
										</li>
									</ul>
									<ul class="col-md-4 mega-menu-submenu">
										<li>
											<h3>Even More!</h3>
										</li>						
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Sidebar Closed Page </a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Content Loading via Ajax </a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Disabled Menu Links </a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Blank Page </a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Boxed Page </a>
										</li>
										<li>
											<a href="#">
											<i class="fa fa-angle-right"></i> Language Switch Bar </a>
										</li>
									</ul>
								</div>
							</div>
						</li>
					</ul>
				</li>
				<li class="mega-menu-dropdown mega-menu-full">
					<a data-toggle="dropdown" href="javascript:;" class="dropdown-toggle">
						全屏菜单 <i class="fa fa-angle-down"></i>
					</a>
					<ul class="dropdown-menu">
						<li>
							<!-- Content container to add padding -->
							<div class="mega-menu-content ">
								<div class="row">
									<div class="col-md-7">
										<ul class="col-md-4 mega-menu-submenu">
											<li>
												<h3>Layouts</h3>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Dashboard & Mega Menu </a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Horizontal & Sidebar Menu </a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Layout with Simple Line Icons <span class="badge badge-roundless badge-success">new</span></a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Layout with Glyphicon</a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Full Height Portlet <span class="badge badge-roundless badge-danger">new</span></a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Full Height Content <span class="badge badge-roundless badge-warning">new</span></a> 
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Horizontal Mega Menu 1 </a>
											</li>
										</ul>
										<ul class="col-md-4 mega-menu-submenu">
											<li>
												<h3>More Layouts</h3>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Horizontal Mega Menu 2 </a>
											</li>				
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Search Box On Header 1 </a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Search Box On Header 2 </a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Sidebar Search Option 1 </a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Sidebar Search Option 2 </a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Right Sidebar Page </a>
											</li>										
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Sidebar Fixed Page </a>
											</li>
										</ul>
										<ul class="col-md-4 mega-menu-submenu">
											<li>
												<h3>Even More!</h3>
											</li>						
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Sidebar Closed Page </a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Content Loading via Ajax </a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Disabled Menu Links </a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Blank Page </a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Boxed Page </a>
											</li>
											<li>
												<a href="#">
												<i class="fa fa-angle-right"></i> Language Switch Bar </a>
											</li>
										</ul>
									</div>
									<div class="col-md-5">
										<div id="accordion" class="panel-group">
											<div class="panel panel-success">
												<div class="panel-heading">
													<h4 class="panel-title">
													<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="collapsed">
													Mega Menu Info #1 </a>
													</h4>
												</div>
												<div id="collapseOne" class="panel-collapse in">
													<div class="panel-body">
														 Metronic Mega Menu Works for fixed and responsive layout and has the facility to include (almost) any Bootstrap elements.
													</div>
												</div>
											</div>
											<div class="panel panel-danger">
												<div class="panel-heading">
													<h4 class="panel-title">
													<a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="collapsed">
													Mega Menu Info #2 </a>
													</h4>
												</div>
												<div id="collapseTwo" class="panel-collapse collapse">
													<div class="panel-body">
														 Metronic Mega Menu Works for fixed and responsive layout and has the facility to include (almost) any Bootstrap elements.
													</div>
												</div>
											</div>
											<div class="panel panel-info">
												<div class="panel-heading">
													<h4 class="panel-title">
													<a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
													Mega Menu Info #3 </a>
													</h4>
												</div>
												<div id="collapseThree" class="panel-collapse collapse">
													<div class="panel-body">
														 Metronic Mega Menu Works for fixed and responsive layout and has the facility to include (almost) any Bootstrap elements.
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</li>
					</ul>
				</li>
				<li class="classic-menu-dropdown">
					<a data-toggle="dropdown" data-hover="dropdown" href="javascript:;">
						多级下拉 <i class="fa fa-angle-down"></i>
					</a>
					<ul class="dropdown-menu pull-left">
						<li>
							<a href="#">
							<i class="fa fa-bookmark-o"></i> Section 1 </a>
						</li>
						<li>
							<a href="#">
							<i class="fa fa-user"></i> Section 2 </a>
						</li>
						<li>
							<a href="#">
							<i class="fa fa-puzzle-piece"></i> Section 3 </a>
						</li>
						<li>
							<a href="#">
							<i class="fa fa-gift"></i> Section 4 </a>
						</li>
						<li>
							<a href="#">
							<i class="fa fa-table"></i> Section 5 </a>
						</li>
						<li class="dropdown-submenu">
							<a href="javascript:;">
							<i class="fa fa-envelope-o"></i> More options </a>
							<ul class="dropdown-menu">
								<li>
									<a href="#">
									Second level link </a>
								</li>
								<li class="dropdown-submenu">
									<a href="javascript:;">
									More options </a>
									<ul class="dropdown-menu">
										<li>
											<a href="#">
											Third level link </a>
										</li>
										<li>
											<a href="#">
											Third level link </a>
										</li>
										<li>
											<a href="#">
											Third level link </a>
										</li>
										<li>
											<a href="#">
											Third level link </a>
										</li>
										<li>
											<a href="#">
											Third level link </a>
										</li>
									</ul>
								</li>
								<li>
									<a href="#">
									Second level link </a>
								</li>
								<li>
									<a href="#">
									Second level link </a>
								</li>
								<li>
									<a href="#">
									Second level link </a>
								</li>
							</ul>
						</li>
					</ul>
				</li>
			</c:if> --%>
	
		</ul>
	</div>
	<!-- END HORIZANTAL MENU -->
	<!-- BEGIN HEADER SEARCH BOX -->
	<!-- DOC: Apply "search-form-expanded" right after the "search-form" class to have half expanded search box -->
	<form class="search-form" action="#" method="GET">
		<div class="input-group">
			<input type="text" class="form-control" placeholder="搜索..." name="query">
			<span class="input-group-btn">
			<!-- DOC: value=" ", that is, value with space must be passed to the submit button -->
			<input class="btn submit" type="button" type="button" value=" "/>
			</span>
		</div>
	</form>
	<!-- END HEADER SEARCH BOX -->
</c:if>
<!-- BEGIN RESPONSIVE MENU TOGGLER -->
<div class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"></div>
<!-- END RESPONSIVE MENU TOGGLER -->
<!-- BEGIN TOP NAVIGATION MENU -->
<div class="top-menu">
	<ul class="nav navbar-nav pull-right">
		<c:if test="${fns:getModule('msg').isEnable && false}">
			<!-- BEGIN NOTIFICATION DROPDOWN -->
			<li class="dropdown dropdown-extended dropdown-notification" id="header_notification_bar">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
					<i class="fa fa-bell-o"></i>
					<span class="badge badge-default" id="msgNumber">0</span>
				</a>
				<ul class="dropdown-menu">
					<li><p id="msgTitle">暂无最新消息<!-- 您还有 5 项未读消息 --></p></li>
					<li>
						<ul class="dropdown-menu-list scroller" style="height: 250px;" id="msgList" ></ul>
					</li>
					<li class="external">
						<a data-href="${ctx}/msg/message/list?status=6" data-title="消息管理" class="addTab">查看所有消息 <i class="m-icon-swapright"></i></a>
					</li>
				</ul>
			</li>
			<!-- END NOTIFICATION DROPDOWN -->
		</c:if>
		<%-- <c:if test="false">
			<!-- BEGIN INBOX DROPDOWN -->
			<li class="dropdown dropdown-extended dropdown-inbox" id="header_inbox_bar">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
				<i class="fa fa-envelope"></i>
				<span class="badge badge-default"> 6 </span>
				</a>
				<ul class="dropdown-menu">
					<li><p>您还有 6 项未读邮件</p></li>
					<li>
						<ul class="dropdown-menu-list scroller" style="height: 250px;">
							<li><a href="#"> <span class="photo"><img src="${ctxStatic}/assets/admin/layout/img/avatar2.jpg" alt="" /></span> <span class="subject"> <span class="from">小二</span> <span class="time"><abbr class='timeago' title='2015-01-01 14:59:17'>2015年1月1日 14:59:17</abbr></span> </span> <span class="message"> 新系统上线了... </span> </a></li> 
							<li><a href="#"> <span class="photo"><img src="${ctxStatic}/assets/admin/layout/img/avatar3.jpg" alt="" /></span> <span class="subject"> <span class="from">张三</span> <span class="time">16 分钟</span> </span> <span class="message"> 新系统上线了... </span> </a></li> 
							<li><a href="#"> <span class="photo"><img src="${ctxStatic}/assets/admin/layout/img/avatar1.jpg" alt="" /></span> <span class="subject"> <span class="from">李四</span> <span class="time">20 分钟</span> </span> <span class="message"> 新系统上线了... </span> </a></li> 
							<li><a href="#"> <span class="photo"><img src="${ctxStatic}/assets/admin/layout/img/avatar2.jpg" alt="" /></span> <span class="subject"> <span class="from">王五</span> <span class="time">40 分钟</span> </span> <span class="message"> 新系统上线了... </span> </a></li> 
							<li><a href="#"> <span class="photo"><img src="${ctxStatic}/assets/admin/layout/img/avatar3.jpg" alt="" /></span> <span class="subject"> <span class="from">赵六</span> <span class="time">2 小时</span> </span> <span class="message"> 新系统上线了... </span> </a></li> 
						</ul>
					</li>
					<li class="external">
						<a href="inbox.html">
						查看所有邮件 <i class="m-icon-swapright"></i>
						</a>
					</li>
				</ul>
			</li>
			<!-- END INBOX DROPDOWN -->
			<!-- BEGIN TODO DROPDOWN -->
			<li class="dropdown dropdown-extended dropdown-tasks" id="header_task_bar">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
				<i class="fa fa-tasks"></i>
				<span class="badge badge-default"> 7 </span>
				</a>
				<ul class="dropdown-menu extended tasks">
					<li><p>您有 7 项正在进行任务</p></li>
					<li>
						<ul class="dropdown-menu-list scroller" style="height: 250px;">
							<li>
								<a href="#"><span class="task"><span class="desc">新版本 v2.2.0 </span>
									<span class="percent">30% </span></span>
									<span class="progress">
										<span style="width: 40%;" class="progress-bar progress-bar-success" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100">
											<span class="sr-only">40% 完成 </span>
										</span>
									</span>
								</a>
							</li>
							<li>
								<a href="#"><span class="task"><span class="desc">应用程序部署 </span>
									<span class="percent">65% </span></span>
									<span class="progress progress-striped">
										<span style="width: 65%;" class="progress-bar progress-bar-danger" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100">
											<span class="sr-only">65% 完成 </span>
										</span>
									</span>
								</a>
							</li>
							<li>
								<a href="#"><span class="task"><span class="desc">手机端发布 </span>
									<span class="percent">98% </span></span>
									<span class="progress">
										<span style="width: 98%;" class="progress-bar progress-bar-success" aria-valuenow="98" aria-valuemin="0" aria-valuemax="100">
											<span class="sr-only">98% 完成 </span>
										</span>
									</span>
								</a>
							</li>
							<li>
								<a href="#"><span class="task"><span class="desc">数据库合并 </span>
									<span class="percent">10% </span></span>
									<span class="progress progress-striped">
										<span style="width: 10%;" class="progress-bar progress-bar-warning" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">
											<span class="sr-only">10% 完成 </span>
										</span>
									</span>
								</a>
							</li>
							<li>
								<a href="#"><span class="task"><span class="desc">服务器应用更新 </span>
									<span class="percent">58% </span></span>
									<span class="progress progress-striped">
										<span style="width: 58%;" class="progress-bar progress-bar-info" aria-valuenow="58" aria-valuemin="0" aria-valuemax="100">
											<span class="sr-only">58% 完成 </span>
										</span>
									</span>
								</a>
							</li>
							<li>
								<a href="#"><span class="task"><span class="desc">手机端部署 </span>
									<span class="percent">85% </span></span>
									<span class="progress progress-striped">
										<span style="width: 85%;" class="progress-bar progress-bar-success" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100">
											<span class="sr-only">85% 完成 </span>
										</span>
									</span>
								</a>
							</li>
							<li>
								<a href="#"><span class="task"><span class="desc">新的用户界面发布 </span>
									<span class="percent">18% </span></span>
									<span class="progress progress-striped">
										<span style="width: 18%;" class="progress-bar progress-bar-important" aria-valuenow="18" aria-valuemin="0" aria-valuemax="100">
											<span class="sr-only">18% 完成 </span>
										</span>
									</span>
								</a>
							</li>
						</ul>
					</li>
					<li class="external">
						<a href="#">
						查看所有待办任务 <i class="m-icon-swapright"></i>
						</a>
					</li>
				</ul>
			</li>
		</c:if> --%>
		<!-- END TODO DROPDOWN -->
		<!-- BEGIN USER LOGIN DROPDOWN -->
		<li class="dropdown dropdown-user">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
				<img alt="" class="img-circle" src="${ctxStatic}/assets/admin/layout/img/avatar.png" style="width:26px;height:26px;"/>
				<span class="username">${fns:getUser().userName} </span>
				<i class="fa fa-angle-down"></i>
			</a>
			<ul class="dropdown-menu">
				<li>
					<a id="userInfo" data-href="${ctx}/sys/user/info?qtype=0" class="addTab">
					<i class="fa fa-user"></i> 个人信息 </a>
				</li>
				<li>
					<a id="modifyPassword" data-href="${ctx}/sys/user/info?qtype=2" class="addTab">
					<i class="fa fa-calendar"></i> 修改密码 </a>
				</li>
				<li class="divider">
				</li><!-- 
				<li>
					<a href="#">
					<i class="fa fa-lock"></i> 锁定屏幕 </a>
				</li> -->
				<li>
					<a href="${ctx}/logout">
					<i class="fa fa-key"></i> 退出登录 </a>
				</li>
			</ul>
		</li>
		<!-- END USER LOGIN DROPDOWN -->
		<!-- BEGIN STYLE CUSTOMIZER -->
		<li class="theme-panel "><!-- theme-panel hidden-xs hidden-sm -->
			&nbsp; &nbsp; &nbsp;
			<div class="toggler"></div>
			<div class="toggler-close"></div>
			<div class="theme-options">
				<div class="theme-option theme-colors clearfix">
					<span>主题切换 </span>
					<ul>
						<li class="color-default tooltips" data-style="default" data-original-title="默认(default)"></li>
						<li class="color-darkblue tooltips" data-style="darkblue" data-original-title="深蓝色(darkblue)"></li>
						<li class="color-blue tooltips" data-style="blue" data-original-title="蓝色(blue)"></li>
						<li class="color-grey tooltips" data-style="grey" data-original-title="灰色(grey)"></li>
						<li class="color-light tooltips" data-style="light" data-original-title="浅色(light)"></li>
						<li class="color-light2 tooltips" data-style="light2" data-html="true" data-original-title="浅色(light2)"></li>
					</ul>
				</div><%-- 
				<div class="theme-option">
					<span>布局 </span>
					<select class="layout-option form-control input-small">
						<option value="fluid" selected="selected">铺满屏幕</option>
						<option value="boxed">固定宽度</option>
					</select>
				</div>
				<div class="theme-option">
					<span>头部 </span>
					<select class="page-header-option form-control input-small">
						<option value="fixed" selected="selected">固定</option>
						<option value="default">流动</option>
					</select>
				</div>
				<div class="theme-option">
					<span>侧边栏 </span>
					<select class="sidebar-option form-control input-small">
						<option value="fixed" selected="selected">固定</option>
						<option value="default" >流动</option>
					</select>
				</div>
				<div class="theme-option">
					<span>侧边栏位置 </span>
					<select class="sidebar-pos-option form-control input-small">
						<option value="left" selected="selected">左侧</option>
						<option value="right">右侧</option>
					</select>
				</div>
				<div class="theme-option">
					<span>底部 </span>
					<select class="page-footer-option form-control input-small">
						<option value="fixed" selected="selected">固定</option>
						<option value="default">流动</option>
					</select>
				</div> --%>
			</div>
		</li>
		<!-- END STYLE CUSTOMIZER -->
	</ul>
</div>
<!-- END TOP NAVIGATION MENU -->