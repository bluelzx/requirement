package com.lanzx.rmmsys.service.impl;

import java.util.List;
import java.util.Map;

import com.lanzx.rmmsys.dao.FileDao;
import com.lanzx.rmmsys.entity.UploadFile;
import com.lanzx.rmmsys.service.FileService;

public class FileServiceImpl implements FileService {

	private FileDao fileDao ;
	
	
	public List<UploadFile> getFileList(Map<String, Object> likeCondition) {
		return fileDao.getFileList(likeCondition);
	}

	public int getTotalFile(Map<String, Object> likeCondition) {
		return fileDao.getTotalFile(likeCondition);
	}

	public void insertFile(UploadFile file) {
		fileDao.insertFile(file);
	}

	public FileDao getFileDao() {
		return fileDao;
	}

	public void setFileDao(FileDao fileDao) {
		this.fileDao = fileDao;
	}

	public void deleteFile(String fileCode) {
		fileDao.deleteFile(fileCode);
	}

	public UploadFile getFileByCode(String fileCode) {
		return fileDao.getFileByCode(fileCode);
	}

	public void updateTmpFile(UploadFile file) {
		fileDao.updateTmpFile(file);
	}

	public List<UploadFile> getNeedMoveFile() {
		return fileDao.getNeedMoveFile();
	}

}
