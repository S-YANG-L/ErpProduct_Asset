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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.test.entity.TestData;
import cn.net.ecode.modules.test.service.TestDataService;

/**
 * 单表生成Controller
 * @author ThinkGem
 * @version 2014-10-27
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testData")
public class TestDataController extends BaseController {

	@Autowired
	private TestDataService testDataService;

	/**
	 * 获取数据
	 * @param id 
	 * @return
	 */
	@ModelAttribute
	public TestData get(String id, boolean isNewRecord) {
		return testDataService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 * @param testData
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
//	@RequiresPermissions("test:testData:view")
	@RequestMapping(value = {"list", ""})
	public String list(TestData testData, Model model) {
		return "test/test/testDataList";
	}
	
	/**
	 * 查询列表
	 * @param testData
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
//	@RequiresPermissions("test:testData:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<TestData> listData(TestData testData, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TestData> page = testDataService.findPage(new Page<TestData>(request, response), testData); 
		return page;
	}

	/**
	 * 查看编辑表单
	 * @param testData
	 * @param model
	 * @return
	 */
//	@RequiresPermissions("test:testData:view")
	@RequestMapping(value = "form")
	public String form(TestData testData, Model model) {
		model.addAttribute("testData", testData);
		return "test/test/testDataForm";
	}

	/**
	 * 保存数据
	 * @param testData
	 * @return
	 */
//	@RequiresPermissions("test:testData:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(TestData testData) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, testData)){
			return renderResult(Global.FALSE, message);
		}
		testDataService.save(testData);
		return renderResult(Global.TRUE, "保存单表成功！");
	}
	
	/**
	 * 删除数据
	 * @param testData
	 * @return
	 */
//	@RequiresPermissions("test:testData:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(TestData testData, RedirectAttributes redirectAttributes) {
		testDataService.delete(testData);
		return renderResult(Global.TRUE, "删除单表成功！");
	}

	/**
	 * 自定义访问视图
	 */
//	@RequiresPermissions("test:testData:view")
	@RequestMapping(value = "{viewName}")
	public String treeList(@PathVariable String viewName, TestData testData, Model model) {
		return "test/test/testData" + StringUtils.capitalize(viewName);
	}
	
}