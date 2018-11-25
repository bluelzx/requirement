package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.entity.Menu;
import com.lanzx.rmmsys.entity.UserMenu;

public interface SysMenuService {

public void insertSysMenu(Menu menu);
	
	public int getTotalSysMenu(Map<String,Object> likeCondition);
	
	public List<Menu> getSysMenu(Map<String,Object> likeCondition);
	
	public List<Menu> getIndexSysMenu(String userCode);
	
	public void insertSysUserMenu(UserMenu userMenus);
	
	public void disableByMenuCode(String menuCode);
	
	public List<Menu> getUserSelectedMenu(String userCode);
	
	public List<Menu> getUserCanSelectMenu(String userCode);
	
	public void deleteSysUserMenu(UserMenu userMenu);
	
	public void updateMenu(Menu menu);
	
	public Menu getMenuByCode(String menuCode);
}
