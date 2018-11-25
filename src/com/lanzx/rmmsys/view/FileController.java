package com.lanzx.rmmsys.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lanzx.rmmsys.entity.ListVO;
import com.lanzx.rmmsys.entity.Log;
import com.lanzx.rmmsys.entity.UploadFile;
import com.lanzx.rmmsys.entity.User;
import com.lanzx.rmmsys.service.FileService;
import com.lanzx.rmmsys.utils.Constants;
import com.lanzx.rmmsys.utils.DateUtil;
import com.lanzx.rmmsys.utils.LogMonitor;
import com.lanzx.rmmsys.utils.SystemUtil;

@Controller
public class FileController  extends BaseController{

	private FileService fileService;
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {

	}

	@RequestMapping(value="toListFile")
	public String toListFile(HttpServletRequest req){
		String requirementCode = req.getParameter("requirementCode");
		if(StringUtils.isNotBlank(requirementCode)){
			req.setAttribute("requirementCode", requirementCode);
		}
		return "toListFile";
	}
	
	@RequestMapping(value="toListReFile")
	public String toListReFile(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		if(StringUtils.isNotBlank(requirementId)){
			req.setAttribute("requirementId", requirementId);
			
			Log log = new Log();
			log.setLogCode(DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14));
			log.setLogTime(DateUtil.getCurrentDate(Constants.DATA_FORMATE_1));
			String userCode = SystemUtil.getLoginUser(req).getUserCode();
			log.setLogCreator(userCode);
			log.setLogText("用户"+userCode+"查看文件下载");
			LogMonitor.getInstance().receive(log);
			
			return "toListReFile";
		}
		return null;
	}

	@RequestMapping(value="listAllFile")
	@ResponseBody
	public ListVO listAllFile(HttpServletRequest req){
		
		String requirementId = req.getParameter("requirementId");
		String userCode = req.getParameter("userCode");
		String fileName = req.getParameter("fileName");
		
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
		if(StringUtils.isNotBlank(requirementId)){
			likeCondition.put("requirementId", requirementId);
		}
		if(StringUtils.isNotBlank(userCode)){
			likeCondition.put("userCode", userCode);
		}
		if(StringUtils.isNotBlank(fileName)){
			likeCondition.put("fileName", fileName);
		}
		
		List<UploadFile> rows = fileService.getFileList(likeCondition);
		int total = fileService.getTotalFile(likeCondition);
		ListVO listVo = new ListVO();
		listVo.setRows(rows);
		listVo.setTotal(total);
		return listVo;
	}
	
	@RequestMapping(value="toSmartUpoadFile")
	public String toSmartUpoadFile(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		req.setAttribute("requirementId", requirementId);
		return "toSmartUpoadFile";
	}

	
	@RequestMapping(value="toUpoadFile")
	public String toUpoadFile(HttpServletRequest req){
		String requirementId = req.getParameter("requirementId");
		req.setAttribute("requirementId", requirementId);
		return "toUpoadFile";
	}

	@RequestMapping(value="doUpoadFile")
	public String doUploadFile(HttpServletRequest req){
		
		String requirementId = req.getParameter("requirementId");
		String savePath = SystemUtil.getFileSavePath(req) ;
		if(StringUtils.isNotBlank(requirementId)){
			savePath = savePath+requirementId+"/";
			File rFile = new File(savePath);
			if(!rFile.exists())
				rFile.mkdirs();
		}
		MultipartHttpServletRequest mReq = (MultipartHttpServletRequest) req;
		User user = SystemUtil.getLoginUser(req);
		Map<String, MultipartFile>  files =  mReq.getFileMap();
		for(Entry<String, MultipartFile> file: files.entrySet()){
			MultipartFile fileItem = file.getValue();
			String originalName = fileItem.getOriginalFilename();
			long fileSize = fileItem.getSize();
			String type = fileItem.getContentType();
			String fileCode = DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14);
			try {
				fileItem.transferTo(new File(savePath+originalName));
				UploadFile uFile = new UploadFile();
				uFile.setFileCode(fileCode);
				uFile.setFileName(originalName);
				uFile.setRequirementId(requirementId);
				uFile.setFileSize(fileSize);
				uFile.setFileType(type);
				uFile.setFilePath(savePath+originalName);
				uFile.setUploadTime(DateUtil.getCurrentDate(Constants.DATA_FORMATE_1));
				
				uFile.setUserCode(user==null?"admin":user.getUserCode());
				fileService.insertFile(uFile);
				
				log(req, requirementId,"上传文件"+originalName+"成功");
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		
		
		boolean fromRtee = Boolean.parseBoolean(req.getParameter("fromRtree"));
		if(fromRtee){
			return "redirect:toListReFile.do?requirementId="+requirementId;
		}else{
			return "redirect:toListFile.do";
		}
	}
	
	@RequestMapping(value="doTmpUploadFile")
	public void doTmpUploadFile(HttpServletRequest req,HttpServletResponse response){
		UploadFile uFile = null;
		String requirementId = "tmp";
		String savePath = SystemUtil.getFileSavePath(req) ;
		if(StringUtils.isNotBlank(requirementId)){
			savePath = savePath+requirementId+"/";
			File rFile = new File(savePath);
			if(!rFile.exists())
				rFile.mkdirs();
		}
		MultipartHttpServletRequest mReq = (MultipartHttpServletRequest) req;
		User user = SystemUtil.getLoginUser(req);
		Map<String, MultipartFile>  files =  mReq.getFileMap();
		for(Entry<String, MultipartFile> file: files.entrySet()){
			MultipartFile fileItem = file.getValue();
			String originalName = fileItem.getOriginalFilename();
			long fileSize = fileItem.getSize();
			String type = fileItem.getContentType();
			String fileCode = DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14);
			savePath = savePath+fileCode;
			try {
				fileItem.transferTo(new File(savePath));
				uFile = new UploadFile();
				uFile.setFileCode(fileCode);
				uFile.setFileName(originalName);
				uFile.setRequirementId(requirementId);
				uFile.setFileSize(fileSize);
				uFile.setFileType(type);
				uFile.setFilePath(savePath);//防止同时上传文件名相同
				uFile.setUploadTime(DateUtil.getCurrentDate(Constants.DATA_FORMATE_1));
				
				uFile.setUserCode(user==null?"admin":user.getUserCode());
				fileService.insertFile(uFile);
				
				
//				ObjectMapper mapper = new ObjectMapper();
//				mapper.writeValue(response.getWriter(),fileCode);
				response.getWriter().write(fileCode);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	@RequestMapping(value="doSmartUpload")
	public String doSmartUpload(HttpServletRequest req){
		String requirementCode = req.getParameter("requirementId");
		String savePath = SystemUtil.getFileSavePath(req) ;
		if(StringUtils.isNotBlank(requirementCode)){
			savePath = savePath+requirementCode+"/";
			File rFile = new File(savePath);
			if(!rFile.exists())
				rFile.mkdirs();
		}
//		把临时上传文件复制到当前需求的文件夹下
		String uploadFiles =  req.getParameter("allFiles");
		String basePath = SystemUtil.getFileSavePath(req);
		if(StringUtils.isNotBlank(uploadFiles)){
			for(String fileCode:uploadFiles.split(",")){
				UploadFile uFile = fileService.getFileByCode(fileCode);
				File fileFrom = new File(uFile.getFilePath());
				File fileTo = new File(basePath+requirementCode+"/"+uFile.getFileName());
				fileFrom.renameTo(fileTo);
				uFile.setRequirementId(requirementCode);
				uFile.setFilePath(basePath+requirementCode+"/"+uFile.getFileName());
				fileService.updateTmpFile(uFile);
				log(req, requirementCode,"上传文件"+uFile.getFileName()+"成功");
			}
		}
		
		return "redirect:toListFile.do";
	}
	
	@RequestMapping(value="downLoadFile")
	public void downLoadFile(HttpServletRequest req,HttpServletResponse response){
		User user = SystemUtil.getLoginUser(req);
		 String fileCode = req.getParameter("fileCode");
		 if(StringUtils.isNotBlank(fileCode)){
			 UploadFile file = fileService.getFileByCode(fileCode);
			 String fileName = file.getFileName();
			 fileName =SystemUtil.getName(fileName);
			 String filePath = file.getFilePath();
			 String type = file.getFileType();
			 response.reset();
			  response.setContentType(type);
		        response.setHeader("Content-disposition", (new StringBuilder()).append("attachment; filename=\"").append(fileName).append("\"").toString());
		        byte b[] = new byte[response.getBufferSize()];
		       
		        File file1 = new File(filePath);
		        InputStream in = null;
		        try
		        {
		        	OutputStream outStream = response.getOutputStream();
		            in = new FileInputStream(file1);
		            for(int length = -1; (length = in.read(b)) != -1;)
			            outStream.write(b, 0, length);

			        outStream.flush();
			        in.close();
			        outStream.close();
			        
					log(req, "下载文件"+fileName+"成功");
		        }
		        catch(Exception e)
		        {
		            e.printStackTrace();
		        }
		       
		 }
	}
	
	@RequestMapping(value="deleteFile")
	@ResponseBody
	public String deleteFile(HttpServletRequest req){
		String fileCode = req.getParameter("fileCode");
		if(StringUtils.isNotBlank(fileCode)){
			UploadFile file = fileService.getFileByCode(fileCode);
			String savePath = SystemUtil.getFileSavePath(req) ;
			File deleteFile = new File(savePath+file.getRequirementId()+"/"+file.getFileName());
			if(deleteFile.exists()){
				deleteFile.delete();
			}
			fileService.deleteFile(fileCode);
			
			log(req, "删除文件"+file.getFileName()+"成功");
		}
		return Constants.RESULT_SUCCESS;
	}
	
	public FileService getFileService() {
		return fileService;
	}


	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}
}
