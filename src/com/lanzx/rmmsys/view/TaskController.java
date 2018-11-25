package com.lanzx.rmmsys.view;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFComment;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFSimpleShape;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.Region;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import rtx.RTXSvrApi;
import rtx.RTXUtils;

import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.Parameter;
import com.lanzx.rmmsys.entity.ReportWeek;
import com.lanzx.rmmsys.entity.Requirement;
import com.lanzx.rmmsys.entity.SignInVO;
import com.lanzx.rmmsys.entity.Task;
import com.lanzx.rmmsys.entity.TaskDependable;
import com.lanzx.rmmsys.entity.TaskSignIn;
import com.lanzx.rmmsys.entity.User;
import com.lanzx.rmmsys.service.SysRequirementService;
import com.lanzx.rmmsys.service.SysTaskService;
import com.lanzx.rmmsys.service.SysUserService;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.DateUtil;
import com.lanzx.rmmsys.utils.SystemUtil;

@Controller
public class TaskController extends BaseController {

	private SysTaskService taskService;
	
	private SysUserService userService;
	
	
	private SysRequirementService requirementService;
	
	private RTXUtils rtxServer;
	
	@RequestMapping(value="toTaskLaunch")
	public String toLaunch(HttpServletRequest req){
		String taskCode = req.getParameter("taskCode");
		Task task = taskService.getTaskByCode(taskCode);
		req.setAttribute("task", task);
		return "toLaunch";
    }
	
	@RequestMapping(value="doTaskLaunch")
	@ResponseBody
	public String doLaunch(HttpServletRequest req){
		String taskCode = req.getParameter("taskCode");
		String launchDate = req.getParameter("launchDate");
		Task task = new Task();
		task.setTaskCode(taskCode);
		task.setLaunchDate(launchDate);
		taskService.updateTaskLaunch(task);
		log(req, "", taskCode, "", "申请上线");
		return Constants.RESULT_SUCCESS;
    }
    

	@RequestMapping(value="toAddTask")
	public String toAddTask(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		req.setAttribute("requirementId", requirementId);
		return "toAddTask";
	}
	
	/**
	 * 任务签收页面
	 * @param req
	 * @return
	 */
	@RequestMapping(value="toSignForTask")
	public String toSignForTask(HttpServletRequest req){
		String taskCode = req.getParameter("taskCode");
		Task task = taskService.getTaskByCode(taskCode);
		if(task.getTaskType()==Constants.TASK_TYPE_CONFORM){
			task.setPlanFinishTime(DateUtil.getCurrentDate(Constants.DATA_FORMATE_3));
		}
		req.setAttribute("task", task);
		return "toSignForTask";
	}
	
	/**
	 * 任务签收,开发人员开始执行这个任务
	 * @param req
	 * @return
	 */
	@RequestMapping(value="doSignFor")
	@ResponseBody
	public String doSignFor(HttpServletRequest req){
		String taskCode = req.getParameter("taskCode");
//		String planFinishTime = req.getParameter("planFinishTime");
//		String planManHaur = req.getParameter("planManHaur");
		Task task = new Task();
		task.setTaskCode(taskCode);
		task.setStatus(Constants.TASK_STATUS_DOING);
		task.setSignTime(DateUtil.getCurrentDate(Constants.DATA_FORMATE_3));
//		task.setPlanFinishTime(planFinishTime);
//		task.setPlanManHaur(Double.parseDouble(planManHaur));
		taskService.updateTask(task);
		
		//更新需求状态为进行中2
		Task taskR = new Task();
		taskR.setTaskCode(taskCode);
		taskR.setStatus(Constants.REQUIREMENT_STATUS_DOING);
		taskService.updateReStatus(taskR);
		
		log(req, "", taskCode, "", "签收任务");
		return "success";
	}
	
	@RequestMapping(value="doFinishTask")
	@ResponseBody
	public String doFinishTask(HttpServletRequest req){
		String taskCode = req.getParameter("taskCode");
		String startTime = req.getParameter("startTime");
		String endTime = req.getParameter("endTime");
//		String manHaur = req.getParameter("manHaur");
		Task task = new Task();
		task.setTaskCode(taskCode);
		task.setStartTime(startTime);
		task.setEndTime(endTime);
		DateFormat df = new SimpleDateFormat(Constants.DATA_FORMATE_3);
		int days = 0;
		try {
			Date fromDate = df.parse(startTime);
			Date toDate = df.parse(endTime);
			 days = (int) DateUtil.getBetweenDays(fromDate, toDate);
			task.setManHaur(days+1);//日期相同算一天
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Task copyTask = taskService.getTaskByCode(taskCode);
		
		double planManHaur = copyTask.getPlanManHaur();
		if(planManHaur<days){
			task.setStatus(Constants.TASK_STATUS_FINISH_OVERDUE);
		}else{
			task.setStatus(Constants.TASK_STATUS_FINISH);
		}
		taskService.updateTask(task);
		
		if(copyTask.getTaskType()!=Constants.TASK_TYPE_CONFORM){//自动派生的确认任务不用增加任务
			
			//默认增加一个确认任务
			String conformCode = DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14);
			Requirement rm  = requirementService.getRequirementById(copyTask.getRequirementId());
			Task conformTask = new Task();
			conformTask.setRequirementId(copyTask.getRequirementId());
			conformTask.setTaskCode(conformCode);
			conformTask.setTaskName("("+copyTask.getUserCode()+")"+copyTask.getTaskName()+"-确认任务");
			conformTask.setStatus(Constants.TASK_STATUS_WATI);
			conformTask.setRemark("自动添加确认任务");
			conformTask.setTaskGroup(copyTask.getTaskGroup());
			conformTask.setTaskType(Constants.TASK_TYPE_CONFORM);
			conformTask.setUserCode(rm.getOwner());//默认开发者为需求责任人
			conformTask.setPlanManHaur(0);//默认开发时间为0
			conformTask.setUrgent(1);//一般
			conformTask.setIsLongTerm("0");//非持续性
			TaskDependable td = new TaskDependable();
			td.setTaskCode(conformCode);
			td.setDependableCode(taskCode);
			conformTask.getDependables().add(td);
			taskService.insertTask(conformTask);
		}
		
		//更新前置任务
		List<Task> tasks = taskService.getTaskByDependableCode(taskCode);
		if(tasks!=null&&tasks.size()>0){
			for(Task tk :tasks){
				tk.setStatus(Constants.TASK_STATUS_BEGIN);
				taskService.updateTaskStatus(tk);
			}
		}else{//如果所有任务都已经完成,更新需求状态
			Map<String,Object> likeCondition = new HashMap<String, Object>();
//			String requirementCode = req.getParameter("requirementCode");
			String requirementId = copyTask.getRequirementId();
			likeCondition.put("requirementId",requirementId );
			int total = taskService.getTotalUnFinishTask(likeCondition);
			if(total==0){
				Task taskR = new Task();
				taskR.setTaskCode(taskCode);
				taskR.setStatus(Constants.REQUIREMENT_STATUS_FINISH);
				taskService.updateReStatus(taskR);
			}
		}
		
		log(req, "", taskCode, "", "完成任务");
		
		return "success";
	}
	
	@RequestMapping(value="doFinishTaskProc")
	@ResponseBody
	public String doFinishTaskForProc(HttpServletRequest req){
		String taskCode = req.getParameter("taskCode");
		String startTime = req.getParameter("startTime");
		String endTime = DateUtil.getCurrentDate(Constants.DATA_FORMATE_3);
		String manHaur = req.getParameter("manHaur");
		String newTaskCode = DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("taskCode", taskCode);
		likeCondition.put("startTime", startTime);
		likeCondition.put("endTime", endTime);
		likeCondition.put("manHaur", manHaur);
		likeCondition.put("newTaskCode", newTaskCode);
		String resultFlay = taskService.doFinishTask(likeCondition);
		log(req, "", taskCode, "", "完成任务");
		return "success";
	}
	
	@RequestMapping(value="toFinishTask")
	public String toFinishTask(HttpServletRequest req) throws ParseException{
		String taskCode = req.getParameter("taskCode");
		Task task = taskService.getTaskByCode(taskCode);
		task.setStartTime(task.getSignTime());
		task.setEndTime(DateUtil.getCurrentDate(Constants.DATA_FORMATE_3));
		DateFormat df = new SimpleDateFormat(Constants.DATA_FORMATE_3);
		long maxDays = DateUtil.getBetweenDays(df.parse(task.getStartTime()), df.parse(task.getEndTime()));
		task.setManHaur((int)maxDays+1);
		req.setAttribute("task", task);
		return "toFinishTask";
		
	}
	
	@RequestMapping(value="doLockTask")
	@ResponseBody
	public String doLockTask(HttpServletRequest req){
		String taskCode = req.getParameter("taskCode");
		taskService.doLockTask(taskCode);
		
		log(req, "", taskCode, "", "锁定任务");
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="doCloseTask")
	@ResponseBody
	public String doCloseTask(HttpServletRequest req){
		String taskCode = req.getParameter("taskCode");
		Task task = new Task();
		task.setTaskCode(taskCode);
		task.setCloseTime(DateUtil.getCurrentDate(Constants.DATA_FORMATE_3));
		task.setStatus(Constants.TASK_STATUS_CLOSE);
		taskService.updateTaskStatus(task);
		
		log(req, "", taskCode, "", "关闭任务");
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="viewTask")
	public String viewTask(HttpServletRequest req){
		String taskCode = req.getParameter("taskCode");
		if(StringUtils.isNotBlank(taskCode)){
			Task task = taskService.getTaskByCode(taskCode);
			String dependableTaskText = null;
			List<Task> tss = taskService.getDependableTaskByCode(taskCode);
			String devCode = "";
			for(Task ts:tss){
				devCode = ts.getUserCode();
				if(StringUtils.isNotBlank(devCode)){
					User user = userService.getUserByUserCode(devCode);
					if(user!=null){
						devCode = user.getUserName();
					}
				}
				if(dependableTaskText==null){
					dependableTaskText = ts.getTaskName()+"("+devCode+")";
				}else{
					dependableTaskText = dependableTaskText+","+ts.getTaskName()+"("+devCode+")";
				}
			}
			String userCode = task.getUserCode();
			if(StringUtils.isNotBlank(userCode)){
				User user = userService.getUserByUserCode(userCode);
				req.setAttribute("userCodeText", user.getUserName());
			}
			req.setAttribute("task", task);
			req.setAttribute("dependableTaskText", dependableTaskText);
			
			Map<String,Object> likeCondition = new HashMap<String, Object>();
			likeCondition.put("startRow", 1);
			likeCondition.put("endRow", Integer.MAX_VALUE);
			likeCondition.put("paraType", "1");
			List<Parameter> paras = paraService.getParas(likeCondition);
			req.setAttribute("paras", paras);
		}
		return "viewTask";
	}
	
	@RequestMapping(value="disableByTaskCode")
	@ResponseBody
	public String disableByTaskCode(HttpServletRequest req){
		String taskCode  = req.getParameter("taskCode");
		taskService.disableByTaskCode(taskCode);
		log(req, "", taskCode, "", "删除任务");
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="toRevokeTask")
	public String toRevokeTask(HttpServletRequest req){
		String taskCode  = req.getParameter("taskCode");
		Task task = taskService.getTaskByCode(taskCode);
		req.setAttribute("task", task);
		return "toRevokeTask";
	}
	
	@RequestMapping(value="revokeTask")
	@ResponseBody
	public String revokeTask(HttpServletRequest req){
		String taskCode  = req.getParameter("taskCode");
		String userCode  = req.getParameter("userCode");
		String remark  = req.getParameter("remark");
		
		//更新前置任务状态为进行中
		List<Task> dTasks = taskService.getDependableTaskByCode(taskCode);
		for(Task t:dTasks){
			t.setStatus(Constants.TASK_STATUS_DOING);
//			t.setUserCode(userCode);
			taskService.updateTask(t);
		}
		//设置当前任务失效
		taskService.disableByTaskCode(taskCode);
		
		//添加备注 通知任务已经被
		log(req, "", taskCode,"","退回任务:"+remark);
		return Constants.RESULT_SUCCESS;
	}
	
	public static void main(String [] str){
		System.out.println(DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14));
	}
	
	@RequestMapping(value="saveTask")
	public String saveTask(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		String requirementCode = req.getParameter("requirementCode");
//		当界面上用户粘贴进去的没有选择的时
		if(StringUtils.isBlank(requirementId)&&StringUtils.isNotBlank(requirementCode)){
			Requirement rm =  requirementService.getRequirementByRequirementCode(requirementCode);
			requirementId = rm.getRequirementId();
		}
		String taskName = req.getParameter("taskName");
		String remark = req.getParameter("remark");
		String startTime = DateUtil.getCurrentDate(Constants.DATA_FORMATE_3);
//		String endTime = req.getParameter("endTime");
		String taskType = req.getParameter("taskType");
		String taskGroup = req.getParameter("taskGroup");
		String planManHaur = req.getParameter("planManHaur");
		String planFinishTime = req.getParameter("planFinishTime");
		String urgent = req.getParameter("urgent");
		String userCode = req.getParameter("userCode");
		String isLongTerm = req.getParameter("isLongTerm");
		String creator = SystemUtil.getLoginUser(req).getUserCode();
		Task task = new Task();
		task.setStartTime(startTime);
		task.setRequirementId(requirementId);
		task.setTaskName(taskName);
		task.setRemark(remark);
		task.setUserCode(userCode);
		task.setTaskType(Integer.parseInt(taskType));
		task.setTaskGroup(taskGroup);
		task.setCreator(creator);
		if(StringUtils.isNotBlank(planManHaur)){
			task.setPlanManHaur(Double.parseDouble(planManHaur));
		}
		if(StringUtils.isNotBlank(planFinishTime)){
			task.setPlanFinishTime(planFinishTime);
		}
		task.setStatus(Constants.TASK_STATUS_DOING);
		String taskCode = DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14);
		task.setTaskCode(taskCode);
		task.setIsLongTerm(isLongTerm);
		if(StringUtils.isBlank(urgent)){
			urgent = "1";//一般
		}
		task.setUrgent(Integer.parseInt(urgent));
		//前置任务
		String dependableTask = req.getParameter("dependableTask");
		if(StringUtils.isNotBlank(dependableTask)){
			task.setStatus(Constants.TASK_STATUS_WATI);
			String[] dts = dependableTask.split(",");
			for(String dt:dts){
				TaskDependable td = new TaskDependable();
				td.setTaskCode(taskCode);
				td.setDependableCode(dt);
				task.getDependables().add(td);
			}
		}
		
		taskService.insertTask(task);
		
		//更新需求状态
		if(StringUtils.isNotBlank(requirementId)){
			Task taskR = new Task();
			taskR.setTaskCode(taskCode);
			Map<String,Object> likeCondition = new HashMap<String, Object>();
			likeCondition.put("requirementId", requirementId);
			int ddTasks = taskService.getTotalDDTask(likeCondition);
			if(ddTasks==0){
				taskR.setStatus(Constants.REQUIREMENT_STATUS_BEGIN);
			}else{
				taskR.setStatus(Constants.REQUIREMENT_STATUS_DOING);
			}
			taskService.updateReStatus(taskR);
		}
		
		log(req, "", taskCode,"","新增任务");
		
		//RTX通知
		String Url = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+"/viewTask.do?taskCode="+taskCode;
		String msg = "亲,"+SystemUtil.getLoginUser(req).getUserName()+"给你分派了任务:\n["+taskName+"|"+Url+"]\n请按时完成!";
//		SendNotify(userCode, "你有新任务了", msg);
		String rtxCode = userService.getUserByUserCode(userCode).getRtxCode();
		SendNotifyByHTTP(rtxCode, msg);
		boolean fromRtee = Boolean.parseBoolean(req.getParameter("fromRtree"));
		if(fromRtee){
			return "redirect:toListReTask.do?requirementId="+requirementId;
		}else{
			return "redirect:toListAllTask.do";
		}
	}
	
	private void SendNotifyByHTTP(String receivers,String msg){
		List<BasicNameValuePair> params = new LinkedList<BasicNameValuePair>();
		params.add(new BasicNameValuePair("receiver",receivers));
		params.add(new BasicNameValuePair("msg",msg));
		String paraStr = URLEncodedUtils.format(params, "GBK");
		String baseUrl = "http://"+rtxServer.getServerUrl()+":"+rtxServer.getPort()+"/sendnotify.cgi?"+paraStr;
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
	
	@RequestMapping(value="toListAllTask")
	public String toListAllTask(HttpServletRequest req){
		return "toListAllTask";
	}
	
	/**
	 * 列出指定需求的所有任务
	 * @param req
	 * @return
	 */
	@RequestMapping(value="toListReTask")
	public String toListReTask(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		String requirementCode = req.getParameter("requirementCode");
		if(StringUtils.isNotBlank(requirementId)){
			req.setAttribute("requirementId", requirementId);
		}
		if(StringUtils.isNotBlank(requirementCode)){
			req.setAttribute("requirementCode", requirementCode);
		}
		return "toListReTask";
	}
	
	@RequestMapping(value="toListMyTask")
	public String toListMyTask(HttpServletRequest req){
		req.setAttribute("currentDate",DateUtil.getCurrentDate(Constants.DATA_FORMATE_3));
		return "toListMyTask";
	}
	
	@RequestMapping(value="listMyTask")
	@ResponseBody
	public ListVO listMyTask(HttpServletRequest req){
		User user = SystemUtil.getLoginUser(req);
		String userCode = "";
		if(user!=null)
			userCode = user.getUserCode();
		return getAllTask(userCode, req);
	}
	
	@RequestMapping(value="listAllTask")
	@ResponseBody
	public ListVO listAllTask(HttpServletRequest req){
		String userCode = req.getParameter("userCode");
		return getAllTask(userCode,req);
	}
	
	
	private ListVO getAllTask(String userCode,HttpServletRequest req){
		String taskCode = req.getParameter("taskCode");
		String requirementId = req.getParameter("requirementId");
		String requirementCode = req.getParameter("requirementCode");
		
		String status = req.getParameter("status");
		String urgent = req.getParameter("urgent");
		
		String isSignIn = req.getParameter("isSignIn");
		
		String isLongTerm = req.getParameter("isLongTerm");
		
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		String taskGroup = req.getParameter("taskGroup");
		String taskType = req.getParameter("taskType");
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		if(StringUtils.isNotBlank(taskCode)){
			likeCondition.put("taskCode", taskCode);
		}
		if(StringUtils.isNotBlank(requirementId)){
			likeCondition.put("requirementId", requirementId);
		}
		if(StringUtils.isNotBlank(requirementCode)){
			likeCondition.put("requirementCode", requirementCode);
		}
		if(StringUtils.isNotBlank(userCode)){
			likeCondition.put("userCode", userCode);
		}
		if(StringUtils.isNotBlank(status)){
			likeCondition.put("status", Integer.parseInt(status));
		}
		if(StringUtils.isNotBlank(taskGroup)){
			likeCondition.put("taskGroup", taskGroup);
		}
		if(StringUtils.isNotBlank(taskType)){
			likeCondition.put("taskType", Integer.parseInt(taskType));
		}
		if(StringUtils.isNotBlank(urgent)){
			likeCondition.put("urgent", Integer.parseInt(urgent));
		}
		if(StringUtils.isNotBlank(isSignIn)){
			likeCondition.put("isSignIn", isSignIn);
		}
		if(StringUtils.isNotBlank(isLongTerm)){
			likeCondition.put("isLongTerm", isLongTerm);
		}
		
		ListVO vo = new ListVO();
		vo.setRows(taskService.getAllTask(likeCondition));
		vo.setTotal(taskService.getTotalTask(likeCondition));
		return vo;
	}
	
	
	@RequestMapping(value="getUserWorks")
	@ResponseBody
	public ListVO getUserWorks(HttpServletRequest req){
		String userCode = req.getParameter("userCode");
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		ListVO vo = new ListVO();
		vo.setRows(taskService.getUserWorks(likeCondition));
		vo.setTotal(taskService.getUserWorksTotal(userCode));
		return vo;
	}
	
	@RequestMapping(value="toUserWorks")
	public String toUserWorks(HttpServletRequest req){
		return "getUserWorks";
	}
	
	@RequestMapping(value="toModifyTask")
	public String toModifyTask(HttpServletRequest req){
		//传递需求id、code
		String requirementId = req.getParameter("requirementId");
		String requirementCode = req.getParameter("requirementCode");
		req.setAttribute("requirementId", requirementId);
		req.setAttribute("requirementCode", requirementCode);
		String taskCode = req.getParameter("taskCode");
		if(StringUtils.isNotBlank(taskCode)){
			Task task = taskService.getTaskByCode(taskCode);
			String dependableTaskText = null;
			String dependableTask = null;
			List<Task> tss = taskService.getDependableTaskByCode(taskCode);
			for(Task ts:tss){
				if(dependableTaskText==null){
					dependableTaskText = ts.getTaskName();
					dependableTask = ts.getTaskCode();
				}else{
					dependableTaskText = dependableTaskText+","+ts.getTaskName();
					dependableTask = dependableTask + ","+ts.getTaskCode();
				}
			}
			String userCode = task.getUserCode();
			if(StringUtils.isNotBlank(userCode)){
				User user = userService.getUserByUserCode(userCode);
				if(user!=null)
				req.setAttribute("userCodeText", user.getUserName());
			}
			req.setAttribute("task", task);
			req.setAttribute("dependableTaskText", dependableTaskText);
			req.setAttribute("dependableTask", dependableTask);
			
			return "toModifyTask";
		}
		return null;
	}
	
	@RequestMapping(value="doModifyTask")
	public String doModifyTask(HttpServletRequest req){
		String requirementCode = req.getParameter("requirementCode");
		String requirementId = req.getParameter("requirementId");
		//当界面上用户粘贴进去的没有选择的时
		if(StringUtils.isBlank(requirementId)&&StringUtils.isNotBlank(requirementCode)){
			Requirement rm =  requirementService.getRequirementByRequirementCode(requirementCode);
			requirementId = rm.getRequirementId();
		}
		String taskCode = req.getParameter("taskCode");
		String taskName = req.getParameter("taskName");
		String remark = req.getParameter("remark");
		String taskType = req.getParameter("taskType");
		String taskGroup = req.getParameter("taskGroup");
		String planFinishTime = req.getParameter("planFinishTime");
		String planManHaur = req.getParameter("planManHaur");
		String userCode = req.getParameter("userCode");
		String status = req.getParameter("status");
		String urgent = req.getParameter("urgent");
		Task task = new Task();
		task.setRequirementId(requirementId);
		task.setTaskCode(taskCode);
		task.setTaskName(taskName);
		task.setRemark(remark);
		task.setUserCode(userCode);
		task.setTaskType(Integer.parseInt(taskType));
		task.setTaskGroup(taskGroup);
		if(StringUtils.isNotBlank(planManHaur)){
			task.setPlanManHaur(Double.parseDouble(planManHaur));
		}
		task.setStatus(Integer.parseInt(status));
		if(StringUtils.isNotBlank(planFinishTime)){
			task.setPlanFinishTime(planFinishTime);
		}
		if(StringUtils.isBlank(urgent)){
			urgent = "1";//一般
		}
		task.setUrgent(Integer.parseInt(urgent));
		
		//前置任务
		String dependableTask = req.getParameter("dependableTask");
		if(StringUtils.isNotBlank(dependableTask)){
			String[] dts = dependableTask.split(",");
			for(String dt:dts){
				TaskDependable td = new TaskDependable();
				td.setTaskCode(taskCode);
				td.setDependableCode(dt);
				task.getDependables().add(td);
			}
		}
		
		taskService.updateTask(task);
		
		//更新需求状态
		if(StringUtils.isNotBlank(requirementId)){
			Task taskR = new Task();
			taskR.setTaskCode(taskCode);
			Map<String,Object> likeCondition = new HashMap<String, Object>();
			likeCondition.put("requirementId", requirementId);
			int ddTasks = taskService.getTotalDDTask(likeCondition);
			if(ddTasks==0){
				taskR.setStatus(Constants.REQUIREMENT_STATUS_BEGIN);
			}else{
				taskR.setStatus(Constants.REQUIREMENT_STATUS_DOING);
			}
			taskService.updateReStatus(taskR);
		}
		
		
		log(req, "", taskCode,"","修改任务");
		
		boolean fromRtee = Boolean.parseBoolean(req.getParameter("fromRtree"));
		if(fromRtee){
			return "redirect:toListReTask.do?requirementId="+requirementId;
		}else{
			return "redirect:toListAllTask.do";
		}
	}
	
	@RequestMapping(value="toTaskSignIn")
	public String toTaskSignIn(HttpServletRequest req){
		String taskCode = req.getParameter("taskCode");
		req.setAttribute("taskCode", taskCode);
		//计算当天最大可录入正常工时
		String userCode = SystemUtil.getLoginUser(req).getUserCode();
		double todayInputHour = taskService.getTodayInputHour(userCode);
		req.setAttribute("todayInputHour", todayInputHour);
		Task task = taskService.getTaskByCode(taskCode);
		req.setAttribute("task", task);
		return "selectSignInWin";
	}
	
	@RequestMapping(value="getMySignIn")
	@ResponseBody
	public String getMySignIn(HttpServletRequest req){
		String userCode = SystemUtil.getLoginUser(req).getUserCode();
		double todayInputHour = taskService.getTodayInputHour(userCode);
		return todayInputHour+"";
	}
	
	@RequestMapping(value="CheckMySignIn")
	@ResponseBody
	public SignInVO CheckMySignIn(HttpServletRequest req){
		Date date = new Date();
		int hour = date.getHours();
		int minu = date.getMinutes();
		SignInVO vo = new SignInVO();
		if(hour>17 ||( hour==17 && minu >=20)){//每天下午5点20分进行提醒
			String userCode = SystemUtil.getLoginUser(req).getUserCode();
			double todayInputHour = taskService.getTodayInputHour(userCode);
			if(todayInputHour>0){//没有签或者没满当天时间
				vo.setResult("N");
				vo.setTodayInputHour(todayInputHour);
			}else{
				vo.setResult("Y");
				vo.setTodayInputHour(0);
			}
		}else{
			vo.setResult("Y");
			vo.setTodayInputHour(0);
		}
		return vo;
	}
	
	
	@RequestMapping(value="doTaskSignIn")
	@ResponseBody
	public String doTaskSignIn(HttpServletRequest req){
		String signInCode = DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14);
		String taskCode = req.getParameter("taskCode");
		String manHour = req.getParameter("manHour");
		String otHour = req.getParameter("otHour");
		String remark = req.getParameter("remark");
		String weightRatio = req.getParameter("weightRatio");
		String finishPercent = req.getParameter("finishPercent");
		String userCode = SystemUtil.getLoginUser(req).getUserCode();
		if(StringUtils.isNotBlank(taskCode)&&StringUtils.isNotBlank(userCode)){
			TaskSignIn signIn = new TaskSignIn();
			signIn.setSignInCode(signInCode);
			signIn.setTaskCode(taskCode);
			signIn.setUserCode(userCode);
			signIn.setRemark(remark);
			if(StringUtils.isNotBlank(weightRatio)){
				signIn.setWeightRatio(Integer.parseInt(weightRatio));
			}
			if(StringUtils.isNotBlank(manHour)){
				signIn.setManHour(Double.parseDouble(manHour));
			}
			if(StringUtils.isNotBlank(otHour)){
				signIn.setOtHour(Double.parseDouble(otHour));
			}
			taskService.insertTaskSignIn(signIn);
			Task task = new Task();
			task.setTaskCode(taskCode);
			task.setFinishPercent(Double.parseDouble(finishPercent));
			taskService.updateTaskFinishPercent(task);
		}
		
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="deleteTaskSignIn")
	@ResponseBody
	public String deleteTaskSignIn(HttpServletRequest req){
		String signInCode = req.getParameter("signInCode"); 
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("signInCode", signInCode);
		taskService.deleteTaskSignIn(likeCondition);
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="toBackTaskSignIn")
	public String toBackTaskSignIn(HttpServletRequest req){
		return "toBackTaskSignIn";
	}
	
	@RequestMapping(value="doBackTaskSignIn")
	public String doBackTaskSignIn(HttpServletRequest req){
		String signInCode = DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14);
		String taskCode = req.getParameter("taskCode");
		String userCode = req.getParameter("userCode");
		String createTime = req.getParameter("createTime");
		String manHour = req.getParameter("manHour");
		String otHour = req.getParameter("otHour");
		String remark = req.getParameter("remark");
		TaskSignIn signIn = new TaskSignIn();
		signIn.setSignInCode(signInCode);
		signIn.setTaskCode(taskCode);
		signIn.setUserCode(userCode);
		signIn.setCreateTime(createTime+"23:59:59");
		signIn.setRemark(remark);
		if(StringUtils.isNotBlank(manHour)){
			signIn.setManHour(Double.parseDouble(manHour));
		}
		if(StringUtils.isNotBlank(otHour)){
			signIn.setOtHour(Double.parseDouble(otHour));
		}
		taskService.doBackTaskSignIn(signIn);
		
		return "redirect:toListTaskSignIn.do";
	}
	
	@RequestMapping(value="listTaskSignIn")
	@ResponseBody
	public ListVO listTaskSignIn(HttpServletRequest req){
		String userCode = req.getParameter("userCode");
		String taskCode = req.getParameter("taskCode");
		String requirementId = req.getParameter("requirementId");
		String requirementCode = req.getParameter("requirementCode");
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		if(StringUtils.isNotBlank(userCode)){
			likeCondition.put("userCode", userCode);
		}
		if(StringUtils.isNotBlank(requirementId)){
			likeCondition.put("requirementId", requirementId);
		}
		if(StringUtils.isNotBlank(requirementCode)){
			likeCondition.put("requirementCode", requirementCode);
		}
		if(StringUtils.isNotBlank(taskCode)){
			likeCondition.put("taskCode", taskCode);
		}
		if(StringUtils.isNotBlank(startDate)){
			likeCondition.put("startDate", startDate);
		}
		if(StringUtils.isNotBlank(endDate)){
			likeCondition.put("endDate", endDate);
		}
		ListVO vo = new ListVO();
		vo.setRows(taskService.getAllTaskSignIn(likeCondition));
		vo.setTotal(taskService.getTaskSignInCount(likeCondition));
		return vo;
	}
	
	@RequestMapping(value="toListTaskSignIn")
	public String toListTaskSignIn(HttpServletRequest req){
		return "toListTaskSignIn";
	}
	
	/**
	 * 需求下面的报表开发任务
	 * @param req
	 * @return
	 */
	@RequestMapping(value="toListTaskReportDevTask")
	public String toListTaskReportDevTask(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		req.setAttribute("requirementId", requirementId);
		return "toListTaskReportDevTask";
	}
	
	/**
	 * 需求下面的报表开发任务
	 * @param req
	 * @return
	 */
	@RequestMapping(value="doListTaskReportDevTask")
	@ResponseBody
	public ListVO doListTaskReportDevTask(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		likeCondition.put("requirementId", requirementId);
		ListVO vo = new ListVO();
		vo.setRows(taskService.getAllReportDevTask(likeCondition));
		vo.setTotal(taskService.getAllReportDevTaskCount(likeCondition));
		return vo;
	}
	
	@RequestMapping(value="doListTodayTaskSignIn")
	@ResponseBody
	public ListVO doListTodayTaskSignIn(HttpServletRequest req){
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		ListVO vo = new ListVO();
		vo.setRows(taskService.getAllTodaySignIn(likeCondition));
		vo.setTotal(taskService.getAllSignInCount());
		return vo;
	}
	
	@RequestMapping(value="listTodayTaskSignIn")
	public String listTodayTaskSignIn(HttpServletRequest req){
		return "listTodayTaskSignIn";
	}
	
	public SysTaskService getTaskService() {
		return taskService;
	}

	public void setTaskService(SysTaskService taskService) {
		this.taskService = taskService;
	}

	public SysUserService getUserService() {
		return userService;
	}

	public void setUserService(SysUserService userService) {
		this.userService = userService;
	}


	public SysRequirementService getRequirementService() {
		return requirementService;
	}

	public void setRequirementService(SysRequirementService requirementService) {
		this.requirementService = requirementService;
	}
	
	@RequestMapping(value="toDownloadWork")
	public String toDownloadWork(HttpServletRequest req){
		return "toDownloadWork";
	}
	
	@RequestMapping(value="downLoadReportWeek")
	public void downLoadReportWeek(HttpServletRequest req,HttpServletResponse response){
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		String userCode = SystemUtil.getLoginUser(req).getUserCode();
		String userName= SystemUtil.getLoginUser(req).getUserName();
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startDate", startDate);
		likeCondition.put("endDate", endDate);
		likeCondition.put("userCode", userCode);
		
		List<ReportWeek> list = taskService.getReportWeek(likeCondition);
		Set<String> dates = new HashSet<String>();//日期
		
		Map<String,List<ReportWeek>> map = new HashMap<String,List<ReportWeek>>();//需求对应的工作量
		
		for(ReportWeek rw:list){
			dates.add(rw.getDataDate());
			if(rw.getRequirementCode()!=null){
			if(map.get(rw.getRequirementCode())!=null){
				map.get(rw.getRequirementCode()).add(rw);
			}else{
				List<ReportWeek> rws = new ArrayList<ReportWeek>();
				rws.add(rw);
				map.put(rw.getRequirementCode(), rws);
			}
			}
		}
		
		
		List<String> listDates = new ArrayList<String>();
		listDates.addAll(dates);
		Collections.sort(listDates, new Comparator(){

			public int compare(Object o1, Object o2) {
				String week1 = (String)o1;
				String week2 = (String)o2;
				return week1.compareTo(week2);
			}
		});
		
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		//设置默认列宽
		sheet.setDefaultColumnWidth(10);
		HSSFPatriarch p = sheet.createDrawingPatriarch();//
		
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		
		HSSFRow row1 = sheet.createRow(0);
		
		HSSFCell newCell1 = row1.createCell(0);
		newCell1.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell1.setCellValue("人员投入   日期");
		newCell1.setCellStyle(style);
		
		HSSFCell newCell2 = row1.createCell(1);
		newCell2.setCellType(HSSFCell.CELL_TYPE_STRING);
		newCell2.setCellValue("需求编号");
		newCell2.setCellStyle(style);
		for(int i=0;i<listDates.size();i++){
			HSSFCell cell = row1.createCell(i+2);
			cell.setCellStyle(style);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(listDates.get(i));
		}
		List<String> requirementCodes = new ArrayList<String>();
		requirementCodes.addAll(map.keySet());
		for(int i=0;i<requirementCodes.size();i++){
			HSSFRow row = sheet.createRow(i+1);
			
			HSSFCell hcell1 = row.createCell(0);
			hcell1.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell1.setCellValue(userName);
			hcell1.setCellStyle(style);
			
			HSSFCell hcell2 = row.createCell(1);
			hcell2.setCellType(HSSFCell.CELL_TYPE_STRING);
			hcell2.setCellValue(requirementCodes.get(i));
			hcell2.setCellStyle(style);
			
			for(int j=0;j<listDates.size();j++){
				HSSFCell cell = row.createCell(j+2);
				cell.setCellStyle(style);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("");
			}
			
			List<ReportWeek> rws = map.get(requirementCodes.get(i));
			for(ReportWeek rw:rws){
				String dataDate = rw.getDataDate();
				for(int k=0;k<listDates.size();k++){
					if(dataDate.equals(listDates.get(k))){
						row.getCell(k+2).setCellValue(rw.getManHour());
						HSSFComment commt = p.createCellComment(new HSSFClientAnchor(0,0,0,0,(short)0,0,(short)2,4));
						commt.setString(new HSSFRichTextString(userName+":\n"+rw.getRemark()));
						row.getCell(k+2).setCellComment(commt);
						break;
					}
				}
			}
		}
		
		//画斜线
		HSSFSimpleShape line = p.createSimpleShape(new HSSFClientAnchor(0,0,1023,255,(short)0,0,(short)0,0));
		line.setShapeType(HSSFSimpleShape.OBJECT_TYPE_LINE);
		line.setLineStyle(HSSFSimpleShape.LINESTYLE_SOLID);
		
		//合并用户名单元格
		sheet.addMergedRegion(new Region(1,(short)0,requirementCodes.size(),(short)0));
		
		//设置列宽
		sheet.setColumnWidth(0, 5000);
		sheet.setColumnWidth(1, 10000);
		
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Content-disposition", "attachment; filename=\""+SystemUtil.getName("管理信息中心-需求工作量投入-"+userName+".xls")+"\"");
		ServletOutputStream os = null;
		try {
			os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		log(req,"导出工时统计");
	}

	public RTXUtils getRtxServer() {
		return rtxServer;
	}

	public void setRtxServer(RTXUtils rtxServer) {
		this.rtxServer = rtxServer;
	}
}
