/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.usedinfo.web;

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
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;
import cn.net.ecode.modules.ass.usedinfo.service.AssetUsedDtlService;

/**
 * 资产领用子表Controller
 * @author zhaohongbin
 * @version 2018-09-20
 */
@Controller
@RequestMapping(value = "${adminPath}/usedinfo/assetUsedDtl")
public class AssetUsedDtlController extends BaseController {

	@Autowired
	private AssetUsedDtlService assetUsedDtlService;
	
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public AssetUsedDtl get(String id, boolean isNewRecord) {
		return assetUsedDtlService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("usedinfo:assetUsedDtl:view")
	@RequestMapping(value = {"list", ""})
	public String list(AssetUsedDtl assetUsedDtl, Model model) {
		model.addAttribute("assetUsedDtl", assetUsedDtl);
		return "ecode/asset/base/usedinfo/assetUsedDtlList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("usedinfo:assetUsedDtl:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<AssetUsedDtl> listData(AssetUsedDtl assetUsedDtl, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AssetUsedDtl> page = assetUsedDtlService.findPage(new Page<AssetUsedDtl>(request, response), assetUsedDtl); 
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("usedinfo:assetUsedDtl:view")
	@RequestMapping(value = "form")
	public String form(AssetUsedDtl assetUsedDtl, Model model) {
		model.addAttribute("assetUsedDtl", assetUsedDtl);
		return "ecode/asset/base/usedinfo/assetUsedDtlForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("usedinfo:assetUsedDtl:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(AssetUsedDtl assetUsedDtl) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, assetUsedDtl)){
			return renderResult(Global.FALSE, message);
		}
		assetUsedDtlService.save(assetUsedDtl);
		return renderResult(Global.TRUE, "保存资产领用子表成功！");
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("usedinfo:assetUsedDtl:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(AssetUsedDtl assetUsedDtl) {
		assetUsedDtlService.delete(assetUsedDtl);
		return renderResult(Global.TRUE, "删除资产领用子表成功！");
	}

}