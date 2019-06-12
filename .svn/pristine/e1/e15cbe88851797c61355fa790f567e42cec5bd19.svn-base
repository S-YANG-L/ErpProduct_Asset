/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.articlesfile.web;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.modules.ass.assetsclassify.entity.AssetSort;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.wareitems.entity.WarehouseItems;
import cn.net.ecode.modules.ass.wareitems.service.WarehouseItemsService;
import com.fr.web.core.A.W;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.articlesfile.entity.ArticlesFile;
import cn.net.ecode.modules.ass.articlesfile.service.ArticlesFileService;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedInfo;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.UserDict;
import cn.net.ecode.modules.sys.service.UserDictService;

/**
 * 办公用品档案管理Controller
 * @author yangjianjun
 * @version 2018-09-29
 */
@Controller
@RequestMapping(value = "${adminPath}/articlesfile/articlesFile")
public class ArticlesFileController extends BaseController {
	@Autowired
	private WarehouseItemsService warehouseItemsService;
	@Autowired
	private ArticlesFileService articlesFileService;
	@Autowired
	private UserDictService userDictService;
	@Autowired
	private CodeRuleService codeRuleService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public ArticlesFile get(String id, boolean isNewRecord) {
		return articlesFileService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("articlesfile:articlesFile:view")
	@RequestMapping(value = {"list", ""})
	public String list(ArticlesFile articlesFile, Model model) {
		model.addAttribute("articlesFile", articlesFile);
		return "ecode/asset/base/articlesfile/articlesFileList";
	}
	
	/**
	 * 查询采购办公用品列表
	 */
	@RequiresPermissions("articlesfile:articlesFile:view")
	@RequestMapping(value = {"articlesList", ""})
	public String articlesList(ArticlesFile articlesFile, Model model) {

		model.addAttribute("articlesFile", articlesFile);
		return "ecode/asset/base/articlesfile/articlesList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("articlesfile:articlesFile:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<ArticlesFile> listData(ArticlesFile articlesFile, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ArticlesFile> page = articlesFileService.findPage(new Page<ArticlesFile>(request, response), articlesFile); 
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("articlesfile:articlesFile:view")
	@RequestMapping(value = "form")
	public String form(ArticlesFile articlesFile, Model model) {
		model.addAttribute("articlesFile", articlesFile);
		return "ecode/asset/base/articlesfile/articlesFileForm";
	}
	/**
	 * 保存数据
	 */
	@RequiresPermissions("articlesfile:articlesFile:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(ArticlesFile articlesFile) {
		//生成办公用品编码:BGYP+当前年月日+6位流水号
		//生成办公用品编码
		if (articlesFile.getIsNewRecord()) {
			articlesFile.setArticlesCode(codeRuleService.createBgCode("BGDA","办公用品档案"));
		}
		articlesFileService.save(articlesFile);
		return renderResult(Global.TRUE, "保存办公用品档案成功！");
	}
	/**
	 * 删除数据
	 */
	@RequiresPermissions("articlesfile:articlesFile:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(ArticlesFile articlesFile) {
		WarehouseItems warehouseItems=new WarehouseItems();
		warehouseItems.setArticlesCode(articlesFile.getArticlesCode());
		List<WarehouseItems> warehouseItemsList=warehouseItemsService.findList(warehouseItems);
		if(warehouseItemsList.size()>0){
			return renderResult(Global.FALSE, "已经入库不能删除！");
		}else{
			articlesFileService.delete(articlesFile);
			return renderResult(Global.TRUE, "删除办公用品档案成功！");
		}
	}
	/**
	 * 获取办公用品分类结构数据。
	 * @param extCode 排除的ID
	 */
	@ResponseBody
	@RequestMapping(value = "sortTreeData")
	public List<Map<String, Object>> sortTreeData(String extCode, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		//定义用户字段实体
		UserDict userDict = new UserDict();
		//set用户字典编码
		userDict.setDictTypeCode("office_supplies_code");
		List<UserDict> list = userDictService.findList(userDict);
		for (int i=0; i<list.size(); i++){
			UserDict e = list.get(i);
			if ((StringUtils.isBlank(extCode) || (extCode!=null && !extCode.equals(e.getId()) && e.getParentCodes().indexOf(","+extCode+",")==-1))
					&&(e.getStatus().equals("0"))){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getDictCode());
				map.put("pId", e.getParentCode());
				map.put("pIds", e.getParentCodes());
				map.put("name", e.getDictName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	/**APP端获取办公用品分类树级列表
	 * @param request
	 * @param response
	 * @throws Exception
	 * @author xulan
	 * @date 2018年10月10日17:16:17
	 */
	@ResponseBody
	@RequestMapping(value = "sortTreeDataAPP")
	public Map<String, Object> getTreeData(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			//定义用户字段实体
			UserDict userDict = new UserDict();
			//set用户字典编码
			userDict.setDictTypeCode("office_supplies_code");
			List<UserDict> list = userDictService.findList(userDict);
			List<UserDict> list1=new ArrayList<>();
			for(int i=0;i<list.size();i++){
				if(list.get(i).getSortGrade()==1){
					list1.add(list.get(i));
				}
			}
			result.put("data",list1);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {// 失败
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	/**APP端保存办公用品档案
	 * @author tiange
	 * @param articlesFile
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
    @ResponseBody
	@RequestMapping(value = "saveAPP")
	public Map<String, Object> saveAPP(ArticlesFile articlesFile, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			//生成办公用品编码:BGYP+当前年月日+6位流水号
			if (articlesFile.getIsNewRecord()) {
				String articlesCode ="BGYP";
				SimpleDateFormat codeDate = new SimpleDateFormat("yyyyMMdd");
				articlesCode = articlesCode + codeDate.format(new Date());
				Random random = new Random();
				for(int i=0;i<6;i++){
					articlesCode+=random.nextInt(10);
				}
				articlesFile.setArticlesCode(articlesCode);
		     }
			articlesFileService.save(articlesFile);
			result.put("code", "200");
			result.put("message", "success");

		} catch (Exception e) {// 如果失败 result存这个
			e.printStackTrace();
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
    
	/**
	 * APP端获取办公用品档案列表
	 * @author tiange
	 * @param articlesFile
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
    @ResponseBody
    @RequestMapping(value = "getArticlesfileList")
    public Map<String, Object> getArticlesfileList(ArticlesFile articlesFile,HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            List<ArticlesFile> list = articlesFileService.findList(articlesFile);
            result.put("page", list);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**APP端办公用品档案编辑
     * @author tiange
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getArticlesfileApp")
    public  Map<String, Object> getArticlesfileApp(String id){
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            result.put("page", articlesFileService.get(id));
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    
}