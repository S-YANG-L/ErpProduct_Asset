<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.lang.management.ManagementFactory"%>
<%@ page import="java.lang.management.RuntimeMXBean" %>
<%
RuntimeMXBean rt = ManagementFactory.getRuntimeMXBean();
%>
<b>Vm Name</b>: <%=rt.getVmName()%><br>
<b>Vm Version</b>: <%=rt.getVmVersion()%> (<%=System.getProperty("java.version", "not specified")%>)<br>
<b>Vm Vendor</b>: <%=rt.getVmVendor()%><br>
<b>Vm Uptime</b>: <%=((float)rt.getUptime())/(1000*60*60)%> hours<br>
<b>Start Time</b>: <%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(rt.getStartTime()))%><br>
<b>Java Home</b>: <%=System.getProperty("java.home", "not specified")%><br>
<b>Input Arguments</b>: <%=rt.getInputArguments()%><br>
<b>Library Path</b>: <%=rt.getLibraryPath()%><br>
<b>Class Path</b>: <%=rt.getClassPath()%><br>
<%--
	out.print("<b>Runtime Info: </b>");
	out.print("maxMemory: "+(Runtime.getRuntime().maxMemory()/1024/1024)
		+"m, totalMemory: "+(Runtime.getRuntime().totalMemory()/1024/1024)
		+"m, freeMemory: "+(Runtime.getRuntime().freeMemory()/1024/1024)
		+"m, maxMemory - totalMemory + freeMemory: "+((Runtime.getRuntime().maxMemory()-Runtime.getRuntime().totalMemory()
				+Runtime.getRuntime().freeMemory())/1024/1024)+"m");
	out.print("<br/>");
--%>