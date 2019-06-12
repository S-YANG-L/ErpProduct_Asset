<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<sys:header title=""></sys:header>
<%
	java.util.List<String> colors = new java.util.ArrayList<String>();
	colors.add("blue");
	colors.add("blue-madison");
	colors.add("blue-chambray");
	colors.add("blue-ebonyclay");
	colors.add("blue-hoki");
	colors.add("blue-steel");
	colors.add("green");
	colors.add("green-meadow");
	colors.add("green-seagreen");
	colors.add("green-turquoise");
	colors.add("green-haze");
	colors.add("green-jungle");
	colors.add("grey");
	colors.add("grey-steel");
	colors.add("grey-cararra");
	colors.add("grey-gallery");
	colors.add("grey-cascade");
	colors.add("grey-silver");
	colors.add("red");
	colors.add("red-pink");
	colors.add("red-sunglo");
	colors.add("red-intense");
	colors.add("red-thunderbird");
	colors.add("red-flamingo");
	colors.add("yellow");
	colors.add("yellow-gold");
	colors.add("yellow-casablanca");
	colors.add("yellow-crusta");
	colors.add("yellow-lemon");
	colors.add("yellow-saffron");
	colors.add("purple");
	colors.add("purple-plum");
	colors.add("purple-medium");
	colors.add("purple-studio");
	colors.add("purple-wisteria");
	colors.add("purple-seance");
%>
<sys:footer></sys:footer>
<%
	for (int i = 0; i < colors.size(); i++) {
		String color = colors.get(i);
%>
<div class="portlet box <%=color%>" style="margin:10px;width:245px;display:inline-block;">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-user"></i>信息管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm"><i class="fa fa-plus"></i> 新增</a>
		</div>
	</div>
	<div class="portlet-body list">
		<button class="btn <%=color%>">&nbsp;</button> &nbsp; <%=color%>
	</div>
</div>
<%
	}
%>
