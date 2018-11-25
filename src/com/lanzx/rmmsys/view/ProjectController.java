package com.lanzx.rmmsys.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.Project;
import com.lanzx.rmmsys.service.ProjectService;
import com.lanzx.rmmsys.utils.Constants;

@Controller
public class ProjectController extends BaseController{

	private ProjectService projectService;

	public ProjectService getProjectService() {
		return projectService;
	}

	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	
	@RequestMapping(value="getAllProjects")
	@ResponseBody
	public List<Project> getAllProjects(HttpServletRequest req){
		int startRow = 0;
		int endRow = Integer.MAX_VALUE;
		
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		List<Project> projects = projectService.getProjectList(likeCondition);
		return projects;
	}
	
	@RequestMapping(value="toListProject")
	public String toListProject(HttpServletRequest req){
		return "toListProject";
	}
	
	@RequestMapping(value="toAddProject")
	public String toAddProject(HttpServletRequest req){
		return "toAddProject";
	}
	
	@RequestMapping(value="doAddProject")
	public String doAddProject(HttpServletRequest req){
		String projectCode = req.getParameter("projectCode");
		String projectName = req.getParameter("projectName");
		
		Project project = new Project();
		project.setProjectCode(projectCode);
		project.setProjectName(projectName);
		
		projectService.insertProject(project);
		
		return "redirect:toListProject.do";
	}
	
	@RequestMapping(value="listAllProject")
	@ResponseBody
	public ListVO listAllProject(HttpServletRequest req){
		String projectCode = req.getParameter("projectCode");
		String projectName = req.getParameter("projectName");
		String page = req.getParameter("page");
		String pagesize = req.getParameter("pagesize");
		if(StringUtils.isBlank(page)){
			page= "1";
		}
		if(StringUtils.isBlank(pagesize)){
			pagesize = "10";
		}
		Integer pageNum = Integer.parseInt(page);
		Integer pageSize = Integer.parseInt(pagesize);
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		if(StringUtils.isNotBlank(projectCode)){
			likeCondition.put("projectCode", projectCode);
		}
		if(StringUtils.isNotBlank(projectName)){
			likeCondition.put("projectName", projectName);
		}
		List<Project> rows = projectService.getProjectList(likeCondition);
		int total = projectService.getTotalProject(likeCondition);
		ListVO listVo = new ListVO();
		listVo.setRows(rows);
		listVo.setTotal(total);
		return listVo;
	}
	
	@RequestMapping(value="deleteProject")
	@ResponseBody
	public String deleteProject(HttpServletRequest req){
		String projectCode = req.getParameter("projectCode");
		if(StringUtils.isNotBlank(projectCode)){
			projectService.deleteProject(projectCode);
		}
		return Constants.RESULT_SUCCESS;
	}
	
	@RequestMapping(value="toUpdateProject")
	public String toUpdateProject(HttpServletRequest req){
		String projectCode = req.getParameter("projectCode");
		if(StringUtils.isNotBlank(projectCode)){
			Project project = projectService.getProjectByCode(projectCode);
			req.setAttribute("project",project);
		}
		return "toUpdateProject";
	}
	
	@RequestMapping(value="doUpdateProject")
	public String doUpdateProject(HttpServletRequest req){
		String projectCode = req.getParameter("projectCode");
		String projectName = req.getParameter("projectName");
		Project project = new Project();
		project.setProjectCode(projectCode);
		project.setProjectName(projectName);
		projectService.updateProject(project);
		return "redirect:toListProject.do";
	}
}
