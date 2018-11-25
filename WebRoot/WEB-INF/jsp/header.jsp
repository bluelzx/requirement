<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.lanzx.rmmsys.utils.SystemUtil"%>
<div id="pageloading"></div>  
<div id="topmenu" class="l-topmenu">
    <div class="l-topmenu-logo">数据应用中心项目管理平台</div>
    <div class="l-topmenu-welcome">
    	<span style="color: #E7E7E7;">欢迎,<%=SystemUtil.getLoginUser(request).getUserName() %></span>
    	<span class="space">|</span>
    	<!-- 
    	<span class="space">已签工时:<span id="signTId" style="color: #E7E7E7;font-size: 2em;">7</span></span>
    	<span class="space">|</span>
    	-->
        <a href="<%=request.getContextPath()%>/logonOut.do" class="l-link2">退出</a>
        <span class="space">|</span>
         <a href="#" class="l-link2" target="_blank">关于我们</a>
    </div> 
</div>

<script type="text/javascript">
		function refreshSignId(){
            		$.ajax({	type: 'POST',
						url: '<%=request.getContextPath()%>/getMySignIn.do',
						data: '',
						dataType: 'json',
						async: false,
						success: function (data){
							if(parseFloat(data)>0){//当天未签满7小时
								$("#signTId").css({ color: "red", "font-size": "2em" });
								$("#signTId").text(7-parseFloat(data));
							}else{
								$("#signTId").html(7);
								$("#signTId").css({ color: "#E7E7E7", "font-size": "2em" });
							}
						}
			});
            	}
            	//refreshSignId();
            	//window.setInterval("refreshSignId()", 120000);
</script>