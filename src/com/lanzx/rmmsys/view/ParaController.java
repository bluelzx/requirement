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
import com.lanzx.rmmsys.entity.Parameter;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.SystemUtil;

@Controller
public class ParaController extends BaseController{

	
	@RequestMapping(value="toListPara")
	public String toListPara(HttpServletRequest req){
		return "toListPara";
	}
	
	@RequestMapping(value="listAllPara")
	@ResponseBody
	public ListVO listAllPara(HttpServletRequest req){
		String paraType = req.getParameter("paraType");
		String paraCode = req.getParameter("paraCode");
		
		ListVO vo = new ListVO();
		Integer pageNum = Integer.parseInt(req.getParameter("page"));
		Integer pageSize = Integer.parseInt(req.getParameter("pagesize"));
		int startRow = (pageNum ==1)?1:((pageNum-1)*pageSize+1);
		int endRow = (pageNum ==1)?pageSize+1:(startRow+pageSize);
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", startRow);
		likeCondition.put("endRow", endRow);
		if(StringUtils.isNotBlank(paraType))
		likeCondition.put("paraType", paraType);
		if(StringUtils.isNotBlank(paraCode))
		likeCondition.put("paraCode", paraCode);
		
		vo.setRows(paraService.getParas(likeCondition));
		vo.setTotal(paraService.getTotalPara(likeCondition));
		return vo;
	}
	
	@RequestMapping(value="checkParaExist")
	@ResponseBody
	public String checkParaExist(HttpServletRequest req){
		String paraType = req.getParameter("paraType");
		String paraCode = req.getParameter("paraCode");
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(paraType))
			likeCondition.put("paraType", paraType);
		if(StringUtils.isNotBlank(paraCode))
			likeCondition.put("paraCode", paraCode);
		int total = paraService.getTotalPara(likeCondition);
		return total==0?"true":"false";
	}
	
	@RequestMapping(value="toAddPara")
	public String toAddPara(HttpServletRequest req){
		return "toAddPara";
	}
	
	@RequestMapping(value="doAddPara")
	public String doAddPara(HttpServletRequest req){
		String paraType = req.getParameter("paraType");
		String paraCode = req.getParameter("paraCode");
		String paraValue = req.getParameter("paraValue");
		String paraRemark = req.getParameter("paraRemark");
		
		Parameter para = new Parameter();
		para.setParaType(paraType);
		para.setParaCode(paraCode);
		para.setParaValue(paraValue);
		para.setParaRemark(paraRemark);
		
		paraService.insertPara(para);
		
		//更新缓存中的数据
		SystemUtil.putPara(para);
		
		log(req, "新增参数:paraType="+paraType+",paraCode="+paraCode);
		
		
		return "redirect:toListPara.do";
	}
	
	/**
	 * 从缓存中取
	 * @param req
	 * @return
	 */
	@RequestMapping(value="getAllParas")
	@ResponseBody
	public List<Parameter> getAllParas(HttpServletRequest req){
		String paraType = req.getParameter("paraType");
//		Map<String,Object> likeCondition = new HashMap<String, Object>();
//		likeCondition.put("startRow", 1);
//		likeCondition.put("endRow", Integer.MAX_VALUE);
//		likeCondition.put("paraType", paraType);
//		List<Parameter> paras = paraService.getParas(likeCondition);
		return SystemUtil.getParasByType(paraType);
	}
	
	@RequestMapping(value="toUpdatePara")
	public String toUpdatePara(HttpServletRequest req){
		String paraType = req.getParameter("paraType");
		String paraCode = req.getParameter("paraCode");
		Parameter pa = new Parameter();
		pa.setParaCode(paraCode);
		pa.setParaType(paraType);
		Parameter para = paraService.getParaByTypeAndCode(pa);
		req.setAttribute("para", para);
		return "toUpdatePara";
	}
	
	@RequestMapping(value="doUpdatePara")
	public String doUpdatePara(HttpServletRequest req){
		String paraType = req.getParameter("paraType");
		String paraCode = req.getParameter("paraCode");
		String paraValue = req.getParameter("paraValue");
		String paraRemark = req.getParameter("paraRemark");
		
		Parameter para = new Parameter();
		para.setParaType(paraType);
		para.setParaCode(paraCode);
		para.setParaValue(paraValue);
		para.setParaRemark(paraRemark);
		
		paraService.updatePara(para);
		
		//更新缓存中的数据
		List<Parameter> paras = SystemUtil.getParasByType(paraType);
		for(Parameter pa:paras){
			if(pa.getParaType().equals(paraType)&&pa.getParaCode().equals(paraCode)){
				pa.setParaValue(paraValue);
				pa.setParaRemark(paraRemark);
				break;
			}
		}
		
		log(req, "修改参数:paraType="+paraType+",paraCode="+paraCode);
		
		return "redirect:toListPara.do";
	}
	
	@RequestMapping(value="doDeletePara")
	@ResponseBody
	public String doDeletePara(HttpServletRequest req){
		String paraType = req.getParameter("paraType");
		String paraCode = req.getParameter("paraCode");
		Parameter para = new Parameter();
		para.setParaType(paraType);
		para.setParaCode(paraCode);
		paraService.deletePara(para);
		
		//更新缓存中的数据
		List<Parameter> paras = SystemUtil.getParasByType(paraType);
		for(Parameter pa:paras){
			if(pa.getParaType().equals(paraType)&&pa.getParaCode().equals(paraCode)){
				paras.remove(pa);
				break;
			}
		}
		log(req, "删除参数:paraType="+paraType+",paraCode="+paraCode);
		
		return Constants.RESULT_SUCCESS;
	}
}
