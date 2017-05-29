package com.stp.absm.common;

import com.stp.absm.model.AbsmOrg;
import com.stp.absm.model.AbsmPrivate;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.util.IOUtils;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.List;

/**
 * Created by thomas on 2017-05-15.
 */
public class ExcelUtil {
    private static ExcelUtil ourInstance = new ExcelUtil();

    public static ExcelUtil getInstance() {
        return ourInstance;
    }

    private ExcelUtil() {

    }

    public void makeFile(String fileLocation, String fileName, List excelParamList) {

        FileOutputStream stream			= null;
        try{
            stream						= new FileOutputStream(fileLocation + fileName);
            HSSFWorkbook workBook 		= new HSSFWorkbook();
            HSSFRow row					= null;
            HSSFSheet sheet				= workBook.createSheet("리포트");
            int rowCnt                  = 0;

            row = sheet.createRow(rowCnt++);
            row.createCell(0).setCellValue("인적사항");

            /* Private Data */
            AbsmPrivate absmPrivate     = (AbsmPrivate)excelParamList.get(0);
            /* Chart Data */
            List<AbsmOrg> reportData    = (List)excelParamList.get(1);

            /* 개인정보 */
            row = sheet.createRow(rowCnt++);
            row.createCell(0).setCellValue("나이");
            row.createCell(1).setCellValue(absmPrivate.getAge());
            row = sheet.createRow(rowCnt++);
            row.createCell(0).setCellValue("이름");
            row.createCell(1).setCellValue(absmPrivate.getName());

            /* 조회 데이터 정보 */
            row = sheet.createRow(rowCnt++);
            row = sheet.createRow(rowCnt++);
            row.createCell(0).setCellValue("생체신호 자료");

            /* 조회 데이터 타이틀 */
            row = sheet.createRow(rowCnt++);
            row.createCell(0).setCellValue("구간");
            row.createCell(1).setCellValue("시간");
            row.createCell(2).setCellValue("std RRI");
            row.createCell(3).setCellValue("mean HRV");
            row.createCell(4).setCellValue("pNN50");
            row.createCell(5).setCellValue("SCL");
            row.createCell(6).setCellValue("예측 스트레스");

            /* 조회 데이터 */
            for (AbsmOrg absmOrg : reportData) {
                row = sheet.createRow(rowCnt++);

                row.createCell(0).setCellValue(absmOrg.getCodeName());
                row.createCell(1).setCellValue(absmOrg.getEventTime());

                if (absmOrg.getMStdRri() != null && !"".equals(absmOrg.getMStdRri().toString()))
                    row.createCell(2).setCellValue(absmOrg.getMStdRri());
                else
                    row.createCell(2).setCellValue("-");

                if (absmOrg.getMMeanHrv() != null && !"".equals(absmOrg.getMMeanHrv().toString()))
                    row.createCell(3).setCellValue(absmOrg.getMMeanHrv());
                else
                    row.createCell(3).setCellValue("-");

                if (absmOrg.getMPnn50() != null && !"".equals(absmOrg.getMPnn50().toString()))
                    row.createCell(4).setCellValue(absmOrg.getMPnn50());
                else
                    row.createCell(4).setCellValue("-");

                if (absmOrg.getMScl() != null && !"".equals(absmOrg.getMScl().toString()))
                    row.createCell(5).setCellValue(absmOrg.getMScl());
                else
                    row.createCell(5).setCellValue("-");

                if (absmOrg.getStLevel() != null && !"".equals(absmOrg.getStLevel().toString()))
                    row.createCell(6).setCellValue(absmOrg.getStLevel());
                else
                    row.createCell(6).setCellValue("-");
            }

            DefaultCategoryDataset stdRRIDataset    = createDataset(reportData, 1);
            DefaultCategoryDataset meanHrvDataset   = createDataset(reportData, 2);
            DefaultCategoryDataset pnn50Dataset     = createDataset(reportData, 3);
            DefaultCategoryDataset sclDataset       = createDataset(reportData, 4);

            int i = rowCnt + 5;
            int additionNum = 20;
            String imageFullPath = fileLocation + "graph.jpeg";
            File chartImg = new File(imageFullPath);

            JFreeChart stdRRIchart  = getLineChart("std Rri", stdRRIDataset);
            ChartUtilities.saveChartAsJPEG(chartImg ,stdRRIchart, 500 ,300);
            insertImageIntoExcel(workBook, sheet, imageFullPath, i);

            i += additionNum;
            JFreeChart meanHrvchart  = getLineChart("meav Hrv", meanHrvDataset);
            ChartUtilities.saveChartAsJPEG(chartImg ,meanHrvchart, 500 ,300);
            insertImageIntoExcel(workBook, sheet, imageFullPath, i);

            i += additionNum;
            JFreeChart pnn50chart  = getLineChart("pnn50", pnn50Dataset);
            ChartUtilities.saveChartAsJPEG(chartImg ,pnn50chart, 500 ,300);
            insertImageIntoExcel(workBook, sheet, imageFullPath, i);

            i += additionNum;
            JFreeChart sclchart  = getLineChart("scl", sclDataset);
            ChartUtilities.saveChartAsJPEG(chartImg ,sclchart, 500 ,300);
            insertImageIntoExcel(workBook, sheet, imageFullPath, i);

            workBook.write(stream);

            // 사용한 이미지 파일 삭제
            if (chartImg.exists()) {
                chartImg.delete();
            }

        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if (stream != null)
                try{stream.close();}catch(Exception e){}
        }
    }

    private JFreeChart getLineChart(String chartTitle, DefaultCategoryDataset dataset) {

        JFreeChart lineChart = ChartFactory.createLineChart(chartTitle,"event name","",
                                dataset, PlotOrientation.VERTICAL,true,true,false);
        System.out.println(lineChart.getTitle().getFont().getName());

        return lineChart;
    }

    private DefaultCategoryDataset createDataset(List<AbsmOrg> reportData, int dataCode) {

        DefaultCategoryDataset dataset = new DefaultCategoryDataset( );

        try {
            /* Chart Data Loop */
            switch (dataCode) {
                case 1:
                    // std rri
                    for (int i = 0; i < reportData.size(); i++) {
                        AbsmOrg absmOrg = reportData.get(i);
                        dataset.addValue( absmOrg.getMStdRri(), "std Rri" , absmOrg.getCodeName());
                        dataset.addValue( absmOrg.getStLevel(), "Stress Lv" , absmOrg.getCodeName());
                    }
                    break;
                case 2:
                    // mean hrv
                    for (int i = 0; i < reportData.size(); i++) {
                        AbsmOrg absmOrg = reportData.get(i);
                        dataset.addValue( absmOrg.getMMeanHrv(), "mean Hrv" , absmOrg.getCodeName());
                        dataset.addValue( absmOrg.getStLevel(), "Stress Lv" , absmOrg.getCodeName());
                    }
                    break;
                case 3:
                    // pnn50
                    for (int i = 0; i < reportData.size(); i++) {
                        AbsmOrg absmOrg = reportData.get(i);
                        dataset.addValue( absmOrg.getMPnn50(), "pnn50" , absmOrg.getCodeName());
                        dataset.addValue( absmOrg.getStLevel(), "Stress Lv" , absmOrg.getCodeName());
                    }
                    break;
                case 4:
                    // scl
                    for (int i = 0; i < reportData.size(); i++) {
                        AbsmOrg absmOrg = reportData.get(i);
                        dataset.addValue( absmOrg.getMScl(), "scl" , absmOrg.getCodeName());
                        dataset.addValue( absmOrg.getStLevel(), "Stress Lv" , absmOrg.getCodeName());
                    }
                    break;
            }
        }
        catch(Exception e) {
            e.printStackTrace();
        }

        return dataset;
    }

    public boolean insertImageIntoExcel(HSSFWorkbook workBook, HSSFSheet sheet, String imageFullPath, int i){
        boolean isSuccess = true;

        InputStream inputStream = null;
        try{
            inputStream 	= new FileInputStream(imageFullPath);
            byte[] bytes 	= IOUtils.toByteArray(inputStream);
            int pictureIdx 	= workBook.addPicture(bytes, HSSFWorkbook.PICTURE_TYPE_JPEG);

            HSSFCreationHelper helper 	= workBook.getCreationHelper();
            HSSFPatriarch patriarch 		= sheet.createDrawingPatriarch();
            HSSFClientAnchor anchor 		= helper.createClientAnchor();

            anchor.setCol1(0);
            anchor.setRow1(i);

            HSSFPicture picture = patriarch.createPicture(anchor, pictureIdx);
            picture.resize();
        }catch(Exception e){
            isSuccess = false;
        }finally{
            if(inputStream!=null)try{inputStream.close();}catch(Exception e){}
        }

        return isSuccess;
    }
}
