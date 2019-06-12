/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.changeinfo.service;

import java.util.List;

import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import cn.net.ecode.modules.ass.cancelstocks.entity.AssetReturnDtl;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.changeinfo.entity.AssetChangeInfo;
import cn.net.ecode.modules.ass.changeinfo.dao.AssetChangeInfoDao;
import cn.net.ecode.modules.ass.changeinfo.entity.AssetChangeDtl;
import cn.net.ecode.modules.ass.changeinfo.dao.AssetChangeDtlDao;

/**
 * 实物信息变更Service
 * @author zhao
 * @version 2018-10-09
 */
@Service
@Transactional(readOnly = true)
public class AssetChangeInfoService extends CrudService<AssetChangeInfoDao, AssetChangeInfo> {

	@Autowired
	private AssetChangeDtlDao assetChangeDtlDao;
    @Autowired
    private AssetInfoService assetInfoService;
	/**
	 * 获取单条数据
	 * @param assetChangeInfo
	 * @return
	 */
	public AssetChangeInfo get(AssetChangeInfo assetChangeInfo) {
		AssetChangeInfo entity = super.get(assetChangeInfo);
		if (entity != null) {
            assetChangeInfo.setAssetChangeDtlList(assetChangeDtlDao.findList(new AssetChangeDtl(entity.getId())));
        }
		return entity;
	}

	/**
	 * 查询列表数据
	 * @param assetChangeInfo
	 * @return
	 */
	public List<AssetChangeInfo> findList(AssetChangeInfo assetChangeInfo) {
		return super.findList(assetChangeInfo);
	}

	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param assetChangeInfo
	 * @return
	 */
	public Page<AssetChangeInfo> findPage(Page<AssetChangeInfo> page, AssetChangeInfo assetChangeInfo) {
		return super.findPage(page, assetChangeInfo);
	}

	/**
	 * 保存数据（插入或更新）
	 * @param assetChangeInfo
	 */
	@Transactional(readOnly = false)
	public void save(AssetChangeInfo assetChangeInfo) {
        if (assetChangeInfo.getIsNewRecord()) {
            super.save(assetChangeInfo);
            for (AssetChangeDtl assetChangeDtl : assetChangeInfo.getAssetChangeDtlList()) {
                String changeInfo="";
                assetChangeDtl.setChangeCode(assetChangeInfo.getId());
                AssetInfo assetInfo = new AssetInfo();
                assetInfo.setAssetCode(assetChangeDtl.getAssetCode());
                assetInfo=assetInfoService.getAssetCodesql(assetInfo);
                if(!assetChangeInfo.getTopSortName().trim().equals("")){
                    changeInfo=changeInfo+"资产大类由'"+assetInfo.getTopSortName()+"'改为了'"+assetChangeInfo.getTopSortName()+"',";
                    assetInfo.setTopSortCode(assetChangeInfo.getTopSortCode());
                    assetInfo.setTopSortName(assetChangeInfo.getTopSortName());
                }
                if(!assetChangeInfo.getSortName().trim().equals("")){
                    changeInfo=changeInfo+"资产小类由'"+assetInfo.getSortName()+"'改为了'"+assetChangeInfo.getSortName()+"',";
                    assetInfo.setSortName(assetChangeInfo.getSortName());
                    assetInfo.setSortCode(assetChangeInfo.getSortCode());
                }
                if(!assetChangeInfo.getAssetName().trim().equals("")){
                    changeInfo=changeInfo+"资产名称由'"+assetInfo.getAssetName()+"'改为了'"+assetChangeInfo.getAssetName()+"',";
                    assetInfo.setAssetName(assetChangeInfo.getAssetName());
                }
                if(!assetChangeInfo.getStoragePlace().trim().equals("")){
                    changeInfo=changeInfo+"存放地点由'"+assetInfo.getStoragePlace()+"'改为了'"+assetChangeInfo.getStoragePlace()+"',";
                    assetInfo.setStoragePlaceCode(assetChangeInfo.getStoragePlaceCode());
                    assetInfo.setStoragePlace(assetChangeInfo.getStoragePlace());
                }
                if(!assetChangeInfo.getRegionName().trim().equals("")){
                    changeInfo=changeInfo+"区域名称由'"+assetInfo.getRegionName()+"'改为了'"+assetChangeInfo.getRegionName()+"',";
                    assetInfo.setRegionCode(assetChangeInfo.getRegionCode());
                    assetInfo.setRegionName(assetChangeInfo.getRegionName());
                }
                if(!assetChangeInfo.getSupplier().trim().equals("")){
                    changeInfo=changeInfo+"供货商由'"+assetInfo.getSupplier()+"'改为了'"+assetChangeInfo.getSupplier()+"',";
                    assetInfo.setSupplierCode(assetChangeInfo.getSupplierCode());
                    assetInfo.setSupplier(assetChangeInfo.getSupplier());
                }
                if(!assetChangeInfo.getUnit().trim().equals("")){
                    changeInfo=changeInfo+"计量单位由'"+assetInfo.getUnit()+"'改为了'"+assetChangeInfo.getUnit()+"',";
                    assetInfo.setUnit(assetChangeInfo.getUnit());
                }
                if(!assetChangeInfo.getBrand().trim().equals("")){
                    changeInfo=changeInfo+"品牌由'"+assetInfo.getBrand()+"'改为了'"+assetChangeInfo.getBrand()+"',";
                    assetInfo.setBrand(assetChangeInfo.getBrand());
                }
                if(!assetChangeInfo.getVersion().trim().equals("")){
                    changeInfo=changeInfo+"型号由'"+assetInfo.getVersion()+"'改为了'"+assetChangeInfo.getVersion()+"',";
                    assetInfo.setVersion(assetChangeInfo.getVersion());
                }
                if(!assetChangeInfo.getRemarks().trim().equals("")){
                    changeInfo=changeInfo+"备注信息'"+assetInfo.getRemarks()+"'改为了'"+assetChangeInfo.getRemarks()+"',";
                    assetInfo.setRemarks(assetChangeInfo.getRemarks());
                }
                if(!assetChangeInfo.getPicturePath().equals("")){
                    changeInfo=changeInfo+"图片修改了"+",";
                    assetInfo.setPicturePath(assetChangeInfo.getPicturePath());
                }
                if(changeInfo.length()>1){
                    changeInfo = changeInfo.substring(0,changeInfo.length() - 1);
                }
                assetChangeDtl.setChangeInfo(changeInfo);
                assetChangeDtl.preInsert();
                assetChangeDtlDao.insert(assetChangeDtl);
                assetInfo.preUpdate();
                assetInfoService.updataChange(assetInfo);
            }
        } else {
            super.save(assetChangeInfo);
            AssetChangeDtl assetChangeDtl1=new AssetChangeDtl();
            assetChangeDtl1.setChangeCode(assetChangeInfo.getId());
            assetChangeDtlDao.delete(assetChangeDtl1);
            for (AssetChangeDtl assetChangeDtl : assetChangeInfo.getAssetChangeDtlList()) {
                assetChangeDtl.setChangeCode(assetChangeInfo.getId());
                assetChangeDtl.preInsert();
                assetChangeDtlDao.insert(assetChangeDtl);

            }
        }
	}

	/**
	 * 删除数据
	 * @param assetChangeInfo
	 */
	@Transactional(readOnly = false)
	public void delete(AssetChangeInfo assetChangeInfo) {
		super.delete(assetChangeInfo);
		AssetChangeDtl assetChangeDtl = new AssetChangeDtl();
		assetChangeDtl.preUpdate();
		assetChangeDtlDao.delete(assetChangeDtl);
	}

    public List<AssetChangeDtl> findUsedCode(AssetChangeDtl assetChangeDtl) {
        return assetChangeDtlDao.findUsedCode(assetChangeDtl);
    }
}