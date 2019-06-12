<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js"
	type="text/javascript"></script>
<title>APP test</title>


</head>
<body >
<sys:pdfjs url="${ctxStatic}/test.pdf" width="100%" height="100%"></sys:pdfjs>

</body>
</html>