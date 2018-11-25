package com.lanzx.rmmsys.entity;

/**
 * 当天签到情况表
 * @author lanzx
 *
 */
public class TodayTaskSignIn {

	private String userName;
	
	/**非确认任务总数 */
	private Integer taskC1;
	
	/**确认任务总数 */
	private Integer taskC2;

	public Integer getTaskC1() {
		return taskC1;
	}

	public void setTaskC1(Integer taskC1) {
		this.taskC1 = taskC1;
	}

	public Integer getTaskC2() {
		return taskC2;
	}

	public void setTaskC2(Integer taskC2) {
		this.taskC2 = taskC2;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
}
