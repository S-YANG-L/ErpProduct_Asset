/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.allotinfo.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.allotinfo.entity.AssetAllotDtl;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
import cn.net.ecode.modules.ass.inout.entity.InoutBills;
import cn.net.ecode.modules.ass.location.entity.AssLocation;
import cn.net.ecode.modules.ass.location.service.AssLocationService;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBill;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBillDtl;
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
import cn.net.ecode.modules.ass.allotinfo.entity.AssetAllotInfo;
import cn.net.ecode.modules.ass.allotinfo.service.AssetAllotInfoService;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 资产调拨管理Controller
 *
 * @author zhaohongbin
 * @version 2018-10-10
 */

@Controller
@RequestMapping(value = "${adminPath}/allotinfo/assetAllotInfo")
public class AssetAllotInfoController extends BaseController {
    @Autowired
    CommonService commonService;
    @Autowired
    private AssetAllotInfoService assetAllotInfoService;
    @Autowired
    private AssLocationService assLocationService;
    @Autowired
    private FlowBusinessService flowBusinessService;
    @Autowired
    private FlowLogService flowLogService;
    @Autowired
    private CodeRuleService codeRuleService;

    /**
     * 获取数据
     */
    @ModelAttribute
    public AssetAllotInfo get(String id, boolean isNewRecord) {
        return assetAllotInfoService.get(id, isNewRecord);
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("allotinfo:assetAllotInfo:view")
    @RequestMapping(value = {"list", ""})
    public String list(AssetAllotInfo assetAllotInfo, Model model) {
        model.addAttribute("assetAllotInfo", assetAllotInfo);
        Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
        model.addAttribute("common", common);
        return "ecode/asset/base/allotinfo/assetAllotInfoList";
    }

    /**
     * 查询列表数据
     */
    @RequiresPermissions("allotinfo:assetAllotInfo:view")
    @ResponseBody
    @RequestMapping(value = "listData")
    public Page<AssetAllotInfo> listData(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<AssetAllotInfo> page = assetAllotInfoService.findPage(new Page<AssetAllotInfo>(request, response), assetAllotInfo);
        return page;
    }

    /**
     * 查看编辑表单
     */
    @RequiresPermissions("allotinfo:assetAllotInfo:view")
    @RequestMapping(value = "form")
    public String form(AssetAllotInfo assetAllotInfo, Model model) {
        if (!assetAllotInfo.getIsNewRecord()) {
            model.addAttribute("allotCode", assetAllotInfo.getId());
        }
        Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
        if (assetAllotInfo.getIsNewRecord() == true) {
            assetAllotInfo.setOperatorCode(UserUtils.getUser().getUserCode());
            assetAllotInfo.setOperatorName(UserUtils.getUser().getUserName());
            Office office = new Office();
            office.setOfficeCode(common.getOfficeCode());
            assetAllotInfo.setOffice(office);
            assetAllotInfo.setOfficeName(common.getOfficeName());
            assetAllotInfo.setCompanyCode(common.getCompanyCode());
            assetAllotInfo.setAllotDate(new Date());
        } else {
            assetAllotInfo.setOperatorCode(assetAllotInfo.getOperatorName());
            assetAllotInfo.setOperatorName(assetAllotInfo.getOperatorCode());
            assetAllotInfo.setAllotDate(assetAllotInfo.getAllotDate());
        }
        assetAllotInfo.setAllotUserCode(UserUtils.getUser().getUserCode());
        assetAllotInfo.setAllotUserName(UserUtils.getUser().getUserName());
        AssLocation assLocation = new AssLocation();
        List<AssLocation> locations = assLocationService.findList(assLocation);
        model.addAttribute("locations", locations);
        model.addAttribute("assetAllotInfo", assetAllotInfo);
        return "ecode/asset/base/allotinfo/assetAllotInfoForm";
    }

    /**
     * 得到子表数据
     */
    @ResponseBody
    @RequestMapping(value = "getDtlData")
    public List<AssetAllotDtl> getDtlData(AssetAllotDtl assetAllotDtl) {
        List<AssetAllotDtl> assetAllotDtls = assetAllotInfoService.findUsedCode(assetAllotDtl);
        return assetAllotDtls;
    }

    /**
     * 点击选择资产，打开资产数据表格
     */
    @RequestMapping(value = "getusedDtllist")
    public String warehouseSelect(AssetInfo assetInfo, Model model) {
        model.addAttribute("assetInfo", assetInfo);
        return "ecode/asset/base/allotinfo/usedDtllist";
    }

    /**
     * 保存数据
     */
    @RequiresPermissions("allotinfo:assetAllotInfo:edit")
    @ResponseBody
    @RequestMapping(value = "save")
    public String save(AssetAllotInfo assetAllotInfo) {
        StringBuilder message = new StringBuilder();
        if (!beanValidator(message, assetAllotInfo)) {
            return renderResult(Global.FALSE, message);
        }
		if (assetAllotInfo.getIsNewRecord()){
            Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
            assetAllotInfo.setAllotCode(codeRuleService.createCode("ZCDB","",common.getOfficeCode(),common.getCompanyCode()));
        }
        assetAllotInfoService.save(assetAllotInfo);
        if (assetAllotInfo.getStep().equals("")) {
            if (assetAllotInfo.getAllotTypeName().equals("调拨到部门")) {
                return renderResult(Global.TRUE, "提交成功！");
            } else if (assetAllotInfo.getAllotTypeName().equals("调拨到新单位")) {
                return renderResult(Global.TRUE, "调拨成功！");
            } else {
                return renderResult(Global.TRUE, "捐献成功！");
            }
        } else if (assetAllotInfo.getStep().equals("1")) {
            return renderResult(Global.TRUE, "审批通过！");
        } else {
            return renderResult(Global.TRUE, "确认成功！");
        }
    }
    /**
     * 删除数据
     */
    @RequiresPermissions("allotinfo:assetAllotInfo:edit")
    @ResponseBody
    @RequestMapping(value = "delete")
    public String delete(AssetAllotInfo assetAllotInfo) {
        assetAllotInfoService.delete(assetAllotInfo);
        assetAllotInfoService.deleteFlowLog(assetAllotInfo);
        return renderResult(Global.TRUE, "删除资产调拨管理成功！");
    }

    /**
     * @param flowBusiness
     * @param request
     * @param response
     * @return
     * @Title: getNextFlowBusiness
     * @Description: 判断工作流是否为最后一步
     */
    @ResponseBody
    @RequestMapping(value = "getNextFlowBusiness")
    public Integer getNextFlowBusiness(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) {
        FlowBusiness nextFlowBusiness;
        nextFlowBusiness = flowBusinessService.getNextFlowBusiness(flowBusiness.getBizKey(), flowBusiness.getStep());
        if (nextFlowBusiness != null) {
            return 1;  //不是最后一步
        } else {
            return 0;  //是最后一步
        }
    }

    /**
     * @param flowBusiness
     * @param request
     * @param response
     * @return
     * @Title: getNextFlowBusiness
     * @Description: 判断工作流是否为最后一步
     */
    @ResponseBody
    @RequestMapping(value = "getNextFlowBusinessAPP")
    public Map<String, Object> getNextFlowBusinessAPP(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) {
        FlowBusiness nextFlowBusiness;
        nextFlowBusiness = flowBusinessService.getNextFlowBusiness(flowBusiness.getBizKey(), flowBusiness.getStep());
        Map<String, Object> result = new HashMap<>();
        try {
            if (nextFlowBusiness != null) {
                result.put("data", "1"); //不是最后一步
            } else {
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
     * 选择审批人只显示自己部门的
     *
     * @param flowBusiness
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping({"listApprovalData"})
    public Page<User> listApprovalData(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) {
        Page<User> page = this.flowBusinessService.findApprovalPage(new Page(request, response), flowBusiness);
        page = filtration(page);
        return page;
    }

    /**
     * 选择审批人
     *
     * @param flowBusiness
     * @return
     */
    @RequestMapping({"approvalSelect"})
    public String approvalSelect(FlowBusiness flowBusiness, Model model) {
        model.addAttribute("flowBusiness", flowBusiness);
        return "ecode/asset/base/allotinfo/approvalSelect";
    }

    /**
     * 得到部门管理员
     *
     * @param flowBusiness
     * @param model
     * @return
     */
    @RequestMapping({"nextApprovalSelect"})
    public String nextApprovalSelect(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("flowBusiness", flowBusiness);
        String allotOfficeCode = request.getParameter("allotOfficeCode");
        model.addAttribute("allotOfficeCode", allotOfficeCode);
        return "ecode/asset/base/allotinfo/nextApprovalSelect";
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
        String allotOfficeCode = request.getParameter("allotOfficeCode");
        Page<User> page = assetAllotInfoService.findNextApprovalPage(flowBusiness, allotOfficeCode, request, response);
        return page;
    }

    /**
     * 过滤选择审批人只显示自己部门的
     *
     * @param page
     * @return
     */
    public Page<User> filtration(Page<User> page) {
        List<User> list = page.getList();
        Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
        String office = common.getOfficeCode();
        String office2 = "";
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                list.get(i).getLoginCode();
                common = commonService.getOfficeCompany(list.get(i).getLoginCode());
                office2 = common.getOfficeCode();
                if (office.equals(office2)) {
                } else {
                    list.remove(i);
                    i--;
                }
            }
        } else {
        }
        return page;
    }

    /**
     * @return
     * @Title:getAll
     * @Description:查看详情
     */
    @ResponseBody
    @RequestMapping(value = "getAll")
    public Map<String, Object> getAll(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            List<AssetAllotInfo> list = assetAllotInfoService.getAll(assetAllotInfo);
            FlowLog flowLog = new FlowLog();
            flowLog.setBizKey(assetAllotInfo.getBizKey());
            Page page = new Page();
            page.setOrderBy("a.update_date ASC");
            flowLog.setPage(page);
            List<FlowLog> flList = flowLogService.findList(flowLog);
            // wuchunyan add 新增工作流数据内容，根据小程序的业务需求
            FlowBusiness flowBusiness = new FlowBusiness();
            flowBusiness.setBizKey(assetAllotInfo.getBizKey());
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
     * @return
     * @Title:getAll
     * @Description:APP查看调拨列表
     */
    @ResponseBody
    @RequestMapping(value = "getAllDateApp")
    public Map<String, Object> getAllDateApp(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            Page<AssetAllotInfo> page = assetAllotInfoService.findPage(new Page<AssetAllotInfo>(request, response), assetAllotInfo);
            result.put("page", page);
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
     * 手机端获取调拨单条数据详情加子表 zhaohonbin
     *
     * @param assetAllotInfo
     * @throws Exception
     * @Title: getBorrowBill
     * @Description: 手机端获取借款单条数据详情
     */
    @ResponseBody
    @RequestMapping(value = "getAssetAllotDtlAPP")
    public Map<String, Object> getOutBoundBillAPP(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            AssetAllotInfo assetAllotInfo1 = assetAllotInfoService.get(assetAllotInfo);
            AssetAllotDtl assetAllotDtl = new AssetAllotDtl();
            assetAllotDtl.setAllotCode(assetAllotInfo1.getId());
            List<AssetAllotDtl> page = assetAllotInfoService.findUsedCode(assetAllotDtl);
            assetAllotInfo1.setAssetAllotDtlList(page);
            result.put("list", assetAllotInfo1);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * @param assetAllotInfo
     * @param request
     * @param response
     * @return
     * @Title:agreePC
     * @Description:审批通过PC
     * @date: 2016年10月31日 上午9:50:56
     */
    @RequiresPermissions("allotinfo:assetAllotInfo:edit")
    @ResponseBody
    @RequestMapping(value = "agreePC")
    public String agreePC(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response) {
        try {
            String isEnd = request.getParameter("isEnd");
            String sysCode = request.getParameter("sysCode");
            assetAllotInfo.setIsEnd(Integer.parseInt(isEnd));
            assetAllotInfo.setId(sysCode);
            assetAllotInfoService.agree(assetAllotInfo);
            return renderResult(Global.TRUE, "审批通过！");
        } catch (Exception e) {
            e.printStackTrace();
            return renderResult(Global.TRUE, "出现问题！");
        }

    }

    /**
     * @throws Exception
     * @Title:agree
     * @Description:审批通过
     */
    @ResponseBody
    @RequestMapping(value = "agree", method = RequestMethod.POST)
    public Map<String, Object> agree(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            assetAllotInfoService.agree(assetAllotInfo);
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
     * @param assetAllotInfo
     * @param request
     * @param response
     * @return
     * @Title:disagreePC
     * @Description:驳回PC
     */
    @RequiresPermissions("allotinfo:assetAllotInfo:edit")
    @ResponseBody
    @RequestMapping(value = "disagreePC")
    public String disagreePC(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response) {
        try {
            String sysCode = request.getParameter("sysCode");
            assetAllotInfo.setId(sysCode);
            assetAllotInfoService.disagree(assetAllotInfo);
            return renderResult(Global.TRUE, "已驳回！");
        } catch (Exception e) {
            return renderResult(Global.TRUE, "出现问题！");
        }
    }

    /**
     * @param assetAllotInfo
     * @param request
     * @param response
     * @return
     * @throws Exception
     * @Title: disagree
     * @Description: 手机端驳回
     */
    @ResponseBody
    @RequestMapping(value = "disagreeApp", method = RequestMethod.POST)
    public Map<String, Object> disagreeApp(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            assetAllotInfoService.disagree(assetAllotInfo);
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
     * @throws Exception
     * @Title:disagree
     * @Description:驳回
     */
    @ResponseBody
    @RequestMapping(value = "disagree", method = RequestMethod.POST)
    public Map<String, Object> disagree(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            assetAllotInfoService.disagree(assetAllotInfo);
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
     * @return
     * @Title: unDo
     * @Description: 撤回审批
     * @date: 2017年10月12日 上午9:43:55
     */
    @ResponseBody
    @RequestMapping(value = "unDo", method = RequestMethod.POST)
    public Map<String, Object> unDo(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            String msg = assetAllotInfoService.unDo(flowBusiness);
            // 如果msg信息为空
            if (org.apache.commons.lang3.StringUtils.isBlank(msg)) {
                result.put("code", "200");
                result.put("message", "单据撤回成功！");
            } else {
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
    @RequestMapping(value = "unSubmit", method = RequestMethod.POST)
    public Map<String, Object> unSubmit(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        String msg = null;
        try {
            msg = assetAllotInfoService.unSubmit(assetAllotInfo);
            if (org.apache.commons.lang3.StringUtils.isEmpty(msg)) {//如果msg信息为空
                result.put("true", "单据撤回成功！");
                result.put("code", "200");
                result.put("message", "success");
            } else {
                if (msg.equals("当前单据未提交或已撤回")) {
                    result.put("true", "单据撤回成功！");
                    result.put("code", "200");
                    result.put("message", "success");
                } else {
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
     * App端提交调拨
     *
     * @throws Exception
     */
    @RequestMapping(value = "saveAPP", method = RequestMethod.POST)
    public Map<String, Object> saveAPP(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
            assetAllotInfo.setAllotCode(codeRuleService.createCode("ZCDB","",common.getOfficeCode(),common.getCompanyCode()));
            List<AssetAllotDtl> inoutBillso = JSONArray.parseArray(assetAllotInfo.getAssetAllotDtl(), AssetAllotDtl.class);
            assetAllotInfo.setAssetAllotDtlList(inoutBillso);
            assetAllotInfoService.save(assetAllotInfo);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * 手机端获取借款单条数据详情 lixin
     *
     * @param assetAllotInfo
     * @throws Exception
     * @Title: getBorrowBill
     * @Description: 手机端获取借款单条数据详情和审批流数据
     */
    @ResponseBody
    @RequestMapping(value = "getAssetAllotInfo")
    public Map<String, Object> getBorrowBill(AssetAllotInfo assetAllotInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            AssetAllotInfo assetAllotInfo1 = assetAllotInfoService.get(assetAllotInfo);
            AssetAllotDtl assetAllotDtl = new AssetAllotDtl();
            assetAllotDtl.setAllotCode(assetAllotInfo.getId());
            List<AssetAllotDtl> page = assetAllotInfoService.findUsedCode(assetAllotDtl);
            assetAllotInfo1.setAssetAllotDtlList(page);
            // wuchunyan add 新增工作流数据内容，根据小程序的业务需求
            FlowBusiness flowBusiness = new FlowBusiness();
            flowBusiness.setBizKey(assetAllotInfo.getBizKey());
            List<FlowBusiness> flowBusinessList = flowBusinessService.findList(flowBusiness);
            FlowLog flowLog = new FlowLog();
            flowLog.setBizKey(assetAllotInfo.getBizKey());
            List<FlowLog> finishList = this.flowLogService.findFinishListByBizKey(flowLog);
            result.put("flList", finishList);
            result.put("flowBusinessList", flowBusinessList);
            // end
            result.put("list", assetAllotInfo1);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
}