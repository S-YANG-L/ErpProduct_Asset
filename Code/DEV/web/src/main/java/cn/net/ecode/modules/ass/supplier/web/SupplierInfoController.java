/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.supplier.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
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
import cn.net.ecode.modules.ass.supplier.entity.SupplierInfo;
import cn.net.ecode.modules.ass.supplier.service.SupplierInfoService;

import java.util.*;

/**
 * 供货商Controller
 * @author zhaohongbin
 * @version 2018-11-03
 */
@Controller
@RequestMapping(value = "${adminPath}/supplier/supplierInfo")
public class SupplierInfoController extends BaseController {

	@Autowired
	private SupplierInfoService supplierInfoService;
	@Autowired
	private AssetInfoService assetInfoService;
	
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public SupplierInfo get(String id, boolean isNewRecord) {
		return supplierInfoService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("supplier:supplierInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(SupplierInfo supplierInfo, Model model) {
		model.addAttribute("supplierInfo", supplierInfo);
		return "ecode/asset/base/supplier/supplierInfoList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("supplier:supplierInfo:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<SupplierInfo> listData(SupplierInfo supplierInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SupplierInfo> page = supplierInfoService.findPage(new Page<SupplierInfo>(request, response), supplierInfo); 
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("supplier:supplierInfo:view")
	@RequestMapping(value = "form")
	public String form(SupplierInfo supplierInfo, Model model) {
		model.addAttribute("supplierInfo", supplierInfo);
		return "ecode/asset/base/supplier/supplierInfoForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("supplier:supplierInfo:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(SupplierInfo supplierInfo) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, supplierInfo)){
			return renderResult(Global.FALSE, message);
		}
		if(supplierInfo.getIsNewRecord()){
			List<SupplierInfo> list = supplierInfoService.findAllList(supplierInfo);
			for (int i = 0; i < list.size(); i++) {
				SupplierInfo supplierInfo1 =  list.get(i);
				if (supplierInfo1.getSupplierCode().equals(supplierInfo.getSupplierCode())){
					return renderResult(Global.FALSE, "纳税人识别号不能重复");
				}
				if (supplierInfo1.getSupplierName().equals(supplierInfo.getSupplierName())){
					return renderResult(Global.FALSE, "供货商名称不能重复");
				}
			}
		}else{
			List<SupplierInfo> list = supplierInfoService.findAllList(supplierInfo);
			SupplierInfo supplierInfo2 =  supplierInfoService.get(supplierInfo);
			for (int i = 0; i < list.size(); i++) {
				SupplierInfo supplierInfo1 =  list.get(i);
				if (supplierInfo1.getSupplierCode().equals(supplierInfo2.getSupplierCode())){
					list.remove(i);
				}
			}
			for (int i = 0; i < list.size(); i++) {
				SupplierInfo supplierInfo1 =  list.get(i);
				if (supplierInfo1.getSupplierCode().equals(supplierInfo.getSupplierCode())){
					return renderResult(Global.FALSE, "纳税人识别号不能重复");
				}
				if (supplierInfo1.getSupplierName().equals(supplierInfo.getSupplierName())){
					return renderResult(Global.FALSE, "供货商名称不能重复");
				}
			}
		}
		supplierInfoService.save(supplierInfo);
		return renderResult(Global.TRUE, "保存供货商成功！");
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("supplier:supplierInfo:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(SupplierInfo supplierInfo) {
		AssetInfo assetInfo=new AssetInfo();
		assetInfo.setSupplierCode(supplierInfo.getId());
		List<AssetInfo> assetInfos=assetInfoService.findList(assetInfo);
	    if(assetInfos.size()>0){
			return renderResult(Global.FALSE, "该供货商已经提供过货源,不能删除！");
		}else{
			supplierInfoService.delete(supplierInfo);
			return renderResult(Global.TRUE, "删除供货商成功！");
		}
	}
    /**
     * App获取供应商列表接口
     * @param supplierInfo
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "supplierListApp")
    public Map<String , Object> supplierListApp(SupplierInfo supplierInfo, HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            Page page = new Page<SupplierInfo>(request, response);
            Page<SupplierInfo> page1 = supplierInfoService.findPage(page, supplierInfo);
            result.put("page",page1);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
}