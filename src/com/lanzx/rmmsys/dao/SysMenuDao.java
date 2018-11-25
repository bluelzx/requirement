package com.lanzx.rmmsys.dao;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.Menu;
import com.lanzx.rmmsys.entity.UserMenu;

@Mapper("sysMenuDao")
public interface SysMenuDao {

	public void insertSysMenu(Menu menu);
	
	public int getTotalSysMenu(Map<String,Object> likeCondition);
	
	public List<Menu> getSysMenu(Map<String,Object> likeCondition);
	
	
	public List<Menu> getIndexSysMenu(@Param(value="userCode") String userCode);
	
	public void insertSysUserMenu(UserMenu userMenu) ;
	
	public void disableByMenuCode(String menuCode);
	
	public List<Menu> getUserSelectedMenu(String userCode);
	
	public List<Menu> getUserCanSelectMenu(String userCode);
	
	public void deleteSysUserMenu(UserMenu userMenu);
	
	public void updateMenu(Menu menu);
	
	public Menu getMenuByCode(String menuCode);
	
}
