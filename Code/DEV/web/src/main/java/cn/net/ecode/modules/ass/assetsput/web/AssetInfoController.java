/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsput.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.assetsclassify.service.AssetSortService;
import cn.net.ecode.modules.ass.assetsput.entity.*;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
import cn.net.ecode.modules.ass.common.utils.PrintTest;
import cn.net.ecode.modules.ass.common.utils.TwoDimensionCode;
import cn.net.ecode.modules.ass.supplier.entity.SupplierInfo;
import cn.net.ecode.modules.ass.supplier.service.SupplierInfoService;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.service.OfficeService;
import cn.net.ecode.modules.sys.utils.UserUtils;
import cn.net.ecode.modules.sys.web.UserController;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.utils.DateUtils;
import cn.net.ecode.common.utils.excel.ExcelExport;
import cn.net.ecode.common.utils.excel.ExcelImport;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.location.entity.AssLocation;
import cn.net.ecode.modules.ass.location.service.AssLocationService;

/**
 * 资产入库Controller
 *
 * @author zhaohongbin
 * @version 2018-09-11
 */
@Controller
@RequestMapping(value = "${adminPath}/ass/assetInfo")
public class AssetInfoController extends BaseController {
    @Autowired
    private OfficeService officeService;
    @Autowired
    private UserController userController;
    @Autowired
    private AssetInfoService assetInfoService;
    @Autowired
    private CodeRuleService codeRuleService;
    @Autowired
    private AssLocationService assLocationService;
    @Autowired
    private SupplierInfoService supplierInfoService;
    @Autowired
    private CommonService commonService;

    /**
     * 获取数据
     */
    @ModelAttribute
    public AssetInfo get(String id, boolean isNewRecord) {
        return assetInfoService.get(id, isNewRecord);
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("ass:assetInfo:view")
    @RequestMapping(value = {"list", ""})
    public String list(AssetInfo assetInfo, Model model) {
        AssLocation assLocation = new AssLocation();
        List<AssLocation> locations = assLocationService.findList(assLocation);
        model.addAttribute("locations", locations);
        model.addAttribute("assetInfo", assetInfo);
        SupplierInfo supplierInfo = new SupplierInfo();
        List<SupplierInfo> supplierInfos = supplierInfoService.findList(supplierInfo);
        model.addAttribute("supplierInfos", supplierInfos);
        return "ecode/asset/base/assetsput/assetInfoList";
    }
    /*   资产卡片*/

    @RequestMapping(value = "assetForm")
    public String assetForm(AssetInfo assetInfo, Model model) {
        return "ecode/asset/base/assetsput/assetForm";
    }

    /**
     * 对账列表
     */
    @RequiresPermissions("ass:assetInfo:view")
    @RequestMapping(value = {"sumlist", ""})
    public String sumlist(AssetSum assetSum, Model model) {
        model.addAttribute("assetSum", assetSum);
        return "ecode/asset/base/assetsput/assetSummaryList";
    }

    /**
     * 查询列表数据
     */
    @RequiresPermissions("ass:assetInfo:view")
    @ResponseBody
    @RequestMapping(value = "listData")
    public Page<AssetInfo> listData(AssetInfo assetInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<AssetInfo> page = assetInfoService.findPage(new Page<AssetInfo>(request, response), assetInfo);
        return page;
    }

    /**
     * 变更列表数据
     */
    @RequiresPermissions("ass:assetInfo:view")
    @ResponseBody
    @RequestMapping(value = "listDataChange")
    public Page<AssetInfo> listDataChange(AssetInfo assetInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        assetInfo.setAssetStatuss(new String[]{"0", "1", "3"});
        Page<AssetInfo> page = assetInfoService.findPage(new Page<AssetInfo>(request, response), assetInfo);
        return page;
    }

    /**
     * 调拨列表数据
     */
    @RequiresPermissions("ass:assetInfo:view")
    @ResponseBody
    @RequestMapping(value = "listDataAllot")
    public Page<AssetInfo> listDataAllot(AssetInfo assetInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        if (UserUtils.getUser().getRoleCodes().equals("100")) {
            assetInfo.setOffice(new Office());
        }
        assetInfo.setAssetStatuss(new String[]{"0", "1"});
        Page<AssetInfo> page = assetInfoService.findPage(new Page<AssetInfo>(request, response), assetInfo);
        return page;
    }

    /**
     * 资产清单
     */
    @RequiresPermissions("ass:assetInfo:view")
    @RequestMapping(value = {"assetListing", ""})
    public String assetListing(AssetListing assetListing, Model model) {
        if (UserUtils.getUser().getRoleCodes().equals("100")) {
            model.addAttribute("statusOffice", "0");
        }else{
            model.addAttribute("statusOffice", "1");
        }
        model.addAttribute("assetListing", assetListing);
        return "ecode/asset/base/assetsput/assetListing";
    }

    /**
     * 过期资产
     */
    @RequiresPermissions("ass:assetInfo:view")
    @RequestMapping(value = {"assetOverTime", ""})
    public String assetOverTime(AssetListing assetListing, Model model) {
        assetListing.setCleanerName(UserUtils.getUser().getUserName());
        assetListing.setCleanerCode(UserUtils.getUser().getUserCode());
        assetListing.setCleanDate(new Date());
        model.addAttribute("assetListing", assetListing);
        return "ecode/asset/base/assetsput/assetOverTime";
    }

    /**
     * 管理员查询
     */
    @RequiresPermissions("ass:assetInfo:view")
    @RequestMapping(value = {"assetQuery", ""})
    public String assetQuery(AssetListing assetListing, Model model) {
        model.addAttribute("assetListing", assetListing);
        return "ecode/asset/base/assetsput/assetQuery";
    }

    /**
     * 个人查询
     */
    @RequiresPermissions("ass:assetInfo:view")
    @RequestMapping(value = {"assetQueryPersonal", ""})
    public String assetQueryPersonal(AssetListing assetListing,Model model) {
        assetListing.setUser(UserUtils.getUser());
        assetListing.setUserName(UserUtils.getUser().getUserName());
        model.addAttribute("assetListing", assetListing);
        AssLocation assLocation = new AssLocation();
        List<AssLocation> locations = assLocationService.findList(assLocation);
        model.addAttribute("locations", locations);
        return "ecode/asset/base/assetsput/assetQueryPersonal";
    }

    /**
     * 批量打印方法
     *
     * @param assetInfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "assetPrint")
    public Map<String, Object> assetPrint(AssetInfo assetInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            List<AssetInfo> assetInfos = assetInfoService.findListPrintlist(assetInfo);
            for (AssetInfo assetInfo1 : assetInfos) {
                assetInfo1.setQrCode("http://www.botemc.com/edp/assetInfoQrcode?assetCode=" + assetInfo1.getAssetCode());
                PrintTest.getAssetPrint(assetInfo1);
            }
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
     * 得到所有数据
     *
     * @param assetListing
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getAllData1")
    public List<AssetListing> getAllData1(AssetListing assetListing) {
        if (assetListing.getAaa().equals("1")) {
            List<AssetListing> assetListings = assetInfoService.findAllData1(assetListing);
            return assetListings;
        } else if (assetListing.getAaa().equals("2")) {
            List<AssetListing> assetListings = assetInfoService.findAllData2(assetListing);
            return assetListings;

        } else if (assetListing.getAaa().equals("3")) {
            List<AssetListing> assetListings = assetInfoService.findAllData3(assetListing);
            return assetListings;

        } else if (assetListing.getAaa().equals("4")) {
            List<AssetListing> assetListings = assetInfoService.findAllData4(assetListing);
            return assetListings;
        } else {
            return null;
        }
    }

    /**
     * 资产折旧
     */
    @ResponseBody
    @RequestMapping(value = "zheJiuData")
    public List<AssetZheJiu> zheJiuData(AssetZheJiu assetZheJiu) {
        List<AssetZheJiu> assetZheJius = assetInfoService.findZheJiuData(assetZheJiu);
        return assetZheJius;
    }

    @RequiresPermissions("ass:assetInfo:view")
    @RequestMapping(value = "assetZheJiu")
    public String assetZheJiu(AssetZheJiu assetZheJiu, Model model) {
        AssLocation assLocation = new AssLocation();
        assetZheJiu = assetInfoService.findZheJiuSumData(assetZheJiu);
        List<AssLocation> locations = assLocationService.findList(assLocation);
        model.addAttribute("locations", locations);
        model.addAttribute("assetZheJiu", assetZheJiu);
        return "ecode/asset/base/assetsput/assetZheJiu";
    }

    /**
     * 部门汇总查询列表
     */
    @RequiresPermissions("ass:assetInfo:view")
    @RequestMapping(value = {"officeSum", ""})
    public String officeSum(AssetOffice assetOffice, Model model) {
        if (UserUtils.getUser().getRoleCodes().equals("100")) {
            model.addAttribute("statusOffice", "0");
        }else{
            model.addAttribute("statusOffice", "1");
        }
        model.addAttribute("assetOffice", assetOffice);
        return "ecode/asset/base/assetsput/assetOfficeSum";
    }

    /**
     * 部门汇总查询
     */
    @ResponseBody
    @RequestMapping(value = "getOfficeData")
    public List<AssetOffice> getDtlData(AssetOffice assetOffice) {
        if (!UserUtils.getUser().getRoleCodes().equals("100")) {
            Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
            assetOffice.setOfficeCode(common.getOfficeCode());
            assetOffice.setOfficeName(common.getOfficeName());
        }
        List<AssetOffice> assetOfficeSum = assetInfoService.findOffice(assetOffice);
        return assetOfficeSum;
    }

    /**
     * 查看编辑表单
     */
    @RequiresPermissions("ass:assetInfo:view")
    @RequestMapping(value = "form")
    public String form(AssetInfo assetInfo, Model model) {
        SupplierInfo supplierInfo = new SupplierInfo();
        List<SupplierInfo> supplierInfos = supplierInfoService.findList(supplierInfo);
        AssLocation assLocation = new AssLocation();
        if (assetInfo.getIsNewRecord()) {
            assetInfo.setBuyDate(new Date());
        }
        List<AssLocation> locations = assLocationService.findList(assLocation);
        model.addAttribute("supplierInfos", supplierInfos);
        model.addAttribute("locations", locations);
        model.addAttribute("assetInfo", assetInfo);
        return "ecode/asset/base/assetsput/assetInfoForm";
    }

    /**
     * 查看处理记录
     */
    @RequiresPermissions("ass:assetInfo:view")
    @RequestMapping(value = "Listingcar")
    public String Listingcar(AssetInfo assetInfo, Model model) {
        AssLocation assLocation = new AssLocation();
        assetInfo = assetInfoService.getAssetCodesql(assetInfo);
        List<AssLocation> locations = assLocationService.findList(assLocation);
        model.addAttribute("locations", locations);
        model.addAttribute("assetInfo", assetInfo);
        return "ecode/asset/base/assetsput/assetListingFormCar";
    }

    /**
     * 查看处理记录
     */
    @RequiresPermissions("ass:assetInfo:view")
    @RequestMapping(value = "Listing")
    public String Listing(AssetInfo assetInfo, Model model) {
        AssLocation assLocation = new AssLocation();
        assetInfo = assetInfoService.getAssetCodesql(assetInfo);
        List<AssLocation> locations = assLocationService.findList(assLocation);
        model.addAttribute("locations", locations);
        model.addAttribute("assetInfo", assetInfo);
        return "ecode/asset/base/assetsput/assetListingForm";
    }

    /**
     * 保存数据
     */
    @RequiresPermissions("ass:assetInfo:edit")
    @ResponseBody
    @RequestMapping(value = "save")
    public String save(AssetInfo assetInfo, HttpServletRequest request) {
        StringBuilder message = new StringBuilder();
        if (!beanValidator(message, assetInfo)) {
            return renderResult(Global.FALSE, message);
        }
        Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
        int Quantity = assetInfo.getQuantity();
        try {
            for (int i = 0; i < Quantity; i++) {
                assetInfo.setIsNewRecord(true);
                assetInfo.setAssetCode(codeRuleService.createCode("ZCRK", assetInfo.getSortCode(), common.getOfficeCode(), common.getCompanyCode()));
                assetInfo.setAssetStatus("0");
                assetInfo.setQrCode(printContract(assetInfo, request));
                assetInfo.setQuantity(1);
                assetInfo.setId(IdGen.nextId());
                assetInfo.preInsert();
                assetInfoService.save(assetInfo);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return renderResult(Global.TRUE, "保存资产入库成功！");
    }

    /**
     * 删除数据
     */
    @RequiresPermissions("ass:assetInfo:edit")
    @ResponseBody
    @RequestMapping(value = "delete")
    public String delete(AssetInfo assetInfo) {
        assetInfoService.delete(assetInfo);
        return renderResult(Global.TRUE, "删除资产入库成功！");
    }

    /**
     * 资产折旧
     */
    @RequiresPermissions("ass:assetInfo:edit")
    @RequestMapping(value = "exportZhejiu")
    public String pwdAuditExport(AssetZheJiu assetZheJiu, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "资产折旧" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<AssetZheJiu> list = assetInfoService.findZheJiuData(assetZheJiu);
            for (int i = 0; i < list.size(); i++) {
                AssetZheJiu assetZheJiu1 = list.get(i);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            }
            (new ExcelExport("资产折旧", AssetZheJiu.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/ass/assetInfo/list";
        }
    }

    /**
     * 月增加对账查询
     */
    @ResponseBody
    @RequestMapping(value = "sumlistData")
    public List<AssetSum> getDtlData(AssetSum assetSum) {
        List<AssetSum> assetSums = assetInfoService.findSumList(assetSum);
        return assetSums;
    }

    /**
     * 资产清单
     */
    @ResponseBody
    @RequestMapping(value = "assetListingData")
    public List<AssetListing> getDtlData(AssetListing assetListing) {
        if (!UserUtils.getUser().getRoleCodes().equals("100")) {
            Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
            Office office=new Office();
            office.setOfficeCode(common.getOfficeCode());
            assetListing.setOffice(office);
            assetListing.setOfficeName(common.getOfficeName());
        }
        List<AssetListing> assetListing1 = assetInfoService.findAssetListing(assetListing);
        return assetListing1;
    }

    /**
     * 过期资产查询
     */
    @ResponseBody
    @RequestMapping(value = "assetOverData")
    public List<AssetOverTime> getOverData(AssetOverTime assetOverTime) {
        List<AssetOverTime> assetOverTimes = assetInfoService.findOverData(assetOverTime);
        return assetOverTimes;
    }

    /**
     * 个人资产清单
     */
    @ResponseBody
    @RequestMapping(value = "assetPersonalData")
    public List<AssetPersonal> assetPersonalData(AssetPersonal assetPersonal) {
        List<AssetPersonal> assetPersonals = assetInfoService.findPersonalData(assetPersonal);
        return assetPersonals;
    }

    /**
     * 导出
     *
     * @param assetPersonal
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     */

    @RequestMapping(value = "exportAssetPersonal")
    public String pwdAuditExport(AssetPersonal assetPersonal, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "资产清单" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<AssetPersonal> list = this.assetInfoService.findPersonalData(assetPersonal);
            String[] strings = {"闲置", "领用", "借用", "维修", "报废", "调拨中", "已捐献", "到新单位"};
            for (int i = 0; i < list.size(); i++) {
                AssetPersonal assetPersonal1 = list.get(i);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String date = formatter.format(assetPersonal1.getBuyDate());//格式化数据
                assetPersonal1.setBuyDateString(date);
                assetPersonal1.setAssetStatus(strings[Integer.parseInt(assetPersonal1.getAssetStatus())]);
            }
            (new ExcelExport("资产清单", AssetPersonal.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/ass/assetInfo/assetListing";
        }
    }

    @RequiresPermissions("ass:assetInfo:edit")
    @RequestMapping(value = "exportSum")
    public String pwdAuditExport(AssetSum assetSum, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "月增加对账表" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<AssetSum> list = assetInfoService.findSumList(assetSum);
            for (int i = 0; i < list.size(); i++) {
                AssetSum assetSum1 = list.get(i);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            }
            (new ExcelExport("月增加对账表", AssetSum.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/ass/assetInfo/assetSummaryList";
        }
    }

    /**
     * 部门汇总导出
     */
    @RequiresPermissions("ass:assetInfo:edit")
    @RequestMapping(value = "exportoffice")
    public String pwdAuditExport(AssetOffice assetOffice, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "部门汇总表" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            try {
                assetOffice.setOfficeName(java.net.URLDecoder.decode(assetOffice.getOfficeName(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            List<AssetOffice> list = this.assetInfoService.findOffice(assetOffice);
            for (int i = 0; i < list.size(); i++) {
                AssetOffice assetOffice1 = list.get(i);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            }
            (new ExcelExport("部门汇总表", AssetOffice.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/ass/assetInfo/list";
        }
    }

    /**
     * 资产清单导出
     */
    @RequiresPermissions("ass:assetInfo:edit")
    @RequestMapping(value = "exportAssetListing")
    public String pwdAuditExport(AssetListing assetListing, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "资产清单" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<AssetListing> list = this.assetInfoService.findAssetListing(assetListing);
            String[] strings = {"闲置", "领用", "借用", "维修", "报废", "调拨中", "已捐献", "到新单位"};
            for (int i = 0; i < list.size(); i++) {
                AssetListing assetListing1 = list.get(i);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String date = formatter.format(assetListing1.getBuyDate());//格式化数据
                assetListing1.setBuyDateString(date);
                assetListing1.setAssetStatus(strings[Integer.parseInt(assetListing1.getAssetStatus())]);
            }
            (new ExcelExport("资产清单", AssetListing.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/ass/assetInfo/assetListing";
        }
    }

    /**
     * 过期资产导出
     */
    @RequiresPermissions("ass:assetInfo:edit")
    @RequestMapping(value = "exportOver")
    public String pwdAuditExport(AssetOverTime assetOverTime, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "过期资产清单" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<AssetOverTime> list = this.assetInfoService.findOverData(assetOverTime);
            for (int i = 0; i < list.size(); i++) {
                AssetOverTime assetOverTime1 = list.get(i);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            }
            (new ExcelExport("过期资产清单", AssetOverTime.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/ass/assetInfo/assetOverTime";
        }
    }

    //导出资产入库列表
    @RequiresPermissions("ass:assetInfo:edit")
    @RequestMapping(value = "export")
    public String pwdAuditExport(AssetInfo assetInfo, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "资产信息表" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<AssetInfo> list = this.assetInfoService.findList(assetInfo);
            String[] strings = {"闲置", "领用", "借用", "维修", "报废", "调拨中", "已捐献", "到新单位"};
            for (int i = 0; i < list.size(); i++) {
                AssetInfo assetInfo1 = list.get(i);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String date = formatter.format(assetInfo1.getBuyDate());//格式化数据
                assetInfo1.setBuyDateString(date);
                assetInfo1.setAssetStatus(strings[Integer.parseInt(assetInfo1.getAssetStatus())]);
            }

            (new ExcelExport("资产信息表", AssetInfo.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/ass/assetInfo/list";
        }
    }
    //导出资产入库列表
    @RequiresPermissions("ass:assetInfo:edit")
    @RequestMapping(value = "exportGou")
    public String exportGou(AssetInfo assetInfo, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "资产信息表" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
            List<AssetInfo> list = this.assetInfoService.findListPrint(assetInfo);
            String[] strings = {"闲置", "领用", "借用", "维修", "报废", "调拨中", "已捐献", "到新单位"};
            for (int i = 0; i < list.size(); i++) {
                AssetInfo assetInfo1 = list.get(i);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String date = formatter.format(assetInfo1.getBuyDate());//格式化数据
                assetInfo1.setBuyDateString(date);
                assetInfo1.setAssetStatus(strings[Integer.parseInt(assetInfo1.getAssetStatus())]);
            }
            (new ExcelExport("资产信息表", AssetInfo.class, 1)).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception var7) {
            var7.printStackTrace();
            this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
            System.out.println(var7.getMessage());
            return "redirect:" + this.adminPath + "/ass/assetInfo/list";
        }
    }
    /**
     * 导入资产表数据
     *
     * @param file
     * @param redirectAttributes
     * @return
     * @author lidefang
     * @date 2016-5-10
     */

    @RequestMapping(value = "importFile", method = RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
        Map<String, String> data = null;
        int successNum = 0;
        int failureNum = 0;//必填项为空
        int CodeNum = 0;//系统中未发现该资产类别
        int Codeint = 0;//系统中数据格式不对
        try {
            // 验证是否是演示模板
            if (Global.isDemoMode()) {
                System.out.println("演示模式");
                return "redirect:" + adminPath + "/ass/assetInfo/list/?repage";
            }
            StringBuilder failureMsg = new StringBuilder();
            ExcelImport importer = new ExcelImport(file, 1, 0, true);
            List<AssetInfo> list = importer.getDataList(AssetInfo.class);
            Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
            for (AssetInfo assetInfo : list) {
                if (assetInfo.getAssetName() == "" || assetInfo.getTopSortName() == "" || assetInfo.getSortName() == "" ||
                        assetInfo.getBuyDateString() == "" || assetInfo.getStoragePlace() == "" || assetInfo.getRegionName() == "" ||
                        assetInfo.getSupplier() == "" || assetInfo.getAgeLimit() == null || assetInfo.getUnitPrice() == null ||
                        assetInfo.getResidualValue() == "" || assetInfo.getUnit() == "") {
                    failureNum++;
                } else {
                    try {
                        int ee = Integer.parseInt(assetInfo.getResidualValue());
                        for (int i = 0; i < assetInfo.getQuantity(); i++) {
                            try {
//                        //生成分类大类编码
//                        AssetSort assetSort = new AssetSort();
//                        assetSort.setSortName(assetInfo.getTopSortName());
//                        assetInfo.setTopSortCode(assetSortService.getIdSql(assetSort).getId());
//                        //生成分类小类编码
//                        assetSort = new AssetSort();
//                        assetSort.setSortName(assetInfo.getSortName());
//                        assetInfo.setSortCode(assetSortService.getIdSql(assetSort).getId());
//                        //生成存放地址编码
//                        AssLocation assLocation = new AssLocation();
//                        assLocation.setLocaleName(assetInfo.getStoragePlace());
//                        assLocation = assLocationService.getLocalCodeSql(assLocation);
//                        assetInfo.setStoragePlaceCode(assLocation.getLocaleCode());
                                //生成资产编码
                                assetInfo.setAssetCode(codeRuleService.createCode("ZCRK", "", common.getOfficeCode(), common.getCompanyCode()));
                                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                Date date = formatter.parse(assetInfo.getBuyDateString());
                                assetInfo.setUserName("");
                                assetInfo.setOfficeName("");
                                assetInfo.setBuyDate(date);
                                assetInfo.setAssetStatus("0");
                                assetInfo.setId(IdGen.nextId());
                                assetInfo.preInsert();
                                assetInfoService.insert(assetInfo);
                                successNum++;
                            } catch (Exception e) {
                                CodeNum++;
                            }
                        }
                    } catch (Exception e) {
                        Codeint++;
                    }

                }
            }
            if (CodeNum > 0) {
                failureMsg.insert(0, "，失败 " + CodeNum + " 条机构，导入信息如下：系统中未发现该资产类别");
            }
            if (failureNum > 0) {
                failureMsg.insert(0, "，失败 " + failureNum + " 条机构，导入信息如下：必填项不能为空");
            }
            if (Codeint > 0) {
                failureMsg.insert(0, "，失败 " + Codeint + " 条机构，导入信息如下：数据类型不符合");
            }
            this.addMessage(redirectAttributes, new String[]{"已成功导入 " + successNum + " 条资产" + failureMsg});
        } catch (Exception var18) {
            this.addMessage(redirectAttributes, new String[]{"导入机构失败！失败信息：" + var18.getMessage()});
        }
        return "redirect:" + this.adminPath + "/ass/assetInfo/list/?repage";
    }

    /**
     * APP端新增资产
     *
     * @param assetInfo
     * @param request
     * @throws Exception
     * @author xulan
     * @date 2018年10月10日17:07:42
     */
    @ResponseBody
    @RequestMapping(value = "saveAPP")
    public Map<String, Object> saveAPP(AssetInfo assetInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            Common common = commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
            int Quantity = assetInfo.getQuantity();
            for (int i = 0; i < Quantity; i++) {
                assetInfo.setIsNewRecord(true);
                assetInfo.setAssetCode(codeRuleService.createCode("ZCRK", assetInfo.getSortCode(), common.getOfficeCode(), common.getCompanyCode()));
                assetInfo.setAssetStatus("0");
                assetInfo.setQrCode(printContract(assetInfo, request));
                assetInfo.setQuantity(1);
                assetInfo.setId(IdGen.nextId());
                assetInfo.preInsert();
                assetInfo.setBuyDate(new Date());
                assetInfoService.save(assetInfo);
            }
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * APP端获取资产列表
     *
     * @param assetInfo
     * @param request
     * @throws Exception
     * @author xulan
     * @date 2018年10月11日13:42:49
     */
    @ResponseBody
    @RequestMapping(value = "getAssetList")
    public Page<AssetInfo> getAssetList(AssetInfo assetInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        if(assetInfo.getAssetStatuss()!=null){
        }else{
            assetInfo.setAssetStatuss(new String[]{"0", "1","5"});
        }
        Page<AssetInfo> page = assetInfoService.findPage(new Page<AssetInfo>(request, response), assetInfo);
        return page;
    }

    /**
     * APP端查看得到一条
     *
     * @param assetInfo
     * @param request
     * @throws Exception
     * @author xulan
     * @date 2018年10月11日13:42:49
     */
    @ResponseBody
    @RequestMapping(value = "getAssetinfo")
    public Map<String, Object> getAssetinfo(AssetInfo assetInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            result.put("page", assetInfoService.get(assetInfo));
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
     * 单个打印预览
     * @param assetInfo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "assetLable")
    public String assetLable(AssetInfo assetInfo, Model model, HttpServletRequest request) {
        model.addAttribute("assetCode", assetInfo.getAssetCode());
        return "ecode/asset/base/assetsput/assetLable";
    }

    /**
     * 多个打印预览
     * @param assetInfo
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "assetLablelist")
    public String assetLablelist(AssetInfo assetInfo, Model model, HttpServletRequest request) {
        String ids=StringUtils.join(assetInfo.getIds(), ",");
        model.addAttribute("assetCode",ids);
        return "ecode/asset/base/assetsput/assetLablelist";
    }
    /**
     * 生成二维码
     *
     * @param request
     * @param request
     * @return
     * @throws IOException
     */
    public String printContract(AssetInfo assetInfo, HttpServletRequest request) throws IOException {
        // 1、获取保存二维码的路径
        String filePath = "/userfiles/code";
        String filename = assetInfo.getAssetCode() + ".jpg";
        if (!filePath.endsWith("/")) {
            filePath = filePath + "/";
        }
        try {
            TwoDimensionCode.output(filePath, filename, "http://www.botemc.com/edp/assetInfoQrcode?assetCode=" + assetInfo.getAssetCode());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return filePath + filename;
    }

    @ResponseBody
    @RequestMapping({"treeData"})
    public List<Map<String, Object>> treeData(String extCode, String parentCode, Boolean isAll, String type, String types, String companyCode, String isShowCode, String postCode, String roleCode, String isShowFullName) {
        List<Map<String, Object>> mapList = new ArrayList<>();
        List list = officeService.findList(false);
        for (int i = 0; i < list.size(); i++) {
            Office e = (Office) list.get(i);
            if (e.getOfficeCode().equals(extCode)) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", e.getOfficeCode());
                map.put("pId", e.getParentCode());
                map.put("pIds", e.getParentCodes());
                String name = e.getOfficeName();
                if ("true".equals(isShowFullName) || "1".equals(isShowFullName)) {
                    name = e.getFullName();
                }
                if (!"true".equals(isShowCode) && !"1".equals(isShowCode)) {
                    if ("2".equals(isShowCode)) {
                        map.put("name", name + "(" + e.getViewCode() + ")");
                    } else {
                        map.put("name", name);
                    }
                } else {
                    map.put("name", "(" + e.getViewCode() + ")" + name);
                }

                if (type != null && ("4".equals(type) || "3".equals(type))) {
                    map.put("isParent", true);
                    List<Map<String, Object>> userList = userController.treeData(companyCode, e.getOfficeCode(), postCode, roleCode, isAll, isShowCode);
                    mapList.addAll(userList);
                }
                mapList.add(map);
            }
        }

        return mapList;
    }

}