/**
 * Copyright &copy; 2013-2015 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.basic.web;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.sys.utils.UserUtils;
import cn.net.ecode.modules.ass.basic.entity.Warehouse;
import cn.net.ecode.modules.ass.basic.service.WarehouseService;
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
 * 仓库表Controller
 * @author 肖敦山
 * @version 2015-11-19
 */
@Controller
@RequestMapping(value = "${adminPath}/ass/basic/warehouse")
public class WarehouseController extends BaseController {

	@Autowired
	private WarehouseService warehouseService;

	/**
	 * 获取数据
	 */
	@ModelAttribute
	public Warehouse get(String whCode, boolean isNewRecord) {
		return warehouseService.get(whCode, isNewRecord);
	}

	/**
	 * 查询列表
	 */
	@RequiresPermissions("receipt:warehouse:view")
	@RequestMapping(value = { "list", "" })
	public String list(Warehouse warehouse, Model model) {
		model.addAttribute("warehouse", warehouse);
		return "ecode/modules.ass/basic/warehouseList";
	}

	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("receipt:warehouse:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<Warehouse> listData(Warehouse warehouse, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Warehouse> page = warehouseService.findPage(new Page<Warehouse>(request, response), warehouse);
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("receipt:warehouse:view")
	@RequestMapping(value = "form")
	public String form(Warehouse warehouse, Model model) {
		model.addAttribute("warehouse", warehouse);
		return "ecode/modules.ass/basic/warehouseForm";
	}
	/**
	 * 保存数据
	 */
	@RequiresPermissions("receipt:warehouse:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(Warehouse warehouse) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, warehouse)) {
			return renderResult(Global.FALSE, message);
		}
		warehouse.setCorpCode(UserUtils.getUser().getCorpCode());
		warehouse.setCorpName(UserUtils.getUser().getCorpName());
		if ("1".equals(warehouse.getFlag())) {
			warehouse.setIsNewRecord(true);
			warehouseService.save(warehouse);
		} else {
			warehouseService.save(warehouse);
		}
		return renderResult(Global.TRUE, "保存仓库表成功！");
	}

	/**
	 * 删除数据
	 */
	@RequiresPermissions("receipt:warehouse:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(Warehouse warehouse) {
		List<Warehouse> list= warehouseService.findWhcode(warehouse);
		if(list.size()!=0){
			return renderResult(Global.FALSE, "仓库编码已被使用,无法删除！");
		}		
		warehouseService.delete(warehouse);
		return renderResult(Global.TRUE, "删除仓库表成功！");
	}

	@RequiresPermissions({ "receipt:warehouse:edit" })
	@ResponseBody
	@RequestMapping({ "disable" })
	public String disable(Warehouse warehouse) {

		warehouse.setStatus(Warehouse.STATUS_DISABLE);
		warehouseService.save(warehouse);
//		warehouseService.update(warehouse);
		return renderResult("true", "停用模块" + warehouse.getWhName() + "成功");
	}

	@RequiresPermissions({ "receipt:warehouse:edit" })
	@ResponseBody
	@RequestMapping({ "enable" })
	public String enable(Warehouse warehouse) {
		warehouse.setStatus(Warehouse.STATUS_NORMAL);
		warehouseService.save(warehouse);
//		warehouseService.update(warehouse);
		return renderResult("true", "启用模块" + warehouse.getWhName() + "成功");

	}

	/**
	 * 复制
	 */
	@RequiresPermissions("receipt:warehouse:view")
	@RequestMapping(value = "copy")
	public String copy(Warehouse warehouse, Model model) {
		warehouse.setWhCode(IdGen.nextId());
		warehouse.setIsNewRecord(true);
		warehouse.setFlag("1");
		model.addAttribute("warehouse", warehouse);
		return "ecode/modules.ass/basic/warehouseForm";
	}
	
	
	/** 
	 * @Title: warehouseSelect 
	 * @Description: 仓库选择控件
	 * @author: 陈玉春
	 * @date: 2018年1月11日 上午10:20:34 
	 */
			
	@RequestMapping(value ="warehouseSelect")
	public String warehouseSelect(Warehouse warehouse, Model model) {
		return "ecode/modules.ass/basic/warehouseSelect";
	}
	
	/** 
	 * @Title: warehouseList 
	 * @Description: 仓库控件获取数据
	 * @author: 陈玉春
	 * @date: 2018年1月11日 上午10:25:04 
	 */
			
	@ResponseBody
	@RequestMapping(value = "warehouseList")
	public List<Warehouse> warehouseList(Warehouse warehouse, Model model) {
		List<Warehouse> warehouseList = warehouseService.findList(warehouse);
		return warehouseList;
	}
}