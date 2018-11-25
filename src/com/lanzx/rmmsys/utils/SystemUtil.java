package com.lanzx.rmmsys.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import sun.net.TelnetOutputStream;
import sun.net.ftp.FtpClient;

import com.lanzx.rmmsys.entity.Parameter;
import com.lanzx.rmmsys.entity.UploadFile;
import com.lanzx.rmmsys.entity.User;
import com.lanzx.rmmsys.service.BackDataTaskService;
import com.lanzx.rmmsys.service.FileService;
import com.lanzx.rmmsys.service.SysParaService;

public class SystemUtil {

	private static ConcurrentHashMap<String, List<Parameter>> paras = new ConcurrentHashMap<String, List<Parameter>>();
	
	private static Timer timer = new Timer();
	
	public static List<Parameter> getParasByType(String type){
		return paras.get(type);
	}
	
	public static void putPara(Parameter pa){
		List<Parameter> type = paras.get(pa.getParaType());
		if(type!=null){
			type.add(pa);
		}else{
			List<Parameter> t = new ArrayList<Parameter>();
			t.add(pa);
			paras.put(pa.getParaType(), t);
		}
	}
	
	public static void initParas(){
		paras.clear();
		SysParaService paraService =  (SysParaService) ApplicationContextUtil.getBean("paraService");
		Map<String,Object> likeCondition = new HashMap<String, Object>();
		likeCondition.put("startRow", 1);
		likeCondition.put("endRow", Integer.MAX_VALUE);
		List<Parameter> results = paraService.getParas(likeCondition);
		for(Parameter pa:results){
			List<Parameter> type = paras.get(pa.getParaType());
			if(type!=null){
				type.add(pa);
			}else{
				List<Parameter> t = new ArrayList<Parameter>();
				t.add(pa);
				paras.put(pa.getParaType(), t);
			}
		}
	}
	
	/**
	 * 路径是否存在
	 * @param path
	 * @return
	 */
	private static boolean existDir(FtpClient aftp,String checkPath,String basePath){
		
		try{
			aftp.cd(checkPath);
		}catch (Exception e) {
			e.printStackTrace();
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
	/**
	 * 系统备份
	 *
	 */
	public static void doBackSys(){
		timer.schedule(new TimerTask(){

			@Override
			public void run() {
				//需求附件备份
				FileService fileService = (FileService) ApplicationContextUtil.getBean("fileService");
				FtpParameter ftpParameter = (FtpParameter) ApplicationContextUtil.getBean("ftpParameter");
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
						e.printStackTrace();
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
				BackDataTaskService backDataTaskService =  (BackDataTaskService) ApplicationContextUtil.getBean("backDataTaskService");
				Map map = new HashMap();
				map.put("resultFlag", "");
				String result = backDataTaskService.doBackData(map);
				System.out.println("成功的执行数据备份:"+result);
				
				
			}}, 0, 3600000);
	}
	
	public static  User getLoginUser(HttpServletRequest req){
		HttpSession session = req.getSession();
		User user= (User)session.getAttribute("userInfo");
		return user;
	}
	
	public static String getFileSavePath(HttpServletRequest req){
		String savePath = req.getSession().getServletContext().getRealPath("");
		savePath = savePath + "/upload/";
		return savePath;
	}
	
	/**
     * 对需要下载的文件名进行转码,否则中文文件名会是乱码
     * @param arg
     * @return
     */
    public static  String getName(String arg)
    {
        StringBuffer sb = new StringBuffer();
        try
        {
            char[] c = arg.toCharArray();
            for (int i = 0; i < arg.length(); i++)
            {
                if (c[i] >= 0x100)
                {
                    byte[] buf = ("" + c[i]).getBytes("GBK");
                    String s = new String(buf, "8859_1");
                    sb.append(s);
                } else
                {
                    sb.append(c[i]);
                }
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
            return arg;
        }
        return sb.toString();
    }
    
    public static void main(String[] str){
    	String driver = "oracle.jdbc.driver.OracleDriver";
    	String dburl = "jdbc:oracle:thin:@192.168.220.66:1523:srcbfin";
    	String user = "srcc_rmm";
    	String pass = "SRCC_RMMSRCC_RMM";
    	
    	File file = new File("C:\\Documents and Settings\\Administrator\\桌面\\所有后置需求\\");
    	File[] files = file.listFiles();
    	for(File f:files){
    		if(f.isDirectory()){
    			File[] subFiles = f.listFiles();
    			String requirementId = f.getName();
    			for(File subF:subFiles){
    				String fileCode = DateUtil.getRandomCode(Constants.DATA_FORMATE_1, 14);
    				String fileName = subF.getName();
    				String fielPath = "/app/report/rmm/upload/"+requirementId+"/"+fileName;
    				String uploadTime = DateUtil.getCurrentDate(Constants.DATA_FORMATE_1);
    				String userCode = "admin";
    				long fileSize = subF.getTotalSpace();
    				String lastT = fileName.substring(fileName.lastIndexOf("."));
    				String fileType = "";
    				if(".xls".equals(lastT)){
    					fileType = "application/vnd.ms-excel";
    				}else if(".pdf".equals(lastT)){
    					fileType = "application/pdf";
    				}else if(".doc".equals(lastT)){
    					fileType = "application/doc";
    				}else if(".zip".equals(lastT)){
    					fileType =  "application/zip";
    				}
    				System.out.println("insert into rmm_file(requirementId,fileCode,fileName,filePath,uploadTime,userCode,fileSize,fileType) values('"+
    						requirementId+"','"+fileCode+"','"+fileName+"','"+fielPath+"','"+uploadTime+"','"+userCode+"',"+fileSize+",'"+fileType+"');"	);
    			}
    		}
    	}
    }
    
    /**
	 * 获取数据库连接
	 * 
	 * @param driver
	 *            数据库驱动
	 * @param dburl
	 *            数据库连接串
	 * @return
	 */
	public static Connection getConnection(String driver, String dburl,String user,String pass) {
		Connection con = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(dburl,user,pass);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return con;
	}
}
