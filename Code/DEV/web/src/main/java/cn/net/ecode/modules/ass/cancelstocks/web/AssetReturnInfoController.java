/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.cancelstocks.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.cancelstocks.entity.AssetReturnDtl;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBill;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBillDtl;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedInfo;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.entity.FlowLog;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;
import cn.net.ecode.modules.eflow.service.FlowLogService;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.utils.UserUtils;
import com.alibaba.fastjson.JSONArray;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.cancelstocks.entity.AssetReturnInfo;
import cn.net.ecode.modules.ass.cancelstocks.service.AssetReturnInfoService;

import java.util.*;

/**
 * 资产退库Controller
 * @author zhaohongbin
 * @version 2018-10-08
 */
@Controller
@RequestMapping(value = "${adminPath}/cancelstocks/assetReturnInfo")
public class AssetReturnInfoController extends BaseController {

	@Autowired
	private AssetReturnInfoService assetReturnInfoService;
    @Autowired
    private FlowBusinessService flowBusinessService;
    @Autowired
    private FlowLogService flowLogService;
    @Autowired
    private CodeRuleService codeRuleService;
    @Autowired
    private CommonService commonService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public AssetReturnInfo get(String id, boolean isNewRecord) {
		return assetReturnInfoService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("cancelstocks:assetReturnInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(AssetReturnInfo assetReturnInfo, Model model) {
		model.addAttribute("assetReturnInfo", assetReturnInfo);
		return "ecode/asset/base/cancelstocks/assetReturnInfoList";
	}
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("cancelstocks:assetReturnInfo:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<AssetReturnInfo> listData(AssetReturnInfo assetReturnInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        assetReturnInfo.setRetireCode(UserUtils.getUser().getUserCode());
		Page<AssetReturnInfo> page = assetReturnInfoService.findPage(new Page<AssetReturnInfo>(request, response), assetReturnInfo); 
		return page;
	}

	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("cancelstocks:assetReturnInfo:view")
	@RequestMapping(value = "form")
	public String form(AssetReturnInfo assetReturnInfo, Model model) {
        if (StringUtils.isNotBlank(assetReturnInfo.getId())) {
            model.addAttribute("usedCode", assetReturnInfo.getId());
        }
        if (assetReturnInfo.getIsNewRecord() == true) {
            assetReturnInfo.setRetireCode(UserUtils.getUser().getUserCode());
            assetReturnInfo.setRetireName(UserUtils.getUser().getUserName());
            AssetReturnInfo assetReturnInfo1 = assetReturnInfoService.getOffice(assetReturnInfo);
            assetReturnInfo.setReturnOfficeCode(assetReturnInfo1.getReturnOfficeCode());
            assetReturnInfo.setReturnOfficeName(assetReturnInfo1.getReturnOfficeName());
            assetReturnInfo.setReturnCompanyCode(assetReturnInfo1.getReturnCompanyCode());
            assetReturnInfo.setReturnCompanyName(assetReturnInfo1.getReturnCompanyName());
            assetReturnInfo.setReceiverDate(new Date());
        } else {
            assetReturnInfo.setRetireCode(assetReturnInfo.getRetireCode());
            assetReturnInfo.setRetireName(assetReturnInfo.getRetireName());
            assetReturnInfo.setReceiverDate(assetReturnInfo.getReceiverDate());
        }
		model.addAttribute("assetReturnInfo", assetReturnInfo);
		return "ecode/asset/base/cancelstocks/assetReturnInfoForm";
	}
    /**
     * 得到子表数据，
     */
    @ResponseBody
    @RequestMapping(value = "getDtlData")
    public List<AssetReturnDtl> getDtlData(AssetReturnDtl assetReturnDtl) {
        List<AssetReturnDtl> assetUsedDtls = assetReturnInfoService.findUsedCode(assetReturnDtl);
        return assetUsedDtls;
    }
	/**
	 * 保存数据
	 */
	@RequiresPermissions("cancelstocks:assetReturnInfo:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(AssetReturnInfo assetReturnInfo) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, assetReturnInfo)){
			return renderResult(Global.FALSE, message);
		}
		if(assetReturnInfo.getIsNewRecord()){
            Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
            assetReturnInfo.setReturnCode(codeRuleService.createCode("ZCTK","",common.getOfficeCode(),common.getCompanyCode()));
        }
		assetReturnInfoService.save(assetReturnInfo);
		return renderResult(Global.TRUE, "提交申请成功！");
	}

    /**
     * APP端保存资产退库
     *
     * @param assetReturnInfo
     * @param request
     * @throws Exception
     * @author xulan
     * @date 2018年10月11日11:05:36
     */
    @ResponseBody
    @RequestMapping(value = "returnListDataAPP")
    public Map<String, Object> returnListDataAPP(AssetReturnInfo assetReturnInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
      //      String dateFilter=request.getParameter("dateFilter");
//            if (StringUtils.isNotBlank(dateFilter)) {
//                if ("近三天".equals(dateFilter)) { //近三天
//                    assetReturnInfo.setEndDate(new Date());
//                    Calendar c = Calendar.getInstance();
//                    c.add(Calendar.DATE, -3);
//                    Date endDate = c.getTime();
//                    assetReturnInfo.setBeginDate(endDate);
//                }else if ("近一周".equals(dateFilter)) { //近一周
//                    assetReturnInfo.setEndDate(new Date());
//                    Calendar c = Calendar.getInstance();
//                    c.add(Calendar.DATE, -7);
//                    Date endDate = c.getTime();
//                    assetReturnInfo.setBeginDate(endDate);
//                }else if ("近一月".equals(dateFilter)) { //近一个月
//                    assetReturnInfo.setEndDate(new Date());
//                    Calendar c = Calendar.getInstance();
//                    c.add(Calendar.MONTH, -1);
//                    Date endDate = c.getTime();
//                    assetReturnInfo.setBeginDate(endDate);
//                }else{}
//            }
            Page<AssetReturnInfo> page = assetReturnInfoService.findPage(new Page<AssetReturnInfo>(request, response), assetReturnInfo);
            result.put("page",page);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            System.out.print(e);
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**
     * APP端保存资产退库列表
     *
     * @param assetReturnInfo
     * @param request
     * @throws Exception
     * @author xulan
     * @date 2018年10月11日11:05:36
     */
    @ResponseBody
    @RequestMapping(value = "saveAPP")
    public Map<String, Object> saveAPP(AssetReturnInfo assetReturnInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            if (assetReturnInfo.getIsNewRecord()) {
                Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
                assetReturnInfo.setReturnCode(codeRuleService.createCode("ZCTK","",common.getOfficeCode(),common.getCompanyCode()));
            }
            if(!assetReturnInfo.getAssetReturnDtl().equals("undefined")){
                List<AssetReturnDtl> assetUsedDtlList = JSONArray.parseArray(assetReturnInfo.getAssetReturnDtl(), AssetReturnDtl.class);
                assetReturnInfo.setAssetReturnDtlList(assetUsedDtlList);
            }
            assetReturnInfoService.save(assetReturnInfo);
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
     * 手机端获取退库单条数据详情加子表 zhaohongbin
     * @Title: getBorrowBill
     * @Description: 手机端获取借款单条数据详情
     * @param assetReturnInfo
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "getAssetReturnInfoAPP")
    public Map<String , Object> getAssetReturnInfoAPP(AssetReturnInfo assetReturnInfo, HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            AssetReturnInfo assetReturnInfo1=  assetReturnInfoService.get(assetReturnInfo);
            AssetReturnDtl assetReturnDtl=new AssetReturnDtl();
            assetReturnDtl.setReturnCode(assetReturnInfo1.getId());
            List<AssetReturnDtl> page = assetReturnInfoService.findUsedCode(assetReturnDtl);
            assetReturnInfo1.setAssetReturnDtlList(page);
            result.put("list",assetReturnInfo1);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * 手机端获取单条数据审批流详情数据 zhaohongbin
     * @Title: getBorrowBill
     * @Description: 手机端获取借款单条数据详情和审批流数据
     * @param assetReturnInfo
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "getAssetReturnInfo")
    public Map<String , Object> getBorrowBill(AssetReturnInfo assetReturnInfo,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            AssetReturnInfo assetReturnInfo1=  assetReturnInfoService.get(assetReturnInfo);
            AssetReturnDtl assetReturnDtl=new AssetReturnDtl();
            assetReturnDtl.setReturnCode(assetReturnInfo.getId());
            List<AssetReturnDtl> page = assetReturnInfoService.findUsedCode(assetReturnDtl);
            assetReturnInfo1.setAssetReturnDtlList(page);
            // wuchunyan add 新增工作流数据内容，根据小程序的业务需求
            FlowBusiness flowBusiness = new FlowBusiness();
            flowBusiness.setBizKey(assetReturnInfo.getBizKey());
            List<FlowBusiness> flowBusinessList = flowBusinessService.findList(flowBusiness);
            FlowLog flowLog=new FlowLog();
            flowLog.setBizKey(assetReturnInfo.getBizKey());
            List<FlowLog> finishList = this.flowLogService.findFinishListByBizKey(flowLog);
            result.put("flList",finishList);
            result.put("flowBusinessList", flowBusinessList);
            assetReturnInfo1.setIsNewRecord(false);
            result.put("list",assetReturnInfo1);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * 点击选择资产，打开资产数据表格
     */
    @RequestMapping(value = "getusedDtllist")
    public String warehouseSelect(AssetUsedDtl assetUsedDtl, Model model) {
        model.addAttribute("assetUsedDtl",assetUsedDtl);
        return "ecode/asset/base/cancelstocks/usedDtllist";
    }
	/**
	 * 删除数据
	 */
	@RequiresPermissions("cancelstocks:assetReturnInfo:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(AssetReturnInfo assetReturnInfo) {
		assetReturnInfoService.delete(assetReturnInfo);
        assetReturnInfoService.deleteFlowLog(assetReturnInfo);
		return renderResult(Global.TRUE, "删除资产退库成功！");
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
        return "ecode/asset/base/cancelstocks/approvalSelect";
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
        return "ecode/asset/base/cancelstocks/nextApprovalSelect";
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
     *
     * @Title: disagree
     * @Description: 手机端驳回

     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "disagreeApp",method = RequestMethod.POST)
    public Map<String , Object> disagreeApp(AssetReturnInfo assetReturnInfo,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            assetReturnInfoService.disagree(assetReturnInfo);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**
     * 过滤选择审批人只显示自己部门的
     * @param page
     * @return
     */
    public Page<User> filtration( Page<User> page){
        List<User> list = page.getList();
        AssetReturnInfo assetReturnInfo = new AssetReturnInfo();
        assetReturnInfo.setRetireCode(UserUtils.getUser().getUserCode());
        assetReturnInfo = assetReturnInfoService.getOffice(assetReturnInfo);
        String office = assetReturnInfo.getReturnOfficeCode();
        String office2="";
        //选择审批人只显示自己部门的
        if(list!=null){
            for (int i = 0; i < list.size(); i++) {
                list.get(i).getLoginCode();
                AssetReturnInfo assetReturnInfo1 = new AssetReturnInfo();
                assetReturnInfo1.setRetireCode(list.get(i).getLoginCode());
                assetReturnInfo1 = assetReturnInfoService.getOffice(assetReturnInfo1);
                office2 = assetReturnInfo1.getReturnOfficeCode();
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
    /**
     * @Title:getAll
     * @Description:查看详情
     * @createBy: 司楠楠
     * @updateBy：司楠楠
     * @date: 2016年9月14日 下午2:40:53
     * @param assetReturnInfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getAll",method= RequestMethod.POST)
    public Map<String, Object> getAll(AssetReturnInfo assetReturnInfo, HttpServletRequest request, HttpServletResponse response)throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            List<AssetReturnInfo> list=assetReturnInfoService.getAll(assetReturnInfo);
            FlowLog flowLog = new FlowLog();
            flowLog.setBizKey(assetReturnInfo.getBizKey());
            Page page = new Page();
            page.setOrderBy("a.update_date ASC");
            flowLog.setPage(page);
            List<FlowLog> flList = flowLogService.findList(flowLog);
            // wuchunyan add 新增工作流数据内容，根据小程序的业务需求
            FlowBusiness flowBusiness = new FlowBusiness();
            flowBusiness.setBizKey(assetReturnInfo.getBizKey());
            List<FlowBusiness> flowBusinessList = flowBusinessService.findList(flowBusiness);
            result.put("flowBusinessList", flowBusinessList);
            // end
            result.put("list", list);
            result.put("flowLog", flList);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;

    }
    /**
     * @Title:agreePC
     * @Description:审批通过PC
     * @createBy: 司楠楠
     * @updateBy：司楠楠
     * @date: 2016年10月31日 上午9:50:56
     * @param assetReturnInfo
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("cancelstocks:assetReturnInfo:edit")
    @ResponseBody
    @RequestMapping(value = "agreePC")
    public String agreePC(AssetReturnInfo assetReturnInfo,HttpServletRequest request, HttpServletResponse response) {
        try {
            String isEnd=request.getParameter("isEnd");
            String sysCode=request.getParameter("sysCode");
            assetReturnInfo.setIsEnd(Integer.parseInt(isEnd));
            assetReturnInfo.setId(sysCode);
            assetReturnInfoService.agree(assetReturnInfo);
            return renderResult(Global.TRUE, "审批通过！");
        } catch (Exception e) {
            e.printStackTrace();
            return renderResult(Global.TRUE, "出现问题！");
        }

    }
    /**
     * @Title:agree
     * @Description:审批通过
     * @createBy: 司楠楠
     * @updateBy：司楠楠
     * @date: 2016年10月24日 下午3:23:49
     * @param assetReturnInfo
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "agree",method = RequestMethod.POST)
    public Map<String , Object> agree(AssetReturnInfo assetReturnInfo,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            assetReturnInfoService.agree(assetReturnInfo);
            result.put("code", "200");
            result.put("message", "success");
            result.put("messagePc", "审批通过！");
            result.put("result", Global.TRUE);
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
            result.put("messagePc", "出现问题");
            result.put("result", Global.FALSE);
        }
        return result;
    }
    /**
     * @Title:disagreePC
     * @Description:驳回PC
     * @createBy: 司楠楠
     * @updateBy：司楠楠
     * @date: 2016年10月31日 上午9:53:46
     * @param assetReturnInfo
     * @param request
     * @param response
     * @return
     */
    @RequiresPermissions("cancelstocks:assetReturnInfo:edit")
    @ResponseBody
    @RequestMapping(value = "disagreePC")
    public String disagreePC(AssetReturnInfo assetReturnInfo,HttpServletRequest request, HttpServletResponse response){
        try {
            String sysCode=request.getParameter("sysCode");
            assetReturnInfo.setId(sysCode);
            assetReturnInfoService.disagree(assetReturnInfo);
            return renderResult(Global.TRUE, "已驳回！");
        } catch (Exception e) {
            return renderResult(Global.TRUE, "出现问题！");
        }
    }
    /**
     * @Title:disagree
     * @Description:驳回
     * @createBy: 司楠楠
     * @updateBy：司楠楠
     * @date: 2016年10月24日 下午3:24:14
     * @param assetReturnInfo
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "disagree",method = RequestMethod.POST)
    public Map<String , Object> disagree(AssetReturnInfo assetReturnInfo,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            assetReturnInfoService.disagree(assetReturnInfo);
            result.put("code", "200");
            result.put("message", "success");
            result.put("messagePc", "已驳回！");
            result.put("result", Global.TRUE);
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
            result.put("messagePc", "出现问题");
            result.put("result", Global.FALSE);
        }
        return result;
    }


    /**
     *
     * @Title: unDo
     * @Description: 撤回审批
     * @author: wuchunyan
     * @date: 2017年10月12日 上午9:43:55
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "unDo",method = RequestMethod.POST)
    public Map<String , Object> unDo(FlowBusiness flowBusiness,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            String msg = assetReturnInfoService.unDo(flowBusiness);
            // 如果msg信息为空
            if(org.apache.commons.lang3.StringUtils.isBlank(msg)){
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

    @ResponseBody
    @RequestMapping(value = "unSubmit",method = RequestMethod.POST)
    public Map<String , Object> unSubmit(FlowBusiness flowBusiness,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        String msg = null;
        try {
            msg = assetReturnInfoService.unSubmit(flowBusiness);
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
}