package com.lanzx.rmmsys.entity;

public class Menu {

	/** 菜单名称 */
	private String text;
	
	/** url */
	private String url;
	
	/** 菜单编号 */
	private String menuCode;
	
	/** 父菜单 */
	private String parentMenu;
	
	/** 菜单顺序号 */
	private Integer menuOrder;
	
	/** 创建者 */
	private String creater;
	
	private boolean isexpand;

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public Integer getMenuOrder() {
		return menuOrder;
	}

	public void setMenuOrder(Integer menuOrder) {
		this.menuOrder = menuOrder;
	}

	public String getParentMenu() {
		return parentMenu;
	}

	public void setParentMenu(String parentMenu) {
		this.parentMenu = parentMenu;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public boolean isIsexpand() {
		return isexpand;
	}

	public void setIsexpand(boolean isexpand) {
		this.isexpand = isexpand;
	}

	
	
}
