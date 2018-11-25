package com.lanzx.rmmsys.task;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import rtx.RTXSvrApi;
import rtx.RTXUtils;

import com.lanzx.rmmsys.entity.User;
import com.lanzx.rmmsys.service.SysTaskService;
import com.lanzx.rmmsys.service.SysUserService;
import com.lanzx.rmmsys.utils.ApplicationContextUtil;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.DateUtil;

public class NotifyUserDayCheckJob {


	private SysUserService userService;
	
	private SysTaskService taskService;
	
	public void job(){
		
		String currentDate = DateUtil.getCurrentDateBefore(Constants.DATA_FORMATE_3);
		String holiday = userService.getHoliday(currentDate);
		if (StringUtils.isBlank(holiday)) {// 非节假日
			Map<String, Object> likeCondition = new HashMap<String, Object>();
			likeCondition.put("data_date", currentDate);
			String msg = null;
			List<User> users = userService.getUnCheckUser(likeCondition);
			if (users.size() > 0) {
				String userCode = null;
				for (User user : users) {
					userCode = user.getUserCode();
					if (!userCode.equals("admin")) {
						String rtxCode = userService.getUserByUserCode(userCode).getRtxCode();
						if(StringUtils.isNotBlank(rtxCode)){//modify by lanzx 不想发RTX通知的,就不配置RTX号
							msg = "亲,"+currentDate+"号,你还没有签到任务,\n请登陆[后置需求管理系统-我的任务|http://192.168.240.206:7001/toListMyTask.do]进行签到";
							SendNotifyByHTTP(rtxCode, msg);
						}
					}
				}
			}
		}
	}
	
	private void SendNotifyByHTTP(String receivers,String msg){
		List<BasicNameValuePair> params = new LinkedList<BasicNameValuePair>();
		params.add(new BasicNameValuePair("receiver",receivers));
		params.add(new BasicNameValuePair("msg",msg));
		String paraStr = URLEncodedUtils.format(params, "GBK");
		RTXUtils rtxUtils = (RTXUtils) ApplicationContextUtil.getBean("RTXServer");
		String baseUrl = "http://"+rtxUtils.getServerUrl()+":"+rtxUtils.getPort()+"/sendnotify.cgi?"+paraStr;
		HttpClient httpClient = null;
		HttpGet get = new HttpGet(baseUrl);
		try {
			httpClient = new DefaultHttpClient();
			httpClient.execute(get);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	private void SendNotify(String receivers,String title,String msg){
		int iRet= -1;
    	RTXSvrApi  RtxsvrapiObj = new RTXSvrApi();        		
    	if( RtxsvrapiObj.Init())
    	{   
    		iRet = RtxsvrapiObj.sendNotify(receivers,title,msg, "0","0");
    		if (iRet == 0)
    		{
    			System.out.println("发送成功");
    			
    		}
    		else 
    		{
    			System.out.println("发送失败");
    		}

    	}
    	RtxsvrapiObj.UnInit();
	}

	public SysUserService getUserService() {
		return userService;
	}

	public void setUserService(SysUserService userService) {
		this.userService = userService;
	}

	public SysTaskService getTaskService() {
		return taskService;
	}

	public void setTaskService(SysTaskService taskService) {
		this.taskService = taskService;
	}

}
