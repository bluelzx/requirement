package com.lanzx.rmmsys.entity;

public class Requirement {

	private String requirementId;
	
	private String requirementCode;
	
	private String requirementName;
	
	private String remark;
	
	private String createTime;
	
	private String creator;
	
	private String startDate;
	
	private String endDate;
	
	private Integer status;
	
	private String dept;
	
	private String presenter;
	
	private String parentCode;
	
	private String closeTime;
	
	private Integer requirementType;
	
	private String owner;

	private Integer important;
	
	private Integer urgent;
	
	private String confirmCloseTime;
	
	private String confirmCloser;
	
	private String launchDate;
	
	private String firstCloseTime;
	
	private String firstCloser;
	
	private double planManHaur;
	
	private String projectCode;
	
	/** 业务分类 */
	private Integer businessType;
	
	/** 监理 */
	private String watcher;
	
	public String getConfirmCloser() {
		return confirmCloser;
	}

	public void setConfirmCloser(String confirmCloser) {
		this.confirmCloser = confirmCloser;
	}

	public String getConfirmCloseTime() {
		return confirmCloseTime;
	}

	public void setConfirmCloseTime(String confirmCloseTime) {
		this.confirmCloseTime = confirmCloseTime;
	}

	public Integer getImportant() {
		return important;
	}

	public void setImportant(Integer important) {
		this.important = important;
	}

	public Integer getUrgent() {
		return urgent;
	}

	public void setUrgent(Integer urgent) {
		this.urgent = urgent;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getPresenter() {
		return presenter;
	}

	public void setPresenter(String presenter) {
		this.presenter = presenter;
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

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getCloseTime() {
		return closeTime;
	}

	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}

	public Integer getRequirementType() {
		return requirementType;
	}

	public void setRequirementType(Integer requirementType) {
		this.requirementType = requirementType;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getRequirementId() {
		return requirementId;
	}

	public void setRequirementId(String requirementId) {
		this.requirementId = requirementId;
	}

	public String getLaunchDate() {
		return launchDate;
	}

	public void setLaunchDate(String launchDate) {
		this.launchDate = launchDate;
	}

	public String getFirstCloseTime() {
		return firstCloseTime;
	}

	public void setFirstCloseTime(String firstCloseTime) {
		this.firstCloseTime = firstCloseTime;
	}

	public String getFirstCloser() {
		return firstCloser;
	}

	public void setFirstCloser(String firstCloser) {
		this.firstCloser = firstCloser;
	}

	public double getPlanManHaur() {
		return planManHaur;
	}

	public void setPlanManHaur(double planManHaur) {
		this.planManHaur = planManHaur;
	}

	public String getProjectCode() {
		return projectCode;
	}

	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}

	public Integer getBusinessType() {
		return businessType;
	}

	public void setBusinessType(Integer businessType) {
		this.businessType = businessType;
	}

	public String getWatcher() {
		return watcher;
	}

	public void setWatcher(String watcher) {
		this.watcher = watcher;
	}

}
