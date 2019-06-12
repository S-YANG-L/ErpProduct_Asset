/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.borrow.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
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
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowDtl;
import cn.net.ecode.modules.ass.borrow.service.AssetBorrowDtlService;

import java.util.List;

/**
 * 资产借用归还子表Controller
 */
@Controller
@RequestMapping(value = "${adminPath}/borrow/assetBorrowDtl")
public class AssetBorrowDtlController extends BaseController {

	@Autowired
	private AssetBorrowDtlService assetBorrowDtlService;

	/**
	 * 获取数据
	 */
	@ModelAttribute
	public AssetBorrowDtl get(String id, boolean isNewRecord) {
		return assetBorrowDtlService.get(id, isNewRecord);
	}

	/**
	 * 查询列表
	 */
	//@RequiresPermissions("borrow:assetBorrowDtl:view")
	@RequestMapping(value = {"list", ""})
	public String list(AssetBorrowDtl assetBorrowDtl, Model model) {
		model.addAttribute("assetBorrowDtl", assetBorrowDtl);
		return "ecode/asset/base/borrow/assetBorrowDtlList";
	}

	/**
	 * 查询列表数据
	 */
	//@RequiresPermissions("borrow:assetBorrowDtl:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<AssetBorrowDtl> listData(AssetBorrowDtl assetBorrowDtl, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AssetBorrowDtl> page = assetBorrowDtlService.findPage(new Page<AssetBorrowDtl>(request, response), assetBorrowDtl);
		return page;
	}
	/**
	 * 查询列表数据,筛选
	 */
	@ResponseBody
	@RequestMapping(value = "listDataCode")
	public List<AssetBorrowDtl> listDataCode(AssetBorrowDtl assetBorrowDtl) {
		List<AssetBorrowDtl> page = assetBorrowDtlService.findListdtl(assetBorrowDtl);
		//判断筛选数据
		if (StringUtils.isNotBlank(assetBorrowDtl.getAssetCode())) {
			String[] asset = assetBorrowDtl.getAssetCode().split(",");
			for(int i=0;i<page.size();i++){
				AssetBorrowDtl assetBorrowDtl1=page.get(i);
				for(int j=0;j<asset.length;j++){
					if(assetBorrowDtl1.getAssetCode().equals(asset[j])){
						page.remove(i);
						i--;
					}
				}
			}
		}
		return page;
	}
	/**
	 * 查看编辑表单
	 */
	//@RequiresPermissions("borrow:assetBorrowDtl:view")
	@RequestMapping(value = "form")
	public String form(AssetBorrowDtl assetBorrowDtl, Model model) {
		model.addAttribute("assetBorrowDtl", assetBorrowDtl);
		return "ecode/asset/base/borrow/assetBorrowDtlForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("borrow:assetBorrowDtl:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(AssetBorrowDtl assetBorrowDtl) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, assetBorrowDtl)){
			return renderResult(Global.FALSE, message);
		}
		assetBorrowDtlService.save(assetBorrowDtl);
		return renderResult(Global.TRUE, "保存资产借用归还子表成功！");
	}

	/**
	 * 删除数据
	 */
	@RequiresPermissions("borrow:assetBorrowDtl:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(AssetBorrowDtl assetBorrowDtl) {
		assetBorrowDtlService.delete(assetBorrowDtl);
		return renderResult(Global.TRUE, "删除资产借用归还子表成功！");
	}

}