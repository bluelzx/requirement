package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.entity.User;

public interface SysUserService {

	public List<User> getSysUser(Map<String,Object> likeCondition);
	
	public List<User> getUnCheckUser(Map<String,Object> likeCondition);
	
	public int getTotalSysUser(Map<String,Object> likeCondition);
	
	public void insertUser(User user);
	
	public List<User> getAllUserForAddMenu();
	
	public void  disableByUserCode(String userCode);
	
	public User getUserByUserCode(String userCode);
	
	public void  updateSysUser(User user);
	
	public List<User>  getUCAddMenu(String menuCode);
	
	public List<User>  getUAddedMenu(String menuCode);
	
	public List<User> getReUsers(String requirementId);
	
	public void updateUserPass(User user);
	
	public List<User> getSelectUsers();
	
	public List<User> getSelectManagerUsers();
	
	public String getHoliday(String holiday_date);
}
