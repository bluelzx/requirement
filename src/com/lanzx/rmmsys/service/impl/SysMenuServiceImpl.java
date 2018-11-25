package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.dao.SysMenuDao;
import com.lanzx.rmmsys.entity.Menu;
import com.lanzx.rmmsys.entity.UserMenu;
import com.lanzx.rmmsys.service.SysMenuService;

public class SysMenuServiceImpl implements SysMenuService {

	private SysMenuDao menuDao;
	public List<Menu> getSysMenu(Map<String, Object> likeCondition) {
		return menuDao.getSysMenu(likeCondition);
	}

	public int getTotalSysMenu(Map<String, Object> likeCondition) {
		return menuDao.getTotalSysMenu(likeCondition);
	}

	public void insertSysMenu(Menu menu) {
		menuDao.insertSysMenu(menu);
	}

	public SysMenuDao getMenuDao() {
		return menuDao;
	}

	public void setMenuDao(SysMenuDao menuDao) {
		this.menuDao = menuDao;
	}

	public List<Menu> getIndexSysMenu(String userCode) {
		return menuDao.getIndexSysMenu(userCode);
	}

	public void insertSysUserMenu(UserMenu userMenu) {
		menuDao.insertSysUserMenu(userMenu);
	}

	public void disableByMenuCode(String menuCode) {
		menuDao.disableByMenuCode(menuCode);
	}

	public List<Menu> getUserCanSelectMenu(String userCode) {
		return menuDao.getUserCanSelectMenu(userCode);
	}

	public List<Menu> getUserSelectedMenu(String userCode) {
		return menuDao.getUserSelectedMenu(userCode);
	}
	
	public void deleteSysUserMenu(UserMenu userMenu){
		menuDao.deleteSysUserMenu(userMenu);
	}

	public void updateMenu(Menu menu) {
		menuDao.updateMenu(menu);
	}

	public Menu getMenuByCode(String menuCode) {
		return menuDao.getMenuByCode(menuCode);
	}
}
