package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.dao.SysTaskDao;
import com.lanzx.rmmsys.entity.ReportWeek;
import com.lanzx.rmmsys.entity.Task;
import com.lanzx.rmmsys.entity.TaskAlarm;
import com.lanzx.rmmsys.entity.TaskDependable;
import com.lanzx.rmmsys.entity.TaskHaurs;
import com.lanzx.rmmsys.entity.TaskRCounts;
import com.lanzx.rmmsys.entity.TaskSignIn;
import com.lanzx.rmmsys.entity.TodayTaskSignIn;
import com.lanzx.rmmsys.entity.UserWork;
import com.lanzx.rmmsys.service.SysTaskService;

public class SysTaskServiceImpl implements SysTaskService {

	private SysTaskDao taskDao;
	
	
	public List<Task> getAllTask(Map<String, Object> likeCondition) {
		return taskDao.getAllTask(likeCondition);
	}

	public int getTotalTask(Map<String, Object> likeCondition) {
		return taskDao.getTotalTask(likeCondition);
	}

	public void insertTask(Task task) {
		taskDao.insertTask(task);
		for(TaskDependable taskDependable:task.getDependables()){
			taskDao.insertTaskDependable(taskDependable);
		}
	}

	public SysTaskDao getTaskDao() {
		return taskDao;
	}

	public void setTaskDao(SysTaskDao taskDao) {
		this.taskDao = taskDao;
	}

	public List<UserWork> getUserWorks(Map<String,Object> likeCondition) {
		return taskDao.getUserWorks(likeCondition);
	}

	public int getUserWorksTotal(String userCode) {
		return taskDao.getUserWorksTotal(userCode);
	}

	public void updateTaskStatus(Task task) {
		 taskDao.updateTaskStatus(task);
	}

	public Task getTaskByCode(String taskCode) {
		return taskDao.getTaskByCode(taskCode);
	}

	public void updateTask(Task task) {
		taskDao.updateTask(task);
		List<TaskDependable> taskDependables = task.getDependables();
		if(taskDependables.size()>0){
			taskDao.deleteDependableTask(task.getTaskCode());
			for(TaskDependable taskDependable:taskDependables){
				taskDao.insertTaskDependable(taskDependable);
			}
		}
	}

	public void disableByTaskCode(String taskCode) {
		Task task = taskDao.getTaskByCode(taskCode);
		if(task!=null){
			taskDao.disableByTaskCode(taskCode);
			taskDao.deleteDependableTask(task.getTaskCode());
		}
	}

	public void doLockTask(String taskCode) {
		taskDao.doLockTask(taskCode);
	}

	public List<Task> getDependableTaskByCode(String taskCode) {
		return taskDao.getDependableTaskByCode(taskCode);
	}

	public List<Task> getTaskByDependableCode(String taskCode) {
		return taskDao.getTaskByDependableCode(taskCode);
	}

	public void updateReStatus(Task task) {
		taskDao.updateReStatus(task);
	}

	public int getTotalUnFinishTask(Map<String, Object> likeCondition) {
		return taskDao.getTotalUnFinishTask(likeCondition);
	}

	public int getTotalDDTask(Map<String, Object> likeCondition) {
		return taskDao.getTotalDDTask(likeCondition);
	}

	public void updateTaskLaunch(Task task) {
		taskDao.updateTaskLaunch(task);
	}

	public String doFinishTask(Map<String, Object> likeCondition) {
		return taskDao.doFinishTask(likeCondition);
	}

	public List<TaskHaurs> getTaskHaurs() {
		return taskDao.getTaskHaurs();
	}

	public List<TaskRCounts> getTaskCounts() {
		return taskDao.getTaskCounts();
	}

	public List<TaskSignIn> getAllTaskSignIn(Map<String, Object> likeCondition) {
		return taskDao.getAllTaskSignIn(likeCondition);
	}

	public int getTaskSignInCount(Map<String, Object> likeCondition) {
		return taskDao.getTaskSignInCount(likeCondition);
	}

	public void insertTaskSignIn(TaskSignIn signIn) {
		taskDao.insertTaskSignIn(signIn);
	}

	public void doBackTaskSignIn(TaskSignIn signIn) {
		taskDao.doBackTaskSignIn(signIn);
	}

	public int getAllSignInCount() {
		return taskDao.getAllSignInCount();
	}

	public List<TodayTaskSignIn> getAllTodaySignIn(Map<String, Object> likeCondition) {
		return taskDao.getAllTodaySignIn(likeCondition);
	}

	public Double getTodayInputHour(String userCode) {
		return taskDao.getTodayInputHour(userCode);
	}

	public void deleteTaskSignIn(Map<String, Object> likeCondition) {
		taskDao.deleteTaskSignIn(likeCondition);
	}

	public List<ReportWeek> getReportWeek(Map<String, Object> likeCondition) {
		return taskDao.getReportWeek(likeCondition);
	}

	public List<Task> getAllReportDevTask(Map<String, Object> likeCondition) {
		return taskDao.getAllReportDevTask(likeCondition);
	}

	public int getAllReportDevTaskCount(Map<String, Object> likeCondition) {
		return taskDao.getAllReportDevTaskCount(likeCondition);
	}

	public void updateTaskFinishPercent(Task task) {
		taskDao.updateTaskFinishPercent(task);
	}

	public List<TaskAlarm> getAllTaskAlarm(Map<String, Object> likeCondition) {
		return taskDao.getAllTaskAlarm(likeCondition);
	}

	public List<TaskAlarm> getMyTaskAlarm(Map<String, Object> likeCondition) {
		return taskDao.getMyTaskAlarm(likeCondition);
	}

	public int getAllTaskAlarmTotal() {
		return taskDao.getAllTaskAlarmTotal();
	}

	public int getMyTaskAlarmTotal(String userCode) {
		return taskDao.getMyTaskAlarmTotal(userCode);
	}

	public Double getInputHour(Map<String, Object> likeCondition) {
		return taskDao.getInputHour(likeCondition);
	}

	

}
