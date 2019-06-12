/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.borrow.web;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowDtl;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowInfo;
import cn.net.ecode.modules.ass.borrow.service.AssetBorrowDtlService;
import cn.net.ecode.modules.ass.borrow.service.AssetBorrowInfoService;
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
 * 资产借用归还Controller
 * @author sunhuijun
 * @version 2018-09-20
 */
@Controller
@RequestMapping(value = "${adminPath}/borrow/assetBorrowInfo")
public class AssetBorrowInfoController extends BaseController {

	@Autowired
	private AssetBorrowInfoService assetBorrowInfoService;
	@Autowired
	private AssetUsedDtlService assetUsedDtlService;
	@Autowired
	private FlowLogService flowLogService;
	@Autowired
	private FlowBusinessService flowBusinessService;
	@Autowired
	private AssetBorrowDtlService assetBorrowDtlService;
	@Autowired
	private CodeRuleService codeRuleService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public AssetBorrowInfo get(String id, boolean isNewRecord) {
		return assetBorrowInfoService.get(id, isNewRecord);
	}

	/**
	 * 查询列表
	 */
	@RequiresPermissions("borrow:assetBorrowInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(AssetBorrowInfo assetBorrowInfo, Model model) {
		model.addAttribute("assetBorrowInfo", assetBorrowInfo);
		return "ecode/asset/base/borrow/assetBorrowInfoList";
	}
	/**
	 * 查询新增选择资产
	 */
	@RequiresPermissions("borrow:assetBorrowInfo:view")
	@RequestMapping(value = {"getusedDtllist", ""})
	public String getusedDtllist(AssetInfo assetInfo, Model model) {
		model.addAttribute("assetInfo", assetInfo);
		return "ecode/asset/base/borrow/usedDtllist";
	}
	/**
	 * 查询列表数据,筛选
	 */
	@ResponseBody
	@RequestMapping(value = "listDataCode")
	public List<AssetInfo> listDataCode(AssetInfo assetInfo) {
		List<AssetInfo> page = assetBorrowInfoService.findAssetInfo(assetInfo);
		//判断筛选数据
		if (StringUtils.isNotBlank(assetInfo.getAssetCode())) {
			String[] asset = assetInfo.getAssetCode().split(",");
			for(int i=0;i<page.size();i++){
				AssetInfo assetInfo1=page.get(i);
				for(int j=0;j<asset.length;j++){
					if(assetInfo1.getAssetCode().equals(asset[j])){
						page.remove(i);
						i--;
					}
				}
			}
		}
		return page;
	}
	/**
	 * 查看编辑借用归还表单
	 */
	@RequiresPermissions("usedinfo:assetUsedInfo:view")
	@RequestMapping(value = "rewithform")
	public String rewithdrawingform(AssetBorrowInfo assetBorrowInfo, Model model) {
		model.addAttribute("assetBorrowInfo", assetBorrowInfo);
		return "ecode/asset/base/borrow/recipientsWithdrawing";
	}
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("borrow:assetBorrowInfo:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<AssetBorrowInfo> listData(AssetBorrowInfo assetBorrowInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		assetBorrowInfo.setBorrowerCode(UserUtils.getUser().getUserCode());
		Page<AssetBorrowInfo> page = assetBorrowInfoService.findPage(new Page<AssetBorrowInfo>(request, response), assetBorrowInfo);
		return page;
	}
	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("borrow:assetBorrowInfo:view")
	@RequestMapping(value = "form")
	public String form(AssetBorrowInfo assetBorrowInfo, Model model) {
		if (StringUtils.isNotBlank(assetBorrowInfo.getId())) {
			model.addAttribute("borrowCode", assetBorrowInfo.getId());
		}
		AssetBorrowInfo assetBorrowInfo1=new AssetBorrowInfo();
		if (assetBorrowInfo.getIsNewRecord() == true) {
			assetBorrowInfo.setBorrowerCode(UserUtils.getUser().getUserCode());
			assetBorrowInfo.setBorrowerName(UserUtils.getUser().getUserName());
			assetBorrowInfo.setRestituerCode(UserUtils.getUser().getUserCode());
			assetBorrowInfo.setRestituerName(UserUtils.getUser().getUserName());
			assetBorrowInfo.setBorrowDate(new Date());
		} else {
			assetBorrowInfo.setBorrowerCode(assetBorrowInfo.getBorrowerCode());
			assetBorrowInfo.setBorrowerName(assetBorrowInfo.getBorrowerName());
			assetBorrowInfo.setRestituerCode(assetBorrowInfo.getRestituerCode());
			assetBorrowInfo.setRestituerName(assetBorrowInfo.getRestituerName());
			assetBorrowInfo.setOfficeCode(assetBorrowInfo.getOfficeCode());
			assetBorrowInfo.setBorrowDate(assetBorrowInfo.getBorrowDate());
			assetBorrowInfo.setBorrowDate(assetBorrowInfo.getBorrowDate());
			assetBorrowInfo.setExpectedReturnDate(assetBorrowInfo.getExpectedReturnDate());
		}
		String companyCode=assetBorrowInfoService.getCompanyCode(assetBorrowInfo);
		assetBorrowInfo.setCompanyCode(companyCode);
		model.addAttribute("assetBorrowInfo", assetBorrowInfo);
		return "ecode/asset/base/borrow/assetBorrowInfoForm";
	}
	/**
	 * 保存数据
	 */
	@RequiresPermissions("borrow:assetBorrowInfo:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(AssetBorrowInfo assetBorrowInfo) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, assetBorrowInfo)){
			return renderResult(Global.FALSE, message);
		}
		Office office=new Office();
		office.setOfficeCode(assetBorrowInfo.getOfficeCode());
	//	assetBorrowInfo.setBorrowCode(codeRuleService.createCode("ZCJY","",office,assetBorrowInfo.getCompanyCode()));

		assetBorrowInfoService.save(assetBorrowInfo);
		return renderResult(Global.TRUE, "提交成功！");
	}
	/**APP端保存资产借用
	 */
	@ResponseBody
	@RequestMapping(value = "saveAPP")
	public Map<String, Object> saveAPP(AssetBorrowInfo assetBorrowInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			assetBorrowInfoService.save(assetBorrowInfo);
			result.put("code", "200");
			result.put("message", "success");

		} catch (Exception e) {// 如果失败 result存这个
			e.printStackTrace();
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	/**
	 * 得到子表数据，
	 */
	@ResponseBody
	@RequestMapping(value = "getDtlData")
	public List<AssetBorrowDtl> getDtlData(AssetBorrowDtl assetBorrowDtl) {
		List<AssetBorrowDtl>  assetBorrowDtls=assetBorrowDtlService.findUsedCode(assetBorrowDtl);
		return assetBorrowDtls;
	}
	/**
	 * 删除数据
	 */
	@RequiresPermissions("borrow:assetBorrowInfo:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(AssetBorrowInfo assetBorrowInfo) {
		assetBorrowInfoService.delete(assetBorrowInfo);
		return renderResult(Global.TRUE, "删除成功！");
	}
	/**
	 * @Title: getNextFlowBusiness
	 * @Description: PC端判断工作流是否为最后一步
	 */
	@ResponseBody
	@RequestMapping(value = "getNextFlowBusiness")
	public Integer getNextFlowBusiness(FlowBusiness flowBusiness,HttpServletRequest request, HttpServletResponse response) {
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
	 * @Title: getNextFlowBusiness
	 * @Description: APP端判断工作流是否为最后一步
	 */
	@ResponseBody
	@RequestMapping(value = "getNextFlowBusinessAPP")
	public Map<String,Object> getNextFlowBusinessAPP(FlowBusiness flowBusiness,HttpServletRequest request, HttpServletResponse response) {
		FlowBusiness nextFlowBusiness;
		nextFlowBusiness = flowBusinessService.getNextFlowBusiness(flowBusiness.getBizKey(), flowBusiness.getStep());
		Map<String,Object> result= new HashMap<>();
		try {
			if(nextFlowBusiness!=null){
				result.put("data", "1"); //不是最后一步
			}
			else{
				result.put("data", "0");  //是最后一步
			}
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
	 * @Description: app端审批通过方法
	 */
	@ResponseBody
	@RequestMapping(value = "agree",method = RequestMethod.POST)
	public Map<String , Object> agree(AssetBorrowInfo assetBorrowInfo, HttpServletRequest request, HttpServletResponse response)throws Exception  {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			assetBorrowInfoService.agree(assetBorrowInfo);
			result.put("code", "200");
			result.put("message", "success");
		} catch (Exception e) {
			result.put("code", "201");
			result.put("message", "fail");
		}
		return result;
	}
	/**
	 * @Description: PC端审批通过方法
	 */

	@ResponseBody
	@RequestMapping(value = "agreePc")
	public String agreePc(AssetBorrowInfo assetBorrowInfo,HttpServletRequest request, HttpServletResponse response){
		try {
			String isEnd=request.getParameter("isEnd");
			String sysCode=request.getParameter("sysCode");
			assetBorrowInfo.setIsEnd(Integer.parseInt(isEnd));
			assetBorrowInfo.setId(sysCode);
			assetBorrowInfoService.agree(assetBorrowInfo);
			return renderResult(Global.TRUE, "审批通过！");
		} catch (Exception e) {
			e.printStackTrace();
			return renderResult(Global.TRUE, "出现问题！");
		}
	}

	/**
	 * @Title: disagree
	 * @Description:app端驳回方法
	 */

	@ResponseBody
	@RequestMapping(value = "disagree",method = RequestMethod.POST)
	public Map<String , Object> disagree(AssetBorrowInfo assetBorrowInfo,HttpServletRequest request, HttpServletResponse response)throws Exception  {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			assetBorrowInfoService.disagree(assetBorrowInfo);
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
	 */

	@ResponseBody
	@RequestMapping(value = "disagreePc")
	public String disagreePc(AssetBorrowInfo assetBorrowInfo,HttpServletRequest request, HttpServletResponse response){
		try {
			String sysCode=request.getParameter("sysCode");
			assetBorrowInfo.setId(sysCode);
			assetBorrowInfoService.disagree(assetBorrowInfo);
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
	 */
	@ResponseBody
	@RequestMapping(value = "unDo",method = RequestMethod.POST)
	public Map<String , Object> unDo(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response)throws Exception  {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String msg = assetBorrowInfoService.unDo(flowBusiness);
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
	 * @Title: unSubmit
	 * @Description: pc端撤回申请的方法
	 */
	@ResponseBody
	@RequestMapping(value = "unSubmit",method = RequestMethod.POST)
	public Map<String , Object> unSubmit(FlowBusiness flowBusiness,HttpServletRequest request, HttpServletResponse response)throws Exception  {
		Map<String, Object> result = new HashMap<String, Object>();
		String msg = null;
		try {
			msg = assetBorrowInfoService.unSubmit(flowBusiness);
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
	 * 选择审批人
	 */
	@RequestMapping({"approvalSelect"})
	public String approvalSelect(FlowBusiness flowBusiness, User user, Model model) {
		model.addAttribute("flowBusiness", flowBusiness);
		model.addAttribute("user", user);
		return "ecode/asset/base/borrow/approvalSelect";
	}
	/**
	 *   选择审批人只显示自己部门的
	 */
	@ResponseBody
	@RequestMapping({"listApprovalData"})
	public Page<User> listApprovalData(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) {
		Page<User> page = this.flowBusinessService.findApprovalPage(new Page(request, response), flowBusiness);
		page=filtration(page);
		return page;
	}
	/**
	 * 选择下级审批人
	 */
	@RequestMapping({"nextApprovalSelect"})
	public String nextApprovalSelect(FlowBusiness flowBusiness, Model model) {
		model.addAttribute("flowBusiness", flowBusiness);
		return "ecode/asset/base/borrow/nextApprovalSelect";
	}
	/**
	 * 得到下级审批人
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
	 */
	public Page<User> filtration( Page<User> page){
		List<User> list = page.getList();
		AssetBorrowInfo assetBorrowInfo = new AssetBorrowInfo();
		assetBorrowInfo.setBorrowerCode(UserUtils.getUser().getUserCode());
		assetBorrowInfo = assetBorrowInfoService.getOffice(assetBorrowInfo);
		String office = assetBorrowInfo.getOfficeCode();
		String office2="";
		//选择审批人只显示自己部门的
		if(list!=null){
			for (int i = 0; i < list.size(); i++) {
				list.get(i).getLoginCode();
				AssetBorrowInfo assetBorrowInfo1 = new AssetBorrowInfo();
				assetBorrowInfo1.setBorrowerCode(list.get(i).getLoginCode());
				assetBorrowInfo1 = assetBorrowInfoService.getOffice(assetBorrowInfo1);
				office2 = assetBorrowInfo1.getOfficeCode();
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