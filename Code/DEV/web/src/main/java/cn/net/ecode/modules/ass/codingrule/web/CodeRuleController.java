/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.codingrule.web;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.codingrule.entity.CodeRule;
import cn.net.ecode.modules.ass.codingrule.entity.CodeRules;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 编码规则Controller
 * @author zhaohongbin
 * @version 2018-09-10
 */
@Controller
@RequestMapping(value = "${adminPath}/ass/codeRule")
public class CodeRuleController extends BaseController {

	@Autowired
	private CodeRuleService codeRuleService;

	/**
	 * 获取数据
	 */
	@ModelAttribute
	public CodeRule get(String codeId, boolean isNewRecord) {
		return codeRuleService.get(codeId, isNewRecord);
	}
	/**
	 * 查询列表
	 */

	@RequiresPermissions("ass:codeRule:view")
	@RequestMapping(value = {"list", ""})
	public String list(CodeRule codeRule, Model model) {
		model.addAttribute("codeRule", codeRule);
		return "ecode/asset/base/codingtule/codeRuleList";
	}
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("ass:codeRule:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<CodeRule> listData(CodeRule codeRule, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CodeRule> page = codeRuleService.findPage(new Page<CodeRule>(request, response), codeRule); 
		return page;
	}
	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("ass:codeRule:view")
	@RequestMapping(value = "form")
	public String form(CodeRule codeRule, Model model) {
        if(StringUtils.isNotBlank(codeRule.getCodeId())){
            CodeRules codeRules=new CodeRules();
            codeRules.setCodeId(codeRule.getCodeId());
            List<CodeRules> codeRuleslist=codeRuleService.findListDtl(codeRules);
            model.addAttribute("codeRuleslist",codeRuleslist);
        }
		model.addAttribute("codeRule", codeRule);
		return "ecode/asset/base/codingtule/codeRuleForm";
	}
	/**
	 * 保存数据
	 */
	@RequiresPermissions("ass:codeRule:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(CodeRule codeRule) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, codeRule)){
			return renderResult(Global.FALSE, message);
		}
        if(codeRule.getIsNewRecord()){
            List<CodeRule> list = codeRuleService.findAllList(codeRule);
            for (int i = 0; i < list.size(); i++) {
                CodeRule code =  list.get(i);
                if (code.getCodeObjectId().equals(codeRule.getCodeObjectId())){
                    return renderResult(Global.FALSE, "编码对象不能重复");
                }
            }
        }
		codeRuleService.save(codeRule);
		return renderResult(Global.TRUE, "保存编码规则成功！");
	}
	/**
	 * 删除数据
	 */
	@RequiresPermissions("ass:codeRule:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(CodeRule codeRule) {
		codeRuleService.delete(codeRule);
        CodeRules codeRules=new CodeRules();
        codeRules.setCodeId(codeRule.getCodeId());
        codeRules.preUpdate();
        codeRuleService.deletecode(codeRules);
		return renderResult(Global.TRUE, "删除编码规则成功！");
	}
}