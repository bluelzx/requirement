package com.lanzx.rmmsys.entity;

/**
 * 员工工时明细
 * @author lanzx
 *
 */
public class ManhaurList {

	/** 工时类型 */
	private String mtype;
	
	/** 人员名称 */
	private String personName;
	
	/** 已确认工时 */
	private double doneTime;
	
	/** 待确认工时 */
	private double todoTime;
	
	/** 合计工时 */
	private double sumTime;
	
	private String requirementCode;
	
	private String requirementName;
	
	private String taskName;
	
	/** 完成日期 */
	private String endTime;

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

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public double getDoneTime() {
		return doneTime;
	}

	public void setDoneTime(double doneTime) {
		this.doneTime = doneTime;
	}

	public String getMtype() {
		return mtype;
	}

	public void setMtype(String mtype) {
		this.mtype = mtype;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public double getSumTime() {
		return sumTime;
	}

	public void setSumTime(double sumTime) {
		this.sumTime = sumTime;
	}

	public double getTodoTime() {
		return todoTime;
	}

	public void setTodoTime(double todoTime) {
		this.todoTime = todoTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	
	
}
