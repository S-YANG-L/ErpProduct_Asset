/**
 * Copyright &copy; 2013-2015 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.mdm.web;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;

import cn.net.ecode.modules.ass.mdm.entity.BtypeInfo;
import cn.net.ecode.modules.ass.mdm.service.SelectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 下拉框/弹出框Controller
 * @author 车磊岩
 * @version 2015-09-11
 */
@Controller
@RequestMapping(value = "${adminPath}/mdm/select")
public class SelectController extends BaseController {

	@Autowired
	private SelectService selectService;
	
	/**
	 * 机构查询列表
	 */
	@RequestMapping(value ="btypeSelect")
	public String btypeList(BtypeInfo btypeInfo, Model model) {
		return "ecode/mdm/btypeSelect";
	}

	/**
	 * 查询列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "btypeListData")
	public Page<BtypeInfo> btypeListData(BtypeInfo btypeInfo, HttpServletRequest request, HttpServletResponse response) {
		Page<BtypeInfo> page = selectService.findBtypeList(new Page<BtypeInfo>(request, response), btypeInfo);
		return page;
	}
}