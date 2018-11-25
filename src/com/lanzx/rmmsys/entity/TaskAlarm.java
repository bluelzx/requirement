package com.lanzx.rmmsys.entity;

/**
 * 任务预警
 * @author lanzx
 *
 */

public class TaskAlarm {

	/** 1、即将延迟预警（1天之后延迟）
	 *  2、已延迟预警； */
	private int alarmType;
	
	/** 预警，天数 */
	private int alermDays;
	
	/** 开发者 */
	private String userName;
	
	/** 任务名称 */
	private String taskName;
	
	private String taskCode;
	
	/** 需求编号 */
	private String requirementCode;
	
	private String requirementId;
	
	/** 预计完成时间 */
	private String planFinishTime;
	
	/** 预计工时 */
	private double planManHaur;
	
	/** 累计工时 */
	private double allHaur;
	
	/** 重要程度 */
	private Integer urgent;
	
	/** 紧急程度 */
	private Integer important;
	
	/** 任务完成百分比 */
	private double finishPercent;
	
	/** 签收日期 */
	private String signTime;
	
	private Integer status;

	public int getAlarmType() {
		return alarmType;
	}

	public void setAlarmType(int alarmType) {
		this.alarmType = alarmType;
	}

	public int getAlermDays() {
		return alermDays;
	}

	public void setAlermDays(int alermDays) {
		this.alermDays = alermDays;
	}

	public double getAllHaur() {
		return allHaur;
	}

	public void setAllHaur(double allHaur) {
		this.allHaur = allHaur;
	}

	public Integer getImportant() {
		return important;
	}

	public void setImportant(Integer important) {
		this.important = important;
	}

	public String getPlanFinishTime() {
		return planFinishTime;
	}

	public void setPlanFinishTime(String planFinishTime) {
		this.planFinishTime = planFinishTime;
	}

	public double getPlanManHaur() {
		return planManHaur;
	}

	public void setPlanManHaur(double planManHaur) {
		this.planManHaur = planManHaur;
	}

	public String getRequirementCode() {
		return requirementCode;
	}

	public void setRequirementCode(String requirementCode) {
		this.requirementCode = requirementCode;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public Integer getUrgent() {
		return urgent;
	}

	public void setUrgent(Integer urgent) {
		this.urgent = urgent;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public double getFinishPercent() {
		return finishPercent;
	}

	public void setFinishPercent(double finishPercent) {
		this.finishPercent = finishPercent;
	}

	public String getRequirementId() {
		return requirementId;
	}

	public void setRequirementId(String requirementId) {
		this.requirementId = requirementId;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getSignTime() {
		return signTime;
	}

	public void setSignTime(String signTime) {
		this.signTime = signTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
}
