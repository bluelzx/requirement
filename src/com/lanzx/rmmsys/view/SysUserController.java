package com.lanzx.rmmsys.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lanzx.rmmsys.encoder.Md5PasswordEncoderImpl;
import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.User;
import com.lanzx.rmmsys.entity.UserMenu;
import com.lanzx.rmmsys.service.SysMenuService;
import com.lanzx.rmmsys.service.SysUserService;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.SystemUtil;

@Controller
public class SysUserController extends BaseController{

	private SysUserService userService;
	
	private SysMenuService menuService;
	
	@RequestMapping(value="listAllSysUser")
	@ResponseBody
	public ListVO listAllUser(HttpServletRequest req){
		String userName = req.getParameter("userName");
		String userCode = req.getParameter("userCode");
		String userType = req.getParameter("userType");
		String myTeam = req.getParameter("myTeam");
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		if(StringUtils.isNotBlank(userName)){
			likeCondition.put("userName", userName);
		}
		if(StringUtils.isNotBlank(userCode)){
			likeCondition.put("userCode", userCode);
		}
		if(StringUtils.isNotBlank(userType)){
			likeCondition.put("userType", userType);
		}
		if(StringUtils.isNotBlank(myTeam)){
			likeCondition.put("myTeam", myTeam);
		}
		List<User> users = userService.getSysUser(likeCondition);
		int total = userService.getTotalSysUser(likeCondition);
		ListVO vo = new ListVO();
		vo.setRows(users);
		vo.setTotal(total);
		return vo;
	}
	
	@RequestMapping(value="selectUserWin")
	public String selectUserWin(HttpServletRequest req){
		return "selectUserWin";
	}
	
	@RequestMapping(value="disableByUserCode")
	@ResponseBody
	public String disableByUserCode(HttpServletRequest req){
		String userCode = req.getParameter("userCode");
		userService.disableByUserCode(userCode);
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="getSelectUsers")
	@ResponseBody
	public List<User> getSelectUsers(HttpServletRequest req){
		return userService.getSelectUsers();
	}
	
	@RequestMapping(value="getSelectManagerUsers")
	@ResponseBody
	public List<User> getSelectManagerUsers(HttpServletRequest req){
		return userService.getSelectManagerUsers();
	}
	
	@RequestMapping(value="getUCAddMenu")
	@ResponseBody
	public List<User>  getUCAddMenu(HttpServletRequest req){
		String menuCode = req.getParameter("menuCode");
		return userService.getUCAddMenu(menuCode);
	}
	
	@RequestMapping(value="getUAddedMenu")
	@ResponseBody
	public List<User>  getUAddedMenu(HttpServletRequest req){
		String menuCode = req.getParameter("menuCode");
		return userService.getUAddedMenu(menuCode);
	}
	
	@RequestMapping(value="getAllUserForAddMenu")
	@ResponseBody
	public List<User> getAllUserForAddMenu(){
		return userService.getAllUserForAddMenu();
	}
	
	@RequestMapping(value="toSaveUser")
	public String toSaveUser(HttpServletRequest req){
		return "add";
	}
	
	@RequestMapping(value="saveSysUser")
	public String saveUser(HttpServletRequest req){
		String userName = req.getParameter("userName");
		String userCode = req.getParameter("userCode");
		String userType = req.getParameter("userType");
		String myTeam = req.getParameter("myTeam");
		Md5PasswordEncoderImpl md5 = new Md5PasswordEncoderImpl();
		String password = md5.encode(Constants.DEFAUL_PASSWORD);
		String userMenus = req.getParameter("userMenus");
		User user = new User();
		if(StringUtils.isNotBlank(userName)){
			user.setUserName(userName);
		}
		if(StringUtils.isNotBlank(userCode)){
			user.setUserCode(userCode);
		}
		if(StringUtils.isNotBlank(password)){
			user.setPassword(password);
		}
		if(StringUtils.isNotBlank(userType)){
			user.setUserType(Integer.parseInt(userType));
		}
		if(StringUtils.isNotBlank(myTeam)){
			user.setMyTeam(Integer.parseInt(myTeam));
		}
		user.setCreater(SystemUtil.getLoginUser(req).getUserCode());
		userService.insertUser(user);
		if(StringUtils.isNotBlank(userMenus)){
			userMenus = userMenus.substring(0,userMenus.length()-1);
			String[] menus = userMenus.split(";");
			for(String menu :menus){
				String[] mm = menu.split(":");
				UserMenu um = new UserMenu();
				um.setMenuCode(mm[0]);
				um.setParentMenu(mm[1]);
				um.setUserCode(userCode);
				um.setMenuOrder(Integer.parseInt(mm[2]));
				menuService.insertSysUserMenu(um);
			}
		}
		log(req, "新增用户："+userCode);
		return "redirect:toListUser.do";
	}
	
	@RequestMapping(value="updateSysUser")
	public String updateUser(HttpServletRequest req){
		String userName = req.getParameter("userName");
		String userCode = req.getParameter("userCode");
		String userType = req.getParameter("userType");
		String myTeam = req.getParameter("myTeam");
		String password = req.getParameter("password");
		String userMenus = req.getParameter("userMenus");
		User user = new User();
		if(StringUtils.isNotBlank(userName)){
			user.setUserName(userName);
		}
		if(StringUtils.isNotBlank(userCode)){
			user.setUserCode(userCode);
		}
		if(StringUtils.isNotBlank(password)){
			Md5PasswordEncoderImpl md5 = new Md5PasswordEncoderImpl();
			user.setPassword(md5.encode(password));
		}
		if(StringUtils.isNotBlank(userType)){
			user.setUserType(Integer.parseInt(userType));
		}
		if(StringUtils.isNotBlank(myTeam)){
			user.setMyTeam(Integer.parseInt(myTeam));
		}
		
		userService.updateSysUser(user);
		
		UserMenu userMenu = new UserMenu();
		userMenu.setUserCode(userCode);
		menuService.deleteSysUserMenu(userMenu);
		
		if(StringUtils.isNotBlank(userMenus)){
			userMenus = userMenus.substring(0,userMenus.length()-1);
			String[] menus = userMenus.split(";");
			for(String menu :menus){
				String[] mm = menu.split(":");
				UserMenu um = new UserMenu();
				um.setMenuCode(mm[0]);
				um.setParentMenu(mm[1]);
				um.setUserCode(userCode);
				um.setMenuOrder(Integer.parseInt(mm[2]));
				menuService.insertSysUserMenu(um);
			}
		}
		log(req, "修改用户："+userCode);
		return "redirect:toListUser.do";
	}
	
	@RequestMapping(value="toListUser")
	public String toListUser(HttpServletRequest req){
		return "list";
	}
	
	@RequestMapping(value="toModifyUser")
	public String toModifyUser(HttpServletRequest req){
		String userCode = req.getParameter("userCode");
		User user = userService.getUserByUserCode(userCode);
		req.setAttribute("user", user);
		return "toModifyUser";
	}
	
	@RequestMapping(value="toListReUser")
	public String toListReUser(HttpServletRequest req){
		String requirementId  = req.getParameter("requirementId");
		if(StringUtils.isNotBlank(requirementId)){
			req.setAttribute("requirementId", requirementId);
			return "toListReUser";
		}
		return null;
	}
	
	@RequestMapping(value="listReUser")
	@ResponseBody
	public ListVO listReUser(HttpServletRequest req){
		String requirementId  = req.getParameter("requirementId");
		if(StringUtils.isNotBlank(requirementId)){
			List<User> users = userService.getReUsers(requirementId);
			ListVO vo = new ListVO();
			vo.setRows(users);
			vo.setTotal(users.size());
			return vo;
		}
		return null;
	}
	
	@RequestMapping(value="checkUserCode")
	@ResponseBody
	public String checkUserCode(HttpServletRequest req){
		String userCode = req.getParameter("userCode");
		User user = userService.getUserByUserCode(userCode);
		if(user!=null){
			return "true";
		}else{
			return "false";
		}
	}
	
	@RequestMapping(value="modifyUserPass")
	@ResponseBody
	public String modifyUserPass(HttpServletRequest req){
		String userCode = req.getParameter("userCode");
		String password = req.getParameter("password");
		User user = new User();
		Md5PasswordEncoderImpl md5 = new Md5PasswordEncoderImpl();
		user.setUserCode(userCode);
		user.setPassword(md5.encode(password));
		userService.updateUserPass(user);
		
		User user1 = SystemUtil.getLoginUser(req);
		user1.setPassword(md5.encode(password));
		req.getSession().setAttribute("userInfo", user1);
		
		log(req, "修改密码");
		
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="toModifyUserPass")
	public String toModifyUserPass(HttpServletRequest req){
		User user = SystemUtil.getLoginUser(req);
		req.setAttribute("userCode", user.getUserCode());
		req.setAttribute("oldPass", user.getPassword());
		return "toModifyUserPass";
	}
	
	
	public SysUserService getUserService() {
		return userService;
	}
	public void setUserService(SysUserService userService) {
		this.userService = userService;
	}

	public SysMenuService getMenuService() {
		return menuService;
	}

	public void setMenuService(SysMenuService menuService) {
		this.menuService = menuService;
	}
}
