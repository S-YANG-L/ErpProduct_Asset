/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.officesupplies.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import cn.net.ecode.modules.ass.officesupplies.entity.SuppliesInfo;
import cn.net.ecode.modules.ass.officesupplies.service.SuppliesInfoService;

/**
 * 办公用品Controller
 * @author sun
 * @version 2018-09-10
 */
@Controller
@RequestMapping(value = "${adminPath}/officesupplies/suppliesInfo")
public class SuppliesInfoController extends BaseController {

	@Autowired
	private SuppliesInfoService suppliesInfoService;
	
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public SuppliesInfo get(String id, boolean isNewRecord) {
		return suppliesInfoService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("officesupplies:suppliesInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(SuppliesInfo suppliesInfo, Model model) {
		model.addAttribute("suppliesInfo", suppliesInfo);
		return "ecode/asset/base/officesupplies/suppliesInfoList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("officesupplies:suppliesInfo:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<SuppliesInfo> listData(SuppliesInfo suppliesInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SuppliesInfo> page = suppliesInfoService.findPage(new Page<SuppliesInfo>(request, response), suppliesInfo); 
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("officesupplies:suppliesInfo:view")
	@RequestMapping(value = "form")
	public String form(SuppliesInfo suppliesInfo, Model model) {
		model.addAttribute("suppliesInfo", suppliesInfo);
		return "ecode/asset/base/officesupplies/suppliesInfoForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("officesupplies:suppliesInfo:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(SuppliesInfo suppliesInfo) {
		StringBuilder message = new StringBuilder();
		List<SuppliesInfo> listsuppliesCode=suppliesInfoService.getprosuppliesCode(suppliesInfo);
		if(suppliesInfo.getIsNewRecord()){
			if(listsuppliesCode.size()!=0){
				return renderResult(Global.FALSE,"不符合办公用品编码唯一性!");
			}
			
		}
		
		
		if (!beanValidator(message, suppliesInfo)){
			return renderResult(Global.FALSE, message);
		}
		suppliesInfoService.save(suppliesInfo);
		return renderResult(Global.TRUE, "保存办公用品成功！");
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("officesupplies:suppliesInfo:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(SuppliesInfo suppliesInfo) {
		suppliesInfoService.delete(suppliesInfo);
		return renderResult(Global.TRUE, "删除办公用品成功！");
	}
	
	/**
	 * 物理删除数据
	 */
	@RequiresPermissions("officesupplies:suppliesInfo:edit")
	@ResponseBody
	@RequestMapping(value = "deleteDtl")
	public String deleteDtl(SuppliesInfo suppliesInfo) {
		suppliesInfoService.deleteDtl(suppliesInfo);
		return renderResult(Global.TRUE, "删除办公用品成功！");
	}
}