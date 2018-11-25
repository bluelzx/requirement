package com.lanzx.rmmsys.task;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sun.net.TelnetOutputStream;
import sun.net.ftp.FtpClient;

import com.lanzx.rmmsys.entity.UploadFile;
import com.lanzx.rmmsys.service.BackDataTaskService;
import com.lanzx.rmmsys.service.FileService;
import com.lanzx.rmmsys.utils.FtpParameter;

/**
 * 系统备份
 * @author lanzx
 *
 */
public class SystemBack {

	private static final Log log = LogFactory.getLog(SystemBack.class);
	
	public FileService fileService;
	
	public FtpParameter ftpParameter;
	
	public BackDataTaskService backDataTaskService;
	
	/**
	 * 路径是否存在
	 * @param path
	 * @return
	 */
	private  boolean existDir(FtpClient aftp,String checkPath,String basePath){
		
		try{
			aftp.cd(checkPath);
		}catch (Exception e) {
			if(log.isErrorEnabled()){
				log.error(checkPath+"不存在", e);
			}
			return false;
		}finally{
			try {
				aftp.cd(basePath);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	public void doSysBack(){

		if(log.isDebugEnabled()){
			log.debug("系统备份开始执行........");
		}
		//需求附件备份
		List<UploadFile> files = fileService.getNeedMoveFile();
		if(files!=null&&!files.isEmpty()){
			//连接
			FtpClient aftp = null;
			TelnetOutputStream outs = null;
			BufferedInputStream inputs = null;
			BufferedOutputStream outputs = null;
			try {
				 aftp = new FtpClient(ftpParameter.getServer(), ftpParameter.getPort());
				 aftp.login(ftpParameter.getUser(), ftpParameter.getPassword());
				 aftp.binary();
				 aftp.cd(ftpParameter.getBasePath());
				 
				 for(UploadFile file :files){
					 String targerFilePath = ftpParameter.getBasePath()+file.getRequirementId();
					 if(existDir(aftp,targerFilePath,ftpParameter.getBasePath())){
						 aftp.sendServer("XMKD " + targerFilePath + "\r\n");
							try {
								aftp.readServerResponse();
							} catch (Exception e) {
								e.printStackTrace();
							}
					 }
					 
					 aftp.cd(targerFilePath);
					 
					 inputs = new BufferedInputStream(
								new FileInputStream(file.getFilePath()), 1024);
					 
					 outs = aftp.put(file.getFileName());
						outputs = new BufferedOutputStream(outs, 1024);
						int ch;
						while ((ch = inputs.read()) >= 0) {
							outputs.write(ch);
						}
					 outputs.flush();
					 
				 }
			} catch (IOException e) {
				if(log.isErrorEnabled()){
					log.error("", e);
				}
			}finally{
				try {
					inputs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				try {
					outputs.close();
					outs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				if(aftp!=null){
					try {
						aftp.closeServer();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		//数据库备份
		Map map = new HashMap();
		map.put("resultFlag", "");
		String result = backDataTaskService.doBackData(map);
		System.out.println("成功的执行数据备份:"+result);
		
		if(log.isDebugEnabled()){
			log.debug("系统备份结束........");
		}
	}

	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	public FtpParameter getFtpParameter() {
		return ftpParameter;
	}

	public void setFtpParameter(FtpParameter ftpParameter) {
		this.ftpParameter = ftpParameter;
	}

	public BackDataTaskService getBackDataTaskService() {
		return backDataTaskService;
	}

	public void setBackDataTaskService(BackDataTaskService backDataTaskService) {
		this.backDataTaskService = backDataTaskService;
	}

}
