package com.lanzx.rmmsys.view;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lanzx.rmmsys.encoder.Md5PasswordEncoderImpl;
import com.lanzx.rmmsys.entity.User;
import com.lanzx.rmmsys.service.SysUserService;

@Controller
public class LoginController extends BaseController{

	private static final Log log = LogFactory.getLog(LoginController.class);
	
	private SysUserService userService;
	
	public static void main(String[] str){
		
	}
	
	@RequestMapping(value="toLogin")
	public String toLogin(HttpServletRequest req){
		HttpSession session = req.getSession();
		User suser= (User)session.getAttribute("userInfo");
		if(suser!=null){
			return "redirect:toIndexPage.do";
		}
		return "login";
	}
	
	@RequestMapping(value="doLogin")
	public String doLogin(HttpServletRequest req){
		String userCode = req.getParameter("userCode");
		String password = req.getParameter("password");
		HttpSession session = req.getSession();
		if(StringUtils.isNotBlank(userCode)
				&&StringUtils.isNotBlank(password)){
			User user = userService.getUserByUserCode(userCode);
			if(user!=null){
				Md5PasswordEncoderImpl md5 = new Md5PasswordEncoderImpl();
				String myPass = user.getPassword();
				
				if(md5.encode(password).equals(myPass)){
					session.removeAttribute("loginFail");
					User suser= (User)session.getAttribute("userInfo");
					session.setAttribute("userInfo", user);
					log(req, "登陆成功");
				}else{//密码不对
					session.removeAttribute("userInfo");
					session.removeAttribute("loginFail");
					session.setAttribute("loginFail","亲,用户密码不对!");
					session.setAttribute("userCode",userCode);
					log(req, "", "", userCode, "输入密码不对");
					return "login";
				}
			}else{//用户不存在
				session.removeAttribute("loginFail");
				session.setAttribute("loginFail","亲,"+userCode+"不存在!");
				return "login";
			}
		}
		return "redirect:toIndexPage.do";
	}
	
	@RequestMapping(value="logonOut")
	public String logonOut(HttpServletRequest req){
		HttpSession session = req.getSession();
		User suser= (User)session.getAttribute("userInfo");
		if(suser!=null){
			session.removeAttribute("userInfo");
			log(req, "", "", suser.getUserCode(), "退出成功");
		}
		return "login";
	}

	public SysUserService getUserService() {
		return userService;
	}

	public void setUserService(SysUserService userService) {
		this.userService = userService;
	}
}
