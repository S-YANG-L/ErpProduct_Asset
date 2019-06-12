<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row " style="padding: 20px 0 40px 0; background: #f3f3f3">
	<div class="container">
		<div class="column col-xs-12">
			<div class="skin_blue_05 ">
				<div class="clearfix">
					<div class="pull-left">
						<div class="m-pills-container" role="tabpanel">
							<!-- Nav tabs -->
							<div class="panel panel-default tabpanel">
								<div class="panel-heading  clearfix  widget-border-clear widget-radius-clear">
									<ul class="nav nav-pills clearfix" role="tablist" style="display:inline-block">
										<li role="presentation" class="active">
											<a href="#tab-search-1" role="tab" data-toggle="tab">全文检索</a>
										</li>
										<li role="presentation">
											<a href="#tab-search-1" role="tab" data-toggle="tab">全文检索2</a>
										</li>
										<li role="presentation">
											<a href="#tab-search-1" role="tab" data-toggle="tab">全文检索3</a>
										</li>
									</ul>
								</div>
								<!-- Tab panes -->
								<div class="panel-body">
									<script>
										function EnterPressNonCom(e) {
											var e = e || window.event;
											if (e.keyCode == 13) {
												$("#searchNonCom").focus();
											}
										}
									</script>
									<div class="tab-content">
										<!--全文检索start-->
										<div role="tabpanel" class="tab-pane active" id="tab-search-1">
											<div class="credit_search_onbanner">
												<div class="search">
													<form action="${ctx}/search" method="get">
														<table cellpadding="0" cellspacing="0" border="0" width="100%">
															<tbody>
																<tr>
																	<td>
																		<div class="input-group input-group-lg widget-radius-clear" style="width: 100%;">
																			<input type="text" class="form-control widget-radius-clear" name="q" id="keyword" style="font-size: 12px; border: 1px solid #ccc; border-right: 0" onkeypress="EnterPressNonCom(event)" onkeydown="EnterPressNonCom()" value="全文搜索..." onfocus="if (this.value == '全文搜索...') {this.value ='';this.style.color = '';}" onblur="if (this.value == '') {this.value = '全文搜索...';this.style.color = '#555';}" /></div>
																	</td>
																	<td width="110">
																		<button id="searchNonCom" class="btn btn-md widget-radius-clear btn-danger " style="height: 44px; width: 100%" type="submit">查 询</button></td>
																</tr>
															</tbody>
														</table>
													</form>
												</div>
											</div>
										</div>
										<!--全文检索end-->
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="pull-right" style="text-align: right; padding-top: 20px">
						<a href="#" target="_blank" style="display: inline-block; font-size: 0; margin-right: 16px">
							<img src="${ctxStaticTheme}/image/tydm.jpg" /></a>
						<a href="#" target="_blank" style="display: inline-block; font-size: 0">
							<img src="${ctxStaticTheme}/image/sgs.jpg" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>