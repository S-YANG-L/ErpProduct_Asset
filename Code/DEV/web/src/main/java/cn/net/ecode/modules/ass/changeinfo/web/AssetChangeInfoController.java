/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.changeinfo.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import cn.net.ecode.modules.ass.cancelstocks.entity.AssetReturnDtl;
import cn.net.ecode.modules.ass.changeinfo.entity.AssetChangeDtl;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.ass.common.service.CommonService;
import cn.net.ecode.modules.ass.location.entity.AssLocation;
import cn.net.ecode.modules.ass.location.service.AssLocationService;
import cn.net.ecode.modules.ass.supplier.entity.SupplierInfo;
import cn.net.ecode.modules.ass.supplier.service.SupplierInfoService;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.utils.UserUtils;
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
import cn.net.ecode.modules.ass.changeinfo.entity.AssetChangeInfo;
import cn.net.ecode.modules.ass.changeinfo.service.AssetChangeInfoService;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

/**
 * 实物信息变更Controller
 * @author zhao
 * @version 2018-10-09
 */
@Controller
@RequestMapping(value = "${adminPath}/changeinfo/assetChangeInfo")
public class AssetChangeInfoController extends BaseController {

	@Autowired
	private AssetChangeInfoService assetChangeInfoService;
	@Autowired
	private AssLocationService assLocationService;
    @Autowired
    private CodeRuleService codeRuleService;
	@Autowired
	private SupplierInfoService supplierInfoService;
	@Autowired
	private AssetInfoService assetInfoService;
	@Autowired
	private CommonService commonService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public AssetChangeInfo get(String id, boolean isNewRecord) {
		return assetChangeInfoService.get(id, isNewRecord);
	}
	
	/**
	 * 查询列表
	 */
	@RequiresPermissions("changeinfo:assetChangeInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(AssetChangeInfo assetChangeInfo, Model model) {
		model.addAttribute("assetChangeInfo", assetChangeInfo);
		return "ecode/asset/base/changeinfo/assetChangeInfoList";
	}
	
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("changeinfo:assetChangeInfo:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<AssetChangeInfo> listData(AssetChangeInfo assetChangeInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AssetChangeInfo> page = assetChangeInfoService.findPage(new Page<AssetChangeInfo>(request, response), assetChangeInfo); 
		return page;
	}
	/**
	 * 查询列表数据
	 */
	@RequestMapping(value = "listDataBg")
	public String listDataBg(AssetInfo assetInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			if(assetInfo.getSortName()!=null){
				assetInfo.setSortName(java.net.URLDecoder.decode(assetInfo.getSortName(), "UTF-8"));
			}
			if(assetInfo.getAssetName()!=null){
				assetInfo.setAssetName(java.net.URLDecoder.decode(assetInfo.getAssetName(), "UTF-8"));
			}
			if(assetInfo.getBrand()!=null){
				assetInfo.setBrand(java.net.URLDecoder.decode(assetInfo.getBrand(), "UTF-8"));
			}
			if(assetInfo.getUnit()!=null){
				assetInfo.setUnit(java.net.URLDecoder.decode(assetInfo.getUnit(), "UTF-8"));
			}
			if(assetInfo.getVersion()!=null){
				assetInfo.setVersion(java.net.URLDecoder.decode(assetInfo.getVersion(), "UTF-8"));
			}
			if(assetInfo.getFinanceCode()!=null){
				assetInfo.setFinanceCode(java.net.URLDecoder.decode(assetInfo.getFinanceCode(), "UTF-8"));
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		assetInfo.setAssetStatuss(new String[]{"0", "1", "3"});
		List<AssetInfo> page = assetInfoService.findList(assetInfo);
		AssLocation assLocation=new AssLocation();
		List<AssLocation> locations=assLocationService.findList(assLocation);
		model.addAttribute("locations", locations);
	   AssetChangeInfo assetChangeInfo=	new AssetChangeInfo();
		if(!assetChangeInfo.getIsNewRecord()){
			model.addAttribute("changeCode", assetChangeInfo.getId());
		}
		if (assetChangeInfo.getIsNewRecord() == true) {
			assetChangeInfo.setOperatorCode(UserUtils.getUser().getUserCode());
			assetChangeInfo.setOperatorName(UserUtils.getUser().getUserName());
			assetChangeInfo.setChangeDate(new Date());
		}
		SupplierInfo supplierInfo = new SupplierInfo();
		List<SupplierInfo> supplierInfos = supplierInfoService.findList(supplierInfo);
		model.addAttribute("supplierInfos", supplierInfos);
		model.addAttribute("assetChangeInfo", assetChangeInfo);
		model.addAttribute("assetChangeDtlList", page);
		return "ecode/asset/base/changeinfo/assetChangeInfoFormBg";
	}
	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("changeinfo:assetChangeInfo:view")
	@RequestMapping(value = "form")
	public String form(AssetChangeInfo assetChangeInfo, Model model) {
		AssLocation assLocation=new AssLocation();
		List<AssLocation> locations=assLocationService.findList(assLocation);
		model.addAttribute("locations", locations);
		SupplierInfo supplierInfo = new SupplierInfo();
		List<SupplierInfo> supplierInfos = supplierInfoService.findList(supplierInfo);
		model.addAttribute("supplierInfos", supplierInfos);
		if(!assetChangeInfo.getIsNewRecord()){
            model.addAttribute("changeCode", assetChangeInfo.getId());
        }
		if (assetChangeInfo.getIsNewRecord() == true) {
			assetChangeInfo.setOperatorCode(UserUtils.getUser().getUserCode());
			assetChangeInfo.setOperatorName(UserUtils.getUser().getUserName());
			assetChangeInfo.setChangeDate(new Date());
		} else {
			assetChangeInfo.setOperatorCode(assetChangeInfo.getOperatorCode());
			assetChangeInfo.setOperatorName(assetChangeInfo.getOperatorName());
			assetChangeInfo.setChangeDate(assetChangeInfo.getChangeDate());
		}
		return "ecode/asset/base/changeinfo/assetChangeInfoForm";
	}

	/**
	 * 保存数据
	 */
	@RequiresPermissions("changeinfo:assetChangeInfo:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(AssetChangeInfo assetChangeInfo) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, assetChangeInfo)){
			return renderResult(Global.FALSE, message);
		}
        if(assetChangeInfo.getIsNewRecord()){
			Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
			assetChangeInfo.setChangeCode(codeRuleService.createCode("ZCBG","",common.getOfficeCode(),common.getCompanyCode()));
        }
			assetChangeInfoService.save(assetChangeInfo);
		return renderResult(Global.TRUE, "保存实物信息变更成功！");
	}

    /**
     * 得到子表数据，
     */
    @ResponseBody
    @RequestMapping(value = "getDtlData")
    public List<AssetChangeDtl> getDtlData(AssetChangeDtl assetChangeDtl) {
        List<AssetChangeDtl> assetChangeDtls = assetChangeInfoService.findUsedCode(assetChangeDtl);
        return assetChangeDtls;
    }
    /**
     * 点击选择资产，打开资产数据表格
     */
    @RequestMapping(value = "getusedDtllist")
    public String warehouseSelect(AssetInfo assetInfo, Model model) {
        model.addAttribute("assetInfo",assetInfo);
        return "ecode/asset/base/changeinfo/usedDtllist";
    }
	/**
	 * 删除数据
	 */
	@RequiresPermissions("changeinfo:assetChangeInfo:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(AssetChangeInfo assetChangeInfo) {
		assetChangeInfoService.delete(assetChangeInfo);
		return renderResult(Global.TRUE, "删除实物信息变更成功！");
	}

}