<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.lanzx.rmmsys.utils.SystemUtil"%>
<div  style="height:32px; line-height:32px; text-align:center;">
            Copyright © 2014-2025 数据应用中心
    </div>
    <div style="display:none"></div>
     <script type="text/javascript"> 
     	var tip;
     	function refreshCheckSign(){
            		$.ajax({	type: 'POST',
						url: '<%=request.getContextPath()%>/CheckMySignIn.do',
						data: '',
						dataType: 'json',
						async: false,
						success: function (data){
							
							if(parseFloat(data.todayInputHour)>0){//当天未签满7小时
								 if (!tip) {
									tip=$.ligerDialog.tip({  title: '提醒信息',content:'<div style="color: red;font-size: 1.5em;" ><%=SystemUtil.getLoginUser(request).getUserName() %>同学:<br>你今天还要签到'+data.todayInputHour+'小时哦</div>' });
								 }else{
								 	 var visabled = tip.get('visible');
					                 if (!visabled) tip.show();
					                 tip.set('content', '<div style="color: red;font-size: 1.5em;" ><%=SystemUtil.getLoginUser(request).getUserName() %>同学:<br>你今天还要签到'+data.todayInputHour+'小时哦</div>' );
								 }
							}
						}
			});
            	}
            	//refreshCheckSign();
            	//window.setInterval("refreshCheckSign()", 120000);
     </script>