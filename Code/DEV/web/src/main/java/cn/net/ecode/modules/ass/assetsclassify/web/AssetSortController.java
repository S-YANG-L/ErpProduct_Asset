/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsclassify.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import cn.net.ecode.common.persistence.TreeEntity;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.assetsclassify.entity.AssetSort;
import cn.net.ecode.modules.ass.assetsclassify.service.AssetSortService;

/**
 * assetsortController
 * @author tiantongwang
 * @version 2018-09-11
 */
@Controller
@RequestMapping(value = "${adminPath}/ass/assetSort")
public class AssetSortController extends BaseController {

	@Autowired
	private AssetSortService assetSortService;
	
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public AssetSort get(String id, boolean isNewRecord) {
		return assetSortService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("ass:assetSort:view")
	@RequestMapping(value = {"list", ""})
	public String list(AssetSort assetSort, Model model) {
		model.addAttribute("assetSort", assetSort);
		return "ecode/asset/base/assetsclassify/assetSortList";
	}

	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("ass:assetSort:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public List<AssetSort> listData(AssetSort assetSort) {
		if (StringUtils.isBlank(assetSort.getParentCode())) {
			assetSort.setParentCode(AssetSort.ROOT_CODE);
		}
		List<AssetSort> list = null;
		if (StringUtils.isNotBlank(assetSort.getId())){
			list = Lists.newArrayList(get(assetSort.getId(), false));
		}else{
			list = assetSortService.findList(assetSort);
		}
		return list;
	}
	
	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("ass:assetSort:view")
	@RequestMapping(value = "form")
	public String form(AssetSort assetSort, Model model) {
		if (assetSort.getParent() != null && StringUtils.isNotBlank(assetSort.getParent().getId())) {
			assetSort.setParent(assetSortService.get(assetSort.getParent().getId()));
		} else {
			assetSort.setParentCode(TreeEntity.ROOT_CODE);
		}
		if (StringUtils.isBlank(assetSort.getId())) {
			assetSort.setSorts(assetSortService.getMaxSort(assetSort) + 30);
			// int size=assetSortService.getMaxSize(assetSort) ;
			// assetSort.setId(assetSort.getParent().getId() + StringUtils.leftPad(String.valueOf(size > 0 ? size+1 : 1), 3, "0"));
			assetSort.setId(IdGen.nextId());	
			assetSort.setIsNewRecord(true);
		}
		model.addAttribute("assetSort", assetSort);
		return "ecode/asset/base/assetsclassify/assetSortForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("ass:assetSort:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(AssetSort assetSort) {
		if(Global.isDemoMode()){
			return renderResult(Global.FALSE, "演示模式，不允许操作！");
		}
		StringBuilder builder = new StringBuilder();

		/**
		 * 分类编码唯一性检验
		 */
		List<AssetSort> assetSorts = assetSortService.getSortCodes(assetSort);
/*		if(assetSort.getIsNewRecord()){
			if(assetSorts.size()!=0){
				return renderResult(Global.FALSE, "分类编码已经存在！");
			}
		}*/
		if (!beanValidator(builder, assetSort)){
			return renderResult(Global.FALSE, builder.toString());
		}
		assetSortService.save(assetSort);
		return renderResult(Global.TRUE, "保存分类成功");		
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("ass:assetSort:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(AssetSort assetSort) {
		assetSortService.delete(assetSort);
		return renderResult(Global.TRUE, "删除分类成功！");
	}
	
	/**
	 * 停用
	 */
	@RequiresPermissions("ass:assetSort:disable")
	@ResponseBody
	@RequestMapping(value = "disable")
	public String disable(AssetSort assetSort) {
		if(Global.isDemoMode()){
			return renderResult(Global.FALSE, "演示模式，不允许操作！");
		}
		
		List<AssetSort> assetSortList = assetSortService.getEnabledList(assetSort);
		if(assetSortList!=null&&assetSortList.size()>0){
			return renderResult(Global.FALSE, "分类包含未停用的，请先停用子节点！");
		}
		assetSortService.disable(assetSort);
		return renderResult(Global.TRUE, "停用分类成功");
	}
	
	/**
	 * 按组停用
	 */
	@RequiresPermissions("ass:assetSort:disable")
	@ResponseBody
	@RequestMapping(value = "disableByGroup")
	public String disableByGroup(AssetSort assetSort) {
		if(Global.isDemoMode()){
			return renderResult(Global.FALSE, "演示模式，不允许操作！");
		}
		assetSortService.disableByGroup(assetSort);
		return renderResult(Global.TRUE, "停用分类及子成功");
	}
	
	/**
	 * 启用
	 */
	@RequiresPermissions("ass:assetSort:enable")
	@ResponseBody
	@RequestMapping(value = "enable")
	public String enable(AssetSort assetSort) {
		if(Global.isDemoMode()){
			return renderResult(Global.FALSE, "演示模式，不允许操作！");
		}
		assetSortService.enable(assetSort);
		return renderResult(Global.TRUE, "启用分类成功");
	}
	
	/**
	 * 按组启用
	 */
	@RequiresPermissions("ass:assetSort:enable")
	@ResponseBody
	@RequestMapping(value = "enableByGroup")
	public String enableByGroup(AssetSort assetSort) {
		if(Global.isDemoMode()){
			return renderResult(Global.FALSE, "演示模式，不允许操作！");
		}
		assetSortService.enableByGroup(assetSort);
		return renderResult(Global.TRUE, "启用分类及子成功");
	}

	/**
	 * 获取结构数据。
	 * @param id 排除的ID
	 */
	@ResponseBody
	@RequestMapping(value = "treeDataXiao")
	public List<Map<String, Object>> treeDataXiao(String id, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
        AssetSort assetSort=new AssetSort();
        List<AssetSort> list = assetSortService.findList(assetSort);
		for (int i=0; i<list.size(); i++){
			AssetSort e = list.get(i);
			if ((StringUtils.isBlank(id) || (id!=null && !id.equals(e.getId()) && e.getParentCodes().indexOf(","+id+",")==-1))
					&&(e.getStatus().equals("0"))){
				Map<String, Object> mapss = Maps.newHashMap();
				mapss.size();
			}else{
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", e.getId());
                map.put("pId", e.getParentCode());
                map.put("pIds", e.getParentCodes());
                map.put("name", e.getSortName());
                mapList.add(map);
            }
		}
		return mapList;
	}
	/**
	 * 获取结构数据。
	 * @param id 排除的ID
	 */
	@ResponseBody
	@RequestMapping(value = "treeDataXiaoNULL")
	public List<Map<String, Object>> treeDataXiaoNULL(String id, HttpServletResponse response) {
		List<Map<String, Object>> mapList=new ArrayList<>();
//				Map<String, Object> map = Maps.newHashMap();
//				map.put("id","");
//				map.put("pId","");
//				map.put("pIds","");
//				map.put("name","(空)");
//				mapList.add(map);
		return mapList;
	}
    /**
     * 获取结构数据。
     * @param extCode 排除的ID
     */
//	@RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "treeData")
    public List<Map<String, Object>> treeData(String extCode, HttpServletResponse response) {
        List<Map<String, Object>> mapList = Lists.newArrayList();
        List<AssetSort> list = assetSortService.findAllList(new AssetSort());
        for (int i=0; i<list.size(); i++){
            AssetSort e = list.get(i);
            if ((StringUtils.isBlank(extCode) || (extCode!=null && !extCode.equals(e.getId()) && e.getParentCodes().indexOf(","+extCode+",")==-1))
                    &&(e.getStatus().equals("0"))){
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", e.getId());
                map.put("pId", e.getParentCode());
                map.put("pIds", e.getParentCodes());
                map.put("name", e.getSortName());
                mapList.add(map);
            }
        }
        return mapList;
    }
	/**
	 * 获取结构数据第一层。
	 * @param extCode 排除的ID
	 */
	@ResponseBody
	@RequestMapping(value = "treeDataTopApp")
	public Map<String, Object> treeDataTopApp(String extCode, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			AssetSort assetSort=new AssetSort();
			List<AssetSort> list = assetSortService.findListTop(assetSort);
			result.put("data", list);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {// 失败
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	/**
	 * APP获取结构数据。
	 * @param id 排除的ID
	 */
	@ResponseBody
	@RequestMapping(value = "treeDataXiaoApp")
	public Map<String, Object> treeDataXiaoApp(String id, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<AssetSort> listreturn =new ArrayList<>();
			AssetSort assetSort=new AssetSort();
			List<AssetSort> list = assetSortService.findList(assetSort);
			for (int i=0; i<list.size(); i++){
				AssetSort e = list.get(i);
				if ((StringUtils.isBlank(id) || (id!=null && !id.equals(e.getId()) && e.getParentCodes().indexOf(","+id+",")==-1))
						&&(e.getStatus().equals("0"))){
				}else{
					listreturn.add(e);
				}
			}
			result.put("data", listreturn);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {// 失败
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
    /**
     * 获取结构数据第一层。
     * @param extCode 排除的ID
     */
    @ResponseBody
    @RequestMapping(value = "treeDataTop")
    public List<Map<String, Object>> treeDataTop(String extCode, HttpServletResponse response) {
        List<Map<String, Object>> mapListtt = Lists.newArrayList();
        AssetSort assetSort=new AssetSort();
        List<AssetSort> list = assetSortService.findListTop(assetSort);
        for (int i=0; i<list.size(); i++){
            AssetSort e = list.get(i);
            if ((StringUtils.isBlank(extCode) || (extCode!=null && !extCode.equals(e.getId()) && e.getParentCodes().indexOf(","+extCode+",")==-1))
                    &&(e.getStatus().equals("0"))){
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", e.getId());
                map.put("pId", e.getParentCode());
                map.put("pIds", e.getParentCodes());
                map.put("name", e.getSortName());
                mapListtt.add(map);
            }
        }
        return mapListtt;
    }
	/**
	 * 树结构数据修复
	 * @return
	 */
	@RequiresPermissions("ass:assetSort:edit")
	@ResponseBody
	@RequestMapping(value = "dataFix")
	public String dataFix(){
		assetSortService.updateFixParentCodes();
		return renderResult(Global.TRUE, "数据修复成功");
	}
	
	/**APP端获取资产分类树级列表
	 * @param request
	 * @param response
	 * @throws Exception
	 * @author xulan
	 * @date 2018年10月10日17:16:1734r
	 */
	@ResponseBody
	@RequestMapping(value = "getTreeData")
	public Map<String, Object> getTreeData(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<AssetSort> list = assetSortService.findAllList(new AssetSort());
			result.put("data", list);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {// 失败
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
}