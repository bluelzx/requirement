package com.lanzx.rmmsys.entity;

public class TaskHaurs {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	private String taskType;
	
	private String avgPlan;
	
	private String avgMan;
	
	private String maxMan;
	
	private String minMan;
	
	private String counts;

	public String getAvgMan() {
		return avgMan;
	}

	public void setAvgMan(String avgMan) {
		this.avgMan = avgMan;
	}

	public String getAvgPlan() {
		return avgPlan;
	}

	public void setAvgPlan(String avgPlan) {
		this.avgPlan = avgPlan;
	}

	public String getCounts() {
		return counts;
	}

	public void setCounts(String counts) {
		this.counts = counts;
	}

	public String getMaxMan() {
		return maxMan;
	}

	public void setMaxMan(String maxMan) {
		this.maxMan = maxMan;
	}

	public String getMinMan() {
		return minMan;
	}

	public void setMinMan(String minMan) {
		this.minMan = minMan;
	}

	public String getTaskType() {
		return taskType;
	}

	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}
	
	
}
