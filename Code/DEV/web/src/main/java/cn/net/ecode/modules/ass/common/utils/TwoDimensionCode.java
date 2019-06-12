package cn.net.ecode.modules.ass.common.utils;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;

/**
 * 二维码生成器
 * 
 * @author Administrator
 * 
 */
public class TwoDimensionCode {

	private static final int DEFAULT_WIDTH = 400;
	private static final int DEFAULT_HEIGHT = 400;
	private static final String DEFAULT_CHAR_SET = "UTF-8";
	private static final String DEFAULT_FILE_TYPE = "jpg";

	/**
	 * 输出二维码
	 * 
	 * @param filePath
	 *            文件路径
	 * @param filename
	 *            文件名
	 * @param content
	 *            二维码显示数据内容
	 * @throws Exception
	 *             输出错误
	 */
	public static void output(String filePath, String filename, String content)
			throws Exception {
		output(filePath, filename, content, DEFAULT_WIDTH, DEFAULT_HEIGHT,
				DEFAULT_CHAR_SET, DEFAULT_FILE_TYPE);
	}

	/**
	 * 输出二维码
	 * 
	 * @param filePath
	 *            文件路径
	 * @param filename
	 *            文件名
	 * @param content
	 *            二维码显示数据内容
	 * @param width
	 *            二维码宽度
	 * @param height
	 *            二维码高度
	 * @param charSet
	 *            数据编码格式
	 * @param fileType
	 *            文件类型
	 * @throws Exception
	 *             输出错误
	 */
	public static void output(String filePath, String filename, String content,
			int width, int height, String charSet, String fileType)
			throws Exception {
		File dir = new File(filePath);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		output(new File(filePath, filename), content, width, height, charSet,
				fileType);
	}

	/**
	 * 输出二维码
	 * 
	 * @param filePath
	 *            文件路径
	 * @param filename
	 *            文件名
	 * @param content
	 *            二维码显示数据内容
	 * @throws Exception
	 *             输出错误
	 */
	public static void output(File file, String content) throws Exception {
		output(file, content, DEFAULT_WIDTH, DEFAULT_HEIGHT, DEFAULT_CHAR_SET,
				DEFAULT_FILE_TYPE);
	}

	/**
	 * 输出二维码
	 * 
	 * @param file
	 *            文件
	 * @param content
	 *            二维码显示数据内容
	 * @param width
	 *            二维码宽度
	 * @param height
	 *            二维码高度
	 * @param charSet
	 *            数据编码格式
	 * @param fileType
	 *            文件类型
	 * @throws Exception
	 *             输出错误
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void output(File file, String content, int width, int height,
			String charSet, String fileType) throws Exception {
		MultiFormatWriter multiFormatWrite = new MultiFormatWriter();
		Map hints = new HashMap();
		hints.put(EncodeHintType.CHARACTER_SET, charSet);
		// 按照指定的宽度，高度和附加参数对字符串进行编码
		// 生成二维码
		BitMatrix bitMatrix = multiFormatWrite.encode(content,
				BarcodeFormat.QR_CODE, width, height, hints);
		// 写入文件
		if (file.exists()) {
			file.delete();
		}
		MartixToImageWriter.writeToFile(bitMatrix, fileType, file);
	}

	public static void main(String[] args) {
		String filepath = "E:/a/test/demo/t";
		String filename = "a.jpg";
		String content = "项目编码:01，项目名称：测试";
		try {
			output(filepath, filename, content);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
