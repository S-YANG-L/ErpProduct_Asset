/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.ascheck.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.ascheck.entity.AsCheckDtl;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBillDtl;
import cn.net.ecode.modules.ass.warehouse.entity.WarehouseInfo;
import cn.net.ecode.modules.ass.warehouse.service.WarehouseInfoService;
import cn.net.ecode.modules.sys.utils.UserUtils;
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
import cn.net.ecode.modules.ass.ascheck.entity.AsCheck;
import cn.net.ecode.modules.ass.ascheck.service.AsCheckService;

import java.util.Date;
import java.util.List;

/**
 * 办公用品盘点Controller
 * @author zhaohongbin
 * @version 2018-10-17
 */
@Controller
@RequestMapping(value = "${adminPath}/ascheck/asCheck")
public class AsCheckController extends BaseController {

	@Autowired
	private AsCheckService asCheckService;
	@Autowired
    private WarehouseInfoService warehouseInfoService;
	@Autowired
	private CodeRuleService codeRuleService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public AsCheck get(String id, boolean isNewRecord) {
		return asCheckService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("ascheck:asCheck:view")
	@RequestMapping(value = {"list", ""})
	public String list(AsCheck asCheck, Model model) {
		//获取仓库列表
        WarehouseInfo warehouseInfo = new WarehouseInfo();
        List<WarehouseInfo> warehouses=warehouseInfoService.findList(warehouseInfo);
        model.addAttribute("warehouses",warehouses);
		model.addAttribute("asCheck", asCheck);
		return "ecode/asset/base/ascheck/asCheckList";
	}

	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("ascheck:asCheck:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<AsCheck> listData(AsCheck asCheck, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AsCheck> page = asCheckService.findPage(new Page<AsCheck>(request, response), asCheck); 
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("ascheck:asCheck:view")
	@RequestMapping(value = "form")
	public String form(AsCheck asCheck, Model model) {
		if (StringUtils.isNotBlank(asCheck.getId())) {
            model.addAttribute("checkCode", asCheck.getId());
        }
        if (asCheck.getIsNewRecord()) {
            asCheck.setCheckDate(new Date());
            asCheck.setOperatorCode(UserUtils.getUser().getUserCode());
            asCheck.setOperatorName(UserUtils.getUser().getUserName());
        } else {
            asCheck.setCheckDate(asCheck.getCreateDate());
            asCheck.setOperatorCode(asCheck.getOperatorCode());
            asCheck.setOperatorName(asCheck.getOperatorName());
        }
      //得到仓库名称
        WarehouseInfo warehouseInfo = new WarehouseInfo();
        List<WarehouseInfo> warehouses = warehouseInfoService.findList(warehouseInfo);
        model.addAttribute("warehouses", warehouses);
		model.addAttribute("asCheck", asCheck);
		return "ecode/asset/base/ascheck/asCheckForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("ascheck:asCheck:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(AsCheck asCheck) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, asCheck)){
			return renderResult(Global.FALSE, message);
		}
		//生成办公用品编码
		if (asCheck.getIsNewRecord()) {
			asCheck.setCheckCode(codeRuleService.createBgCode("BGLY","办公用品领用"));
		}
		asCheckService.save(asCheck);
		return renderResult(Global.TRUE, "保存办公用品盘点成功！");
	}
	/**
	 * 删除数据
	 */
	@RequiresPermissions("ascheck:asCheck:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(AsCheck asCheck) {
		asCheckService.delete(asCheck);
		return renderResult(Global.TRUE, "删除办公用品盘点成功！");
	}
    /**
     * 得到子表数据，
     */
    @ResponseBody
    @RequestMapping(value = "findCheckCode")
    public List<AsCheckDtl> findCheckCode(AsCheckDtl asCheckDtl) {
        List<AsCheckDtl> asCheckDtls = asCheckService.findCheckCode(asCheckDtl);
        return asCheckDtls;
    }
}