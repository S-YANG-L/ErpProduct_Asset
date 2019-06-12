/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.codingrule.web;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.codingrule.entity.CodeRules;
import cn.net.ecode.modules.ass.codingrule.service.CodeRulesService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 编码规范子表Controller
 * @author zhaohongbin
 * @version 2018-09-10
 */
@Controller
@RequestMapping(value = "${adminPath}/ass/codeRules")
public class CodeRulesController extends BaseController {

	@Autowired
	private CodeRulesService codeRulesService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public CodeRules get(String id, boolean isNewRecord) {
		return codeRulesService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("ass:codeRules:view")
	@RequestMapping(value = {"list", ""})
	public String list(CodeRules codeRules, Model model) {
		model.addAttribute("codeRules", codeRules);
		return "ecode/asset/base/codingtule/codeRulesList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("ass:codeRules:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<CodeRules> listData(CodeRules codeRules, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CodeRules> page = codeRulesService.findPage(new Page<CodeRules>(request, response), codeRules); 
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("ass:codeRules:view")
	@RequestMapping(value = "form")
	public String form(CodeRules codeRules, Model model) {
		model.addAttribute("codeRules", codeRules);
		return "ecode/asset/base/codingtule/codeRulesForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("ass:codeRules:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(CodeRules codeRules) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, codeRules)){
			return renderResult(Global.FALSE, message);
		}
		codeRulesService.save(codeRules);
		return renderResult(Global.TRUE, "保存编码规范成功！");
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("ass:codeRules:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(CodeRules codeRules) {
		codeRulesService.delete(codeRules);
		return renderResult(Global.TRUE, "删除编码规范成功！");
	}

}