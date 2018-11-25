package com.lanzx.rmmsys.entity;

public class ReportWeek {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	/** 日期 8位 **/
	private String dataDate;
	/** 完成工时 每小时为0.125 **/
	private double manHour;
	/** 需求号 **/
	private String requirementCode;
	/** 用户名 **/
	private String userName;
	/** 批注 **/
	private String remark;

	public String getDataDate() {
		return dataDate;
	}

	public void setDataDate(String dataDate) {
		this.dataDate = dataDate;
	}

	public double getManHour() {
		return manHour;
	}

	public void setManHour(double manHour) {
		this.manHour = manHour;
	}


	public String getRequirementCode() {
		return requirementCode;
	}

	public void setRequirementCode(String requirementCode) {
		this.requirementCode = requirementCode;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
