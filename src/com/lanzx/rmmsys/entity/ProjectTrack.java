package com.lanzx.rmmsys.entity;

/**
 * 项目跟踪表
 * @author lanzx
 *
 */
public class ProjectTrack {

	/** 项目名称 */
	private String projectName;
	
	/** 紧急程度 */
	private String urgent;
	
	/** 责任人 */
	private String owner;
	
	/** 需求类型 */
	private String rtype;
	
	/** 人天 评估工时 */
	private double planmanhaur;
	
	/** 领取日期 */
	private String createDate;
	
	/** 计划完成日期 */
	private String planfinishDate;
	
	/** 需求部门 */
	private String rDept;
	
	/** 项目状态 */
	private String projectStatus;
	
	/** 是否关闭 */
	private String isClosed;
	
	/** 是否逾期 */
	private String isOverDate;
	
	/** 是否新增 */
	private String isAdded;
	
	private String pig;
	
	private String pts;
	
	private String pcf;
	
	private String cntall;
	
	private String presenter;
	
	public String getCntall() {
		return cntall;
	}

	public void setCntall(String cntall) {
		this.cntall = cntall;
	}

	public String getPcf() {
		return pcf;
	}

	public void setPcf(String pcf) {
		this.pcf = pcf;
	}

	public String getPig() {
		return pig;
	}

	public void setPig(String pig) {
		this.pig = pig;
	}

	public String getPts() {
		return pts;
	}

	public void setPts(String pts) {
		this.pts = pts;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getIsAdded() {
		return isAdded;
	}

	public void setIsAdded(String isAdded) {
		this.isAdded = isAdded;
	}

	public String getIsClosed() {
		return isClosed;
	}

	public void setIsClosed(String isClosed) {
		this.isClosed = isClosed;
	}

	public String getIsOverDate() {
		return isOverDate;
	}

	public void setIsOverDate(String isOverDate) {
		this.isOverDate = isOverDate;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getPlanfinishDate() {
		return planfinishDate;
	}

	public void setPlanfinishDate(String planfinishDate) {
		this.planfinishDate = planfinishDate;
	}


	public double getPlanmanhaur() {
		return planmanhaur;
	}

	public void setPlanmanhaur(double planmanhaur) {
		this.planmanhaur = planmanhaur;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectStatus() {
		return projectStatus;
	}

	public void setProjectStatus(String projectStatus) {
		this.projectStatus = projectStatus;
	}

	public String getRDept() {
		return rDept;
	}

	public void setRDept(String dept) {
		rDept = dept;
	}

	public String getRtype() {
		return rtype;
	}

	public void setRtype(String rtype) {
		this.rtype = rtype;
	}

	public String getUrgent() {
		return urgent;
	}

	public void setUrgent(String urgent) {
		this.urgent = urgent;
	}

	public String getPresenter() {
		return presenter;
	}

	public void setPresenter(String presenter) {
		this.presenter = presenter;
	}
	
}
