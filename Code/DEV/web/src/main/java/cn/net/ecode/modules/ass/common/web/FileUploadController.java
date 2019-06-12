package cn.net.ecode.modules.ass.common.web;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.mapper.JsonMapper;
import cn.net.ecode.common.security.Digests;
import cn.net.ecode.common.utils.Encodes;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.file.entity.FileEntity;
import cn.net.ecode.modules.file.entity.FileUser;
import cn.net.ecode.modules.file.entity.FileUserBiz;
import cn.net.ecode.modules.file.service.FileService;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigInteger;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.security.MessageDigest;
import java.util.List;
import java.util.Map;

/**
 * 文件上传
 * 
 * @author 刘保全
 * 
 */
@Controller
public class FileUploadController extends BaseController {

    @Autowired
    private FileService fileService;
    
    @RequestMapping(value = "fileupload")
    @ResponseBody
    public Map<String, Object> fileupload(MultipartHttpServletRequest multipartRequest) throws Exception {
        JSONObject result = new JSONObject();
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        AjaxFileUploadUtil.init();
        String message = "上传成功";
        String result1 = "true";
        List<Map<String, Object>> list = Lists.newArrayList();
        Map<String, Object> messageMap = Maps.newHashMap();
        List<String> fUserList = Lists.newArrayList();
        for (MultipartFile file : fileMap.values()) {

            String fileName = file.getOriginalFilename();
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

            if (!AjaxFileUploadUtil.suffixs.contains(suffix)) {
                result.put("code", "222");
                result.put("message", "只支持" + AjaxFileUploadUtil.suffixMsg + "类型的文件！");
                break;
            } else if (file.getSize() > AjaxFileUploadUtil.sizeMax) {
                result.put("code", "222");
                result.put("message", "文件大小最大为" + AjaxFileUploadUtil.sizeMax);
                break;
            } else {

                String fieldName = file.getName();
                String guid = IdGen.nextId();
                String pathname = AjaxFileUploadUtil.getDataFileName(guid, suffix);
                JSONObject oneResult=new JSONObject();
                try {
                    FileOutputStream out= new FileOutputStream(pathname);
                    byte[] contents = file.getBytes();
                    out.write(contents);
                    out.close();


                    FileEntity fileEntity = new FileEntity();
                    fileEntity.setIsNewRecord(true);
                    fileEntity.setId(guid);
                    fileEntity.setFileSize(file.getSize());
                    fileEntity.setFilePath(AjaxFileUploadUtil.relativePath);
                    fileEntity.setFileMd5(new String(Digests.md5(contents)));
                    fileEntity.setFileSuffix("." +suffix);
                    fileEntity.setFileType(file.getContentType());
                    fileService.saveFile(fileEntity);



                    FileUser fileUser = new FileUser(fileEntity);
                    fileUser.setFileName(fileName);
                    fileUser.setFileEntity(fileEntity);
                    // fileUser.setFileCategory(uploadType);
                    fileUser.setCreateBy(fileUser.getCurrentUser());
                    fileUser.setStatus("0");
                    List<FileUser> fileUserList = fileService.findFileUserList(fileUser);
                    if (fileUserList.size() > 0) {
                        fileUser = (FileUser) fileUserList.get(0);
                    }
                    fileService.saveFileUser(fileUser);

                    Map<String, Object> map = Maps.newHashMap();
                    map.put("fieldName", fieldName);
                    // map.put("realFileName", realFileName);
                    map.put("guid", guid);
                    map.put("fileName", fileName);
                    map.put("pathName", pathname);
                    map.put("url", "/userfiles/$fileupload/app/" + guid + "." + suffix);
                    map.put("size", file.getSize());
                    map.put("suffix", suffix);
                    list.add(map);
                    fUserList.add(fileUser.getId());
                    oneResult.put("code", 200);
                    oneResult.put("message", "保存成功");
                } catch (IOException e) {
                    oneResult.put("code", 202);
                    oneResult.put("message", "保存失败");
                    e.printStackTrace();
                }finally{
                    result.put(fileName, oneResult);
                }

            }

        }

        if (list.size() == 0 && result.equals("true")) {
            result1 = "false";
            message = "请选择上传文件";
        }
        messageMap.put("list", list);
        messageMap.put("message", message);
        messageMap.put("result", result1);
        messageMap.put("fUserlist", fUserList);
        String msg = JsonMapper.toJsonString(messageMap);
        logger.debug("fileupload msg:" + msg);
        result.put("code", "200");
        return messageMap;


    }

    /**
     * 文件上传service
     */
   /* @RequestMapping(value = "fileupload1")
    @ResponseBody
    public Map<String, Object> fileupload1(MultipartHttpServletRequest multipartRequest) throws Exception {

        AjaxFileUploadUtil.init();

        String message = "上传成功";
        String result = "true";
        List<Map<String, Object>> list = Lists.newArrayList();
        List<String> fUserList = Lists.newArrayList();
        // 获取多个file
        Iterator<String> it = multipartRequest.getFileNames();
        while (it.hasNext()) {
            String key = it.next();
            MultipartFile multipartFile = multipartRequest.getFile(key);
            String fileName = multipartFile.getOriginalFilename(); // 文件名
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase(); // 文件后缀
            if (StringUtils.isNotBlank(fileName)) {
                FileEntity fileEntity = new FileEntity();
                if (!AjaxFileUploadUtil.suffixs.contains(suffix)) {
                    message = "只支持" + AjaxFileUploadUtil.suffixMsg + "类型的文件！";
                    result = "false";
                    break;
                }
                if (multipartFile.getSize() > AjaxFileUploadUtil.sizeMax) {
                    message = "文件大小最大为" + AjaxFileUploadUtil.sizeMax;
                    result = "false";
                    break;
                }

                String fieldName = multipartFile.getName();
                String guid = IdGen.nextId();
                String pathname = AjaxFileUploadUtil.getDataFileName(guid, suffix);

                InputStream in = multipartFile.getInputStream();
                FileOutputStream out = new FileOutputStream(pathname);
                try {
                    StreamUtils.copy(in, out);

                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    System.out.println("------------张萌测试----------------");
                    in.close();
                    out.flush();
                    out.close();
                    out = null;
                }
                Map<String, Object> map = Maps.newHashMap();
                map.put("fieldName", fieldName);
                // map.put("realFileName", realFileName);
                map.put("guid", guid);
                map.put("fileName", fileName);
                map.put("pathName", pathname);
                map.put("url", "/userfiles/$fileupload/app/" + guid + "." + suffix);
                map.put("size", multipartFile.getSize());
                map.put("suffix", suffix);

                list.add(map);

                saveFileEntity(map, multipartFile, fileEntity);
                FileUser fUser = saveFileUser(map, fileEntity);
                fUserList.add(fUser.getId());
            }

        }

        if (list.size() == 0 && result.equals("true")) {
            result = "false";
            message = "请选择上传文件";
        }

        Map<String, Object> messageMap = Maps.newHashMap();
        messageMap.put("list", list);
        messageMap.put("fUserlist", fUserList);
        messageMap.put("message", message);
        messageMap.put("result", result);

        String msg = JsonMapper.toJsonString(messageMap);
        logger.debug("fileupload msg:" + msg);
        return messageMap;
    }*/

    private FileUser saveFileUser(Map<String, Object> map, FileEntity fileEntity) {
        FileUser fileUser = new FileUser(fileEntity);
        fileUser.setFileName((String) map.get("fileName"));
        fileUser.setFileEntity(fileEntity);
        // fileUser.setFileCategory(uploadType);
        fileUser.setCreateBy(fileUser.getCurrentUser());
        fileUser.setStatus("0");
        List<FileUser> fileUserList = fileService.findFileUserList(fileUser);
        if (fileUserList.size() > 0) {
            fileUser = (FileUser) fileUserList.get(0);
        }
        fileService.saveFileUser(fileUser);
        return fileUser;
    }

    private void saveFileEntity(Map<String, Object> map, MultipartFile multipartFile, FileEntity fileEntity)
            throws Exception {
        fileEntity.setIsNewRecord(true);
        fileEntity.setId((String) map.get("guid"));
        String fileMd5 = getMd5ByFile(new File((String) map.get("pathName")));
        fileEntity.setFileSize((Long) map.get("size"));
        fileEntity.setFilePath(AjaxFileUploadUtil.relativePath);
        fileEntity.setFileMd5(fileMd5);
        fileEntity.setFileSuffix("." + (String) map.get("suffix"));
        fileEntity.setFileType(multipartFile.getContentType());
        fileService.saveFile(fileEntity);
    }

    /**
     * 下载
     * 
     * @param request
     * @param response
     * @return
     * @throws IOException
     * @throws ServletException
     */
    @RequestMapping(value = "filedownload")
    public void filedownload(HttpServletRequest request, HttpServletResponse response) throws IOException,
            ServletException {

        String filePath = request.getParameter("filepath");
        String fileName = request.getParameter("fileName");

        // WebOffice点聚中间件 http://www.dianju.cn/products/middleware/weboffice
        String docType = null;
        if (StringUtils.endsWithAny(filePath, ".doc", ".docx")) {
            docType = "doc";
        } else if (StringUtils.endsWithAny(filePath, ".xls", ".xlsx")) {
            docType = "xls";
        } else if (StringUtils.endsWithAny(filePath, ".ppt", ".pptx")) {
            docType = "ppt";
        } else if (StringUtils.endsWithAny(filePath, ".wps", ".wpt")) {
            docType = "wps";
        } else if (StringUtils.endsWithAny(filePath, ".pdf")) {
            docType = "pdf";
        }
        if (docType != null) {
            request.setAttribute("docType", docType);
            request.getRequestDispatcher("/static/weboffice/preview.jsp").forward(request, response);
            return;
        }
        if (StringUtils.endsWithAny(filePath, ".download")) {
            filePath = filePath.replaceFirst(".download", "");
        }

        // 下载文件
        response.reset();
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=" + Encodes.urlEncode(fileName));
        OutputStream os = null;
        try {
            os = response.getOutputStream();
            File file = new File(filePath);
            if (!file.exists()) {
                return;
            }
            FileUtils.copyFile(file, os);
        } finally {
            if (os != null) {
                os.close();
            }
        }

    }

    /**
     * 删除
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "filedelete")
    @ResponseBody
    public String filedelete(HttpServletRequest request, HttpServletResponse response) {
        String filepath = request.getParameter("filepath");
        String fileId = request.getParameter("guid");
        String fileUserId = request.getParameter("fUserlist");
        try {
            File file = new File(filepath);
            if (file.exists()) {
                deleteData(fileId, fileUserId);
                boolean ok = file.delete();
                System.out.println(ok);
                if (ok) {
                    return renderResult(Global.TRUE, "删除成功!");
                } else {
                    return renderResult(Global.FALSE, "删除失败!");
                }
            } else {
                return renderResult(Global.FALSE, "文件不存在");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return renderResult(Global.FALSE, "删除失败!");
        }
    }

    private void deleteData(String fileId, String fileUserId) {
        FileUser fileUser = fileService.getFileUser(fileUserId);
        FileEntity fileEntity = fileService.getFile(new FileEntity(fileId));
        // 根据文件ID查询关联业务
        List<FileUserBiz> fubList = fileService.findFileUserBizListByFileEntity(fileEntity);
        // 查看该文件是否映射多条上传关系 ，如果仅仅一条 且 fileUserId 是当前 用户 上传的则可以删除
        List<FileUser> fuList = fileService.findFileUserListByFileEntity(fileUser);

        // if (fubList == null || fubList.size() <= 0) {
        if (fuList != null && fuList.size() == 1) {
            FileUser fuTemp = fuList.get(0);
            if (fuTemp.getFileUserId().equals(fileUserId)) {
                // 真实删除数据记录和真实文件
                fileService.deleteFile(fileEntity);
                fileService.deleteFileUser(fileUser);
            }
        } else if (fuList != null && fuList.size() > 1) { //
            // 多条关系记录 仅仅逻辑删除 fileUser 表
            fileService.deleteFileUser(fileUser);
        } else {

        }
        // }
    }

    public static String getMd5ByFile(File file) throws FileNotFoundException {
        String value = null;
        FileInputStream in = new FileInputStream(file);
        try {
            MappedByteBuffer byteBuffer = in.getChannel().map(FileChannel.MapMode.READ_ONLY, 0, file.length());
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(byteBuffer);
            BigInteger bi = new BigInteger(1, md5.digest());
            value = bi.toString(16);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null != in) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return value;
    }

    // /**
    // * 文件上传service
    // */
    // @RequestMapping(value = "headFileupload")
    // @ResponseBody
    // public String headPhotoUpload(User user,MultipartHttpServletRequest
    // multipartRequest)
    // throws Exception {
    //
    // AjaxFileUploadUtil.init();
    //
    // String message = "上传成功";
    // String result = "true";
    // List<Map<String, Object>> list = Lists.newArrayList();
    //
    // // 获取多个file
    // for (Iterator<String> it = multipartRequest.getFileNames(); it
    // .hasNext();) {
    // String key = it.next();
    // MultipartFile multipartFile = multipartRequest.getFile(key);
    // String fileName = multipartFile.getOriginalFilename(); // 文件名
    // String suffix = fileName.substring(fileName.lastIndexOf(".") +
    // 1).toLowerCase(); // 文件后缀
    // boolean secondUpload = false;
    // if (StringUtils.isNotBlank(fileName)) {
    // FileEntity fileEntity = new FileEntity();
    // if (!AjaxFileUploadUtil.suffixs.contains(suffix)) {
    // message = "只支持" + AjaxFileUploadUtil.suffixMsg + "类型的文件！";
    // result = "false";
    // break;
    // }
    // if (multipartFile.getSize() > AjaxFileUploadUtil.sizeMax) {
    // message = "文件大小最大为" + AjaxFileUploadUtil.sizeMax;
    // result = "false";
    // break;
    // }
    //
    // String fieldName = multipartFile.getName();
    // String guid = IdGen.nextId();
    // String pathname = AjaxFileUploadUtil.getDataFileName(guid,
    // fileName);
    // InputStream in = multipartFile.getInputStream();
    // FileOutputStream out = new FileOutputStream(pathname);
    // StreamUtils.copy(in, out);
    // in.close();
    // out.close();
    //
    // Map<String, Object> map = Maps.newHashMap();
    // map.put("fieldName", fieldName);
    // map.put("guid", guid);
    // map.put("fileName", fileName);
    // map.put("pathname", pathname);
    // map.put("size", multipartFile.getSize());
    // map.put("suffix", suffix);
    //
    // list.add(map);
    //
    // File localFile = new File(pathname);
    // if (localFile.exists()) {
    // secondUpload = true;
    // }
    // if(!secondUpload){
    // saveFileEntity(map,multipartFile,fileEntity);
    // }
    // saveFileUser(map,fileEntity);
    //
    // }
    //
    // }
    //
    // if (list.size() == 0 && result.equals("true")) {
    // result = "false";
    // message = "请选择上传文件";
    // }
    //
    // Map<String, Object> messageMap = Maps.newHashMap();
    // messageMap.put("list", list);
    // messageMap.put("message", message);
    // messageMap.put("result", result);
    //
    // String msg = JsonMapper.toJsonString(messageMap);
    // logger.debug("fileupload msg:" + msg);
    // return msg;
    // }

}
