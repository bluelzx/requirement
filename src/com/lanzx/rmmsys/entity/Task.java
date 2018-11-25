package com.lanzx.rmmsys.entity;

import java.util.ArrayList;
import java.util.List;

public class Task {

	private String taskCode;
	
	private String taskName;
	
	private String remark;
	
	private String startTime;
	
	private String endTime;
	
	private Integer taskType;
	
	private String requirementId;
	
	private String requirementCode;
	
	private String requirementName;
	
	private String taskGroup;
	
	private double planManHaur;
	
	private double manHaur;
	
	private Integer status;
	
	private String userCode;
	
	private String signTime;
	
	private String closeTime;
	
	private Integer urgent;
	
	private String launchDate;
	
	private Integer isSignIn;
	
	/** 当天正常工时 */
	private double sManHour;
	
	/** 当天加班工时 */
	private double otHour;
	
	/** 预计完成时间 */
	private String planFinishTime;
	
	/** 任务完成百分比 */
	private double finishPercent;
	
	/** 是否持续性 */
	private String isLongTerm;
	
	/** 任务创建者 */
	private String creator;
	
	
	private List<TaskDependable> dependables = new ArrayList<TaskDependable>();

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}


	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getTaskGroup() {
		return taskGroup;
	}

	public void setTaskGroup(String taskGroup) {
		this.taskGroup = taskGroup;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public Integer getTaskType() {
		return taskType;
	}

	public void setTaskType(Integer taskType) {
		this.taskType = taskType;
	}

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public List<TaskDependable> getDependables() {
		return dependables;
	}

	public void setDependables(List<TaskDependable> dependables) {
		this.dependables = dependables;
	}

	public String getSignTime() {
		return signTime;
	}

	public void setSignTime(String signTime) {
		this.signTime = signTime;
	}


	public String getRequirementId() {
		return requirementId;
	}

	public void setRequirementId(String requirementId) {
		this.requirementId = requirementId;
	}

	public String getCloseTime() {
		return closeTime;
	}

	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}

	public String getRequirementCode() {
		return requirementCode;
	}

	public void setRequirementCode(String requirementCode) {
		this.requirementCode = requirementCode;
	}

	public String getRequirementName() {
		return requirementName;
	}

	public void setRequirementName(String requirementName) {
		this.requirementName = requirementName;
	}

	public Integer getUrgent() {
		return urgent;
	}

	public void setUrgent(Integer urgent) {
		this.urgent = urgent;
	}

	public String getLaunchDate() {
		return launchDate;
	}

	public void setLaunchDate(String launchDate) {
		this.launchDate = launchDate;
	}

	public Integer getIsSignIn() {
		return isSignIn;
	}

	public void setIsSignIn(Integer isSignIn) {
		this.isSignIn = isSignIn;
	}


	public double getOtHour() {
		return otHour;
	}

	public void setOtHour(double otHour) {
		this.otHour = otHour;
	}

	public double getSManHour() {
		return sManHour;
	}

	public void setSManHour(double manHour) {
		sManHour = manHour;
	}

	public String getPlanFinishTime() {
		return planFinishTime;
	}

	public void setPlanFinishTime(String planFinishTime) {
		this.planFinishTime = planFinishTime;
	}

	public double getFinishPercent() {
		return finishPercent;
	}

	public void setFinishPercent(double finishPercent) {
		this.finishPercent = finishPercent;
	}

	public double getManHaur() {
		return manHaur;
	}

	public void setManHaur(double manHaur) {
		this.manHaur = manHaur;
	}

	public double getPlanManHaur() {
		return planManHaur;
	}

	public void setPlanManHaur(double planManHaur) {
		this.planManHaur = planManHaur;
	}

	public String getIsLongTerm() {
		return isLongTerm;
	}

	public void setIsLongTerm(String isLongTerm) {
		this.isLongTerm = isLongTerm;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}


}
