/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.borrowreturn.web;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowDtl;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowInfo;
import cn.net.ecode.modules.ass.borrowreturn.entity.AssetBorrowReturn;
import cn.net.ecode.modules.ass.borrowreturn.entity.AssetBorrowReturnDtl;
import cn.net.ecode.modules.ass.borrowreturn.service.AssetBorrowReturnService;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.usedinfo.service.AssetUsedDtlService;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;
import cn.net.ecode.modules.eflow.service.FlowLogService;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 资产归还Controller
 * @author shiwangwang
 * @version 2018-10-09
 */
@Controller
@RequestMapping(value = "${adminPath}/return/assetBorrowReturn")
public class AssetBorrowReturnController extends BaseController {

	@Autowired
	private AssetBorrowReturnService assetBorrowReturnService;
	@Autowired
	private AssetUsedDtlService assetUsedDtlService;
	@Autowired
	private FlowLogService flowLogService;
	@Autowired
	private FlowBusinessService flowBusinessService;
	@Autowired
	private CodeRuleService codeRuleService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public AssetBorrowReturn get(String id, boolean isNewRecord) {
		return assetBorrowReturnService.get(id, isNewRecord);
	}

	/**
	 * 查询列表
	 */
	@RequiresPermissions("borrowreturn:assetBorrowReturn:view")
	@RequestMapping(value = {"list", ""})
	public String list(AssetBorrowReturn assetBorrowReturn, Model model) {
		model.addAttribute("assetBorrowReturn", assetBorrowReturn);
		return "ecode/asset/base/borrowreturn/assetBorrowReturnList";
	}

	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("borrowreturn:assetBorrowReturn:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<AssetBorrowReturn> listData(AssetBorrowReturn assetBorrowReturn, HttpServletRequest request, HttpServletResponse response, Model model) {
		assetBorrowReturn.setBorrowerCode(UserUtils.getUser().getUserCode());
		Page<AssetBorrowReturn> page = assetBorrowReturnService.findPage(new Page<AssetBorrowReturn>(request, response), assetBorrowReturn);
		return page;
	}
	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("borrowreturn:assetBorrowReturn:view")
	@RequestMapping(value = "form")
	public String form(AssetBorrowReturn assetBorrowReturn, Model model) {
		if (StringUtils.isNotBlank(assetBorrowReturn.getId())) {
			model.addAttribute("borrowCode", assetBorrowReturn.getId());
		}
		AssetBorrowReturn assetBorrowReturn1=new AssetBorrowReturn();
		if (assetBorrowReturn.getIsNewRecord() == true) {
			assetBorrowReturn.setBorrowerCode(UserUtils.getUser().getUserCode());
			assetBorrowReturn.setBorrowerName(UserUtils.getUser().getUserName());
			assetBorrowReturn.setRestituerCode(UserUtils.getUser().getUserCode());
			assetBorrowReturn.setRestituerName(UserUtils.getUser().getUserName());
			assetBorrowReturn.setBorrowDate(new Date());
			assetBorrowReturn.setFactReturnDate(new Date());
		} else {
			assetBorrowReturn.setBorrowerCode(assetBorrowReturn.getBorrowerCode());
			assetBorrowReturn.setBorrowerName(assetBorrowReturn.getBorrowerName());
			assetBorrowReturn.setRestituerCode(assetBorrowReturn.getRestituerCode());
			assetBorrowReturn.setRestituerName(assetBorrowReturn.getRestituerName());
			assetBorrowReturn.setBorrowDate(assetBorrowReturn.getBorrowDate());
			assetBorrowReturn.setFactReturnDate(assetBorrowReturn.getFactReturnDate());
		}
		String companyCode=assetBorrowReturnService.getCompanyCode(assetBorrowReturn);
		assetBorrowReturn.setCompanyCode(companyCode);
		model.addAttribute("assetBorrowReturn", assetBorrowReturn);
//		return "ecode/asset/base/borrowreturn/assetBorrowReturnForm";
		return "ecode/asset/base/borrowreturn/assetBorrowReturnInfoForm";
	}
	/**
	 * 点击选择资产，打开资产数据表格
	 */
	@RequestMapping(value = "getusedDtllist")
	public String warehouseSelect(AssetBorrowDtl assetBorrowDtl, Model model) {
		model.addAttribute("assetBorrowDtl",assetBorrowDtl);
		return "ecode/asset/base/borrowreturn/usedDtllist";
	}
	/**
	 * 得到子表数据，
	 */
	@ResponseBody
	@RequestMapping(value = "getDtlData")
	public List<AssetBorrowReturnDtl> getDtlData(AssetBorrowReturnDtl assetBorrowReturnDtl) {
		List<AssetBorrowReturnDtl>  assetBorrowReturnDtls=assetBorrowReturnService.findUsedCode(assetBorrowReturnDtl);
		return assetBorrowReturnDtls;
	}
	/**
	 * 保存数据
	 */
	@RequiresPermissions("return:assetBorrowReturn:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(AssetBorrowReturn assetBorrowReturn) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, assetBorrowReturn)){
			return renderResult(Global.FALSE, message);
		}
		Office office=new Office();
		office.setOfficeCode(assetBorrowReturn.getOfficeCode());
		//assetBorrowReturn.setBorrowCode(codeRuleService.createCode("ZCGH","",office,assetBorrowReturn.getCompanyCode()));

		assetBorrowReturnService.save(assetBorrowReturn);
		return renderResult(Global.TRUE, "提交成功");
	}

	/**
	 * 删除数据
	 */
	@RequiresPermissions("return:assetBorrowReturn:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(AssetBorrowReturn assetBorrowReturn) {
		assetBorrowReturnService.delete(assetBorrowReturn);
		return renderResult(Global.TRUE, "删除资产归还成功！");
	}
	/**
	 * @Title: getNextFlowBusiness
	 * @Description: 判断工作流是否为最后一步
	 * @param flowBusiness
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getNextFlowBusiness")
	public Integer getNextFlowBusiness(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) {
		FlowBusiness nextFlowBusiness;
		nextFlowBusiness = flowBusinessService.getNextFlowBusiness(flowBusiness.getBizKey(), flowBusiness.getStep());
		if(nextFlowBusiness!=null){
			return 1;  //不是最后一步
		}
		else{
			return 0;  //是最后一步
		}
	}

	/**
	 * @Title: agree
	 * @Description: app端审批通过方法
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */

	@ResponseBody
	@RequestMapping(value = "agree",method = RequestMethod.POST)
	public Map<String , Object> agree(AssetBorrowReturn assetBorrowReturn, HttpServletRequest request, HttpServletResponse response)throws Exception  {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			assetBorrowReturnService.agree(assetBorrowReturn);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}

	/**
	 * @Title: agree
	 * @Description: PC端审批通过方法
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */

	@ResponseBody
	@RequestMapping(value = "agreePc")
	public String agreePc(AssetBorrowReturn assetBorrowReturn,HttpServletRequest request, HttpServletResponse response){
		try {
			String isEnd=request.getParameter("isEnd");
			String sysCode=request.getParameter("sysCode");
			assetBorrowReturn.setIsEnd(Integer.parseInt(isEnd));
			assetBorrowReturn.setId(sysCode);
			assetBorrowReturnService.agree(assetBorrowReturn);
			return renderResult(Global.TRUE, "审批通过！");

		} catch (Exception e) {
			e.printStackTrace();
			return renderResult(Global.FALSE, "出现问题！");
		}
	}
	/**
	 * @Title: disagree
	 * @Description:app端驳回方法
	 */
	@ResponseBody
	@RequestMapping(value = "disagree",method = RequestMethod.POST)
	public Map<String , Object> disagree(AssetBorrowReturn assetBorrowReturn,HttpServletRequest request, HttpServletResponse response)throws Exception  {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			assetBorrowReturnService.disagree(assetBorrowReturn);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}

	/**
	 * @Title: disagree
	 * @Description: pc端驳回
	 * @param request
	 * @param response
	 */

	@ResponseBody
	@RequestMapping(value = "disagreePc")
	public String disagreePc(AssetBorrowReturn assetBorrowReturn,HttpServletRequest request, HttpServletResponse response){
		try {
			String sysCode=request.getParameter("sysCode");
			assetBorrowReturn.setId(sysCode);
			assetBorrowReturnService.disagree(assetBorrowReturn);
			return renderResult(Global.TRUE, "已驳回！");
		} catch (Exception e) {
			e.printStackTrace();
			return renderResult(Global.FALSE, "出现问题！");
		}
	}




	/**
	 *
	 * @Title: unDo
	 * @Description: 撤回审批app端
	 * @author: wuchunyan
	 * @date: 2017年10月16日 上午11:16:20
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "unDo",method = RequestMethod.POST)
	public Map<String , Object> unDo(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response)throws Exception  {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String msg = assetBorrowReturnService.unDo(flowBusiness);
			// 如果msg信息为空
			if(StringUtils.isBlank(msg)){
				result.put("code", "200");
				result.put("message", "单据撤回成功！");
			}else{
				result.put("code", "201");
				result.put("message", msg);
			}
		} catch (Exception e) {
			result.put("code", "201");
			result.put("message", "网络错误！");
		}
		return result;
	}
	/**
	 * @Title: unSubmJitPc
	 */

	@ResponseBody
	@RequestMapping(value = "unSubmit",method = RequestMethod.POST)
	public Map<String , Object> unSubmit(FlowBusiness flowBusiness,HttpServletRequest request, HttpServletResponse response)throws Exception  {
		Map<String, Object> result = new HashMap<String, Object>();
		String msg = null;
		try {
			msg = assetBorrowReturnService.unSubmit(flowBusiness);
			if(org.apache.commons.lang3.StringUtils.isEmpty(msg)){//如果msg信息为空
				result.put("true", "单据撤回成功！");
				result.put("code", "200");
				result.put("message", "success");
			}else{
				if(msg.equals("当前单据未提交或已撤回")){
					result.put("true", "单据撤回成功！");
					result.put("code", "200");
					result.put("message", "success");
				}else{
					result.put("false", msg);
					result.put("code", "201");
					result.put("message", "fail");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}

	/**
	 *   选择审批人只显示自己部门的
	 * @param flowBusiness
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping({"listApprovalData"})
	public Page<User> listApprovalData(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) {
		Page<User> page = this.flowBusinessService.findApprovalPage(new Page(request, response), flowBusiness);
		page=filtration(page);
		return page;
	}

	@RequestMapping({"approvalSelect"})
	public String approvalSelect(FlowBusiness flowBusiness, User user, Model model) {
		model.addAttribute("flowBusiness", flowBusiness);
		model.addAttribute("user", user);
		return "ecode/asset/base/borrowreturn/approvalSelect";
	}
	/**
	 * 得到部门管理员
	 *
	 * @param flowBusiness
	 * @param model
	 * @return
	 */
	@RequestMapping({"nextApprovalSelect"})
	public String nextApprovalSelect(FlowBusiness flowBusiness, Model model) {
		model.addAttribute("flowBusiness", flowBusiness);
		return "ecode/asset/base/borrowreturn/nextApprovalSelect";
	}

	/**
	 * 得到部门管理员
	 *
	 * @param flowBusiness
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping({"listNextApprovalData"})
	public Page<User> listNextApprovalData(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) {
		Page<User> page = this.flowBusinessService.findNextApprovalPage(new Page(request, response), flowBusiness);
		page=filtration(page);
		return page;
	}

	/**
	 * 过滤选择审批人只显示自己部门的
	 * @param page
	 * @return
	 */
	public Page<User> filtration( Page<User> page){
		List<User> list = page.getList();
		AssetBorrowInfo assetBorrowInfo = new AssetBorrowInfo();
		AssetBorrowReturn assetBorrowReturn = new AssetBorrowReturn();
		assetBorrowReturn.setBorrowerCode(UserUtils.getUser().getUserCode());
		assetBorrowReturn = assetBorrowReturnService.getOffice(assetBorrowReturn);
		String office = assetBorrowReturn.getOfficeCode();
		String office2="";
		//选择审批人只显示自己部门的
		if(list!=null){
			for (int i = 0; i < list.size(); i++) {
				list.get(i).getLoginCode();
				AssetBorrowReturn assetBorrowReturn1 = new AssetBorrowReturn();
				assetBorrowReturn1.setBorrowerCode(list.get(i).getLoginCode());
				assetBorrowReturn1 = assetBorrowReturnService.getOffice(assetBorrowReturn1);
				office2 = assetBorrowReturn1.getOfficeCode();
				if (office.equals(office2)) {
				} else {
					list.remove(i);
					i--;
				}
			}
		}else{
		}
		return page;
	}
}