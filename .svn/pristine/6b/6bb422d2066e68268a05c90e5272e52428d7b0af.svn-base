/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.wareitems.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.modules.ass.articlesfile.entity.ArticlesFile;
import cn.net.ecode.modules.ass.articlesfile.service.ArticlesFileService;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheck;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheckDtl;
import cn.net.ecode.modules.ass.warehouse.entity.WarehouseInfo;
import cn.net.ecode.modules.ass.warehouse.service.WarehouseInfoService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.utils.DateUtils;
import cn.net.ecode.common.utils.excel.ExcelExport;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.wareitems.entity.WarehouseItems;
import cn.net.ecode.modules.ass.wareitems.service.WarehouseItemsService;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 仓库物品信息Controller
 *
 * @author tiange
 * @version 2018-10-13
 */
@Controller
@RequestMapping(value = "${adminPath}/wareitems/warehouseItems")
public class WarehouseItemsController extends BaseController {

    @Autowired
    private WarehouseItemsService warehouseItemsService;
    @Autowired
    private WarehouseInfoService warehouseInfoService;
    @Autowired
    private ArticlesFileService articlesFileService;
    /**
     * 获取数据
     */
    @ModelAttribute
    public WarehouseItems get(String id, boolean isNewRecord) {
        return warehouseItemsService.get(id, isNewRecord);
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("wareitems:warehouseItems:view")
    @RequestMapping(value = {"list", ""})
    public String list(WarehouseItems warehouseItems, Model model) {
		//获取仓库列表
		WarehouseInfo warehouseInfo = new WarehouseInfo();
        List<WarehouseInfo> warehouses=warehouseInfoService.findList(warehouseInfo);
        model.addAttribute("warehouses",warehouses);
		model.addAttribute("warehouseItems", warehouseItems);
		//获取物品名称
		ArticlesFile articlesFile = new ArticlesFile();
		List<ArticlesFile> articlesFiles = articlesFileService.findList(articlesFile);
		model.addAttribute("articlesFiles",articlesFiles);
        model.addAttribute("warehouseItems", warehouseItems);
        return "ecode/asset/base/wareitems/warehouseItemsList";
    }
    
	/**
	 * 查询收发存汇总列表
	 */
	@RequiresPermissions("wareitems:warehouseItems:view")
	@RequestMapping(value = {"wareSummaryList", ""})
	public String wareSummaryList(WarehouseItems warehouseItems, Model model) {
		//获取仓库列表
		WarehouseInfo warehouseInfo = new WarehouseInfo();
        List<WarehouseInfo> warehouses=warehouseInfoService.findList(warehouseInfo);
        model.addAttribute("warehouses",warehouses);
		model.addAttribute("warehouseItems", warehouseItems);
		//获取物品名称
		ArticlesFile articlesFile = new ArticlesFile();
		List<ArticlesFile> articlesFiles = articlesFileService.findList(articlesFile);
		model.addAttribute("articlesFiles",articlesFiles);
		return "ecode/asset/base/wareitems/wareSummaryList";
	}

    /**
     * 查询列表数据
     */
    @RequiresPermissions("wareitems:warehouseItems:view")
    @ResponseBody
    @RequestMapping(value = "listData")
    public Page<WarehouseItems> listData(WarehouseItems warehouseItems, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<WarehouseItems> page = warehouseItemsService.findPage(new Page<WarehouseItems>(request, response), warehouseItems);
        return page;
    }
    /**
     * 查询列表数据
     */
    @RequiresPermissions("wareitems:warehouseItems:view")
    @ResponseBody
    @RequestMapping(value = "listDataYuan")
    public List<WarehouseItems> listDataYuan(WarehouseItems warehouseItems, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<WarehouseItems> page = warehouseItemsService.findList(warehouseItems);
        return page;
    }
    /**
     * 查询列表数据
     */
    @RequiresPermissions("wareitems:warehouseItems:view")
    @ResponseBody
    @RequestMapping(value = "listDataTong")
    public List<WarehouseItems> listDataTong(WarehouseItems warehouseItems, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<WarehouseItems> page = warehouseItemsService.findList(warehouseItems);
        for(int i=0;i<page.size();i++){
            page.get(i).setCheckQty(page.get(i).getQty());
        }
        return page;
    }

    //导出资产盘点列表
    @RequestMapping(value = "warehouseItemsExport")
    public String warehouseItemsExport(WarehouseItems warehouseItems, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "办公用品盘点"+ DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<WarehouseItems> list = this.warehouseItemsService.findList(warehouseItems);
            (new ExcelExport( "办公用品盘点", WarehouseItems.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/assetcheck/assetCheck/list";

        }
    }
    /**
     * APP查询列表数据
     */
    @ResponseBody
    @RequestMapping(value = "listDataApp")
    public Map<String, Object> listDataApp(WarehouseItems warehouseItems, HttpServletRequest request, HttpServletResponse response, Model model) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            Page<WarehouseItems> page = warehouseItemsService.findPage(new Page<WarehouseItems>(request, response), warehouseItems);
            result.put("page",page);
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
     * 查看编辑表单
     */
    @RequiresPermissions("wareitems:warehouseItems:view")
    @RequestMapping(value = "form")
    public String form(WarehouseItems warehouseItems, Model model) {
        model.addAttribute("warehouseItems", warehouseItems);
        return "ecode/asset/base/wareitems/warehouseItemsForm";
    }

    /**
     * 查看仓库库存
     */
    @ResponseBody
    @RequestMapping(value = "getQty")
    public Map<String, Object> getqty(WarehouseItems warehouseItems, HttpServletRequest request, HttpServletResponse response, Model model) {
        Map<String, Object> map = new HashMap<>();
        WarehouseItems warehouseItems1 = warehouseItemsService.getQty(warehouseItems);
        map.put("qty", warehouseItems1.getQty());
        return map;
    }

    /**
     * 保存数据
     */
    @RequiresPermissions("wareitems:warehouseItems:edit")
    @ResponseBody
    @RequestMapping(value = "save")
    public String save(WarehouseItems warehouseItems) {
        StringBuilder message = new StringBuilder();
        if (!beanValidator(message, warehouseItems)) {
            return renderResult(Global.FALSE, message);
        }
        warehouseItemsService.save(warehouseItems);
        return renderResult(Global.TRUE, "保存仓库物品信息成功！");
    }
    
    @RequiresPermissions("wareitems:warehouseItems:edit")
    @RequestMapping(value = "export")
    public String pwdAuditExport(WarehouseItems warehouseItems, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "即时库存查询列表" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<WarehouseItems> list = this.warehouseItemsService.findAllList(warehouseItems);
            for (int i = 0; i < list.size(); i++) {
            	WarehouseItems warehouseItems1 = list.get(i);
            }
            (new ExcelExport("即时库存查询列表", WarehouseItems.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/wareitems/warehouseItems/list";
        }
    }

    /**
     * 删除数据
     */
    @RequiresPermissions("wareitems:warehouseItems:edit")
    @ResponseBody
    @RequestMapping(value = "delete")
    public String delete(WarehouseItems warehouseItems) {
        warehouseItemsService.delete(warehouseItems);
        return renderResult(Global.TRUE, "删除仓库物品信息成功！");
    }

    /**
     * 查看仓库数据
     */
    @RequestMapping(value = "getWarehouseinfo")
    public String getWarehouseinfo(WarehouseItems warehouseItems, HttpServletRequest request, HttpServletResponse response, Model model) {
    	
    	//得到仓库名称
        WarehouseInfo warehouseInfo = new WarehouseInfo();
        List<WarehouseInfo> warehouses = warehouseInfoService.findList(warehouseInfo);
        model.addAttribute("warehouses", warehouses);
        
    	return "ecode/asset/base/wareitems/warehouseJumpList";
    }

    /**
     * 通过仓库名查数据
     */
    @RequestMapping(value = "getWarehouseinfoCode")
    public String getWarehouseinfoCode(WarehouseItems warehouseItems, HttpServletRequest request, HttpServletResponse response, Model model) {
        return "ecode/asset/base/wareitems/warehouseUnJumpList";
    }
}