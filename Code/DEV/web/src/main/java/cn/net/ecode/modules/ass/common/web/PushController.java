/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.web;


import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.common.entity.Push;
import cn.net.ecode.modules.ass.common.service.PushService;
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
 * 推送中间表Controller
 * @author Mc
 * @version 2017-03-03
 */
@Controller
@RequestMapping(value = "${adminPath}/app/push")
public class PushController extends BaseController {

	@Autowired
	private PushService pushService;
	
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public Push get(String id, boolean isNewRecord) {
		return pushService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("app:push:view")
	@RequestMapping(value = {"list", ""})
	public String list(Push push, Model model) {
		model.addAttribute("push", push);
		return "ecode/app/pushList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("app:push:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<Push> listData(Push push, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Push> page = pushService.findPage(new Page<Push>(request, response), push);
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("app:push:view")
	@RequestMapping(value = "form")
	public String form(Push push, Model model) {
		model.addAttribute("push", push);
		return "ecode/app/pushForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("app:push:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(Push push) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, push)){
			return renderResult(Global.FALSE, message);
		}
		pushService.save(push);
		return renderResult(Global.TRUE, "保存推送中间表成功！");
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("app:pushassLocation:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(Push push) {
		pushService.delete(push);
		return renderResult(Global.TRUE, "删除推送中间表成功！");
	}

}