package com.lanzx.rmmsys.entity;

public class TaskRCounts {

	/** 任务类型 */
	private String taskRtype;
	
	/** 未开始任务数 */
	private String taskBeginCount;
	
	/** 进行中任务数 */
	private String taskDoingCount;
	
	/** 逾期任务数 */
	private String taskOverdueCount;

	public String getTaskBeginCount() {
		return taskBeginCount;
	}

	public void setTaskBeginCount(String taskBeginCount) {
		this.taskBeginCount = taskBeginCount;
	}

	public String getTaskDoingCount() {
		return taskDoingCount;
	}

	public void setTaskDoingCount(String taskDoingCount) {
		this.taskDoingCount = taskDoingCount;
	}

	public String getTaskOverdueCount() {
		return taskOverdueCount;
	}

	public void setTaskOverdueCount(String taskOverdueCount) {
		this.taskOverdueCount = taskOverdueCount;
	}

	public String getTaskRtype() {
		return taskRtype;
	}

	public void setTaskRtype(String taskRtype) {
		this.taskRtype = taskRtype;
	}
	
	
}
