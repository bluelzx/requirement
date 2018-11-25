package com.lanzx.rmmsys.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.Menu;
import com.lanzx.rmmsys.entity.User;
import com.lanzx.rmmsys.entity.UserMenu;
import com.lanzx.rmmsys.service.SysMenuService;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.SystemUtil;

@Controller
public class MenuController extends BaseController{
	
	private SysMenuService menuService;

	public SysMenuService getMenuService() {
		return menuService;
	}

	public void setMenuService(SysMenuService menuService) {
		this.menuService = menuService;
	}
	
	@RequestMapping(value="listAllSysMenu")
	@ResponseBody
	public ListVO listAllSysMenu(HttpServletRequest req){
		String text = req.getParameter("text");
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		if(StringUtils.isNotBlank(text)){
			likeCondition.put("text", text);
		}
		ListVO vo = new ListVO();
		vo.setRows(menuService.getSysMenu(likeCondition));
		vo.setTotal(menuService.getTotalSysMenu(likeCondition));
		return vo;
	}
	
	@RequestMapping(value="getAllMenuForUser")
	@ResponseBody
	public List<Menu> getAllMenuForUser(HttpServletRequest req){
		User user = SystemUtil.getLoginUser(req);
		if("admin".equals(user.getUserCode())){
			Map<String,Object> likeCondition = new HashMap<String, Object>();
			likeCondition.put("startRow", 0);
			likeCondition.put("endRow", Integer.MAX_VALUE);
			return menuService.getSysMenu(likeCondition);
		}
		else{
			return	menuService.getIndexSysMenu(user.getUserCode());
		}
	}
	
	@RequestMapping(value="disableByMenuCode")
	@ResponseBody
	public String disableByMenuCode(HttpServletRequest req){
		String menuCode = req.getParameter("menuCode");
		menuService.disableByMenuCode(menuCode);
		log(req, "删除菜单"+menuCode);
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="indexSysMenu")
	@ResponseBody
	public List<Menu> indexSysMenu(HttpServletRequest req){
		User user = SystemUtil.getLoginUser(req);
		if("admin".equals(user.getUserCode())){
			Map<String,Object> likeCondition = new HashMap<String, Object>();
			likeCondition.put("startRow", 0);
			likeCondition.put("endRow", Integer.MAX_VALUE);
			return menuService.getSysMenu(likeCondition);
		}else
			return	menuService.getIndexSysMenu(user.getUserCode());
	}
	
	@RequestMapping(value="toListSysMenu")
	public String toListUser(HttpServletRequest req){
		return "listMenu";
	}
	
	@RequestMapping(value="toAddMenu")
	public String toAddMenu(HttpServletRequest req){
		return "addMenu";
	}
	
	@RequestMapping(value="toModifyMenu")
	public String toModifyMenu(HttpServletRequest req){
		String menuCode = req.getParameter("menuCode");
		Menu menu = menuService.getMenuByCode(menuCode);
		req.setAttribute("menu", menu);
		return "toModifyMenu";
	}
	
	@RequestMapping(value="toAddMenuWin")
	public String toAddMenuWin(HttpServletRequest req){
		return "addMenuWin";
	}
	
	/**
	 * 动态新增菜单页面
	 * @param req
	 * @return
	 */
	@RequestMapping(value="toDyAddMenu")
	public String toDyAddMenu(HttpServletRequest req){
		return "toDyAddMenu";
	}
	
	/**
	 * 动态新增菜单
	 * @param req
	 * @return
	 */
	@RequestMapping(value="doSaveDyMenu")
	@ResponseBody
	public Menu doSaveDyMenu(HttpServletRequest req){
		return saveMenu(req);
	}
	
	private Menu saveMenu(HttpServletRequest req){
		String text = req.getParameter("text");
		String url = req.getParameter("url");
		String menuCode = req.getParameter("menuCode");
		String parentMenu = req.getParameter("parentMenu");
		String menuOrder = req.getParameter("menuOrder");
		String toUserIds = req.getParameter("toUserIds");
		
		Menu menu = new Menu();
		menu.setUrl(url);
		menu.setText(text);
		menu.setMenuCode(menuCode);
		menu.setParentMenu(parentMenu);
		menu.setMenuOrder(Integer.parseInt(menuOrder));
		menu.setCreater(SystemUtil.getLoginUser(req).getUserCode());
		
		menuService.insertSysMenu(menu);
		
		parentMenu = StringUtils.isBlank(parentMenu)?"@":parentMenu;
		if(StringUtils.isNotBlank(toUserIds)){
			String[] uIds = toUserIds.split(";");
//			List<UserMenu> userMenus = new ArrayList<UserMenu>();
			for(String id: uIds){
				UserMenu um = new UserMenu();
				um.setMenuCode(menuCode);
				um.setParentMenu(parentMenu);
				um.setUserCode(id);
				um.setMenuOrder(Integer.parseInt(menuOrder));
//				userMenus.add(um);
				menuService.insertSysUserMenu(um);
			}
			
		}
		log(req, "新增菜单:"+text);
		return menu;
	}
	
	@RequestMapping(value="saveSysMenu")
	public String saveSysMenu(HttpServletRequest req){
		saveMenu(req);
		
		return "redirect:toListSysMenu.do";
	}
	
	@RequestMapping(value="updateMenu")
	public String updateMenu(HttpServletRequest req){
		String text = req.getParameter("text");
		String url = req.getParameter("url");
		String menuCode = req.getParameter("menuCode");
		String parentMenu = req.getParameter("parentMenu");
		String menuOrder = req.getParameter("menuOrder");
		String toUserIds = req.getParameter("toUserIds");
		
		Menu menu = new Menu();
		menu.setUrl(url);
		menu.setText(text);
		menu.setMenuCode(menuCode);
		menu.setParentMenu(parentMenu);
		menu.setMenuOrder(Integer.parseInt(menuOrder));
		menu.setCreater("admin");
		
		menuService.updateMenu(menu);
		
		UserMenu userMenu = new UserMenu();
		userMenu.setMenuCode(menuCode);
		menuService.deleteSysUserMenu(userMenu);
		
		parentMenu = StringUtils.isBlank(parentMenu)?"@":parentMenu;
		if(StringUtils.isNotBlank(toUserIds)){
			String[] uIds = toUserIds.split(";");
//			List<UserMenu> userMenus = new ArrayList<UserMenu>();
			for(String id: uIds){
				UserMenu um = new UserMenu();
				um.setMenuCode(menuCode);
				um.setParentMenu(parentMenu);
				um.setUserCode(id);
				um.setMenuOrder(Integer.parseInt(menuOrder));
//				userMenus.add(um);
				menuService.insertSysUserMenu(um);
			}
			
		}
		log(req, "修改菜单:"+text);
		return "redirect:toListSysMenu.do";
	}
	
	@RequestMapping(value="getUCanSelectMenu")
	@ResponseBody
	public List<Menu> getUserCanSelectMenu(HttpServletRequest req){
		String userCode = req.getParameter("userCode");
		return menuService.getUserCanSelectMenu(userCode);
	}
	
	@RequestMapping(value="getUSelectedMenu")
	@ResponseBody
	public List<Menu> getUserSelectedMenu(HttpServletRequest req){
		String userCode = req.getParameter("userCode");
		List<Menu> menus = new ArrayList<Menu>();
		Menu root = new Menu();
		root.setMenuCode("0");
		root.setText("已分配菜单");
		menus.add(root);
		menus.addAll(menuService.getUserSelectedMenu(userCode))	;
		return menus;
	}
	
	@RequestMapping(value="checkMenuCode")
	@ResponseBody
	public String checkMenuCode(HttpServletRequest req){
		String menuCode = req.getParameter("menuCode");
		Menu menu = menuService.getMenuByCode(menuCode);
		if(menu!=null){
			return "true";
		}else{
			return "false";
		}
	}
}
