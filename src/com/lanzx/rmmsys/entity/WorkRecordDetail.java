package com.lanzx.rmmsys.entity;
/**
 * 签到明细信息
 * @author lanzx
 *
 */
public class WorkRecordDetail {

	private String requirementCode;
	
	private String requirementName;
	
	private String taskCode;
	
	private String taskName;
	
	/**用户代码*/
	private String userCode;
	/** 用户*/
	private String userName;
	/** 签到信息*/
	private String remark;
	/** 正常上班工时*/
	private double manhour;
	/** 加班工时*/
	private double othour;
	
	private String createTime;
	
	/** 任务的累计投入正常工时 */
	private double sumMan;
	
	/** 任务的累计投入加班工时 */
	private double sumOt;
	
	/** 显示参数 2为小计 */
	private int disType;
	
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	public String getTaskCode() {
		return taskCode;
	}
	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}
	public String getTaskName() {
		return taskName;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public double getSumMan() {
		return sumMan;
	}
	public void setSumMan(double sumMan) {
		this.sumMan = sumMan;
	}
	public double getSumOt() {
		return sumOt;
	}
	public void setSumOt(double sumOt) {
		this.sumOt = sumOt;
	}
	public int getDisType() {
		return disType;
	}
	public void setDisType(int disType) {
		this.disType = disType;
	}
	
	
}
