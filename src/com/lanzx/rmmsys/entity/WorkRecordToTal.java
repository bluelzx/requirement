package com.lanzx.rmmsys.entity;

/**
 * 签到信息日期、按用户汇总
 * @author lanzx
 *
 */
public class WorkRecordToTal {
	/**用户代码*/
	private String userCode;
	/** 用户*/
	private String userName;
	/** 正常上班工时*/
	private double manhour;
	/** 加班工时*/
	private double othour;
	
	public double getManhour() {
		return manhour;
	}
	public void setManhour(double manhour) {
		this.manhour = manhour;
	}
	public double getOthour() {
		return othour;
	}
	public void setOthour(double othour) {
		this.othour = othour;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	
	
}
