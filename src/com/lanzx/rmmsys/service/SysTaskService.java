package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.entity.ReportWeek;
import com.lanzx.rmmsys.entity.Task;
import com.lanzx.rmmsys.entity.TaskAlarm;
import com.lanzx.rmmsys.entity.TaskHaurs;
import com.lanzx.rmmsys.entity.TaskRCounts;
import com.lanzx.rmmsys.entity.TaskSignIn;
import com.lanzx.rmmsys.entity.TodayTaskSignIn;
import com.lanzx.rmmsys.entity.UserWork;

public interface SysTaskService {

	public void insertTask(Task task);

	public int getTotalTask(Map<String, Object> likeCondition);

	public List<Task> getAllTask(Map<String, Object> likeCondition);

	public List<UserWork> getUserWorks(Map<String,Object> likeCondition);
	
	public int getUserWorksTotal(String userCode);
	
	public void updateTaskStatus(Task task);
	
	public Task getTaskByCode(String taskCode);
	
	public void updateTask(Task task);
	
	public void updateTaskFinishPercent(Task task);
	
	public void disableByTaskCode(String taskCode);
	
	public void doLockTask(String taskCode);
	
	public List<Task> getDependableTaskByCode(String taskCode);
	
	public List<Task> getTaskByDependableCode(String taskCode);
	
	public void updateReStatus(Task task);
	
	public int getTotalUnFinishTask(Map<String, Object> likeCondition);
	
	public int getTotalDDTask(Map<String, Object> likeCondition);
	
	public void updateTaskLaunch(Task task);
	
	public String doFinishTask(Map<String, Object> likeCondition);
	
	/** 每类任务的估算平均工时(算术？)，实际平均工时(算术？)、最高工时、最低工时，任务数 */
	public List<TaskHaurs> getTaskHaurs();
	
	/** 按任务类型和状态（体现出逾期状态；是否需要包括已完成）显示任务数，紧急程度  */
	public List<TaskRCounts> getTaskCounts();
	
	/**
	 * 任务签到
	 * @param signIn
	 */
	public void insertTaskSignIn(TaskSignIn signIn);
	
	/**
	 * 补录任务签到
	 * @param signIn
	 */
	public void doBackTaskSignIn(TaskSignIn signIn);
	
	/**
	 * 任务签到列表
	 * @param likeCondition
	 * @return
	 */
	public List<TaskSignIn> getAllTaskSignIn(Map<String, Object> likeCondition);
	
	/**
	 * 任务签到列表总数
	 * @param likeCondition
	 * @return
	 */
	public int getTaskSignInCount(Map<String, Object> likeCondition);
	
	/**
	 * 开发人员当天签到任务
	 * @param likeCondition
	 * @return
	 */
	public List<TodayTaskSignIn> getAllTodaySignIn(Map<String, Object> likeCondition);
	
	/**
	 * 开发人员当天签到任务的总数
	 * @return
	 */
	public int getAllSignInCount();
	
	/**
	 * 当天用户可输入正常工时数
	 * @param userCode 用户代码
	 * @return
	 */
	public Double getTodayInputHour(String userCode);
	
	/**
	 * 删除签到记录
	 * @param likeCondition
	 */
	public void deleteTaskSignIn(Map<String, Object> likeCondition);
	
	/**
	 * 每周导出工时统计excel
	 * @param likeCondition
	 * @return
	 */
	public List<ReportWeek> getReportWeek(Map<String, Object> likeCondition);
	
	public List<Task> getAllReportDevTask(Map<String, Object> likeCondition);
	
	public int getAllReportDevTaskCount(Map<String, Object> likeCondition);
	
	/**
	 * 任务预警清单
	 * @return
	 */
	public List<TaskAlarm> getAllTaskAlarm(Map<String, Object> likeCondition);
	/**
	 * 任务预警清单
	 * @return
	 */
	public List<TaskAlarm> getMyTaskAlarm(Map<String, Object> likeCondition);
	/**
	 * 任务预警清单
	 * @return
	 */
	public int getAllTaskAlarmTotal();
	/**
	 * 任务预警清单
	 * @return
	 */
	public int getMyTaskAlarmTotal(String userCode);
	
	public Double getInputHour(Map<String, Object> likeCondition); 
}
