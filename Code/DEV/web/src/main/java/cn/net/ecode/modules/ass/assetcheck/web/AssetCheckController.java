/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetcheck.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.common.utils.DateUtils;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.common.utils.excel.ExcelExport;
import cn.net.ecode.common.utils.excel.ExcelImport;
import cn.net.ecode.modules.ass.ascheck.entity.AsCheckDtl;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheckDtl;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheckDtlSM;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.changeinfo.entity.AssetChangeInfo;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
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

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheck;
import cn.net.ecode.modules.ass.assetcheck.service.AssetCheckService;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 资产盘点Controller
 *
 * @author zhaohongbin
 * @version 2018-10-20
 */
@Controller
@RequestMapping(value = "${adminPath}/assetcheck/assetCheck")
public class AssetCheckController extends BaseController {

    @Autowired
    private AssetCheckService assetCheckService;
    @Autowired
    private CodeRuleService codeRuleService;
    @Autowired
    private CommonService commonService;

    /**
     * 获取数据
     */
    @ModelAttribute
    public AssetCheck get(String id, boolean isNewRecord) {
        return assetCheckService.get(id, isNewRecord);
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("assetcheck:assetCheck:view")
    @RequestMapping(value = {"list", ""})
    public String list(AssetCheck assetCheck, Model model) {
        model.addAttribute("assetCheck", assetCheck);
        return "ecode/asset/base/assetcheck/assetCheckList";
    }

    /**
     * 查询列表数据
     */
    @RequiresPermissions("assetcheck:assetCheck:view")
    @ResponseBody
    @RequestMapping(value = "listData")
    public Page<AssetCheck> listData(AssetCheck assetCheck, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<AssetCheck> page = assetCheckService.findPage(new Page<AssetCheck>(request, response), assetCheck);
        return page;
    }

    /**
     * 查看编辑表单
     */
    @RequiresPermissions("assetcheck:assetCheck:view")
    @RequestMapping(value = "form")
    public String form(AssetCheck assetCheck, Model model) {
        if (StringUtils.isNotBlank(assetCheck.getId())) {
            model.addAttribute("chackCode", assetCheck.getId());
        }
        if (assetCheck.getIsNewRecord()) {
            assetCheck.setHandleTime(new Date());
            assetCheck.setHandleCode(UserUtils.getUser().getUserCode());
            assetCheck.setHandleName(UserUtils.getUser().getUserName());
        } else {
            assetCheck.setHandleTime(assetCheck.getHandleTime());
            assetCheck.setHandleCode(assetCheck.getHandleCode());
            assetCheck.setHandleName(assetCheck.getHandleName());
        }

        model.addAttribute("assetCheck", assetCheck);
        return "ecode/asset/base/assetcheck/assetCheckForm";
    }

    /**
     * 查看编辑表单
     */
    @RequiresPermissions("assetcheck:assetCheck:view")
    @RequestMapping(value = "formSm")
    public String formSm(AssetCheck assetCheck, Model model) {
        if (StringUtils.isNotBlank(assetCheck.getId())) {
            model.addAttribute("chackCode", assetCheck.getId());
        }
        if (assetCheck.getIsNewRecord()) {
            assetCheck.setHandleTime(new Date());
            assetCheck.setHandleCode(UserUtils.getUser().getUserCode());
            assetCheck.setHandleName(UserUtils.getUser().getUserName());
        } else {
            assetCheck.setHandleTime(assetCheck.getHandleTime());
            assetCheck.setHandleCode(assetCheck.getHandleCode());
            assetCheck.setHandleName(assetCheck.getHandleName());
        }
        model.addAttribute("assetCheck", assetCheck);
        return "ecode/asset/base/assetcheck/assetCheckForm";
    }
    /**
     * 保存数据
     */
    @RequiresPermissions("assetcheck:assetCheck:edit")
    @ResponseBody
    @RequestMapping(value = "save")
    public Map<String, Object> save(AssetCheck assetCheck) {
        Map<String, Object> result = new HashMap<String, Object>();
        StringBuilder message = new StringBuilder();
        if (!beanValidator(message, assetCheck)) {
            result.put("code", "201");
            result.put("message", message);
            return result;
        }
        Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
        assetCheck.setChackCode(codeRuleService.createCode("ZCPD", "", common.getOfficeCode(), common.getCompanyCode()));
        assetCheckService.save(assetCheck);
        result.put("code", "200");
        result.put("id", assetCheck.getId());
        result.put("message", "创建盘点单成功");
        result.put("message1", "提交盘点结果成功");
        return result;
    }

    /**
     * 删除数据
     */
    @RequiresPermissions("assetcheck:assetCheck:edit")
    @ResponseBody
    @RequestMapping(value = "delete")
    public String delete(AssetCheck assetCheck) {
        assetCheckService.delete(assetCheck);
        return renderResult(Global.TRUE, "删除资产盘点成功！");
    }

    /**
     * 得到子表数据，
     */
    @ResponseBody
    @RequestMapping(value = "findCheckCode")
    public List<AssetCheckDtl> findCheckCode(AssetCheckDtl assetCheckDtl) {
        List<AssetCheckDtl> assetCheckDtls = assetCheckService.findCheckCode(assetCheckDtl);
        return assetCheckDtls;
    }

    /**
     * 扫码盘点
     */
    @ResponseBody
    @RequestMapping(value = "assetCheckStatus")
    public Map<String, Object> assetCheckStatus(AssetCheckDtl assetCheckDtl) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            assetCheckDtl.setAssetStatus("1");
            assetCheckService.updateCheckStatus(assetCheckDtl);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     *  * App提交资产盘亏
     */
    @RequestMapping(value = "updateAssetCheckDtlApp")
    public Map<String, Object> updateAssetCheckDtlApp(AssetCheckDtl assetCheckDtl) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            assetCheckService.updateAssetCheckDtLosses(assetCheckDtl);
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
     * App端查询自己的待盘资产
     */
    @ResponseBody
    @RequestMapping(value = "undeterminedAssetCheck")
    public Map<String, Object> undeterminedAssetCheck(String userCode) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            //判断子表有没有自己要盘点的资产
            List<AssetCheckDtl> assetCheckDtls = assetCheckService.undeterminedAssetCheck(userCode);
            if (assetCheckDtls.size() != 0) {
                List<AssetCheck> assetChecks = new ArrayList<>();
                //通过
                for (AssetCheckDtl assetCheckDtl : assetCheckDtls) {
                    AssetCheck assetCheck = assetCheckService.get(assetCheckDtl.getChackCode());
                    if (assetCheck.getSubmitStatus().equals("0")) {
                        assetChecks.add(assetCheck);
                    }
                }
                //过滤掉重复的主表
                for (int i = 0; i < assetChecks.size() - 1; i++) {
                    for (int j = assetChecks.size() - 1; j > i; j--) {
                        if (assetChecks.get(j).getId().equals(assetChecks.get(i).getId())) {
                            assetChecks.remove(j);
                        }
                    }
                }
                List<AssetCheck> assetChecksall = new ArrayList<>();
                for (AssetCheck assetCheck : assetChecks) {
                    AssetCheckDtl assetCheckDtl = new AssetCheckDtl();
                    assetCheckDtl.setChackCode(assetCheck.getId());
                    User user = new User();
                    user.setUserCode(userCode);
                    assetCheckDtl.setUser(user);
                    List<AssetCheckDtl> assetCheckDtlall = assetCheckService.undeterminedAssetCheckFen(assetCheckDtl);
                    assetCheck.setAssetCheckDtlList(assetCheckDtlall);
                    assetChecksall.add(assetCheck);
                }
                result.put("data", assetChecksall);
            } else {
                result.put("data", null);
            }
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    //导出资产盘点列表
    @RequestMapping(value = "export")
    public String pwdAuditExport(AssetCheckDtl assetCheckDtl, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "资产盘点" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<AssetCheckDtl> list = this.assetCheckService.findCheckCode(assetCheckDtl);
            String[] strings = {"未盘", "已盘", "盘亏"};
            for (int i = 0; i < list.size(); i++) {
                AssetCheckDtl assetCheckDtl1 = list.get(i);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String date = formatter.format(assetCheckDtl1.getBuyDate());//格式化数据
                assetCheckDtl1.setBuyDateString(date);
                assetCheckDtl1.setAssetStatus(strings[Integer.parseInt(assetCheckDtl1.getAssetStatus())]);
            }
            (new ExcelExport("资产盘点", AssetCheckDtl.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/assetcheck/assetCheck/list";
        }
    }

    //导出资产盘点列表
    @RequestMapping(value = "exportSM")
    public String exportSM(AssetCheckDtlSM assetCheckDtlSM, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {

            String fileName = "私密盘点记录.xlsx";
            List<AssetCheckDtlSM> list = this.assetCheckService.findCheckCodeSM(assetCheckDtlSM);
            String[] strings = {"未盘", "已盘", "盘亏"};
            for (int i = 0; i < list.size(); i++) {
                AssetCheckDtlSM assetCheckDtlSM1 = list.get(i);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String date = formatter.format(assetCheckDtlSM1.getBuyDate());//格式化数据
                assetCheckDtlSM1.setBuyDateString(date);
                assetCheckDtlSM1.setAssetStatus(strings[Integer.parseInt(assetCheckDtlSM1.getAssetStatus())]);
            }
            (new ExcelExport("资产盘点", AssetCheckDtlSM.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/assetcheck/assetCheck/list";
        }
    }

    @RequestMapping(value = "importFile", method = RequestMethod.POST)
    public String importFile(MultipartFile file,String chackCode, RedirectAttributes redirectAttributes) {
        Map<String, String> data = null;
        int successNum = 0;
        try {
            // 验证是否是演示模板
            if (Global.isDemoMode()) {
                System.out.println("演示模式");
                return "redirect:" + adminPath + "/assetcheck/assetCheck/formSm/?repage";
            }

            StringBuilder failureMsg = new StringBuilder();
            ExcelImport importer = new ExcelImport(file, 0, 0, true);
            List<AssetCheckDtlSM> list = importer.getDataList(AssetCheckDtlSM.class);
            String[] strings = {"未盘", "已盘", "盘亏"};
            for (int i = 0; i < list.size(); i++) {
                if (list.get(i).getAssetStatus().equals("未盘")) {
                    list.get(i).setAssetStatus("0");
                }else if (list.get(i).getAssetStatus().equals("已盘")) {
                    list.get(i).setAssetStatus("1");
                } else {
                    list.get(i).setAssetStatus("2");
                }
                //私密盘点改变状态
                assetCheckService.updateCheckCodeSM(list.get(i));
                successNum++;
            }
//            if (CodeNum > 0) {
//                failureMsg.insert(0, "，失败 " + CodeNum + " 条机构，导入信息如下：系统中未发现该资产类别");
//            }
//            if (failureNum > 0) {
//                failureMsg.insert(0, "，失败 " + failureNum + " 条机构，导入信息如下：必填项不能为空");
//            }
//            if (Codeint > 0) {
//                failureMsg.insert(0, "，失败 " + Codeint + " 条机构，导入信息如下：数据类型不符合");
//            }
            this.addMessage(redirectAttributes, new String[]{"已成功导入盘点 " + successNum + " 条资产"});
        } catch (Exception var18) {
            this.addMessage(redirectAttributes, new String[]{"导入机构失败！失败信息：" + var18.getMessage()});
        }
        return "redirect:" + this.adminPath + "/assetcheck/assetCheck/formSm?id="+chackCode;
    }
}