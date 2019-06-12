<%@page import="cn.net.ecode.common.utils.DateUtils"%>
<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.http.*"%>
<html>
<head>
	<title>Session Test</title>
</head>
<body>
	Server Info:
	<%
	out.println(request.getLocalAddr() + " : " + request.getLocalPort() + "<br>");
	out.println("<br/> Session ID: " + session.getId() + "<br/>");
	out.println("<br/> 最后访问: " + DateUtils.formatDateTime(new Date(session.getLastAccessedTime())) + "<br/>");
	out.println("<br/> 超时时间: " + DateUtils.formatDateTime(session.getMaxInactiveInterval()*1000) + "<br/>");

    out.println("<br />");
    out.println("webapp.root: "+System.getProperty("webapp.root") + "<br/>");
    out.println("webapp.ctxPath: "+System.getProperty("webapp.ctxPath") + "<br/>");
    
	String dataName = request.getParameter("dataName");

	if (dataName != null && dataName.length() > 0) {
		String dataValue = request.getParameter("dataValue");
		session.setAttribute(dataName, dataValue);
	}

	out.print("<br/><b>Session List</b><br/>");

	Enumeration e = session.getAttributeNames();
	while (e.hasMoreElements()) {
		String name = (String) e.nextElement();
		String value = session.getAttribute(name).toString();
		out.println(name + " = " + value + "<br>");
		//System.out.println(name + " = " + value);
	}
	
	out.print("<br/>");
%>
	<!-- <b>Add Session</b><br/>
	<form action="" method="POST">
		&nbsp;name: <input type=text size=20 name="dataName"> <br>
		value: <input type=text size=20 name="dataValue"> <br>
		<input type=submit>
	</form> -->
<%

	out.println("<br/><b>Header List</b><br/>");
	Enumeration headers =  request.getHeaderNames();
    if (headers != null) {
		while (headers.hasMoreElements()) {
			String str = headers.nextElement().toString();
			if (!"cookie".equals(str)){
				out.println(str + ":" + request.getHeader(str) + "<br/>");
			}
		}
    }
    out.println("<br />");

	out.print("<br/><b>Cookie List</b><br/>");
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			out.print(cookie.getName() + ": " + cookie.getValue() + "<br/>");
		}
	}
    
%>
</body>
</html>