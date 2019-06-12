package cn.net.ecode.modules.ass.common.web;

import cn.net.ecode.common.config.Global;
import com.google.common.collect.Lists;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;

import java.io.File;
import java.util.List;

/**
 * AJAX实现的文件上传
 * 
 * @author 刘保全
 * 
 */
public class AjaxFileUploadUtil {

	public static int sizeThreshold = 0; // 缓存大小
	public static long sizeMax = 0L; // 文件最大大小
	public static String dataPath = null; //
	public static File tempPathFile = null;
	public static List<String> suffixs = null;
	public static String suffixMsg = null;
	public static String relativePath = null; //

	public static ServletFileUpload upload = null;

	public static void init() {
		AjaxFileUploadUtil.fileuploadInit();
		AjaxFileUploadUtil.uploadInit();
	}

	/**
	 * 初始化upload
	 */
	private static void uploadInit() {

		if (upload != null) {
			return;
		}

		// Create a factory for disk-based file items
		DiskFileItemFactory factory = new DiskFileItemFactory();

		// Set factory constraints
		factory.setSizeThreshold(sizeThreshold); // 设置缓冲区大小，这里是4kb
		factory.setRepository(tempPathFile);// 设置缓冲区目录

		// Create a new file upload handler
		upload = new ServletFileUpload(factory);

		// Set overall request size constraint
		upload.setSizeMax(sizeMax);
	}

	/**
	 * 初始化文件上传参数
	 * 
	 * @param request
	 */
	private static void fileuploadInit() {

		if (dataPath != null) {
			return;
		}

//		String realPath = AjaxFileUploadUtil.class.getResource("/").getPath()
//				.replaceAll("\\\\", "/");
		String realPath = Global.getUserfilesBaseDir("$fileupload/");
		
//		if (!realPath.endsWith("/")) {
//			realPath = realPath + "/";
//		}
		// 设置缓冲区大小
		try {
			sizeThreshold = (int) getNumber("fileupload.size.threshold"); // 缓存大小
			sizeMax = getNumber("fileupload.size.max"); // 文件最大大小
			dataPath = getPath("fileupload.path.data.absolute", // 数据文件路径
					"fileupload.path.data.relative", realPath);
			relativePath = getRelativePath("fileupload.path.data.absolute", // 数据文件路径
					"fileupload.path.data.relative");
			String tempPath = getPath("fileupload.path.temp.absolute", // 临时文件路径
					"fileupload.path.temp.relative", realPath);
			tempPathFile = new File(tempPath);

			suffixMsg = Global.getConfig("fileupload.allow.suffix");
			suffixs = Lists.newArrayList(suffixMsg.split(","));

			if (!tempPathFile.exists()) {
				tempPathFile.mkdirs();
			}
			File dataPathFile = new File(dataPath);
			if (!dataPathFile.exists()) {
				dataPathFile.mkdirs();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("sizeThreshold:" + sizeThreshold);
			System.out.println("sizeMax:" + sizeMax);
			System.out.println("dataPath:" + dataPath);
			System.out.println("relativePath:" + relativePath);
			System.out.println("sizeThreshold:" + sizeThreshold);
			System.out.println("suffixMsg:" + suffixMsg);
		}
	}

	/**
	 * 获取路径
	 * 
	 * @param absolute
	 *            据对位置配置字符串
	 * @param relative
	 *            相对位置配置字符串
	 * @param realPath
	 *            项目据对路径
	 * @return 路径
	 */
	private static String getPath(String absolute, String relative,
			String realPath) {
		String path = Global.getConfig(absolute);
		if (path == null || StringUtils.isBlank(path)) {
			path = Global.getConfig(relative);
			if(path != null && !("".equals(path))){
				path = path.replaceAll("\\\\", "/");
				if (path.startsWith("/")) {
					path = path.substring(1);
				}
				if (!path.endsWith("/")) {
					path = path + "/";
				}
				path = realPath + path;
			}else{
				path = realPath;
			}
		}
		return realPath + path;
	}
	
	private static String getRelativePath(String absolute, String relative) {
		String path = Global.getConfig(absolute);
		if (path == null || StringUtils.isBlank(path)) {
			path = Global.getConfig(relative);
			if(path != null && !("".equals(path))){
				path = path.replaceAll("\\\\", "/");
				if (path.startsWith("/")) {
					path = path.substring(1);
				}
				if (!path.endsWith("/")) {
					path = path + "/";
				}
			}else{
				path = "";
			}
		}
		return path;
	}

	/**
	 * 获取数值
	 * 
	 * @param key
	 *            配置字符串
	 * @return 数值
	 */
	private static long getNumber(String key) {

		String config = Global.getConfig(key);

		int length = config.length(); // 长度
		String number = config.substring(0, length - 1); // 数值
		String unit = config.substring(length - 1); // 单位
		long data = Long.parseLong(number); // 数值
		if (unit.equalsIgnoreCase("b")) {
			data = data * 1;
		} else if (unit.equalsIgnoreCase("k")) {
			data = data * 1024;
		} else if (unit.equalsIgnoreCase("m")) {
			data = data * 1024 * 1024;
		} else if (unit.equalsIgnoreCase("g")) {
			data = data * 1024 * 1024 * 1024;
		} else {
			data = 0;
		}
		return data;
	}

	/**
	 * 获取上传文件的文件名
	 * 
	 * @param fileName
	 *            原始文件名
	 * @return
	 */
	public static String getDataFileName(String guid, String fileName) {
//		Map<String,String> map = new HashMap<String,String>();
//		String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
//		map.put("path", AjaxFileUploadUtil.dataPath +  guid + "." + fileName);
//		map.put("realFileName", fileName);
		return AjaxFileUploadUtil.dataPath +  guid + "." + fileName;
	}

}
