<%@page import="java.lang.management.MemoryUsage"%>
<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.lang.management.ManagementFactory"%>
<%
	ManagementFactory.getMemoryMXBean().gc();
	MemoryUsage hmu = ManagementFactory.getMemoryMXBean().getHeapMemoryUsage();
	MemoryUsage nmu = ManagementFactory.getMemoryMXBean().getNonHeapMemoryUsage();
%>
<b>Heap Init Memory: </b><%=hmu.getInit()/1000000%>M<br>
<b>Heap Max &nbsp;Memory: </b><%=hmu.getMax()/1000000%>M<br>
<b>Heap Used Memory: </b><%=hmu.getUsed()/1000000%>M<br>
<b>Heap Available Memory: </b><%=(hmu.getMax() - hmu.getUsed())/1000000%>M<br>
<br>
<b>Non Heap Init Memory: </b><%=nmu.getInit()/1000000%>M<br>
<b>Non Heap Max &nbsp;Memory: </b><%=nmu.getMax()/1000000%>M<br>
<b>Non Heap Used Memory: </b><%=nmu.getUsed()/1000000%>M<br>
<b>Non Heap Available Memory: </b><%=(nmu.getMax() - nmu.getUsed())/1000000%>M<br>
