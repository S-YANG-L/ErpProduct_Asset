/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.warehouse.web;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.supplier.entity.SupplierInfo;
import cn.net.ecode.modules.ass.wareitems.entity.WarehouseItems;
import cn.net.ecode.modules.ass.wareitems.service.WarehouseItemsService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.articlesfile.entity.ArticlesFile;
import cn.net.ecode.modules.ass.warehouse.entity.WarehouseInfo;
import cn.net.ecode.modules.ass.warehouse.service.WarehouseInfoService;

/**
 * 仓库管理Controller
 * @author sun
 * @version 2018-09-18
 */
@Controller
@RequestMapping(value = "${adminPath}/warehouse/WarehouseInfo")
public class WarehouseInfoController extends BaseController {
	@Autowired
	private WarehouseItemsService warehouseItemsService;
	@Autowired
	private WarehouseInfoService warehouseInfoService;
	
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public WarehouseInfo get(String id, boolean isNewRecord) {
		return warehouseInfoService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("warehouse:WarehouseInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(WarehouseInfo WarehouseInfo, Model model) {
		model.addAttribute("WarehouseInfo", WarehouseInfo);
		return "ecode/asset/base/warehouse/WarehouseInfoList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("warehouse:WarehouseInfo:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<WarehouseInfo> listData(WarehouseInfo WarehouseInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WarehouseInfo> page = warehouseInfoService.findPage(new Page<WarehouseInfo>(request, response), WarehouseInfo);
		return page;
	}
	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("warehouse:WarehouseInfo:view")
	@RequestMapping(value = "form")
	public String form(WarehouseInfo WarehouseInfo, Model model) {
		if(WarehouseInfo.getIsNewRecord()){
			List<WarehouseInfo>  warehouseInfos=warehouseInfoService.findList(WarehouseInfo);
			if(warehouseInfos.size()!=0){
				Collections.sort(warehouseInfos, new Comparator<WarehouseInfo>() {
					@Override
					public int compare(WarehouseInfo o1, WarehouseInfo o2) {
						int a= Integer.parseInt(o1.getWarehouseCode());
						int b= Integer.parseInt(o2.getWarehouseCode());
						int i = a-b;
						return i;
					}
				});
				int newCode= Integer.parseInt(warehouseInfos.get(warehouseInfos.size()-1).getWarehouseCode());
				WarehouseInfo.setWarehouseCode(String.valueOf(newCode+1));
			}else{
				WarehouseInfo.setWarehouseCode("10001");
			}
		}
		model.addAttribute("WarehouseInfo", WarehouseInfo);
		return "ecode/asset/base/warehouse/WarehouseInfoForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("warehouse:WarehouseInfo:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(WarehouseInfo WarehouseInfo) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, WarehouseInfo)){
			return renderResult(Global.FALSE, message);
		}
		if(WarehouseInfo.getIsNewRecord()){
			List<WarehouseInfo> list = warehouseInfoService.findAllList(WarehouseInfo);
			for (int i = 0; i < list.size(); i++) {
				WarehouseInfo warehouseInfo =  list.get(i);
				if (warehouseInfo.getWarehouseCode().equals(WarehouseInfo.getWarehouseCode())){
					return renderResult(Global.FALSE, "仓库编码不能重复");
				}
				if (warehouseInfo.getWarehouseName().equals(WarehouseInfo.getWarehouseName())){
					return renderResult(Global.FALSE, "仓库名称不能重复");
				}
			}
		}
		warehouseInfoService.save(WarehouseInfo);
		return renderResult(Global.TRUE, "保存仓库管理成功！");
	}

	/**
	 * 删除数据
	 */
	@RequiresPermissions("warehouse:WarehouseInfo:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(WarehouseInfo WarehouseInfo) {
		WarehouseItems warehouseItems=new WarehouseItems();
		warehouseItems.setWhCode(WarehouseInfo.getWarehouseCode());
		List<WarehouseItems> warehouseItems1=warehouseItemsService.getWhcode(warehouseItems);
		if(warehouseItems1.size()>0){
			return renderResult(Global.FALSE, "该仓库已经存放货物,不能删除！");
		}else{
			warehouseInfoService.deleteDtl(WarehouseInfo);
			return renderResult(Global.TRUE, "删除仓库管理成功！");
		}

	}

	/**
	 * 物理 删除数据
	 */
	@RequiresPermissions("warehouse:WarehouseInfo:edit")
	@ResponseBody
	@RequestMapping(value = "deleteDtl")
	public String deleteDtl(WarehouseInfo WarehouseInfo) {
		WarehouseItems warehouseItems=new WarehouseItems();
		warehouseItems.setWhCode(WarehouseInfo.getWarehouseCode());
		List<WarehouseItems> warehouseItems1=warehouseItemsService.getWhcode(warehouseItems);
		if(warehouseItems1.size()>0){
				return renderResult(Global.FALSE, "该仓库已经存放货物,不能删除！");
		}else{
			warehouseInfoService.deleteDtl(WarehouseInfo);
			return renderResult(Global.TRUE, "删除仓库管理成功！");
		}
	}
	/**
	 * 停用数据
	 */
	@RequiresPermissions("warehouse:WarehouseInfo:edit")
	@ResponseBody
	@RequestMapping(value = "disable")
	public String disable(WarehouseInfo WarehouseInfo) {
		WarehouseInfo.preUpdate();
		warehouseInfoService.disable(WarehouseInfo);
		return renderResult(Global.TRUE, "停用仓库管理成功！");
	}
	
	
	/**
	 * 启用数据
	 */
	@RequiresPermissions("warehouse:WarehouseInfo:edit")
	@ResponseBody
	@RequestMapping(value = "activate")
	public String normal(WarehouseInfo WarehouseInfo) {
		WarehouseInfo.preUpdate();
		warehouseInfoService.normal(WarehouseInfo);
		return renderResult(Global.TRUE, "启用仓库管理成功！");
	}
	/**
	 * APP端保存仓库
	 * @author tiange
	 * @param WarehouseInfo
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
    @ResponseBody
	@RequestMapping(value = "saveAPP")
	public Map<String, Object> saveAPP(WarehouseInfo WarehouseInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			warehouseInfoService.save(WarehouseInfo);
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
     * APP端仓库列表
     * @author tiange
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "getWarehouseInfoList")
    public Map<String, Object> getArticlesfileList(WarehouseInfo WarehouseInfo,HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            List<WarehouseInfo> list = warehouseInfoService.findList(WarehouseInfo);
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
    /**
     * APP端仓库编辑
     * @author tiange
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getWarehouseInfoApp")
    public  Map<String, Object> getWarehouseInfoApp(String id){
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            result.put("page", warehouseInfoService.get(id));
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