/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.web;


import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.common.entity.PushModel;
import cn.net.ecode.modules.ass.common.service.PushModelService;
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
 * 推送方式表Controller
 * @author Mc
 * @version 2017-02-24
 */
@Controller
@RequestMapping(value = "${adminPath}/app/pushModel")
public class PushModelController extends BaseController {

	@Autowired
	private PushModelService pushModelService;
	
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public PushModel get(String id, boolean isNewRecord) {
		return pushModelService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("app:pushModel:view")
	@RequestMapping(value = {"list", ""})
	public String list(PushModel pushModel, Model model) {
		model.addAttribute("pushModel", pushModel);
		return "ecode/app/pushModelList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("app:pushModel:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<PushModel> listData(PushModel pushModel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PushModel> page = pushModelService.findPage(new Page<PushModel>(request, response), pushModel);
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("app:pushModel:view")
	@RequestMapping(value = "form")
	public String form(PushModel pushModel, Model model) {
		model.addAttribute("pushModel", pushModel);
		return "ecode/app/pushModelForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("app:pushModel:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(PushModel pushModel) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, pushModel)){
			return renderResult(Global.FALSE, message);
		}		
		pushModelService.save(pushModel);
		return renderResult(Global.TRUE, "保存推送方式表成功！");
	}
	
	/**
	 * 删除数据
	 */
	@RequiresPermissions("app:pushModel:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(PushModel pushModel) {
		pushModelService.delete(pushModel);
		return renderResult(Global.TRUE, "删除推送方式表成功！");
	}

}