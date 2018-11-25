<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.lanzx.rmmsys.utils.Constants" %>
<%@ page import="com.lanzx.rmmsys.utils.SystemUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="com.lanzx.rmmsys.entity.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>