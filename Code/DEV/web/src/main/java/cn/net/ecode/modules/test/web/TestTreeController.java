/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.test.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.TreeEntity;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.test.entity.TestTree;
import cn.net.ecode.modules.test.service.TestTreeService;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 树结构数据表Controller
 * @author ThinkGem
 * @version 2016-10-08
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testTree")
public class TestTreeController extends BaseController {

	@Autowired
	private TestTreeService testTreeService;
	
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public TestTree get(String id, boolean isNewRecord) {
		return testTreeService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	//@RequiresPermissions("test:testTree:view")
	@RequestMapping(value = {"list", ""})
	public String list(TestTree testTree, Model model) {
		model.addAttribute("testTree", testTree);
		return "test/test/testTreeList";
	}

	/**
	 * 查询列表数据
	 */
	//@RequiresPermissions("test:testTree:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public List<TestTree> listData(TestTree testTree) {
		if (StringUtils.isBlank(testTree.getParentCode())) {
			testTree.setParentCode(TestTree.ROOT_CODE);
		}
		List<TestTree> list = null;
		if (StringUtils.isNotBlank(testTree.getId())){
			list = Lists.newArrayList(get(testTree.getId(), false));
		}else{
			list = testTreeService.findList(testTree);
		}
		return list;
	}
    /**
     * 查询列表数据
     */
    //@RequiresPermissions("test:testTree:view")
    @ResponseBody
    @RequestMapping(value = "listDataTree")
    public List<TestTree> listDatatree() {
        List<TestTree> list = testTreeService.findListTree();
        return list;
    }
	/**
	 * 查看编辑表单
	 */
	//@RequiresPermissions("test:testTree:view")
	@RequestMapping(value = "form")
	public String form(TestTree testTree, Model model) {
		if (testTree.getParent() != null && StringUtils.isNotBlank(testTree.getParent().getId())) {
			testTree.setParent(testTreeService.get(testTree.getParent().getId()));
		} else {
			testTree.setParentCode(TreeEntity.ROOT_CODE);
		}
		if (StringUtils.isBlank(testTree.getId())) {
			testTree.setSorts(testTreeService.getMaxSort(testTree) + 30);
			// int size=testTreeService.getMaxSize(testTree) ;
			// testTree.setId(testTree.getParent().getId() + StringUtils.leftPad(String.valueOf(size > 0 ? size+1 : 1), 3, "0"));
			testTree.setId(IdGen.nextId());	
			testTree.setIsNewRecord(true);
		}
		model.addAttribute("testTree", testTree);
		return "test/test/testTreeForm";		
	}
	/**
	 * 保存数据
	 */
	//@RequiresPermissions("test:testTree:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(TestTree testTree) {
		if(Global.isDemoMode()){
			return renderResult(Global.FALSE, "演示模式，不允许操作！");
		}
		StringBuilder builder = new StringBuilder();
		if (!beanValidator(builder, testTree)){
			return renderResult(Global.FALSE, builder.toString());
		}
		testTreeService.save(testTree);
		return renderResult(Global.TRUE, "保存树表成功");		
	}
	/**
	 * 删除数据
	 */
	//@RequiresPermissions("test:testTree:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(TestTree testTree) {
		testTreeService.delete(testTree);
		return renderResult(Global.TRUE, "删除树表成功！");
	}
	/**
	 * 停用
	 */
	//@RequiresPermissions("test:testTree:disable")
	@ResponseBody
	@RequestMapping(value = "disable")
	public String disable(TestTree testTree) {
		if(Global.isDemoMode()){
			return renderResult(Global.FALSE, "演示模式，不允许操作！");
		}
		
		List<TestTree> testTreeList = testTreeService.getEnabledList(testTree);
		if(testTreeList!=null&&testTreeList.size()>0){
			return renderResult(Global.FALSE, "树表包含未停用的，请先停用子节点！");
		}
		testTreeService.disable(testTree);
		return renderResult(Global.TRUE, "停用树表成功");
	}
	/**
	 * 按组停用
	 */
	//@RequiresPermissions("test:testTree:disable")
	@ResponseBody
	@RequestMapping(value = "disableByGroup")
	public String disableByGroup(TestTree testTree) {
		if(Global.isDemoMode()){
			return renderResult(Global.FALSE, "演示模式，不允许操作！");
		}
		testTreeService.disableByGroup(testTree);
		return renderResult(Global.TRUE, "停用树表及子成功");
	}
	/**
	 * 启用
	 */
	//@RequiresPermissions("test:testTree:enable")
	@ResponseBody
	@RequestMapping(value = "enable")
	public String enable(TestTree testTree) {
		if(Global.isDemoMode()){
			return renderResult(Global.FALSE, "演示模式，不允许操作！");
		}
		testTreeService.enable(testTree);
		return renderResult(Global.TRUE, "启用树表成功");
	}
	/**
	 * 按组启用
	 */
	//@RequiresPermissions("test:testTree:enable")
	@ResponseBody
	@RequestMapping(value = "enableByGroup")
	public String enableByGroup(TestTree testTree) {
		if(Global.isDemoMode()){
			return renderResult(Global.FALSE, "演示模式，不允许操作！");
		}
		testTreeService.enableByGroup(testTree);
		return renderResult(Global.TRUE, "启用树表及子成功");
	}
	/**
	 * 获取结构数据。
	 * @param extCode 排除的ID
	 */
	//@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(String extCode, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<TestTree> list = testTreeService.findAllList(new TestTree());
		for (int i=0; i<list.size(); i++){
			TestTree e = list.get(i);
			if ((StringUtils.isBlank(extCode) || (extCode!=null && !extCode.equals(e.getId()) && e.getParentCodes().indexOf(","+extCode+",")==-1))
					&&(e.getStatus().equals("0"))){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentCode());
				map.put("pIds", e.getParentCodes());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	/**
	 * 树结构数据修复
	 * @return
	 */
	//@RequiresPermissions("test:testTree:edit")
	@ResponseBody
	@RequestMapping(value = "dataFix")
	public String dataFix(){
		testTreeService.updateFixParentCodes();
		return renderResult(Global.TRUE, "数据修复成功");
	}
}