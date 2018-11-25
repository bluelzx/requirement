package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.dao.SysUserDao;
import com.lanzx.rmmsys.entity.User;
import com.lanzx.rmmsys.service.SysUserService;

public class SysUserServicImpl implements SysUserService {

	private SysUserDao userDao;
	
	public List<User> getSysUser(Map<String,Object> likeCondition) {
		return userDao.getSysUser(likeCondition);
	}
	public SysUserDao getUserDao() {
		return userDao;
	}
	public void setUserDao(SysUserDao userDao) {
		this.userDao = userDao;
	}
	public int getTotalSysUser(Map<String,Object> likeCondition) {
		return userDao.getTotalSysUser(likeCondition);
	}
	public void insertUser(User user) {
		userDao.insertSysUser(user);
	}
	
	public List<User> getAllUserForAddMenu() {
		return userDao.getAllUserForAddMenu();
	}
	
	public void disableByUserCode(String userCode) {
		userDao.disableByUserCode(userCode);
	}
	
	public User getUserByUserCode(String userCode) {
		return userDao.getUserByUserCode(userCode);
	}
	public void updateSysUser(User user) {
		userDao.updateSysUser(user);
	}
	public List<User> getUAddedMenu(String menuCode) {
		return userDao.getUAddedMenu(menuCode);
	}
	public List<User> getUCAddMenu(String menuCode) {
		return userDao.getUCAddMenu(menuCode);
	}
	public List<User> getReUsers(String requirementId) {
		return userDao.getReUsers(requirementId);
	}
	public void updateUserPass(User user) {
		userDao.updateUserPass(user);
	}
	public List<User> getSelectUsers() {
		return userDao.getSelectUsers();
	}
	public List<User> getSelectManagerUsers() {
		return userDao.getSelectManagerUsers();
	}
	public String getHoliday(String holiday_date) {
		return userDao.getHoliday(holiday_date);
	}
	public List<User> getUnCheckUser(Map<String, Object> likeCondition) {
		return userDao.getUnCheckUser(likeCondition);
	}

}
