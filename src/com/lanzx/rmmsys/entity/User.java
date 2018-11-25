package com.lanzx.rmmsys.entity;

public class User {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	/** 用户代码 */
	private String userCode;
	
	/** 用户名称 */
	private String userName;
	
	/** 用户密码 */
	private String password;
	
	/** 用户创建时间 */
	private String createTime;
	
	/** 用户创建者 */
	private String creater;
	
	/** 
	 * 用户类型：
	 * 0为admin
	 * 1为项目管理人员,
	 * 2为开发人员,
	 * 3为测试人员 
	 * */
	private Integer userType;
	
	/**
	 * 归属团队
	 * 1本行
	 * 2外包
	 * 3项目
	 */
	private Integer myTeam;
	
	
	/** 用户状态:
	 * 1为有效
	 * 0为无效 
	 *  */
	private Integer userStatus;
	
	/** rtx 帐号 */
	private String rtxCode;

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}


	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}
	
	public User(){
		
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public Integer getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(Integer userStatus) {
		this.userStatus = userStatus;
	}

	public Integer getMyTeam() {
		return myTeam;
	}

	public void setMyTeam(Integer myTeam) {
		this.myTeam = myTeam;
	}

	public String getRtxCode() {
		return rtxCode;
	}

	public void setRtxCode(String rtxCode) {
		this.rtxCode = rtxCode;
	}

}
