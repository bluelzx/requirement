package com.lanzx.rmmsys.entity;

/**
 * 项目送测清单
 * @author lanzx
 *
 */
public class RequirementTestApply {

	/** 清单编号 */
	private String applyCode;
	/** 版本号 */
	private String applyVersion;
	/** 需求编号 */
	private String requirementId;
	/** 需求编号 */
	private String requirementCode;
	private String requirementName;
	/** 项目名称 */
	private String applyName;
	/** 技术负责人 */
	private String devPrincipal;
	/** 自测报告 */
	private String reportSelf;
	/** 送测时间 */
	private String applyTime;
	/** 测试部门 */
	private String applyDept;
	/** 完成时间 */
	private String applyFinishTime;
	/** 测试指引 */
	private String howToTest;
	/** 其他说明 */
	private String info;
	/** 测试人 */
	private String conner;
	/** 授权人 */
	private String charge;
	/** 创建时间 */
	private String createTime;
	/** 创建者 */
	private String creator;
	/** 状态:1待送测2已送测3测试完成4待上线5上线完成 */
	private Integer status;
	/** 上线日期 */
	private String onLineDate;
	
	public String getApplyCode() {
		return applyCode;
	}
	public void setApplyCode(String applyCode) {
		this.applyCode = applyCode;
	}
	public String getApplyDept() {
		return applyDept;
	}
	public void setApplyDept(String applyDept) {
		this.applyDept = applyDept;
	}
	public String getApplyFinishTime() {
		return applyFinishTime;
	}
	public void setApplyFinishTime(String applyFinishTime) {
		this.applyFinishTime = applyFinishTime;
	}
	public String getApplyTime() {
		return applyTime;
	}
	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}
	public String getApplyVersion() {
		return applyVersion;
	}
	public void setApplyVersion(String applyVersion) {
		this.applyVersion = applyVersion;
	}
	public String getCharge() {
		return charge;
	}
	public void setCharge(String charge) {
		this.charge = charge;
	}
	public String getDevPrincipal() {
		return devPrincipal;
	}
	public void setDevPrincipal(String devPrincipal) {
		this.devPrincipal = devPrincipal;
	}
	public String getHowToTest() {
		return howToTest;
	}
	public void setHowToTest(String howToTest) {
		this.howToTest = howToTest;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getReportSelf() {
		return reportSelf;
	}
	public void setReportSelf(String reportSelf) {
		this.reportSelf = reportSelf;
	}
	public String getRequirementId() {
		return requirementId;
	}
	public void setRequirementId(String requirementId) {
		this.requirementId = requirementId;
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
	public String getRequirementCode() {
		return requirementCode;
	}
	public void setRequirementCode(String requirementCode) {
		this.requirementCode = requirementCode;
	}
	public String getConner() {
		return conner;
	}
	public void setConner(String conner) {
		this.conner = conner;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getApplyName() {
		return applyName;
	}
	public void setApplyName(String applyName) {
		this.applyName = applyName;
	}
	public String getRequirementName() {
		return requirementName;
	}
	public void setRequirementName(String requirementName) {
		this.requirementName = requirementName;
	}
	public String getOnLineDate() {
		return onLineDate;
	}
	public void setOnLineDate(String onLineDate) {
		this.onLineDate = onLineDate;
	}
}
