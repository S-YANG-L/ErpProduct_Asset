package cn.net.ecode.modules.ass.common.web;



import cn.net.ecode.modules.ass.assetcheck.dao.AssetCheckDtlDao;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheckDtl;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetCleanDtl;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.net.ecode.common.web.BaseController;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class IndexController extends BaseController {
	 @Autowired
	 private AssetInfoService assetInfoService;
    @Autowired
    private AssetCheckDtlDao assetCheckDtlDao;
	/**
	 *
	 * @Title: 资产标签二维码展示页
	 * yangjianjun
	 * 2018-10-11
	 * @return
	 */
	@RequestMapping(value = "assetInfoQrcode")
	public String index(String assetCode, Model model) throws Exception {
		    String  assetinfoStatus="0";
		    AssetInfo assetinfo=new AssetInfo();
		    assetinfo.setAssetCode(assetCode);
		    assetinfo = assetInfoService.getAssetCodesql(assetinfo);
            List<AssetCheckDtl> assetCheckDtls = assetCheckDtlDao.getAssetCodesql(assetCode);
            if(assetCheckDtls.size()==0){
            	assetinfoStatus="0";
            }else{
            	if(assetCheckDtls.get(assetCheckDtls.size()-1).getAssetStatus().equals("1")){
            		assetinfoStatus="0";
            	}else{
            		assetinfoStatus="1";
            	}
            	
            }
	        model.addAttribute("assetinfo", assetinfo);
	        model.addAttribute("assetinfoStatus", assetinfoStatus);
	   return "ecode/asset/base/assetsput/assetInfoQrcodeForm";
	}
    /**
     *
     * @Title: 资产盘点改变
     * yangjianjun
     * 2018-10-11
     * @return
     */
    @RequestMapping(value = "updateAssetCheckStatus")
    public Map<String, Object> updateAssetCheckStatus(String assetCode, Model model) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            AssetCheckDtl assetCheckDtl=new AssetCheckDtl();
            assetCheckDtl.setAssetCode(assetCode);
            assetCheckDtlDao.updateCheckStatus(assetCheckDtl);
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return  result;
    }
    /**
     *
      * App得到盘点结果
     */
    @RequestMapping(value = "getAppAssetCheckDtls")
    public Map<String, Object> getAppAssetCheckDtls(AssetCheckDtl assetCheckDtl) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {// 成功
            result.put("data", assetCheckDtlDao.findAppAssetCheckDtls(assetCheckDtl));
            result.put("code", "200");
            result.put("message", "success");
        } catch (Exception e) {// 失败
            e.printStackTrace();
            result.put("code", "201");
            result.put("message", "fail");
        }
        return  result;
    }
    /**
    *
     * App提交盘点结果
    */
   @RequestMapping(value = "updateAppAssetCheckDtls")
   public Map<String, Object> updateAppAssetCheckDtls(AssetCheckDtl assetCheckDtl) {
       Map<String, Object> result = new HashMap<String, Object>();
       try {// 成功
           assetCheckDtlDao.updateAppAssetCheckDtls(assetCheckDtl);
           result.put("code", "200");
           result.put("message", "success");
       } catch (Exception e) {// 失败
           e.printStackTrace();
           result.put("code", "201");
           result.put("message", "fail");
       }
       return  result;
   }
}
//assetStatus