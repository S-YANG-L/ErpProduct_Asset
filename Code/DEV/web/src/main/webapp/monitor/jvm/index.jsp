<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%long start = System.currentTimeMillis();%><html><%@ page import="java.util.Enumeration"%>
<head>
	<title>JVM Manage</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<div class="container-fluid">
	<h2>JVM OS Info</h2>
	<%@include file="osinfo.jsp"%><hr>
	<h2>JVM Memory Info</h2>
	<%@include file="memory.jsp"%><hr>
	<h2>JVM Runtime Info</h2>
	<%@include file="runtime.jsp"%><hr>
	<h2>JVM Service Info</h2>
	<%@include file="info.jsp"%><hr>
	<h2>JVM Thread Info</h2>
	<%@include file="thread.jsp"%><hr>
	<h2> Execute Cost Time <%=System.currentTimeMillis()-start%> </h2>
</div>
</body>
