/**
 * 
 */
package cn.net.ecode.modules.ass.common.utils;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.DocAttributeSet;
import javax.print.attribute.HashDocAttributeSet;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.Chromaticity;
import javax.print.attribute.standard.Copies;
import javax.print.attribute.standard.MediaPrintableArea;
import javax.print.attribute.standard.OrientationRequested;
import javax.print.attribute.standard.PrintQuality;

import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import com.sun.jna.Memory;
import com.sun.jna.Pointer;

import cn.net.ecode.modules.ass.common.utils.PrintLab.printdll;

/**
 * @author 26699
 * 
 */
public class PrintTest {

    /**
     * 打印图片
     * 
     * @param fileName 文件路径， 如：E:\\timg.jpg
     * @param count
     */
    public void printImg(String fileName, int count) {
        try {
            // DocFlavor dof = DocFlavor.INPUT_STREAM.AUTOSENSE;

            DocFlavor dof = null;
            if (fileName.endsWith(".gif")) {
                dof = DocFlavor.INPUT_STREAM.GIF;
            } else if (fileName.endsWith(".jpg")) {
                dof = DocFlavor.INPUT_STREAM.JPEG;
            } else if (fileName.endsWith(".png")) {
                dof = DocFlavor.INPUT_STREAM.PNG;
            }
            PrintService pservice = PrintServiceLookup.lookupDefaultPrintService();

            // 打印属性
            PrintRequestAttributeSet pras = new HashPrintRequestAttributeSet();

            pras.add(OrientationRequested.PORTRAIT);
            pras.add(new Copies(count));
            pras.add(PrintQuality.HIGH);
            pras.add(Chromaticity.MONOCHROME);

            // 文档属性
            DocAttributeSet das = new HashDocAttributeSet();
            FileInputStream fis = new FileInputStream(fileName);
            // 设置打印纸张的大小（将像素转化为mm）
            // das.add(new MediaPrintableArea(0, 0, 110, 148, MediaPrintableArea.MM));
            das.add(new MediaPrintableArea(0, 0, 15, 15, MediaPrintableArea.MM));

            Doc doc = new SimpleDoc(fis, dof, das);

            DocPrintJob job = pservice.createPrintJob();
            job.print(doc, pras);

            fis.close();

        } catch (IOException ie) {
            ie.printStackTrace();
        } catch (PrintException pe) {
            pe.printStackTrace();
        }
    }

    private static void getRfid() throws InterruptedException {
        // 取RFID信息
      //  StringBuilder strRFData = new StringBuilder(256);
        // String strRFData = null;
        
        Pointer p = new Memory(256);  
        for (int i = 0; i < 1; i++) {
            int tryTime = 0;
            while (true) {
                Thread.sleep(200);//
                int status = printdll.Instance.PTK_ErrorReportUSB(255);
                if (status == 0) {
                    tryTime++;//
                    if (tryTime > 2) //
                    {
                        tryTime = 0;
                        break;
                    }
                } else {
                    tryTime = 0;//
                    continue;
                }
            }
            // 取RFID标签EPC,TID信息
           // int nReturn = printdll.Instance.PTK_ReadRFTagDataUSB(255, 2, 0, 0, strRFData.toString());// 0: TID , 1: EPC
            //// MessageBox.Show(strRFData.ToString());
           // System.out.println("strRFData:" + strRFData);
           // System.out.println("nReturn:" + nReturn);                                                                                      // 2: TID+EPC
            //int nReturn = printdll.Instance.PTK_ReadRFTagDataUSB(255, 2, 0, false, p)  ;  
            StringBuffer sbBuffer=new StringBuffer();
            //int  nStatus=printdll.Instance.PTK_GetPrinterName("aa");
            int  nStatus=printdll.Instance.PTK_ErrorReport();
            
            byte [] status1=new byte[127];
            int ascii;
            //for(int i1=0, sumi=256; i1< sumi; i1++){  
                //System.out.print((char) p.getByteArray(0, 256)[i1]);  
            	
             //}  
            for(int i2=0,sum=127;i2<sum;i2++){
            	sbBuffer.append((char)status1[i2]);
            }
            ascii=status1[0];
            String message=sbBuffer.toString().trim();
            System.out.println("ascii-----"+ascii);
            System.out.print("\n");  
            System.out.println("message------"+message);
            System.out.println("\n");
            while (true) {
                // textBox3.Text=strRFData.ToString().Split('+')[0];
                // textBox2.Text=strRFData.ToString().Split('+')[1];
                // System.out.println("textBox3.Text:"+strRFData.toString().split("+")[0]);
                // System.out.println("textBox2.Text:"+strRFData.toString().split("+")[1]);
               //  System.out.println("textBox3.Text:" + strRFData.toString());
                Thread.sleep(100);// 160601 by xr
                int status = printdll.Instance.PTK_ErrorReportUSB(255);
                if (status == 0) {
                    tryTime++;// 160601 by xr
                    if (tryTime > 2) // 160601 by xr
                    {
                        tryTime = 0;
                        break;
                    }
                } else {
                    tryTime = 0;// 160601 by xr
                    continue;
                }
            }

        }
    }

    private void printTag(Map map) throws SQLException, InterruptedException {
        try {
            // 通过IP连接
            // int openInt = printdll.Instance.PTK_Connect("192.168.197.177", 9100);
            // 通过USB连接
            int openInt = printdll.Instance.PTK_ErrorReportUSB(255); 
            printdll.Instance.OpenPort(255);
            System.out.println("openInt:" + openInt);
            if (openInt == 0) {
                System.out.println("连接打印机成功！");
                System.out.println("开始打印...");
                printdll.Instance.PTK_ClearBuffer(); // 清空缓冲区
                printdll.Instance.PTK_SetPrintSpeed(4); // 设置打印速度
                printdll.Instance.PTK_SetDarkness(10); // 设置打印黑度
                // printdll.Instance.PTK_SetLabelHeight(450, 3, 142, false); // 设置标签的高度和定位间隙\黑线\穿孔的高度 原来是470
                // printdll.Instance.PTK_SetLabelWidth(800); // 设置标签的宽度 原来是1300

                printdll.Instance.PTK_SetLabelHeight(400, 15, 142, false); // 设置标签的高度和定位间隙\黑线\穿孔的高度 原来是470
                printdll.Instance.PTK_SetLabelWidth(720); // 设置标签的宽度 原来是1300
                if (map != null) {
                    int diff = 0;
                    String assetCode = (String) map.get("assetCode");
                    String assetName = (String) map.get("assetName");
                    String sortName = (String) map.get("sortName");
                    String supplier = (String) map.get("supplier");
                    String brand = (String) map.get("brand");
                    String qrCode = (String) map.get("qrCode");

                    // printImg("E:\\1.png", 1);
                    printdll.Instance.PTK_DrawTextTrueTypeW(100, 100, 30, 0, "微软雅黑", 1, 400, false, false, false, "A1", "资产编码 :");

                    // 超过14位，换行
//                    if (null != productName && productName.length() > 14) {
//                        String pn1 = productName.substring(0, 14);
//                        int ret = printdll.Instance.PTK_DrawTextTrueTypeW(210, 100, 30, 0, "微软雅黑", 1, 400, false, false, false, "B1", pn1);
//                        System.out.println("ret:" + ret);
//                        String pn2 = productName.substring(14);
//                        printdll.Instance.PTK_DrawTextTrueTypeW(260, 150, 30, 0, "微软雅黑", 1, 400, false, false, false, "B2", pn2);
//                        diff = 50;// 高度调整值
//                    } else {
                        int ret = printdll.Instance.PTK_DrawTextTrueTypeW(210,100, 30, 0, "微软雅黑", 1, 400, false, false, false, "B1",
                                assetCode);
                        System.out.println("ret:" + ret);
//                    }

                    printdll.Instance.PTK_DrawTextTrueTypeW(100, 150 + diff, 30, 0, "微软雅黑", 1, 400, false, false, false, "A3", "资产名称 :");
                    printdll.Instance.PTK_DrawTextTrueTypeW(210, 150 + diff, 30, 0, "微软雅黑", 1, 400, false, false, false, "B3", assetName);
                    printdll.Instance.PTK_DrawTextTrueTypeW(100, 200 + diff, 30, 0, "微软雅黑", 1, 400, false, false, false, "A4", "类别:");
                    printdll.Instance.PTK_DrawTextTrueTypeW(210, 200 + diff, 30, 0, "微软雅黑", 1, 400, false, false, false, "B4", sortName);
                    printdll.Instance.PTK_DrawTextTrueTypeW(100, 250 + diff, 30, 0, "微软雅黑", 1, 400, false, false, false, "C4", "供货商:");
                    printdll.Instance.PTK_DrawTextTrueTypeW(210, 250 + diff, 30, 0, "微软雅黑", 1, 400, false, false, false, "D4", supplier);
                    printdll.Instance.PTK_DrawTextTrueTypeW(100, 300 + diff, 30, 0, "微软雅黑", 1, 400, false, false, false, "A5", "品牌:");
                    printdll.Instance.PTK_DrawTextTrueTypeW(210, 300 + diff, 30, 0, "微软雅黑", 1, 400, false, false, false, "B5", brand);
                    printdll.Instance.PTK_DrawBar2D_QR(400, 150, 190, 190, 0, 6, 3, 0, 0, qrCode);

                    // int tag = printdll.Instance.PTK_RWRFIDLabel(1, 0, 2, 2, 1, (String) map.get("epc"));
                    // StringBuilder strRFData = new StringBuilder(256);
                    // printdll.Instance.PTK_ReadRFTagDataUSB(255, 2, 0, false, strRFData.toString());
                    // System.out.println("strRFData:"+strRFData.toString());

                    // 命令打印机执行打印工作
                    printdll.Instance.PTK_PrintLabel(1, 1);
                    System.out.println("打印完成。");
                } else {
                    System.out.println("连接打印机失败！");
                }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            printdll.Instance.ClosePort();// 关闭打印机端口
        }

    }

    private void printTag3(Map map) throws SQLException, InterruptedException {
        try {
            // int openInt = printdll.Instance.PTK_Connect("192.168.197.177", 9100);
            int openInt = printdll.Instance.OpenPort(255);
            System.out.println("openInt:" + openInt);
            if (openInt == 0) {
                System.out.println("连接打印机成功！");
                System.out.println("开始打印...");
                printdll.Instance.PTK_ClearBuffer(); // 清空缓冲区
                printdll.Instance.PTK_SetPrintSpeed(4); // 设置打印速度
                printdll.Instance.PTK_SetDarkness(10); // 设置打印黑度
                // printdll.Instance.PTK_SetLabelHeight(450, 3, 142, false); // 设置标签的高度和定位间隙\黑线\穿孔的高度 原来是470
                // printdll.Instance.PTK_SetLabelWidth(800); // 设置标签的宽度 原来是1300

                printdll.Instance.PTK_SetLabelHeight(400, 15, 142, false); // 设置标签的高度和定位间隙\黑线\穿孔的高度 原来是470
                printdll.Instance.PTK_SetLabelWidth(800); // 设置标签的宽度 原来是1300
                
                printdll.Instance.PTK_SetRFID(0,0,0,1,0);
                if (map != null) {
                	 printdll.Instance.PTK_DrawTextTrueTypeW(280, 360 , 30, 0, "微软雅黑", 1, 400, false, false, false, "C4", "原产地:");
                	
                 //    写EPC
                   int tag = printdll.Instance.PTK_RWRFIDLabel(1, 0, 2, 4, 1, "46466464");
                   System.out.println("写入返回："+tag);
                    

                    // 获取TID EPC
                    getRfid();
                    
                    // 命令打印机执行打印工作
                    int b=  printdll.Instance.PTK_PrintLabel(1, 1);
                    System.out.println("打印完成。");
                } else {
                    System.out.println("连接打印机失败！");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            printdll.Instance.ClosePort();// 关闭打印机端口
        }
    }

    /**
     * 打印机覆膜安装注意：粗糙在外面，光滑的在里面。
     *
     * @param string
     * @throws UnsupportedEncodingException
     */
    public static String string2Unicode(String string) {
        
        StringBuffer unicode = new StringBuffer();
     
        for (int i = 0; i < string.length(); i++) {
     
            // 取出每一个字符
            char c = string.charAt(i);
     
            // 转换为unicode
            unicode.append(Integer.toHexString(c));
        }
     
        return unicode.toString();
    }
    
    public static String unicode2String(String unicode) {
    	 
        StringBuffer string = new StringBuffer();
     
        String[] hex = unicode.split("\\\\u");
     
        for (int i = 1; i < hex.length; i++) {
     
            // 转换出每一个代码点
            int data = Integer.parseInt(hex[i], 16);
     
            // 追加成string
            string.append((char) data);
        }
     
        return string.toString();
    }
    
    @SuppressWarnings("unchecked")
    public static void main(String[] args) throws UnsupportedEncodingException {
        /**
         * Dll放的位置:可以放在项目的根目录下,可以放在jdk目录中的bin目录下.这两个地方jna都是可以找到的.
         * 因为调用的过程中设计了中文,dll中的中文是用GBK进行编码的,所以java传给dll也得是GBK,不然就会乱码
         * .因为c,c++中的char*对应java中的string,不过jna默认的编码方式是utf-8,所以要手动的将编码方式改为GBK
         */
      System.setProperty("jna.encoding", "GBK");
      
      // 读TID+EPC
     
     try {
    	 System.out.println("---------打印之前读----------------");
          getRfid();  
          System.out.println("---------打印之前读---------------");
       } catch (Exception e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }
     
      // 打印及读写
       Map map = new HashMap();
        map.put("product_name", "ZCRK2018091028738");
        map.put("artnum", "A款");
        map.put("norms", "B号");
        map.put("color", "红色");
        map.put("epc", "1111");
        map.put("barcode", "P2140600149644S1");
        map.put("price", "10.23");
        map.put("name", "sssssssssss");
        PrintTest test = new PrintTest();

        try {
            test.printTag(map);
           
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        // 读TID+EPC
        try {
        //	System.out.println("---------打印之后读---------------");
          //  getRfid();     
          //  System.out.println("---------打印之后读---------------");
        	int tryTime = 0;
        	int status = -1;
            while (true) {
                // textBox3.Text=strRFData.ToString().Split('+')[0];
                // textBox2.Text=strRFData.ToString().Split('+')[1];
                // System.out.println("textBox3.Text:"+strRFData.toString().split("+")[0]);
                // System.out.println("textBox2.Text:"+strRFData.toString().split("+")[1]);
               //  System.out.println("textBox3.Text:" + strRFData.toString());
                Thread.sleep(100);// 160601 by xr
                 status = printdll.Instance.PTK_ErrorReportUSB(255);
                System.out.println(status);
                if (status == 99 || status == 0) {
                    tryTime++;// 160601 by xr
                    if (tryTime > 2) // 160601 by xr
                    {
                        tryTime = 0;
                        break;
                    }
                } else {
                    tryTime = 0;// 160601 by xr
                    continue;
                }
            }
            if (status == 99)
            {
            	System.out.println("RFID错误");
            }
            if(status == 0)
            {
            	System.out.println("就绪");
            }
         } catch (Exception e) {
             // TODO Auto-generated catch block
             e.printStackTrace();
         }
       
        

    }
    @SuppressWarnings("unchecked")
    public static void getAssetPrint(AssetInfo assetInfo) throws UnsupportedEncodingException {
        /**
         * Dll放的位置:可以放在项目的根目录下,可以放在jdk目录中的bin目录下.这两个地方jna都是可以找到的.
         * 因为调用的过程中设计了中文,dll中的中文是用GBK进行编码的,所以java传给dll也得是GBK,不然就会乱码
         * .因为c,c++中的char*对应java中的string,不过jna默认的编码方式是utf-8,所以要手动的将编码方式改为GBK
         */
        System.setProperty("jna.encoding", "GBK");

        // 读TID+EPC

        try {
            System.out.println("---------打印之前读----------------");
            getRfid();
            System.out.println("---------打印之前读---------------");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        // 打印及读写
        Map map = new HashMap();
        map.put("assetCode",assetInfo.getAssetCode());
        map.put("assetName",assetInfo.getAssetName());
        map.put("sortName",assetInfo.getSortName());
        map.put("supplier", assetInfo.getSupplier());
        map.put("brand", assetInfo.getBrand());
        map.put("qrCode", assetInfo.getQrCode());
        PrintTest test = new PrintTest();

        try {
            test.printTag(map);

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        // 读TID+EPC
        try {
            //	System.out.println("---------打印之后读---------------");
            //  getRfid();
            //  System.out.println("---------打印之后读---------------");
            int tryTime = 0;
            int status = -1;
            while (true) {
                // textBox3.Text=strRFData.ToString().Split('+')[0];
                // textBox2.Text=strRFData.ToString().Split('+')[1];
                // System.out.println("textBox3.Text:"+strRFData.toString().split("+")[0]);
                // System.out.println("textBox2.Text:"+strRFData.toString().split("+")[1]);
                //  System.out.println("textBox3.Text:" + strRFData.toString());
                Thread.sleep(100);// 160601 by xr
                status = printdll.Instance.PTK_ErrorReportUSB(255);
                System.out.println(status);
                if (status == 99 || status == 0) {
                    tryTime++;// 160601 by xr
                    if (tryTime > 2) // 160601 by xr
                    {
                        tryTime = 0;
                        break;
                    }
                } else {
                    tryTime = 0;// 160601 by xr
                    continue;
                }
            }
            if (status == 99)
            {
                System.out.println("RFID错误");
            }
            if(status == 0)
            {
                System.out.println("就绪");
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }



    }
}
