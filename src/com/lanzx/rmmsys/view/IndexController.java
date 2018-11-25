package com.lanzx.rmmsys.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.RequirementCount;
import com.lanzx.rmmsys.entity.TaskHaurs;
import com.lanzx.rmmsys.entity.TaskRCounts;
import com.lanzx.rmmsys.entity.WorkRecordDetail;
import com.lanzx.rmmsys.service.SysRequirementService;
import com.lanzx.rmmsys.service.SysTaskService;
import com.lanzx.rmmsys.service.WorkRecordService;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.DateUtil;
import com.lanzx.rmmsys.utils.SystemUtil;

@Controller
public class IndexController {

	private SysTaskService taskService;
	
	private SysRequirementService requirementService;
	
	private WorkRecordService workRecordService; 
	
	@RequestMapping(value="toBootstrapDemo")
	public String toBootstrapDemo(HttpServletRequest req){
		return "toBootstrapDemo";
	}
	
	@RequestMapping(value="toIndexPage")
	public String toIndexPage(HttpServletRequest req){
		return "index";
	}
	
	@RequestMapping(value="welcome")
	public String welcome(HttpServletRequest req){
		
		//任务视图
		//每类任务的估算平均工时(算术？)，实际平均工时(算术？)、最高工时、最低工时，任务数
		List<TaskHaurs> taskHaurs = taskService.getTaskHaurs();
		StringBuilder haursTypes = new StringBuilder();
		StringBuilder avgPlanDatas =  new StringBuilder();
		StringBuilder avgManDatas =  new StringBuilder();
		StringBuilder MaxPlanDatas =  new StringBuilder();
		StringBuilder MinPlanDatas =  new StringBuilder();
		StringBuilder taskCounts =  new StringBuilder();
		
		//构造数据
		int hSize = taskHaurs.size();
		TaskHaurs task = null;
		for(int i=0;i<hSize;i++){
			task = taskHaurs.get(i);
			if(i!=hSize-1){
				haursTypes.append("'").append(task.getTaskType()).append("',");
				avgPlanDatas.append(task.getAvgPlan()).append(",");
				avgManDatas.append(task.getAvgMan()).append(",");
				MaxPlanDatas.append(task.getMaxMan()).append(",");
				MinPlanDatas.append(task.getMinMan()).append(",");
				taskCounts.append("{value:").append(task.getCounts()).append(",name:'").append(task.getTaskType()).append("'},");
			}else{
				haursTypes.append("'").append(task.getTaskType()).append("'");
				avgPlanDatas.append(task.getAvgPlan());
				avgManDatas.append(task.getAvgMan());
				MaxPlanDatas.append(task.getMaxMan());
				MinPlanDatas.append(task.getMinMan());
				taskCounts.append("{value:").append(task.getCounts()).append(",name:'").append(task.getTaskType()).append("'}");
			}
		}
		
		req.setAttribute("haursTypes", haursTypes.toString());
		req.setAttribute("avgPlanDatas", avgPlanDatas.toString());
		req.setAttribute("avgManDatas", avgManDatas.toString());
		req.setAttribute("MaxPlanDatas", MaxPlanDatas.toString());
		req.setAttribute("MinPlanDatas", MinPlanDatas.toString());
		req.setAttribute("taskCounts", taskCounts.toString());
		
		//需求统计
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		List<RequirementCount> rcounts = requirementService.getRequirementCount(likeCondition);
		StringBuilder rTypes = new StringBuilder();//需求类型
		StringBuilder rBeginCounts =  new StringBuilder();//未开始需求数
		StringBuilder rRuningCounts =  new StringBuilder();//进行中需求数
		StringBuilder rFinishCounts =  new StringBuilder();//完成需求数
		StringBuilder rCloseCounts =  new StringBuilder();//关闭需求数
		int rSize = rcounts.size();
		RequirementCount rc = null;
		for(int i = 0;i<rSize;i++){
			rc = rcounts.get(i);
			if(i!=rSize-1){
					rTypes.append("'").append(rc.getRequirementType()).append("',");
					rBeginCounts.append(rc.getRBeginCounts()).append(",");
					rRuningCounts.append(rc.getRRuningCounts()).append(",");
					rFinishCounts.append(rc.getRFinishCounts()).append(",");
					rCloseCounts.append(rc.getRCloseCounts()).append(",");
			}else{
				rTypes.append("'").append(rc.getRequirementType()).append("'");
				rBeginCounts.append(rc.getRBeginCounts());
				rRuningCounts.append(rc.getRRuningCounts());
				rFinishCounts.append(rc.getRFinishCounts());
				rCloseCounts.append(rc.getRCloseCounts());
			}
		}
		
		req.setAttribute("rTypes", rTypes.toString());
		req.setAttribute("rBeginCounts", rBeginCounts.toString());
		req.setAttribute("rRuningCounts", rRuningCounts.toString());
		req.setAttribute("rFinishCounts", rFinishCounts.toString());
		req.setAttribute("rCloseCounts", rCloseCounts.toString());
		
		//按任务类型和状态（体现出逾期状态；是否需要包括已完成）显示任务数，紧急程度
		List<TaskRCounts> taskRCounts = taskService.getTaskCounts();
		StringBuilder taskRtypes = new StringBuilder();
		StringBuilder taskBeginCounts = new StringBuilder();
		StringBuilder taskDoingCounts = new StringBuilder();
		StringBuilder taskOverdueCounts = new StringBuilder();
		int rcSize = taskRCounts.size();
		TaskRCounts rTask = null;
		for(int i =0;i<rcSize;i++){
			rTask = taskRCounts.get(i);
			if(i!=rcSize-1){
				taskRtypes.append("'").append(rTask.getTaskRtype()).append("',");
				taskBeginCounts.append(rTask.getTaskBeginCount()).append(",");
				taskDoingCounts.append(rTask.getTaskDoingCount()).append(",");
				taskOverdueCounts.append(rTask.getTaskOverdueCount()).append(",");
			}else{
				taskRtypes.append("'").append(rTask.getTaskRtype()).append("'");
				taskBeginCounts.append(rTask.getTaskBeginCount());
				taskDoingCounts.append(rTask.getTaskDoingCount());
				taskOverdueCounts.append(rTask.getTaskOverdueCount());
			}
		}
		req.setAttribute("taskRtypes", taskRtypes.toString());
		req.setAttribute("taskBeginCounts", taskBeginCounts.toString());
		req.setAttribute("taskDoingCounts", taskDoingCounts.toString());
		req.setAttribute("taskOverdueCounts", taskOverdueCounts.toString());
		
		
		return "welcome";

	}
	
	@RequestMapping(value="toWelcome")
	public String toWelcome(HttpServletRequest req){
		String workDate = DateUtil.getCurrentDateBefore(Constants.DATA_FORMATE_3);
		req.setAttribute("workDate",workDate);
		return "welcome";
	}
	
	/**
	 * 20141021 by lanzx 昨天工作情况
	 * @param req
	 * @return
	 */
	@RequestMapping(value="allWorkDetail")
	public String allWorkDetail(HttpServletRequest req) {
		String workDate = DateUtil.getCurrentDateBefore(Constants.DATA_FORMATE_3);
		req.setAttribute("workDate",workDate);
		req.setAttribute("reusltDetails", getWorkRecordDetailByDate(workDate));
		return "allWorkDetail";
	}
	
	@RequestMapping(value="toAllTaskAlarm")
	public String toAllTaskAlarm(HttpServletRequest req){
		return "allTaskAlarm";
	}
	
	@RequestMapping(value="toMyTaskAlarm")
	public String toMyTaskAlarm(HttpServletRequest req){
		return "myTaskAlarm";
	}
	
	/**
	 * 20150508 by lanzx 任务预警情况
	 * @param req
	 * @return
	 */
	@RequestMapping(value="allTaskAlarm")
	@ResponseBody
	public ListVO allTaskAlarm(HttpServletRequest req) {
		int pageNum = 1;
		int pageSize = Constants.LIST_PAGE_SIZE;
		if(req.getParameter("page")!=null){
			pageNum = Integer.parseInt(req.getParameter("page"));
		}
		if(req.getParameter("pagesize")!=null){
			pageSize = Integer.parseInt(req.getParameter("pagesize"));
		}
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		ListVO vo = new ListVO();
		vo.setRows(taskService.getAllTaskAlarm(likeCondition));
		vo.setTotal(taskService.getAllTaskAlarmTotal());
		return vo;
	}
	
	/**
	 * 20150508 by lanzx 我的任务预警情况
	 * @param req
	 * @return
	 */
	@RequestMapping(value="myTaskAlarm")
	@ResponseBody
	public ListVO myTaskAlarm(HttpServletRequest req) {
		int pageNum = 1;
		int pageSize = Constants.LIST_PAGE_SIZE;
		if(req.getParameter("page")!=null){
			pageNum = Integer.parseInt(req.getParameter("page"));
		}
		if(req.getParameter("pagesize")!=null){
			pageSize = Integer.parseInt(req.getParameter("pagesize"));
		}
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		String userCode = SystemUtil.getLoginUser(req).getUserCode();
		likeCondition.put("userCode", userCode);
		ListVO vo = new ListVO();
		vo.setRows(taskService.getMyTaskAlarm(likeCondition));
		vo.setTotal(taskService.getMyTaskAlarmTotal(userCode));
		return vo;
	}
	
	/**
	 * 20141023 by lanzx 当天工作情况
	 * @param req
	 * @return
	 */
	@RequestMapping(value="searchWorkDetail")
	public String searchWorkDetail(HttpServletRequest req) {
		String workDate  = req.getParameter("workDate");
		if(StringUtils.isBlank(workDate)){
			workDate = DateUtil.getCurrentDate(Constants.DATA_FORMATE_3);
		}
		req.setAttribute("workDate",workDate);
		req.setAttribute("reusltDetails", getWorkRecordDetailByDate(workDate));
		return "searchWorkDetail";
	}
	
	private List<WorkRecordDetail> getWorkRecordDetailByDate(String workDate){
		Map<String, Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("workDate", workDate);
		List<WorkRecordDetail> workDetails = workRecordService.getWorkDetail(likeCondition);
		List<WorkRecordDetail> reusltDetails = new ArrayList<WorkRecordDetail>();
		String userCode = "";
		String userName = "";
		double manhours = 0;
		double othours = 0;
		for (WorkRecordDetail detail : workDetails) {
			if (StringUtils.isBlank(userCode)) {
				userCode = detail.getUserCode();
				userName = detail.getUserName();
			}
			if (userCode.equals(detail.getUserCode())) {
				manhours = manhours + detail.getManhour();
				othours = othours + detail.getOthour();
				detail.setDisType(0);
				
			} else {// 这里加入一个小计
				WorkRecordDetail sumDetail = new WorkRecordDetail();
				sumDetail.setDisType(2);
				sumDetail.setUserCode(userCode);
				sumDetail.setUserName(userName + "(小计)");
				sumDetail.setManhour(manhours);
				sumDetail.setOthour(othours);
				reusltDetails.add(sumDetail);
				// 加入原来的行
				detail.setDisType(0);
				// 重置
				userCode = detail.getUserCode();
				userName = detail.getUserName();
				manhours = detail.getManhour();
				othours = detail.getOthour();
			}
			reusltDetails.add(detail);
		}
		//最后加一个小计
		WorkRecordDetail sumDetail = new WorkRecordDetail();
		sumDetail.setDisType(2);
		sumDetail.setUserCode(userCode);
		sumDetail.setUserName(userName + "(小计)");
		sumDetail.setManhour(manhours);
		sumDetail.setOthour(othours);
		reusltDetails.add(sumDetail);
		
		return reusltDetails;
	}

	public SysTaskService getTaskService() {
		return taskService;
	}

	public void setTaskService(SysTaskService taskService) {
		this.taskService = taskService;
	}

	public SysRequirementService getRequirementService() {
		return requirementService;
	}

	public void setRequirementService(SysRequirementService requirementService) {
		this.requirementService = requirementService;
	}

	public WorkRecordService getWorkRecordService() {
		return workRecordService;
	}

	public void setWorkRecordService(WorkRecordService workRecordService) {
		this.workRecordService = workRecordService;
	}
}
