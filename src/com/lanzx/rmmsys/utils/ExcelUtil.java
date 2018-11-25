package com.lanzx.rmmsys.utils;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Iterator;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

public class ExcelUtil {

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		
		}
		
	/**
	 * 变更sql
	 * @throws Exception
	 */
		public static void  print1() throws Exception{
			InputStream in = new FileInputStream("D:\\lanzhaoxing\\MyEclipse\\workspace\\spring_mybatis\\变更.xls");
			HSSFWorkbook wb = new HSSFWorkbook(in);
			HSSFSheet sheet = wb.getSheetAt(0);
			Iterator<Row> rows = sheet.rowIterator();
			while(rows.hasNext()){
				Row row = rows.next();
				Cell cell1 =  row.getCell(0);
				String type = cell1.getStringCellValue();
				int reType=0;
				if(type.contains("监管报表")){
					reType=1;
				}else if(type.contains("管理报表")){
					reType=2;
				}else if(type.contains("监管报送系统")){
					reType=3;
				}else if(type.contains("批量接口")){
					reType=4;
				}else if(type.contains("临时统计")){
					reType=5;
				}else if(type.contains("临时维护")){
					reType=6;
				}else if(type.contains("自有功能")){
					reType=7;
				}else{
					reType=8;
				}
				Cell cell2 =  row.getCell(1);
				String CreateTime = DateUtil.getFmtDate("MM/dd/yyyy HH:mm:ss",Constants.DATA_FORMATE_5,cell2.getStringCellValue());
				
				Cell cell3 =  row.getCell(2);
				Cell cell4 =  row.getCell(3);
				String reCode = cell4.getStringCellValue();
				Cell cell5 =  row.getCell(4);
				String[] temp = cell5.getStringCellValue().split("-");
				String DEPT = temp[0];
				String PRESENTER = temp[1];
				Cell cell6 =  row.getCell(5);
				String startDate = DateUtil.getFmtDate("MM/dd/yyyy HH:mm:ss",Constants.DATA_FORMATE_5,cell6.getStringCellValue());
				Cell cell7 =  row.getCell(6);
				String endDate = DateUtil.getFmtDate("MM/dd/yyyy HH:mm:ss",Constants.DATA_FORMATE_5,cell7.getStringCellValue());
				Cell cell8 =  row.getCell(7);
				String remark = cell8.getStringCellValue();
				Cell cell9 =  row.getCell(8);
				String devText = cell9.getStringCellValue();
				if(devText.indexOf("(")!=-1){
					int start = devText.indexOf("(");
					int end = devText.indexOf(")");
					devText = devText.substring(start+1, end);
				}
				Cell cell10 =  row.getCell(9);
				String devText1 = cell10.getStringCellValue();
				
				if(devText1.indexOf("(")!=-1){
					int start1 = devText1.indexOf("(");
					int end1 = devText1.indexOf(")");
					devText1 = devText1.substring(start1, end1);
				}
				if("A-20131118-005".equals(reCode)){
					int i=0;
				}
				System.out.println("insert into RMM_REQUIREMENT(REQUIREMENTCODE,STARTDATE,ENDDATE,CREATETIME,DEPT,PRESENTER,REQUIREMENTTYPE) "+
									" values('"+reCode+"','"+startDate+"','"+endDate+"','"+CreateTime+"','"+DEPT+"','"+PRESENTER+"',"+reType+");");
		}
			
	}

}
