/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetdepre.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.common.utils.DateUtils;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.assetdepre.dao.AssetDepreDtlDao;
import cn.net.ecode.modules.ass.assetdepre.entity.AssetDepreDtl;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.assetdepre.entity.AssetDepre;
import cn.net.ecode.modules.ass.assetdepre.service.AssetDepreService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 计提折旧Controller
 *
 * @author zhaohongbin
 * @version 2018-11-07
 */
@Controller
@RequestMapping(value = "${adminPath}/assetdepre/assetDepre")
public class AssetDepreController extends BaseController {

    @Autowired
    private AssetDepreService assetDepreService;
    @Autowired
    private AssetInfoService assetInfoService;
    @Autowired
    private AssetDepreDtlDao assetDepreDtlDao;

    /**
     * 获取数据
     */
    @ModelAttribute
    public AssetDepre get(String sysId, boolean isNewRecord) {
        return assetDepreService.get(sysId, isNewRecord);
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("assetdepre:assetDepre:view")
    @RequestMapping(value = {"list", ""})
    public String list(AssetDepre assetDepre, Model model) {
        model.addAttribute("assetDepre", assetDepre);
        return "ecode/asset/base/assetdepre/assetDepreList";
    }

    /**
     * 查询列表
     */
    @RequiresPermissions("assetdepre:assetDepre:view")
    @RequestMapping(value = {"listDetail", ""})
    public String listDetail(AssetDepreDtl assetDepreDtl, Model model) {
        model.addAttribute("assetDepreDtl", assetDepreDtl);
        return "ecode/asset/base/assetdepre/assetDepreDetailList";
    }

    /**
     * 查询列表数据
     */
    @RequiresPermissions("assetdepre:assetDepre:view")
    @ResponseBody
    @RequestMapping(value = "listDataDetail")
    public Page<AssetDepreDtl> listDataDetail(AssetDepreDtl assetDepreDtl, HttpServletRequest request, HttpServletResponse response, Model model) {
        if (assetDepreDtl.getCurrYear() == null && assetDepreDtl.getCurrMonth() == null) {
            assetDepreDtl.setCurrYear(Long.parseLong(DateUtils.getYear()));
            assetDepreDtl.setCurrMonth(Long.parseLong(DateUtils.getMonth()));
        }
        Page<AssetDepreDtl> newPage = new Page<AssetDepreDtl>(request, response);
        newPage.setPageSize(50);
        Page<AssetDepreDtl> assetDepreDtlList = assetDepreService.findListDtlPage(newPage, assetDepreDtl);
        return assetDepreDtlList;
    }

    /**
     * 查询列表数据
     */
    @RequiresPermissions("assetdepre:assetDepre:view")
    @ResponseBody
    @RequestMapping(value = "listData")
    public List<AssetDepre> listData(AssetDepre assetDepre, HttpServletRequest request, HttpServletResponse response, Model model) {
        if (assetDepre.getCurrYear() == null && assetDepre.getCurrMonth() == null) {
            assetDepre.setCurrYear(Long.parseLong(DateUtils.getYear()));
            assetDepre.setCurrMonth(Long.parseLong(DateUtils.getMonth()));
        }
        //加载页面时没有新增/  有的话查询
        List<AssetDepre> list = new ArrayList<>();
        List<AssetDepre> listAssetDepre = assetDepreService.findList(assetDepre);
        if (listAssetDepre.size() == 0) {
            list = assetDepreService.findListDepre(assetDepre);
            if (list.size() > 0 && list != null) {
                for (AssetDepre asset : list) {
                    asset.setCurrYear(assetDepre.getCurrYear());
                    asset.setCurrMonth(assetDepre.getCurrMonth());
                    asset.setMdepreValue(0.0);
                    asset.setSysId(IdGen.nextId());
                    asset.setIsNewRecord(true);
                    asset.setAssetType("0");
                    assetDepreService.save(asset);
                    List<AssetDepreDtl> assetDepreDtlList = assetInfoService.findListDepre(asset);
                    if (assetDepreDtlList.size() != 0) {
                        for (AssetDepreDtl assetDepreDtl : assetDepreDtlList) {
                            assetDepreDtl.setId(IdGen.nextId());
                            assetDepreDtl.setAccountThisMonth(0.0);
                            assetDepreDtl.setCurrYear(asset.getCurrYear());
                            assetDepreDtl.setCurrMonth(asset.getCurrMonth());
                            assetDepreDtl.setNetSalvage(assetDepreDtl.getUnitPrice() * assetDepreDtl.getResidualValue() / 100);
                            assetDepreDtl.setAddAccount(assetDepreDtl.getUnitPrice() - assetDepreDtl.getNetPrice());
                            assetDepreDtl.setDepreCode(asset.getSysId());
                            assetDepreDtl.setSubmitStatus("0");
                            assetDepreService.saveDtl(assetDepreDtl);
                        }
                    }

                }
            }
        } else {
            list = listAssetDepre;
        }
        return list;
    }

    /**
     * 查看编辑表单
     */
    @RequiresPermissions("assetdepre:assetDepre:view")
    @RequestMapping(value = "form")
    public String form(AssetDepre assetDepre, Model model) {
        AssetDepreDtl assetDepreDtl = new AssetDepreDtl();
        assetDepreDtl.setDepreCode(assetDepre.getSysId());
        List<AssetDepreDtl> assetDepreDtlList = assetDepreService.findListDtl(assetDepreDtl);
        model.addAttribute("assetDepre", assetDepre);
        model.addAttribute("assetDepreDtlList", assetDepreDtlList);
        return "ecode/asset/base/assetdepre/assetDepreForm";
    }

    /**
     * 计提时改变
     */
    @RequiresPermissions("assetdepre:assetDepre:view")
    @RequestMapping(value = "mentionSubmit")
    public Map<String, Object> mentionSubmit(AssetDepre assetDepre, Model model) {
        Map<String, Object> result = new HashMap<>();
        //提交时改变
        try {
            Double thisDepre = 0.0;//本月折旧
            Double addDepre = 0.0;//累计折旧
            AssetDepre assetDepre1 = assetDepreService.get(assetDepre);
            AssetDepreDtl assetDepreDtl = new AssetDepreDtl();
            assetDepreDtl.setDepreCode(assetDepre1.getSysId());
            List<AssetDepreDtl> assetDepreDtlList = assetDepreService.findListDtl(assetDepreDtl);
            if (assetDepreDtlList.size() != 0) {
                for (AssetDepreDtl assetDepreDtl1 : assetDepreDtlList) {
                    if (assetDepreDtl1.getAccountComStatus().equals("0")) {
                        Double thisAssDepre = (assetDepreDtl1.getUnitPrice() - assetDepreDtl1.getNetSalvage()) / assetDepreDtl1.getAgeLimit();
                        thisDepre = thisDepre + thisAssDepre;
                        assetDepreDtl1.setAccountQuantity(assetDepreDtl1.getAccountQuantity() + 1);
                        assetDepreDtl1.setAccountThisMonth(thisAssDepre);
                        assetDepreDtl1.setAddAccount(assetDepreDtl1.getAddAccount() + thisAssDepre);
                        addDepre = addDepre + assetDepreDtl1.getAddAccount();
                        assetDepreDtl1.preUpdate();
                        assetDepreDtl1.setNetPrice(assetDepreDtl1.getUnitPrice() - assetDepreDtl1.getAddAccount());
                        //改变资产表价格 是否折旧完成
                        AssetInfo assetInfo = new AssetInfo();
                        assetInfo.setAssetCode(assetDepreDtl1.getAssetCode());
                        assetInfo = assetInfoService.getAssetCodesql(assetInfo);
                        assetInfo.setNetPrice(assetDepreDtl1.getUnitPrice() - assetDepreDtl1.getAddAccount());
                        assetInfo.setAccountQuantity(assetInfo.getAccountQuantity() + 1);
                        assetDepreDtl1.setSubmitStatus("1");
                        if (assetInfo.getAccountQuantity().equals(assetInfo.getAgeLimit())) {
                            assetInfo.setAccountComStatus("1");
                            assetDepreDtl1.setAccountComStatus("1");
                        }
                        assetDepreDtlDao.update(assetDepreDtl1);
                        assetInfoService.update(assetInfo);
                    }
                }
                assetDepre1.setAssetType("1");
                assetDepre1.setMdepreValue(thisDepre);
                assetDepre1.setDepreTotal(addDepre);
                assetDepre1.setNetsalvageValue(assetDepre1.getOriginalValue() - addDepre);
                assetDepreService.save(assetDepre1);
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
     * 查一查上个月
     */
    @ResponseBody
    @RequestMapping(value = "isJudge")
    public Map<String, Object> isJudge(AssetDepre assetDepre, Model model) {
        Map<String, Object> result = new HashMap<>();
        //提交时改变
        try {
            if (assetDepre.getCurrMonth().equals(Long.valueOf(1))) {
                assetDepre.setCurrMonth((long) 12);
                assetDepre.setCurrYear(assetDepre.getCurrYear() - 1);
            } else {
                assetDepre.setCurrMonth(assetDepre.getCurrMonth() - 1);
            }
            assetDepre.setAssetType("1");
            List<AssetDepre> listAssetDepre = assetDepreService.findList(assetDepre);
            if (listAssetDepre.size() != 0) {
                result.put("message", "success");
            } else {
                result.put("message", "null");
            }
            result.put("code", "200");
        } catch (Exception e) {
            result.put("code", "201");
            result.put("message", "fail");
        }
        return result;
    }

    /**
     * 计提时改变
     */
    @ResponseBody
    @RequestMapping(value = "btnJTAll")
    public Map<String, Object> btnJTAll(AssetDepre assetDepre, Model model) {
        Map<String, Object> result = new HashMap<>();
        //提交时改变
        try {
            Double thisDepre = 0.0;//本月折旧
            Double addDepre = 0.0;//累计折旧
            List<AssetDepre> assetDepres = assetDepreService.findList(assetDepre);
            for (AssetDepre assetDepre1 : assetDepres) {
                if (assetDepre1.getAssetType().equals("0")) {
                    AssetDepreDtl assetDepreDtl = new AssetDepreDtl();
                    assetDepreDtl.setDepreCode(assetDepre1.getSysId());
                    List<AssetDepreDtl> assetDepreDtlList = assetDepreService.findListDtl(assetDepreDtl);
                    if (assetDepreDtlList.size() != 0) {
                        for (AssetDepreDtl assetDepreDtl1 : assetDepreDtlList) {
                            if (assetDepreDtl1.getAccountComStatus().equals("0")) {
                                Double thisAssDepre = (assetDepreDtl1.getUnitPrice() - assetDepreDtl1.getNetSalvage()) / assetDepreDtl1.getAgeLimit();
                                thisDepre = thisDepre + thisAssDepre;
                                assetDepreDtl1.setAccountQuantity(assetDepreDtl1.getAccountQuantity() + 1);
                                assetDepreDtl1.setAccountThisMonth(thisAssDepre);
                                assetDepreDtl1.setAddAccount(assetDepreDtl1.getAddAccount() + thisAssDepre);
                                addDepre = addDepre + assetDepreDtl1.getAddAccount();
                                assetDepreDtl1.preUpdate();
                                assetDepreDtl1.setNetPrice(assetDepreDtl1.getUnitPrice() - assetDepreDtl1.getAddAccount());
                                //改变资产表价格 是否折旧完成
                                AssetInfo assetInfo = new AssetInfo();
                                assetInfo.setAssetCode(assetDepreDtl1.getAssetCode());
                                assetInfo = assetInfoService.getAssetCodesql(assetInfo);
                                assetInfo.setNetPrice(assetDepreDtl1.getUnitPrice() - assetDepreDtl1.getAddAccount());
                                assetInfo.setAccountQuantity(assetInfo.getAccountQuantity() + 1);
                                assetDepreDtl1.setSubmitStatus("1");
                                if (assetInfo.getAccountQuantity().equals(assetInfo.getAgeLimit())) {
                                    assetInfo.setAccountComStatus("1");
                                    assetDepreDtl1.setAccountComStatus("1");
                                }
                                assetDepreDtlDao.update(assetDepreDtl1);
                                assetInfoService.update(assetInfo);
                            }
                        }
                        assetDepre1.setAssetType("1");
                        assetDepre1.setMdepreValue(thisDepre);
                        assetDepre1.setDepreTotal(addDepre);
                        assetDepre1.setNetsalvageValue(assetDepre1.getOriginalValue() - addDepre);
                        assetDepreService.save(assetDepre1);
                    } else {
                        assetDepre1.setAssetType("1");
                        assetDepreService.save(assetDepre1);
                    }
                }

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
     * 保存数据
     */
    @RequiresPermissions("assetdepre:assetDepre:edit")
    @ResponseBody
    @RequestMapping(value = "save")
    public String save(AssetDepre assetDepre) {
        StringBuilder message = new StringBuilder();
        if (!beanValidator(message, assetDepre)) {
            return renderResult(Global.FALSE, message);
        }
        assetDepreService.save(assetDepre);
        return renderResult(Global.TRUE, "保存计提折旧成功！");
    }
//    Page<AssetInfo> newPage=new Page<AssetInfo>(request, response);
//        newPage.setPageSize(50);

    /**
     * 删除数据
     */
    @RequiresPermissions("assetdepre:assetDepre:edit")
    @ResponseBody
    @RequestMapping(value = "delete")
    public String delete(AssetDepre assetDepre) {
        assetDepreService.delete(assetDepre);
        return renderResult(Global.TRUE, "删除计提折旧成功！");
    }

}