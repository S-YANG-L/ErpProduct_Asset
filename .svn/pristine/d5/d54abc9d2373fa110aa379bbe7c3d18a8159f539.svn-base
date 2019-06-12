/**
 * Copyright &copy; 2013-2015 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.mdm.web;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;

import cn.net.ecode.modules.ass.mdm.dao.BtypeInfoDao;
import cn.net.ecode.modules.ass.mdm.entity.BtypeInfo;
import cn.net.ecode.modules.ass.mdm.service.BtypeInfoService;
import cn.net.ecode.modules.sys.entity.UserDict;
import cn.net.ecode.modules.sys.service.UserDictService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * @Package: cn.net.ecode.mdm.web 
 * @ClassName: BtypeInfoController
 * @Description: TODO
 * @author: 于明珠
 * @date: 2015年9月17日 下午4:52:57 
 * @Version: V1.0
 */
@Controller
@RequestMapping(value = "${adminPath}/mdm/btypeInfo")
public class BtypeInfoController extends BaseController {

	@Autowired
	private BtypeInfoService btypeInfoService;

	@Autowired
	private BtypeInfoDao btypeInfoDao;
	@Autowired
	private UserDictService userDictService;
	/**
	 * 查询列表
	 */
	@RequiresPermissions("mdm:btypeInfo:view")
	@RequestMapping(value = { "list", "" })
	public String list(BtypeInfo btypeInfo, Model model) {
		model.addAttribute("btypeInfo", btypeInfo);
		return "ecode/mdm/btypeInfoList";
	}
	/**
	 * 查询列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<BtypeInfo> listData(BtypeInfo btypeInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BtypeInfo> page = btypeInfoService.findPage(new Page<BtypeInfo>(request, response), btypeInfo);
		model.addAttribute("btypeInfo", btypeInfo);
//		List<BtypeInfo> selectData = btypeInfoDao.findList(btypeInfo);
//		model.addAttribute("btypeCode",selectData.get(0).getBtypeCode());
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("mdm:btypeInfo:view")
	@RequestMapping(value = "form")
	public String form(BtypeInfo btypeInfo, Model model) {
		if(btypeInfo.getIsNewRecord()){
			List<BtypeInfo> list=btypeInfoService.findMaxCode(btypeInfo);
			BtypeInfo btypeCode=list.get(0);
			int maxCode=Integer.parseInt(btypeCode.getBtypeCode());
			String maxBtypeCode=String.valueOf(maxCode+1);
			btypeInfo.setBtypeCode(maxBtypeCode);
			btypeInfo.setIsNewRecord(true);
			model.addAttribute("btypeInfo", btypeInfo);
		}else{
			BtypeInfo btypeInfo1=btypeInfoService.get(btypeInfo);
			model.addAttribute("btypeInfo", btypeInfo1);
		}

		//单位性质
		UserDict userDict = new UserDict();
		userDict.setDictTypeCode("btype_sort");
		List<UserDict> userDictList = userDictService.findList(userDict);
		model.addAttribute("userDictList", userDictList);
		//国别
		UserDict userDict1 = new UserDict();
		userDict1.setDictTypeCode("bug_type");
		List<UserDict> userDictList1 = userDictService.findList(userDict1);
		model.addAttribute("userDictList1", userDictList1);
		//所属行业
		UserDict userDict2 = new UserDict();
		userDict2.setDictTypeCode("trade_sort");
		List<UserDict> userDictList2 = userDictService.findList(userDict2);
		model.addAttribute("userDictList2", userDictList2);
		//上市类型
		UserDict userDict3 = new UserDict();
		userDict3.setDictTypeCode("YH1012");
		List<UserDict> userDictList3 = userDictService.findList(userDict3);
		model.addAttribute("userDictList3", userDictList3);
		//所在园区
		UserDict userDict4 = new UserDict();
		userDict4.setDictTypeCode("bug_grade");
		List<UserDict> userDictList4 = userDictService.findList(userDict4);
		model.addAttribute("userDictList4", userDictList4);
		return "ecode/mdm/btypeInfoForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("mdm:btypeInfo:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(BtypeInfo btypeInfo) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, btypeInfo)) {
			return renderResult(Global.FALSE, message);
		}
		//校验名称和简称是否重复
		List<BtypeInfo> list = btypeInfoService.checkName(btypeInfo);
		if(!list.isEmpty()){
			return renderResult(Global.FALSE, "名称或者简称已存在！");
		}
		btypeInfoService.save(btypeInfo, btypeInfo.getBtypeExt(), btypeInfo.getBtypeAttrList());
		return renderResult(Global.TRUE, "保存单位信息成功！");
	}

	/**
	 * 保存数据
	 */
	/*@ResponseBody
	@RequestMapping(value = "appSave")
	public Map<String, Object> appSave(BtypeInfo btypeInfo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {// 成功
			btypeInfoService.appSave(btypeInfo);	
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {// 失败
			e.printStackTrace();
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}*/
	/**
	 * 删除数据
	 */
	@RequiresPermissions("mdm:btypeInfo:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(BtypeInfo btypeInfo) {
		btypeInfoService.delete(btypeInfo);
		return renderResult(Global.TRUE, "删除单位信息成功！");
	}

	/**
	 * 禁用数据
	 * @Title: disable 
	 * @Description: TODO
	 * @param btypeInfo
	 * @return
	 */
	@RequiresPermissions("mdm:btypeInfo:edit")
	@ResponseBody
	@RequestMapping(value = "disable")
	public String disable(BtypeInfo btypeInfo) {
		btypeInfoService.disable(btypeInfo);
		return renderResult(Global.TRUE, "停用单位" + btypeInfo.getBtypeName() + "成功");
	}

	/**
	 * 启用数据
	 * @Title: enable 
	 * @Description: TODO
	 * @param btypeInfo
	 * @return
	 */
	@RequiresPermissions("mdm:btypeInfo:edit")
	@ResponseBody
	@RequestMapping(value = "enable")
	public String enable(BtypeInfo btypeInfo) {
		btypeInfoService.enable(btypeInfo);
		return renderResult(Global.TRUE, "启用单位" + btypeInfo.getBtypeName() + "成功");
	}

	/**
	 * 取消主管单位
	 * @Title: isNotAdmin 
	 * @Description: TODO
	 * @param btypeInfo
	 * @return
	 */
	@RequiresPermissions("mdm:btypeInfo:edit")
	@ResponseBody
	@RequestMapping(value = "isNotAdmin")
	public String isNotAdmin(BtypeInfo btypeInfo) {
		//		btypeInfo.setIsAdmin(BtypeInfo.STATUS_NORMAL);
		btypeInfoService.isNotAdmin(btypeInfo);
		return renderResult(Global.TRUE, "取消主管单位" + btypeInfo.getBtypeName() + "成功");
	}

	/**
	 * 设置主管单位
	 * @Title: isAdmin 
	 * @Description: TODO
	 * @param btypeInfo
	 * @return
	 */
	@RequiresPermissions("mdm:btypeInfo:edit")
	@ResponseBody
	@RequestMapping(value = "isAdmin")
	public String isAdmin(BtypeInfo btypeInfo) {
		//		btypeInfo.setIsAdmin(BtypeInfo.STATUS_DELETE);
		btypeInfoService.isAdmin(btypeInfo);
		return renderResult(Global.TRUE, "设置主管单位" + btypeInfo.getBtypeName() + "成功");
	}

	/**
	 * 验证编码是否重复
	 * @Title: checkCode 
	 * @Description: TODO
	 * @param oldCode
	 * @param btypeCode
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("mdm:btypeInfo:edit")
	@RequestMapping(value = "checkCode")
	public String checkCode(String oldCode, String btypeCode) {
		BtypeInfo btypeInfo = new BtypeInfo();
		btypeInfo.setBtypeCode(btypeCode);
		if (btypeCode != null && btypeCode.equals(oldCode)) {
			return "true";
		} else if (btypeCode != null && btypeInfoService.get(btypeInfo) == null) {
			return "true";
		}
		return "false";
	}
	
	/**
	 * 查询列表
	 */
	@RequestMapping(value = { "listBox", "" })
	public String listBox(BtypeInfo btypeInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("btypeInfo", btypeInfo);
		model.addAttribute("selectData", request.getParameter("selectData"));
		return "ecode/asset/base/mdm/btypeInfoListBox";
	}
	/**
	 * 客户基本信息列表页面
	 * @author lichangmei-2016.06.06
	 * @param btypeInfo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "khInfoList")
	public String khInfoList(BtypeInfo btypeInfo, Model model){
		model.addAttribute("btypeInfo", btypeInfo);
		return "rwgl/khInfo/khInfoList";
	}
	
	/**
	 * 客户基本信息新增页面
	 * @author lichangmei-2016.06.06
	 * @param btypeInfo
	 * @param model
	 * @return
	 */
	
	
	

	/**
	 * @Title: 公司列表
	 * @createBy：wfw
	 * 
	 * @param userDict
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "companyList", method = RequestMethod.POST)
	public Map<String, Object> companyList(BtypeInfo btypeInfo, HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {// 成功
			List<BtypeInfo> list = btypeInfoService.companyList();
			result.put("data", list);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {// 失败
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	/**
	 * @Title: 根据projectCode查询客户
	 * @createBy：wfw
	 * @param userDict
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "findBtypeInfoByProjectCode", method = RequestMethod.POST)
	public Map<String, Object> findBtypeInfoByProjectCode(BtypeInfo btypeInfo, HttpServletRequest request, HttpServletResponse response)throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {// 成功
			List<BtypeInfo> list = btypeInfoService.findBtypeInfoByProjectCode(btypeInfo);
			result.put("data", list);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {// 失败
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	
	
}