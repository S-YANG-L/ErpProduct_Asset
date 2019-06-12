/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsclean.web;

import cn.net.ecode.common.config.Global;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.utils.DateUtils;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.common.utils.excel.ExcelExport;
import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetClean;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetCleanDtl;
import cn.net.ecode.modules.ass.assetsclean.service.AssetCleanService;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import cn.net.ecode.modules.ass.changeinfo.entity.AssetChangeInfo;
import cn.net.ecode.modules.ass.codingrule.service.CodeRuleService;
import cn.net.ecode.modules.ass.common.dao.CommonDao;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 资产清理Controller
 * @author sww
 * @version 2018-10-11
 */
@Controller
@RequestMapping(value = "${adminPath}/assetsclean/assetClean")
public class AssetCleanController extends BaseController {

	@Autowired
	private AssetCleanService assetCleanService;
	@Autowired
	private CodeRuleService codeRuleService;
	@Autowired
	private AssetInfoService assetInfoService;

	@Autowired
	private CommonDao commonService;
	/**
	 * 获取数据
	 */
	@ModelAttribute
	public AssetClean get(String id, boolean isNewRecord) {
		return assetCleanService.get(id, isNewRecord);
	}

	/**
	 * 查看编辑借用归还表单
	 */
	@RequiresPermissions("usedinfo:assetUsedInfo:view")
	@RequestMapping(value = "assetCleanList")
	public String assetCleanList(AssetClean assetClean, Model model) {
		model.addAttribute("assetClean", assetClean);
		return "ecode/asset/base/assetsclean/assetCleanList";
	}
	/**
	 * 查询列表
	 */
	@RequiresPermissions("assetsclean:assetClean:view")
	@RequestMapping(value = {"list", ""})
	public String list(AssetClean assetClean, Model model) {
		model.addAttribute("assetClean", assetClean);
		return "ecode/asset/base/assetsclean/assetCleanList";
	}
	@RequiresPermissions("assetsclean:assetClean:view")
	@RequestMapping(value = {"list2", ""})
	public String list2(AssetClean assetClean, Model model) {
		model.addAttribute("assetClean", assetClean);
		return "ecode/asset/base/assetsclean/assetReductionList";
	}
	/**
	 * 清理清单
	 */
	@RequiresPermissions("assetsclean:assetClean:view")
	@RequestMapping(value = {"cleanList", ""})
	public String cleanList(AssetClean assetClean, Model model) {
		model.addAttribute("assetClean", assetClean);
		return "ecode/asset/base/assetsclean/assetCleanJilu";
	}
	/**
	 * 分类汇总
	 */
	@RequiresPermissions("assetsclean:assetClean:view")
	@RequestMapping(value = {"sortUsingList", ""})
	public String sortUsingList(AssetClean assetClean, Model model) {
		model.addAttribute("assetClean", assetClean);
		return "ecode/asset/base/assetsclean/assetSortUsing";
	}
	/**
	 * 查询列表数据
	 */
	@RequiresPermissions("assetsclean:assetClean:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public Page<AssetClean> listData(AssetClean assetClean, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AssetClean> page = assetCleanService.findPage(new Page<AssetClean>(request, response), assetClean); 
		return page;
	}

	/**
	 * 查询列表数据
	 */
	@RequestMapping(value = "listDataQl")
	public String listDataQl(AssetInfo assetInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
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
		assetInfo.setAssetStatuss(new String[]{"0"});
		List<AssetInfo> page = assetInfoService.findList(assetInfo);
		AssetClean assetClean=new AssetClean();
		assetClean.setCleanerCode(UserUtils.getUser().getUserCode());
		assetClean.setCleanerName(UserUtils.getUser().getUserName());
		assetClean.setCleanDate(new Date());
		model.addAttribute("assetClean",assetClean);
		model.addAttribute("assetCleanDtlList", page);
		return "ecode/asset/base/assetsclean/assetCleanFormPl";
	}
	/**
	 * 查看编辑表单
	 */
	@RequiresPermissions("assetsclean:assetClean:view")
	@RequestMapping(value = "form")
	public String form(AssetClean assetClean, Model model) {


		if (StringUtils.isNotBlank(assetClean.getId())) {
			model.addAttribute("cleanCode", assetClean.getId());
		}
		AssetClean assetClean1=new AssetClean();
		if (assetClean.getIsNewRecord() == true) {
			assetClean.setCleanerCode(UserUtils.getUser().getUserCode());
			assetClean.setCleanerName(UserUtils.getUser().getUserName());
			assetClean.setCleanDate(new Date());
		} else {
			assetClean.setCleanerCode(UserUtils.getUser().getUserCode());
			assetClean.setCleanerName(UserUtils.getUser().getUserName());
			assetClean.setCleanDate(assetClean.getCreateDate());
		}
		String companyCode=assetCleanService.getCompanyCode(assetClean);
		assetClean.setCompanyCode(companyCode);
		model.addAttribute("assetClean", assetClean);
		return "ecode/asset/base/assetsclean/assetCleanForm";
	}
	/**
	 * 保存数据
	 */
	@RequiresPermissions("assetsclean:assetClean:edit")
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(AssetClean assetClean) {
		StringBuilder message = new StringBuilder();
		if (!beanValidator(message, assetClean)){
			return renderResult(Global.FALSE, message);
		}
		Common common=commonService.getOfficeCompany(UserUtils.getUser().getUserCode());
		assetClean.setCleanCode(codeRuleService.createCode("ZCQL","",common.getOfficeCode(),common.getCompanyCode()));
		assetCleanService.save(assetClean);
		return renderResult(Global.TRUE, "清理成功！");
	}
	/**
	 * 删除数据
	 */
	@RequiresPermissions("assetsclean:assetClean:edit")
	@ResponseBody
	@RequestMapping(value = "delete")
	public String delete(AssetClean assetClean) {
		assetCleanService.delete(assetClean);
		return renderResult(Global.TRUE, "删除成功！");
	}
	@RequiresPermissions("assetsclean:assetClean:edit")
	@ResponseBody
	@RequestMapping(value = "update1")
	public String update1(String assetCode) {
		assetCleanService.update1(assetCode);
		return renderResult(Global.TRUE, "还原成功！");
	}
	/**
	 * 查询新增选择资产
	 */
	@RequiresPermissions("borrow:assetBorrowInfo:view")
	@RequestMapping(value = {"getusedDtllist", ""})
	public String getusedDtllist(AssetInfo assetInfo, Model model) {
		model.addAttribute("assetInfo", assetInfo);
		return "ecode/asset/base/assetsclean/usedDtllist";
	}
	/**
	 * 查询列表数据,筛选
	 */
	@ResponseBody
	@RequestMapping(value = "listDataCode")
	public List<AssetInfo> listDataCode(AssetInfo assetInfo) {
		List<AssetInfo> page = assetInfoService.findListdtl(assetInfo);
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
	 * 查询新增选择资产
	 */
	@RequiresPermissions("borrow:assetBorrowInfo:view")
	@RequestMapping(value = {"getusedDtllist2", ""})
	public String getusedDtllist2(AssetInfo assetInfo, Model model) {
		model.addAttribute("assetInfo", assetInfo);
		return "ecode/asset/base/assetsclean/usedDtllist2";
	}
	/**
	 * 查询清理人信息
	 */
	@RequiresPermissions("borrow:assetBorrowInfo:view")
	@RequestMapping(value = {"assetCleanJiluDtl", ""})
	public String assetCleanJiluDtl(AssetCleanDtl assetCleanDtl, Model model) {
		model.addAttribute("assetCleanDtl", assetCleanDtl);
		return "ecode/asset/base/assetsclean/assetCleanJiluDtl";
	}
	@ResponseBody
	@RequestMapping(value = "assetCleanJilu")
	public List<AssetCleanDtl> assetCleanJilu(AssetCleanDtl assetCleanDtl) {
		List<AssetCleanDtl> assetCleanDtls = assetCleanService.assetCleanJilu(assetCleanDtl);
        List<AssetCleanDtl> assetCleanDtlCan=new ArrayList<>();
        for(AssetCleanDtl assetCleanDtl1:assetCleanDtls){
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String date = formatter.format(assetCleanDtl1.getCleanDate());//格式化数据
            assetCleanDtl1.setCleanDateString(date);
            assetCleanDtlCan.add(assetCleanDtl1);
        }
        return assetCleanDtlCan;
	}
	/**
	 * 得到子表数据，
	 */
	@ResponseBody
	@RequestMapping(value = "getDtlData")
	public List<AssetCleanDtl> getDtlData(AssetCleanDtl assetCleanDtl) {
		List<AssetCleanDtl>  assetCleanDtlList=assetCleanService.findUsedCode(assetCleanDtl);
		return assetCleanDtlList;
	}
	/**
	 * 得到子表数据，
	 */
	@ResponseBody
	@RequestMapping(value = "CleanData")
	public List<AssetCleanDtl> CleanData(AssetCleanDtl assetCleanDtl) {
		List<AssetCleanDtl>  assetCleanDtlList=assetCleanService.findCleanData(assetCleanDtl);
		return assetCleanDtlList;
	}

	/**
	 * 清理清单导出
	 */
	@RequiresPermissions("assetsclean:assetClean:edit")
	@RequestMapping(value = "export")
	public String pwdAuditExport(AssetCleanDtl assetCleanDtl, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "清理清单" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
			List<AssetCleanDtl> list = assetCleanService.findCleanData(assetCleanDtl);
			for (int i = 0; i < list.size(); i++) {
				AssetCleanDtl assetCleanDtl1 = list.get(i);
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			//	String date = formatter.format(assetCleanDtl1.getCleanDate());//格式化数据
//				assetClean1.setBuyDateString(date);
			}
			(new ExcelExport("清理清单", AssetCleanDtl.class, 1)).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception var7) {
			var7.printStackTrace();
			this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
			System.out.println(var7.getMessage());
			return "redirect:" + this.adminPath + "/assetsclean/assetClean/cleanList";
		}
	}
	/**
	 * 分类使用情况导出
	 */
	@RequiresPermissions("assetsclean:assetClean:edit")
	@RequestMapping(value = "exportSort")
	public String pwdAuditExport(AssetClean assetClean, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "分类使用情况" + DateUtils.getDate("yyyyMMdd") + ".xlsx";
			List<AssetClean> list = assetCleanService.summaryData(assetClean);
			for (int i = 0; i < list.size(); i++) {
				AssetClean assetClean1 = list.get(i);
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//	String date = formatter.format(assetCleanDtl1.getCleanDate());//格式化数据
//				assetClean1.setBuyDateString(date);
			}
			(new ExcelExport("分类使用情况", AssetClean.class, 1)).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception var7) {
			var7.printStackTrace();
			this.addMessage(redirectAttributes, new String[]{"导出数据失败！失败信息：" + var7.getMessage()});
			System.out.println(var7.getMessage());
			return "redirect:" + this.adminPath + "/assetsclean/assetClean/sortUsingList";
		}
	}

	/**
	 * 分类汇总
	 */
	@RequiresPermissions("assetsclean:assetClean:view")
	@ResponseBody
	@RequestMapping(value = "summaryData")
	public List<AssetClean> summaryData(AssetClean assetClean, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<AssetClean> page = assetCleanService.summaryData(assetClean);
		return page;
	}
	/**
	 * 分类汇总跳详情list页面
	 */
	@RequestMapping(value = {"assetSummaryInfoList", ""})
	public String assetSummaryInfoList(AssetInfo assetInfo, Model model) {
		model.addAttribute("assetInfo", assetInfo);
		return "ecode/asset/base/assetsclean/assetSummaryInfoList";
	}
}