/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.usedinfo.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.assetsclassify.entity.AssetSort;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;

import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBill;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBillDtl;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;
import cn.net.ecode.modules.ass.usedinfo.service.AssetUsedDtlService;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.entity.FlowLog;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;
import cn.net.ecode.modules.eflow.service.FlowLogService;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.utils.UserUtils;
import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
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
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedInfo;
import cn.net.ecode.modules.ass.usedinfo.service.AssetUsedInfoService;

import java.util.*;

/**
 * 资产领用Controller
 *
 * @author zhaohongbin
 * @version 2018-09-20
 */
@Controller
@RequestMapping(value = "${adminPath}/usedinfo/assetUsedInfo")
public class AssetUsedInfoController extends BaseController {
    @Autowired
    private AssetUsedInfoService assetUsedInfoService;
    @Autowired
    private AssetUsedDtlService assetUsedDtlService;
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
    public AssetUsedInfo get(String id, boolean isNewRecord) {
        return assetUsedInfoService.get(id, isNewRecord);
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("usedinfo:assetUsedInfo:view")
    @RequestMapping(value = {"list", ""})
    public String list(AssetUsedInfo assetUsedInfo, Model model) {

        model.addAttribute("assetUsedInfo", assetUsedInfo);

        return "ecode/asset/base/usedinfo/assetUsedInfoList";
    }

    /**
     * 查询列表数据
     */
    @RequiresPermissions("usedinfo:assetUsedInfo:view")
    @ResponseBody
    @RequestMapping(value = "listData")
    public Page<AssetUsedInfo> listData(AssetUsedInfo assetUsedInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        assetUsedInfo.setReceiverCode(UserUtils.getUser().getUserCode());
        Page<AssetUsedInfo> page = assetUsedInfoService.findPage(new Page<AssetUsedInfo>(request, response), assetUsedInfo);
        return page;
    }

    /**
     * 查看编辑表单
     */
    @RequiresPermissions("usedinfo:assetUsedInfo:view")
    @RequestMapping(value = "form")
    public String form(AssetUsedInfo assetUsedInfo, Model model) {
        if (StringUtils.isNotBlank(assetUsedInfo.getId())) {
            model.addAttribute("usedCode", assetUsedInfo.getId());
        }
        if (assetUsedInfo.getIsNewRecord() == true) {
            assetUsedInfo.setReceiverCode(UserUtils.getUser().getUserCode());
            assetUsedInfo.setReceiverName(UserUtils.getUser().getUserName());
            Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
            assetUsedInfo.setUsedOfficeCode(common.getOfficeCode());
            assetUsedInfo.setUsedOfficeName(common.getOfficeName());
            assetUsedInfo.setReceiverDate(new Date());
        } else {
            assetUsedInfo.setReceiverCode(assetUsedInfo.getReceiverCode());
            assetUsedInfo.setReceiverName(assetUsedInfo.getReceiverName());
            assetUsedInfo.setReceiverDate(assetUsedInfo.getReceiverDate());
        }
        model.addAttribute("assetUsedInfo", assetUsedInfo);
        return "ecode/asset/base/usedinfo/assetUsedInfoForm";
    }

    /**
     * 查看编辑领用退库表单
     */
    @RequiresPermissions("usedinfo:assetUsedInfo:view")
    @RequestMapping(value = "assetUsedInfoList")
    public String assetUsedInfoList(AssetUsedInfo assetUsedInfo, Model model) {
        model.addAttribute("assetUsedInfo", assetUsedInfo);
        return "ecode/asset/base/usedinfo/assetUsedInfoList";
    }
    /**
     * 点击选择资产，打开资产数据表格
     */
    @RequestMapping(value = "getusedDtllist")
    public String warehouseSelect(AssetInfo assetInfo, Model model) {
        model.addAttribute("assetInfo", assetInfo);
        return "ecode/asset/base/usedinfo/usedDtllist";
    }

    /**
     * 得到子表数据，
     */
    @ResponseBody
    @RequestMapping(value = "getDtlData")
    public List<AssetUsedDtl> getDtlData(AssetUsedDtl assetUsedDtl) {
        List<AssetUsedDtl> assetUsedDtls = assetUsedDtlService.findUsedCode(assetUsedDtl);
        return assetUsedDtls;
    }

    /**
     * 退库时得到子表数据，
     */
    @ResponseBody
    @RequestMapping(value = "getDtlDataReturn")
    public List<AssetUsedDtl> getDtlDataReturn(AssetUsedDtl assetUsedDtl) {
        List<AssetUsedDtl> assetUsedDtls = assetUsedDtlService.findUsedCodeReturn(assetUsedDtl);
        return assetUsedDtls;
    }

    /**
     * 退库时得到子表数据，
     */
    @ResponseBody
    @RequestMapping(value = "getDtlDataReturnAPP")
    public Map<String, Object> getDtlDataReturnAPP(AssetUsedDtl assetUsedDtl) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<AssetUsedDtl> assetUsedDtls = assetUsedDtlService.findUsedCodeReturn(assetUsedDtl);
            result.put("list", assetUsedDtls);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**
     * 保存数据
     */
    @RequiresPermissions("usedinfo:assetUsedInfo:edit")
    @ResponseBody
    @RequestMapping(value = "save")
    public String save(AssetUsedInfo assetUsedInfo) {
        StringBuilder message = new StringBuilder();
        if (!beanValidator(message, assetUsedInfo)) {
            return renderResult(Global.FALSE, message);
        }
        Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
        if (assetUsedInfo.getIsNewRecord()) {
            assetUsedInfo.setUsedCode(codeRuleService.createCode("ZCLY", "", common.getOfficeCode(), common.getCompanyCode()));
        }
        assetUsedInfo.setNotes("标准领用");
        assetUsedInfoService.save(assetUsedInfo);
        if (assetUsedInfo.getStep().equals("")) {
            return renderResult(Global.TRUE, "提交申请成功！");
        } else if (assetUsedInfo.getStep().equals("1") || assetUsedInfo.getStep().equals("2")) {
            return renderResult(Global.TRUE, "审批通过！");
        } else {
            return renderResult(Global.TRUE, "确认成功！");
        }
    }
    /**
     * 保存数据
     */
    @ResponseBody
    @RequestMapping(value = "saveAction")
    public void saveAction(AssetUsedInfo assetUsedInfo) {
        assetUsedInfo.setNotes("标准领用");
        assetUsedInfoService.save(assetUsedInfo);
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
     * App选择审批人只显示自己部门的
     *
     * @param flowBusiness
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping({"listApprovalDataApp"})
    public Map<String, Object> listApprovalDataApp(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) {
        Page<User> page = this.flowBusinessService.findApprovalPage(new Page(request, response), flowBusiness);
        page = filtration(page);
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result.put("data", page);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * 选择审批人
     *
     * @param flowBusiness
     * @return
     */
    @RequestMapping({"approvalSelect"})
    public String approvalSelect(FlowBusiness flowBusiness, User user, Model model) {
        model.addAttribute("flowBusiness", flowBusiness);
        model.addAttribute("user", user);
        return "ecode/asset/base/usedinfo/approvalSelect";
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
        return "ecode/asset/base/usedinfo/nextApprovalSelect";
    }
    /**
     *
     * @Title: disagree
     * @Description: 手机端驳回
     * @param assetUsedInfo
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "disagreeApp",method = RequestMethod.POST)
    public Map<String , Object> disagreeApp(AssetUsedInfo assetUsedInfo,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            assetUsedInfoService.disagree(assetUsedInfo);
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
        AssetUsedInfo assetUsedInfo = new AssetUsedInfo();
        assetUsedInfo.setReceiverCode(UserUtils.getUser().getUserCode());
        assetUsedInfo = assetUsedInfoService.getOffice(assetUsedInfo);
        String office = assetUsedInfo.getUsedOfficeCode();
        String office2 = "";
        //选择审批人只显示自己部门的
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                list.get(i).getLoginCode();
                AssetUsedInfo assetUsedInfo1 = new AssetUsedInfo();
                assetUsedInfo1.setReceiverCode(list.get(i).getLoginCode());
                assetUsedInfo1 = assetUsedInfoService.getOffice(assetUsedInfo1);
                office2 = assetUsedInfo1.getUsedOfficeCode();
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
     * 删除数据
     */
    @RequiresPermissions("usedinfo:assetUsedInfo:edit")
    @ResponseBody
    @RequestMapping(value = "delete")
    public String delete(AssetUsedInfo assetUsedInfo) {
        assetUsedInfoService.delete(assetUsedInfo);
        assetUsedInfoService.deleteFlowLog(assetUsedInfo);
//        业务表--领用资产用到的表 资产领用表
//        flowlog
//        物理删除
        return renderResult(Global.TRUE, "删除资产领用成功！");
    }

    /**
     * @return
     * @Title:getAll
     * @Description:查看详情
     */
    @ResponseBody
    @RequestMapping(value = "getAll", method = RequestMethod.POST)
    public Map<String, Object> getAll(AssetUsedInfo assetUsedInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            List<AssetUsedInfo> list = assetUsedInfoService.getAll(assetUsedInfo);
            FlowLog flowLog = new FlowLog();
            flowLog.setBizKey(assetUsedInfo.getBizKey());
            Page page = new Page();
            page.setOrderBy("a.update_date ASC");
            flowLog.setPage(page);
            List<FlowLog> flList = flowLogService.findList(flowLog);
            // wuchunyan add 新增工作流数据内容，根据小程序的业务需求
            FlowBusiness flowBusiness = new FlowBusiness();
            flowBusiness.setBizKey(assetUsedInfo.getBizKey());
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
     * @param assetUsedInfo
     * @param request
     * @param response
     * @return
     * @Title:agreePC
     * @Description:审批通过PC
     * @date: 2016年10月31日 上午9:50:56
     */
    @RequiresPermissions("usedinfo:assetUsedInfo:edit")
    @ResponseBody
    @RequestMapping(value = "agreePC")
    public String agreePC(AssetUsedInfo assetUsedInfo, HttpServletRequest request, HttpServletResponse response) {
        try {
            String isEnd = request.getParameter("isEnd");
            String sysCode = request.getParameter("sysCode");
            assetUsedInfo.setIsEnd(Integer.parseInt(isEnd));
            assetUsedInfo.setId(sysCode);
            assetUsedInfoService.agree(assetUsedInfo);
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
    public Map<String, Object> agree(AssetUsedInfo assetUsedInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            assetUsedInfoService.agree(assetUsedInfo);
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
     * @param assetUsedInfo
     * @param request
     * @param response
     * @return
     * @Title:disagreePC
     * @Description:驳回PC
     */
    @RequiresPermissions("usedinfo:assetUsedInfo:edit")
    @ResponseBody
    @RequestMapping(value = "disagreePC")
    public String disagreePC(AssetUsedInfo assetUsedInfo, HttpServletRequest request, HttpServletResponse response) {
        try {
            String sysCode = request.getParameter("sysCode");
            assetUsedInfo.setId(sysCode);
            assetUsedInfoService.disagree(assetUsedInfo);
            return renderResult(Global.TRUE, "已驳回！");
        } catch (Exception e) {
            return renderResult(Global.TRUE, "出现问题！");
        }
    }

    /**
     * @throws Exception
     * @Title:disagree
     * @Description:驳回
     */
    @ResponseBody
    @RequestMapping(value = "disagree", method = RequestMethod.POST)
    public Map<String, Object> disagree(AssetUsedInfo assetUsedInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            assetUsedInfoService.disagree(assetUsedInfo);
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
            String msg = assetUsedInfoService.unDo(flowBusiness);
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
    public Map<String, Object> unSubmit(FlowBusiness flowBusiness, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        String msg = null;
        try {
            msg = assetUsedInfoService.unSubmit(flowBusiness);
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
     * APP端保存资产领用
     *
     * @param assetUsedInfo
     * @param request
     * @throws Exception
     * @author xulan
     * @date 2018年10月11日11:05:36
     */
    @ResponseBody
    @RequestMapping(value = "saveAPP")
    public Map<String, Object> saveAPP(AssetUsedInfo assetUsedInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
            if (assetUsedInfo.getIsNewRecord()) {
                Office office = new Office();
                office.setOfficeCode(assetUsedInfo.getUsedOfficeCode());
                assetUsedInfo.setUsedCode(codeRuleService.createCode("ZCLY", "", common.getOfficeCode(), common.getCompanyCode()));
            }
            if(!assetUsedInfo.getAssetUsedDtlsString().equals("undefined")){
                List<AssetUsedDtl> assetUsedDtlList = JSONArray.parseArray(assetUsedInfo.getAssetUsedDtlsString(), AssetUsedDtl.class);
                assetUsedInfo.setAssetUsedDtls(assetUsedDtlList);
            }
            assetUsedInfo.setNotes("标准领用");
            assetUsedInfoService.save(assetUsedInfo);
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
     * APP端获取资产领用列表
     *
     * @param assetUsedInfo
     * @param request
     * @throws Exception
     * @author xulan
     * @date 2018年10月11日13:42:49
     */
    @ResponseBody
    @RequestMapping(value = "getAssetInfoList")
    public Map<String, Object> getAssetInfoList(AssetUsedInfo assetUsedInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
//            String dateFilter=request.getParameter("dateFilter");
//            if (StringUtils.isNotBlank(dateFilter)) {
//                if ("近三天".equals(dateFilter)) { //近三天
//                    outboundBill.setEndDate(new Date());
//                    Calendar c = Calendar.getInstance();
//                    c.add(Calendar.DATE, -3);
//                    Date endDate = c.getTime();
//                    outboundBill.setBeginDate(endDate);
//                }else if ("近一周".equals(dateFilter)) { //近一周
//                    outboundBill.setEndDate(new Date());
//                    Calendar c = Calendar.getInstance();
//                    c.add(Calendar.DATE, -7);
//                    Date endDate = c.getTime();
//                    outboundBill.setBeginDate(endDate);
//                }else if ("近一月".equals(dateFilter)) { //近一个月
//                    outboundBill.setEndDate(new Date());
//                    Calendar c = Calendar.getInstance();
//                    c.add(Calendar.MONTH, -1);
//                    Date endDate = c.getTime();
//                    outboundBill.setBeginDate(endDate);
//                }else{}
//            }
            Page<AssetUsedInfo> page = assetUsedInfoService.findPage(new Page<AssetUsedInfo>(request, response), assetUsedInfo);
            result.put("page",page);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * APP端编辑
     *
     * @param id
     * @throws Exception
     * @author xulan
     * @date 2018年10月11日13:42:49
     */
    @ResponseBody
    @RequestMapping(value = "getinfoApp")
    public Map<String, Object> getinfoApp(String id) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            result.put("page", assetUsedInfoService.get(id));
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * APP得到子表数据，
     */
    @ResponseBody
    @RequestMapping(value = "getDtlDataAPP")
    public Map<String, Object> getDtlDataAPP(AssetUsedDtl assetUsedDtl) {

        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            result.put("page", assetUsedDtlService.findUsedCode(assetUsedDtl));
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**
     * 手机端获取单条数据审批流详情数据 zhaohongbin
     * @Title: getBorrowBill
     * @Description: 手机端获取借款单条数据详情和审批流数据
     * @param assetUsedInfo
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "getAssetUsedInfo")
    public Map<String , Object> getAssetUsedInfo(AssetUsedInfo assetUsedInfo,HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            AssetUsedInfo assetUsedInfo1=  assetUsedInfoService.get(assetUsedInfo);
            AssetUsedDtl assetUsedDtl=new AssetUsedDtl();
            assetUsedDtl.setUsedCode(assetUsedInfo1.getId());
            List<AssetUsedDtl> page = assetUsedDtlService.findUsedCode(assetUsedDtl);
            assetUsedInfo1.setAssetUsedDtls(page);
            // wuchunyan add 新增工作流数据内容，根据小程序的业务需求
            FlowBusiness flowBusiness = new FlowBusiness();
            flowBusiness.setBizKey(assetUsedInfo.getBizKey());
            List<FlowBusiness> flowBusinessList = flowBusinessService.findList(flowBusiness);
            FlowLog flowLog=new FlowLog();
            flowLog.setBizKey(assetUsedInfo.getBizKey());
            List<FlowLog> finishList = this.flowLogService.findFinishListByBizKey(flowLog);
            result.put("flList",finishList);
            result.put("flowBusinessList", flowBusinessList);
            result.put("list",assetUsedInfo1);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
    /**
     * 手机端获取领用单条数据详情加子表 zhaohongbin
     * @Title: getBorrowBill
     * @Description: 手机端获取借款单条数据详情
     * @param assetUsedInfo
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "getAssetUsedInfoAPP")
    public Map<String , Object> getAssetUsedInfoAPP(AssetUsedInfo assetUsedInfo, HttpServletRequest request, HttpServletResponse response)throws Exception  {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            AssetUsedInfo assetUsedInfo1=  assetUsedInfoService.get(assetUsedInfo);
            AssetUsedDtl assetUsedDtl=new AssetUsedDtl();
            assetUsedDtl.setUsedCode(assetUsedInfo1.getId());
            List<AssetUsedDtl> page = assetUsedDtlService.findUsedCode(assetUsedDtl);
            assetUsedInfo1.setAssetUsedDtls(page);
            result.put("list",assetUsedInfo1);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }
}
