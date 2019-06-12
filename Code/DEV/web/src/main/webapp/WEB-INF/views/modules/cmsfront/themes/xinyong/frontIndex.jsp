<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<!DOCTYPE html><html>
<head><title>首页</title>
	<%@include file="include/head.jsp" %>
</head><body>
<div style="min-height: 320px;">
	<%@ include file="include/header.jsp" %>
	<main>
		<%@ include file="include/search.jsp" %>
		<div class="row " style="margin-top: 15px">
			<div class="container">
				<%@ include file="include/lunbo.jsp" %>
				<%@ include file="include/toutiao.jsp" %>
			</div>
		</div>
		<div class="row " style="margin-top: 15px">
			<div class="container">
				<div class="column col-xs-6" style="padding-right: 8px">
					<div class="skin_blue_05 ">
						<div class="widget-box">
							<div class="widget-heading clearfix">
								<a class="widget-more pull-right"href="${ctx}/list-zcfg.html" target="_blank">更多</a>
								<h3 class="widget-title">政策法规</h3>
							</div>
							<div class="widget-body" style="height: 230px; overflow: hidden; background: transparent; padding: 5px 0">
								<ul class="widget-list">
									<c:forEach items="${fnc:getArticleList(site.siteCode, '0', 7, 'orderBy: \"a.create_date desc\"')}" var="a" varStatus="vs">
										<li class="widget-list-item widget-list-icon widget-lineheight">
											<span class="news_other pull-right hidden-xs">${fns:formatDate(a.updateDate,'yyyy-MM-dd')}</span>
											<a style="padding-right:5%" class="widget-title-nowrap" href="${a.url}" title="${a.title}"
												 alt="${a.title}">${a.title}</a></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="column col-xs-6" style="padding-left: 8px">
					<div class="skin_blue_05 ">
						<div class="widget-box">
							<div class="widget-heading clearfix">
								<a class="widget-more pull-right"href="${ctx}/list-tzgg.html" target="_blank">更多</a>
								<h3 class="widget-title">通知公告</h3>
							</div>
							<div class="widget-body" style="height: 230px; overflow: hidden; background: transparent; padding: 5px 0">
								<ul class="widget-list">
									<c:forEach items="${fnc:getArticleList(site.siteCode, '0', 7, 'orderBy: \"a.create_date desc\"')}" var="a" varStatus="vs">
										<li class="widget-list-item widget-list-icon widget-lineheight">
											<span class="news_other pull-right hidden-xs">${fns:formatDate(a.updateDate,'yyyy-MM-dd')}</span>
											<a style="padding-right:5%" class="widget-title-nowrap" href="${a.url}" title="${a.title}"
												 alt="${a.title}">${a.title}</a></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row " style="margin-top: 15px; background: #ededed; padding: 20px 0">
			<div class="container">
				<div class="column col-xs-12">
					<div class="skin_blue_05 ">
						<!--图标链接start-->
						<div class="aiicon-link clearfix">
							<div class="aiicon-link-item">
								<a href="123/index.html" title="" target="_self" style="background: url(http://www.jncredit.gov.cn/images/2017/11/1j9nlwbix1dj6.jpg)">
									<img src="http://www.jncredit.gov.cn/images/2017/11/2j9nlwa7g24he/2j9nlwa7g24he_o.png" />
									<span>双创专栏</span></a>
							</div>
							<div class="aiicon-link-item">
								<a href="creditsearch.redandblacklist.dhtml.htm" title="" target="_self" style="background: url(http://www.jncredit.gov.cn/images/2017/11/1j9nlwaoe1zv3.jpg)">
									<img src="http://www.jncredit.gov.cn/images/2017/11/2j9nlwadc1qsj/2j9nlwadc1qsj_o.png" />
									<span>信用红黑名单</span></a>
							</div>
							<div class="aiicon-link-item">
								<a href="creditsearch.subject.dhtml.htm" title="" target="_self" style="background: url(http://www.jncredit.gov.cn/images/2017/11/1j9sl9u075yo.jpg)">
									<img src="http://www.jncredit.gov.cn/images/2017/11/2j9sl9u2438c/2j9sl9u2438c_o.png" />
									<span>信用承诺</span></a>
							</div>
							<div class="aiicon-link-item">
								<a href="148/index.html" title="" target="_self" style="background: url(http://www.jncredit.gov.cn/images/2017/11/1j9nlwbjed4s.jpg)">
									<img src="http://www.jncredit.gov.cn/images/2017/11/2j9nlwacz1ryj/2j9nlwacz1ryj_o.png" />
									<span>风险提示</span></a>
							</div>
							<div class="aiicon-link-item">
								<a href="134/index.html" title="" target="_self" style="background: url(http://www.jncredit.gov.cn/images/2017/11/1j9nlwbdc15ln.jpg)">
									<img src="http://www.jncredit.gov.cn/images/2017/11/2j9nlwah61uzb/2j9nlwah61uzb_o.png" />
									<span>双十一信用</span></a>
							</div>
						</div>
						<!--图标链接end-->
					</div>
				</div>
			</div>
		</div>
		<div class="row " style="margin-top: 15px">
			<div class="container">
				<div class="column col-xs-6" style="padding-right: 8px">
					<div class="skin_blue_05 ">
						<div class="widget-box">
							<div class="widget-heading clearfix">
								<a class="widget-more pull-right"href="${ctx}/list-zcfg.html" target="_blank">更多</a>
								<h3 class="widget-title">政策法规</h3>
							</div>
							<div class="widget-body" style="height: 230px; overflow: hidden; background: transparent; padding: 5px 0">
								<ul class="widget-list">
									<c:forEach items="${fnc:getArticleList(site.siteCode, '0', 7, 'orderBy: \"a.create_date desc\"')}" var="a" varStatus="vs">
										<li class="widget-list-item widget-list-icon widget-lineheight">
											<span class="news_other pull-right hidden-xs">${fns:formatDate(a.updateDate,'yyyy-MM-dd')}</span>
											<a style="padding-right:5%" class="widget-title-nowrap" href="${a.url}" title="${a.title}"
												 alt="${a.title}">${a.title}</a></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="column col-xs-6" style="padding-left: 8px">
					<div class="skin_blue_05 ">
						<div class="widget-box">
							<div class="widget-heading clearfix">
								<a class="widget-more pull-right"href="${ctx}/list-tzgg.html" target="_blank">更多</a>
								<h3 class="widget-title">通知公告</h3>
							</div>
							<div class="widget-body" style="height: 230px; overflow: hidden; background: transparent; padding: 5px 0">
								<ul class="widget-list">
									<c:forEach items="${fnc:getArticleList(site.siteCode, '0', 7, 'orderBy: \"a.create_date desc\"')}" var="a" varStatus="vs">
										<li class="widget-list-item widget-list-icon widget-lineheight">
											<span class="news_other pull-right hidden-xs">${fns:formatDate(a.updateDate,'yyyy-MM-dd')}</span>
											<a style="padding-right:5%" class="widget-title-nowrap" href="${a.url}" title="${a.title}"
												 alt="${a.title}">${a.title}</a></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row " style="margin-top: 15px">
			<div class="container">
				<div class="column col-xs-6" style="padding-right: 8px">
					<div class="skin_blue_05 ">
						<style>.con-imglink { padding: 8px 0 } .con-imglink .column { padding: 9px 7px 9px 0 } .con-imglink .column a { display: block; font-size: 0; position: relative; height: 95px } .con-imglink .column a span { position: absolute; right: 10px; top: 27px; width: 100px; height: 38px; line-height: 38px; text-align: right; background: transparent; color: #fff; font-size: 18px; font-weight: bold } .con-imglink .column a img { width: 100% }</style>
						<div class="widget-box" style="padding: 0; background: transparent; position: relative">
							<div class="widget-heading clearfix" style="background: transparent; height: 40px; line-height: 40px; border-bottom: 1px solid #e5e5e5;">
								<a class="widget-more pull-right" href="129/index.html" style="color: #000000; padding-right: 0">更多</a>
								<h3 class="widget-title" style="background: transparent; font-weight: normal; font-size: 16px; color: #000; top: 0; left: 0; height: 40px; line-height: 32px; padding: 0; border: 0 none; border-bottom: 4px solid #0681cb; position: absolute;">专项治理</h3></div>
							<div class="widget-body" style="overflow: hidden; background: transparent; padding: 5px 0">
								<div class="con-imglink">
									<div class="clearfix" style="margin: -8px -7px -8px 0px">
										<div class="col-xs-4 column">
											<a href="141/index.html">
												<img src="${ctxStaticTheme}/image/zw.jpg" />
												<span>政务失信</span></a>
										</div>
										<div class="col-xs-4 column">
											<a href="142/index.html">
												<img src="${ctxStaticTheme}/image/jr.jpg" />
												<span>涉金融领域</span></a>
										</div>
										<div class="col-xs-4 column">
											<a href="143/index.html">
												<img src="${ctxStaticTheme}/image/dzsw.jpg" />
												<span>电子商务</span></a>
										</div>
									</div>
								</div>
								<div class="widget-body" style="height: 230px; overflow: hidden; background: transparent; padding: 5px 0">
									<ul class="widget-list">
										<c:forEach items="${fnc:getArticleList(site.siteCode, '0', 6, 'orderBy: \"a.create_date desc\"')}" var="a" varStatus="vs">
											<li class="widget-list-item widget-list-icon widget-lineheight">
												<span class="news_other pull-right hidden-xs">${fns:formatDate(a.updateDate,'yyyy-MM-dd')}</span>
												<a style="padding-right:5%" class="widget-title-nowrap" href="${a.url}" title="${a.title}"
													 alt="${a.title}">${a.title}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="column col-xs-6" style="padding-left: 8px">
					<div class="skin_blue_05 ">
						<script>$(function() {
								$('#textslide_data').scrollbox({
									linear: true,
									step: 1,
									delay: 0,
									speed: 100
								});
							});</script>
						<style type="text/css">.datatab { border-collapse: collapse; color: #444; table-layout: fixed; } .datatab td { border-left: 1px solid #fff; height: 38px; text-align: center } .datatab td.tdcon_left { text-align: left; padding-right: 10px; border-left: none; } .datatab th { height: 35px; color: #0271a7; text-align: center; background-color: #f2f2f2; border-left: 0px solid #FFF; } #textslide_data { height: 240px }</style>
						<div class="widget-box" style="padding: 0; background: transparent; position: relative">
							<div class="widget-heading clearfix" style="background: transparent; height: 40px; line-height: 40px; border-bottom: 1px solid #e5e5e5; margin-bottom: 15px">
								<h3 class="widget-title" style="background: transparent; font-weight: normal; font-size: 16px; color: #000; top: 0; left: 0; height: 40px; line-height: 32px; padding: 0; border: 0 none; border-bottom: 4px solid #0681cb; position: absolute;">数据统计</h3></div>
							<div class="widget-body" style="position: relative; padding: 0; background: #fafafa">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="datatab">
									<colgroup>
										<col width="220" />
										<col width="150" />
										<col width="" /></colgroup>
									<tbody>
										<tr bgcolor="#ffffff">
											<th class="tdcon_left" style="font-weight: bold; color: #2173b6; line-height: 40px; padding-left: 45px; text-align: left" scope="col">
												<strong>数据来源</strong></th>
											<th scope="col" style="font-weight: bold; color: #2173b6; line-height: 40px; text-align: center">
												<strong>数据量</strong></th>
											<th scope="col" style="font-weight: bold; color: #2173b6; line-height: 40px; text-align: center">
												<strong>更新时间</strong></th>
										</tr>
									</tbody>
								</table>
								<div class="widget-content-body">
									<div class="widget-news-content" style="padding-bottom: 10px">
										<div id="textslide_data" class="scroll-text" style="border: 0px solid #f0f0f0; padding: 10px 0">
											<ul class="widget-list">
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市财政局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">147</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-09-09</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市规划局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">1107</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-10-24</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市编办</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">1875</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-10-24</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市科技局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">729</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-10-24</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市物价局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">516</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">17-11-14</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市民政局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">1477</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-10-24</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市旅发委</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">263</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-11-10</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市文化执法局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">40</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-10-24</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市文化广电新闻出版局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">704</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-10-24</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市教育局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">18833</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-10-24</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市房管局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">4910</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">17-06-28</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市工商局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">2053945</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">17-11-03</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市城管局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">48</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-10-24</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市地税局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">395677</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-12-20</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市司法局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">1832</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-11-10</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市卫计委</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">6188</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">16-11-10</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市出入境检验检疫局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">2</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">17-06-28</span></li>
												<li class="widget-lineheight licolor" style="line-height: 36px; height: 36px; font-size: 14px">
													<span class="widget-title-nowrap" style="width: 220px; display: inline-block; padding-left: 45px; padding-right: 0">市农业局</span>
													<span class="widget-title-nowrap" style="width: 150px; display: inline-block; text-align: center; padding-right: 0; color: #e54358">1893</span>
													<span class="widget-title-nowrap" style="display: inline-block; width: 154px; text-align: center; padding-right: 0; color: #a0a0a0">17-11-14</span></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- <div class="skin_blue_05 " style="margin-top: 15px">
						<style>.border-r { border-right: 1px solid #e6e6e6 }</style>
						<div class="widget-box" style="padding: 0; background: transparent; position: relative">
							<div class="widget-heading clearfix" style="background: transparent; height: 40px; line-height: 40px; border-bottom: 1px solid #e5e5e5; margin-bottom: 15px">
								<a class="widget-more pull-right" href="153.location.block.dhtml.htm" style="color: #bbbbbb; padding-right: 0">更多</a>
								<h3 class="widget-title" style="background: transparent; font-weight: normal; font-size: 16px; color: #000; top: 0; left: 0; height: 40px; line-height: 32px; padding: 0; border: 0 none; border-bottom: 4px solid #0681cb; position: absolute;">信用服务</h3></div>
							<div class="widget-body" style="position: relative; padding: 0; background: #fff">
								<div class="xyfwlink clearfix" style="background: #f7f7f7; padding: 12px 0">
									<div class="col-xs-3">
										<a href="creditsearch.corpdeclare.dhtml.htm" style="display: block; text-align: center; height: 60px;" class="border-r">
											<img style="display: block; text-align: center; margin: 0 auto" src="images/2017/11/1j9nvjs3w7v1.png" />
											<span style="display: inline-block; padding-top: 8px">信用申报</span></a>
									</div>
									<div class="col-xs-3">
										<a href="creditsearch.ycl.dhtml.htm" style="display: block; text-align: center; height: 60px;" class="border-r">
											<img style="display: block; text-align: center; margin: 0 auto" src="images/2017/11/1j9nvjs3w5ho.png" />
											<span style="display: inline-block; padding-top: 8px">信用异议</span></a>
									</div>
									<div class="col-xs-3">
										<a href="61.infoswap.forinsert.dhtml.htm" style="display: block; text-align: center; height: 60px;" class="border-r">
											<img style="display: block; text-align: center; margin: 0 auto" src="images/2017/11/1j9nvjs4021r7.png" />
											<span style="display: inline-block; padding-top: 8px">信用咨询</span></a>
									</div>
									<div class="col-xs-3">
										<a href="99.infoswap.forinsert.dhtml.htm" style="display: block; text-align: center; height: 60px;" class="">
											<img style="display: block; text-align: center; margin: 0 auto" src="images/2017/11/1j9nvjs3y7nl.png" />
											<span style="display: inline-block; padding-top: 8px">信用投诉</span></a>
									</div>
								</div>
							</div>
						</div>
					</div> -->
				</div>
			</div>
		</div>
		<div class="row " style="margin-top: 15px; background: #f3f3f3">
			<div class="container">
				<div class="column col-md-12">
					<div class="skin_blue_05 ">
						<style>.cydw-tab td { padding-left: 5px }</style>
						<div class="widget-box" style="background: #f3f3f3; padding: 15px 0">
							<h3 style="color: #333333; font-size: 18px; margin-bottom: 15px; padding-left: 5px">济南市社会信用体系建设工作领导小组成员单位
								<span style="color: #333333; font-size: 12px;">（排名不分先后）</span></h3>
							<div class="widget-body">
								<div class="clearfix">
									<table cellspacing="0" cellpadding="0" border="0" width="100%" class="cydw-tab">
										<colgroup>
											<col width="150" />
											<col width="150" />
											<col width="155" />
											<col width="180" />
											<col width="" />
											<col width="240" /></colgroup>
										<tbody>
											<!-- 第一行 -->
											<tr>
												<td style="line-height: 30px; font-weight: bold;">
													<a href="../www.jndpc.gov.cn/index.htm" alt="发展改革委" title="发展改革委" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市发展改革委</span></a>
												</td>
												<td colspan="5" style="line-height: 30px; font-weight: bold;">
													<a href="../jinan.pbc.gov.cn/index.htm" alt="人行济南分行营业管理部" title="人行济南分行营业管理部" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>人行济南分行营业管理部</span></a>
												</td>
											</tr>
											<!-- 第二行 -->
											<tr>
												<td style="line-height: 30px;">
													<a href="../www.jnbb.gov.cn/index.htm" alt="市编办" title="市编办" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市编办</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../jnmz.gov.cn/index.htm" alt="市民政局" title="市民政局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市民政局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jntj.gov.cn/index.htm" alt="市统计局" title="市统计局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市统计局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../jinan.sd-n-tax.gov.cn/index.htm" alt="市国税局" title="市国税局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市国税局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="javascript:void(0);" alt="市国家安全局" title="市国家安全局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px; color: #b3b2b2">
														<span>市国家安全局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnwgxj.gov.cn/index.htm" alt="市文化广电新闻出版局" title="市文化广电新闻出版局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市文化广电新闻出版局</span></a>
												</td>
											</tr>
											<!-- 第三行 -->
											<tr>
												<td style="line-height: 30px;">
													<a href="../jinanzy.sdcourt.gov.cn/index.htm" alt="市法院" title="市法院" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市法院</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnssfj.gov.cn/index.htm" alt="市司法局" title="市司法局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市司法局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnsafety.gov.cn/index.htm" alt="市安监局" title="市安监局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市安监局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../jinan.sdds.gov.cn/index.htm" alt="市地税局" title="市地税局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市地税局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jncc.gov.cn/index.htm" alt="市城乡建设委" title="市城乡建设委" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市城乡建设委</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.gjj.gov.cn/index.htm" alt="济南住房公积金管理中心" title="济南住房公积金管理中心" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>济南住房公积金管理中心</span></a>
												</td>
											</tr>
											<!-- 第四行 -->
											<tr>
												<td style="line-height: 30px;">
													<a href="../jn.wenming.cn/index.htm" alt="市文明办" title="市文明办" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市文明办</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jncz.gov.cn/index.htm" alt="市财政局" title="市财政局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市财政局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnta.gov.cn/index.htm" alt="市旅游发展委" title="市旅游发展委" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市旅发委</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnsw.gov.cn/index.htm" alt="市委组织部" title="市委组织部" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市委组织部</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnhfpc.gov.cn/index.htm" alt="市卫生计生委" title="市卫生计生委" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市卫生计生委</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnzf.gov.cn/index.htm" alt="市城市管理局（市城管执法局）" title="市城市管理局（市城管执法局）" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市城管局（市城管执法局）</span></a>
												</td>
											</tr>
											<!-- 第五行 -->
											<tr>
												<td style="line-height: 30px;">
													<a href="../www.jnjcy.gov.cn/index.htm" alt="市检察院" title="市检察院" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市检察院</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnup.gov.cn/index.htm" alt="市规划局" title="市规划局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市规划局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jngthuijin.com/index.htm" alt="市国资委" title="市国资委" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市国资委</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../xc.e23.cn/index.htm" alt="市委宣传部" title="市委宣传部" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市委宣传部</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jn.gov.cn/index.htm" alt="市经济和信息化委" title="市经济和信息化委" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市经济和信息化委</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnxzsp.gov.cn/index.htm" alt="市政务服务中心管理办公室" title="市政务服务中心管理办公室" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市政务服务中心管理办公室</span></a>
												</td>
											</tr>
											<!-- 第六行 -->
											<tr>
												<td style="line-height: 30px;">
													<a href="../www.jnedu.gov.cn/index.htm" alt="市教育局" title="市教育局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市教育局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnepb.gov.cn/index.htm" alt="市环保局" title="市环保局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市环保局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnfzb.gov.cn/index.htm" alt="市法制办" title="市法制办" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市法制办</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnzfw.gov.cn/index.htm" alt="市委政法委" title="市委政法委" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市委政法委</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnjtj.gov.cn/index.htm" alt="市城乡交通运输委" title="市城乡交通运输委" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市城乡交通运输委</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnfda.gov.cn/index.htm" alt="市食品药品监管局（市食安办）" title="市食品药品监管局（市食安办）" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市食品药品监管局（市食安办）</span></a>
												</td>
											</tr>
											<!-- 第七行 -->
											<tr>
												<td style="line-height: 30px;">
													<a href="../www.jnsti.gov.cn/index.htm" alt="市科技局" title="市科技局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市科技局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnny.gov.cn/index.htm" alt="市农业局 " title="市农业局 " target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市农业局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jngsj.gov.cn/index.htm" alt="市工商局" title="市工商局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市工商局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnwater.gov.cn/index.htm" alt="市城乡水务局" title="市城乡水务局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市城乡水务局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jinan.sdciq.gov.cn/index.htm" alt="济南出入境检验检疫局" title="济南出入境检验检疫局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>济南出入境检验检疫局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnjr.gov.cn/index.htm" alt="市金融办（市地方金融监督管理局）" title="市金融办（市地方金融监督管理局）" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市金融办（市地方金融监督管理局）</span></a>
												</td>
											</tr>
											<!-- 第八行 -->
											<tr>
												<td style="line-height: 30px;">
													<a href="../www.jnga.gov.cn/index.htm" alt="市公安局" title="市公安局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市公安局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jinanbusiness.gov.cn/index.htm" alt="市商务局" title="市商务局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市商务局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnqts.gov.cn/index.htm" alt="市质监局" title="市质监局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市质监局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jndlr.gov.cn/index.htm" alt="市国土资源局" title="市国土资源局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市国土资源局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnhrss.gov.cn/index.htm" alt="市人力资源社会保障局" title="市人力资源社会保障局" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市人力资源社会保障局</span></a>
												</td>
												<td style="line-height: 30px;">
													<a href="../www.jnfg.gov.cn/index.htm" alt="市住房保障管理局（市城市更新局）" title="市住房保障管理局（市城市更新局）" target="_blank" class="widget-title-nowrap" style="padding-right: 0; line-height: 40px">
														<span>市住房保障管理局（市城市更新局）</span></a>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row ">
			<div class="container" style="margin-top: 10px;">
				<div class="column col-xs-7" style="background: rgb(255, 255, 255); padding: 10px 11px 10px 0;">
					<div class="skin_blue_05 ">
						<style type="text/css">/*友情链接*/ .region-list { position: absolute; width: 100%; background: #FFF none repeat scroll 0% 0%; max-height: 360px; overflow: auto; z-index: 10; border: 1px solid #CCC; margin-bottom: 0 !important; box-shadow: 1px 1px 3px #CCC; top: 58px; left: -1px; padding: 10px 0px; border-radius: 0 !important } .region-item a { display: block; width: 100%; line-height: 30px !important; padding-left: 55px !important; cursor: pointer; background: transparent url("image/goverment-dian.png") no-repeat scroll 27px 15px; text-decoration: none } .region-item a:hover { background-color: #3780DA !important; color: #FFF !important; background-position: 27px -9px !important; } .region-item span { display: block; width: 100%; line-height: 30px; padding-left: 55px; cursor: pointer; } /*.nolink { color: #999; }*/ .credit-icon { display: block; width: 7px; height: 5px; background: transparent url("image/uparrow.jpg") no-repeat scroll center center; position: absolute; right: 10px; top: 12px; } .credit-box { position: relative; height: 30px; border: 1px solid #dcdbdb; cursor: pointer; background: #ffffff } .credit-box h4 { font-size: 14px; font-weight: normal; color: #4b4b4b; line-height: 28px; margin-left: 11px; margin-top: 0px; } .tab_link .col-md-4 { width: 33.333% } .tab_link { background: #fff; }</style>
						<div class="row clearfix tab_link" style="margin: 0; padding: 10px; background: #f6f5f5">
							<div class="container-fluid" style="padding: 0">
								<div class="col-xs-6 col-md-6 column" style="padding: 0 5px">
									<div class="credit-box dropup">
										<a id="drop1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
											<h4>副省级城市信用网</h4>
											<span class="credit-icon"></span>
										</a>
										<ul class="region-list dropdown-menu" style="min-width: 230px; width: 230px; width: auto !important">
											<li class="region-item">
												<a href="../www.sycredit.gov.cn/index.htm" title="" target="_blank" alt="">沈阳市</a></li>
											<li class="region-item">
												<a href="../credit.dl.gov.cn/index.htm" title="" target="_blank" alt="">大连市</a></li>
											<li class="region-item">
												<a href="../cccredit.changchun.gov.cn/index.htm" title="" target="_blank" alt="">长春市</a></li>
											<li class="region-item">
												<a href="../www.hrbcredit.gov.cn/index.htm" title="" target="_blank" alt="">哈尔滨市</a></li>
											<li class="region-item">
												<a href="../www.njcredit.gov.cn/index.htm" title="" target="_blank" alt="">南京市</a></li>
											<li class="region-item">
												<a href="../www.hzcredit.gov.cn/home/home.html" title="" target="_blank" alt="">杭州市</a></li>
											<li class="region-item">
												<a href="../www.nbcredit.gov.cn/index.htm" title="" target="_blank" alt="">宁波市</a></li>
											<li class="region-item">
												<a href="../www.creditxm.gov.cn/index.htm" title="" target="_blank" alt="">厦门市</a></li>
											<li class="region-item">
												<a href="../jncredit.gov.cn/index.htm" title="" target="_blank" alt="">济南市</a></li>
											<li class="region-item">
												<a href="../credit.qingdao.gov.cn/index.htm" title="" target="_blank" alt="">青岛市</a></li>
											<li class="region-item">
												<a href="../www.whcredit.net/index.htm" title="" target="_blank" alt="">武汉市</a></li>
											<li class="region-item">
												<a href="../credit.gz.gov.cn/index.htm" title="" target="_blank" alt="">广州市</a></li>
											<li class="region-item">
												<a href="../www.szcredit.org.cn/index.htm" title="" target="_blank" alt="">深圳市</a></li>
											<li class="region-item">
												<a href="../www.cdcredit.gov.cn/index.htm" title="" target="_blank" alt="">成都市</a></li>
											<li class="region-item">
												<a href="../www.xianinfo.gov.cn/index.htm" title="" target="_blank" alt="">西安市</a></li>
										</ul>
									</div>
								</div>
								<div class="col-xs-6 col-md-6 column" style="padding: 0 5px">
									<div class="credit-box dropup">
										<a id="drop1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
											<h4>省内城市信用网</h4>
											<span class="credit-icon"></span>
										</a>
										<ul class="region-list dropdown-menu" style="min-width: 230px; width: 230px; width: auto !important">
											<li class="region-item">
												<a href="../credit.qingdao.gov.cn/index.htm" title="" target="_blank" alt="">青岛市</a></li>
											<li class="region-item">
												<a href="../www.xinyongzibo.gov.cn/index.htm" title="" target="_blank" alt="">淄博市</a></li>
											<li class="region-item">
												<span class="nolink" title="" alt="">枣庄市</span></li>
											<li class="region-item">
												<a href="../www.11315dy.com/index.html" title="" target="_blank" alt="">东营市</a></li>
											<li class="region-item">
												<a href="../www.credityt.gov.cn/home/index.do" title="" target="_blank" alt="">烟台市</a></li>
											<li class="region-item">
												<a href="../www.wfcredit.gov.cn/index.htm" title="" target="_blank" alt="">潍坊市</a></li>
											<li class="region-item">
												<a href="../www.jnxy.gov.cn/index.htm" title="" target="_blank" alt="">济宁市</a></li>
											<li class="region-item">
												<a href="../www.tacredit.gov.cn/index.htm" title="" target="_blank" alt="">泰安市</a></li>
											<li class="region-item">
												<a href="../sdwhcredit.gov.cn/index.htm" title="" target="_blank" alt="">威海市</a></li>
											<li class="region-item">
												<a href="../www.rzshzx.rz.gov.cn/index.htm" title="" target="_blank" alt="">日照市</a></li>
											<li class="region-item">
												<a href="../xinyong.laiwu.gov.cn/index.html" title="" target="_blank" alt="">莱芜市</a></li>
											<li class="region-item">
												<span class="nolink" title="" alt="">临沂市</span></li>
											<li class="region-item">
												<a href="../xinyong.dezhou.gov.cn/index.htm" title="" target="_blank" alt="">德州市</a></li>
											<li class="region-item">
												<span class="nolink" title="" alt="">聊城市</span></li>
											<li class="region-item">
												<a href="../binzhoucredit.gov.cn/home/home.html" title="" target="_blank" alt="">滨州市</a></li>
											<li class="region-item">
												<span class="nolink" title="" alt="">菏泽市</span></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="column col-xs-5" style="background: rgb(255, 255, 255); padding: 10px 0 10px 0px;">
					<div class="skin_blue_05 ">
						<style type="text/css">.creditimg { background: #fff; } .cn_img { width: 100%; height: 50px; border: 1px solid #e5e5e5 }</style>
						<div class="row" style="margin: 0 -5px">
							<div class="col-xs-6 creditimg" style="padding: 0 5px">
								<a href="www.creditchina.gov.cn" title="" target="_blank" style="font-size: 0">
									<img class="cn_img" src="http://www.jncredit.gov.cn/images/location/2irycmeoj5q6/2irycmeoj5q6_o.jpg" style="width: 100%" /></a>
							</div>
							<div class="col-xs-6 creditimg" style="padding: 0 5px">
								<a href="www.creditsd.gov.cn" title="" target="_blank" style="font-size: 0">
									<img class="cn_img" src="http://www.jncredit.gov.cn/images/location/2irycmha2rhf/2irycmha2rhf_o.jpg" style="width: 100%" /></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<%@ include file="include/footer.jsp" %>
</div>
<script type="text/javascript" src="${ctxStaticTheme}/component/news/jqueryslide/full_02/js/responsiveslides.min.js"></script>
<script type="text/javascript" src="${ctxStaticTheme}/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctxStaticTheme}/js/respond.min.js"></script>
<script type="text/javascript" src="${ctxStaticTheme}/js/showads.js"></script>
