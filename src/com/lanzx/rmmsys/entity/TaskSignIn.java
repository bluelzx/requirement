package com.lanzx.rmmsys.entity;

public class TaskSignIn {

	public String taskCode;
	
	public String userCode;
	
	public String createTime;
	/** 权重:高,中,低 */
	public int weightRatio;
	
	/** 正常工时 */
	private double manHour;
	
	/** 加班工时 */
	private double otHour;
	
	public String taskName;
	
	public String requirementCode;
	
	public String requirementId;
	
	public String requirenmentName;
	
	/** 查询界面开始日期 */
	public String startDate;
	/** 查询界面结束日期 */
	public String endDate;
	
	public String remark;
	
	public String signInCode;

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getRequirementCode() {
		return requirementCode;
	}

	public void setRequirementCode(String requirementCode) {
		this.requirementCode = requirementCode;
	}

	public String getRequirenmentName() {
		return requirenmentName;
	}

	public void setRequirenmentName(String requirenmentName) {
		this.requirenmentName = requirenmentName;
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

	public String getRequirementId() {
		return requirementId;
	}

	public void setRequirementId(String requirementId) {
		this.requirementId = requirementId;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public int getWeightRatio() {
		return weightRatio;
	}

	public void setWeightRatio(int weightRatio) {
		this.weightRatio = weightRatio;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}


	public double getOtHour() {
		return otHour;
	}

	public void setOtHour(double otHour) {
		this.otHour = otHour;
	}

	public String getSignInCode() {
		return signInCode;
	}

	public void setSignInCode(String signInCode) {
		this.signInCode = signInCode;
	}

	public double getManHour() {
		return manHour;
	}

	public void setManHour(double manHour) {
		this.manHour = manHour;
	}
	
	
}
