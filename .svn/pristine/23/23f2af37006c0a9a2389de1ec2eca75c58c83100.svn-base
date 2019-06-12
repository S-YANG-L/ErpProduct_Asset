/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.test.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.test.entity.TestDataMain;
import cn.net.ecode.modules.test.service.TestDataMainService;

/**
 * 主子表增删改Controller
 * @author ThinkGem
 * @version 2016-10-09
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testDataMain")
public class TestDataMainController extends BaseController {

	@Autowired
	private TestDataMainService testDataMainService;
	
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public TestDataMain get(String id, boolean isNewRecord) {
		return testDataMainService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	//@RequiresPermissions("test:testDataMain:view")
	@RequestMapping(value = {"list", ""})
	public String list(TestDataMain testDataMain, Model model) {
		model.addAttribute("testDataMain", testDataMain);
		return "test/test/testDataMainList";
	}
	
	/**
	 * 查询列表数据
	 */
	//@RequiresPermissions("test:testDataMain:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<TestDataMain> listData(TestDataMain testDataMain, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TestDataMain> page = testDataMainService.findPage(new Page<TestDataMain>(request, response), testDataMain); 
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	//@RequiresPermissions("test:testDataMain:view")
	@RequestMapping(value = "form")
	public String form(TestDataMain testDataMain, Model model) {
		model.addAttribute("testDataMain", testDataMain);
		return "test/test/testDataMainForm";
	}

	/**
	 * 保存数据
	 */
	//@RequiresPermissions("test:testDataMain:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(TestDataMain testDataMain) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, testDataMain)){
			return renderResult(Global.FALSE, message);
		}
		testDataMainService.save(testDataMain);
		return renderResult(Global.TRUE, "保存主表成功！");
	}
	
	/**
	 * 删除数据
	 */
	//@RequiresPermissions("test:testDataMain:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(TestDataMain testDataMain) {
		testDataMainService.delete(testDataMain);
		return renderResult(Global.TRUE, "删除主表成功！");
	}

}