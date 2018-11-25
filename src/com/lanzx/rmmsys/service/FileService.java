package com.lanzx.rmmsys.service;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.entity.UploadFile;

public interface FileService {

	public List<UploadFile> getFileList(Map<String, Object> likeCondition);
	
	public void insertFile(UploadFile file);
	
	public int getTotalFile(Map<String, Object> likeCondition);
	
	public void deleteFile(String fileCode);

	public UploadFile getFileByCode(String fileCode);
	
	public void updateTmpFile(UploadFile file);
	
	public List<UploadFile> getNeedMoveFile();
}
