package com.lanzx.rmmsys.entity;

/**
 * 员工工时明细
 * @author lanzx
 *
 */
public class ManhaurListSum {

	/** 类型 */
	private String mtype;
	
	/** 人员名称 */
	private String personName;
	
	/** 已确认工时 */
	private double doneTime;
	
	/** 待确认工时 */
	private double todoTime;
	
	/** 合计工时 */
	private double sumTime;
	
	/** 总任务数 */
	private int sumTask;
	
	/** 已确认任务数 */
	private int doneTask;

	public int getDoneTask() {
		return doneTask;
	}

	public void setDoneTask(int doneTask) {
		this.doneTask = doneTask;
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

	public int getSumTask() {
		return sumTask;
	}

	public void setSumTask(int sumTask) {
		this.sumTask = sumTask;
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
}
