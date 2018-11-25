package com.lanzx.rmmsys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.Mapper;

import com.lanzx.rmmsys.entity.UploadFile;

@Mapper("fileDao")
public interface FileDao {
	
	public List<UploadFile> getFileList(Map<String, Object> likeCondition);
	
	public void insertFile(UploadFile file);
	
	public int getTotalFile(Map<String, Object> likeCondition);
	
	public void deleteFile(String fileCode);

	public UploadFile getFileByCode(String fileCode);
	
	public void updateTmpFile(UploadFile file);
	
	public List<UploadFile> getNeedMoveFile();
}
