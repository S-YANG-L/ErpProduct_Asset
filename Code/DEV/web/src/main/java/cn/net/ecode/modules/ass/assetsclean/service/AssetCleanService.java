/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsclean.service;

import java.util.Date;
import java.util.List;

import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import cn.net.ecode.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetClean;
import cn.net.ecode.modules.ass.assetsclean.dao.AssetCleanDao;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetCleanDtl;
import cn.net.ecode.modules.ass.assetsclean.dao.AssetCleanDtlDao;

/**
 * 资产清理Service
 * @author sww
 * @version 2018-10-11
 */
@Service
@Transactional(readOnly = true)
public class AssetCleanService extends CrudService<AssetCleanDao, AssetClean> {

	@Autowired
	private AssetCleanDtlDao assetCleanDtlDao;
	@Autowired
	private AssetInfoService assetInfoService;
	/**
	 * 获取单条数据
	 * @param assetClean
	 * @return
	 */
	public AssetClean get(AssetClean assetClean) {
		return super.get(assetClean);
	}
	
	/**
	 * 查询列表数据
	 * @param assetClean
	 * @return
	 */
	public List<AssetClean> findList(AssetClean assetClean) {
		return super.findList(assetClean);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param assetClean
	 * @return
	 */
	public Page<AssetClean> findPage(Page<AssetClean> page, AssetClean assetClean) {
		return super.findPage(page, assetClean);
	}
	/**
	 * 保存数据（插入或更新）
	 * @param assetClean
	 */
	@Transactional(readOnly = false)
	public void save(AssetClean assetClean) {
		if(assetClean.getIsNewRecord()){
			assetClean.setCleanStatus("0");
			super.save(assetClean);
            saveDtl(assetClean);
		}else{
		}
	}
	public void saveDtl(AssetClean assetClean) {
		if (assetClean.getAssetCleanDtlList() != null) {
			for(AssetCleanDtl assetCleanDtl: assetClean.getAssetCleanDtlList()) {
				assetCleanDtl.setCleanCode(assetClean.getId());
				assetCleanDtl.setCleanDate(new Date());
                assetCleanDtl.preInsert();
                assetCleanDtlDao.insert(assetCleanDtl);
				 AssetInfo assetInfo = new AssetInfo();
				assetInfo.setAssetCode(assetCleanDtl.getAssetCode());
				assetInfo.setAssetStatus("4");
				assetInfoService.updatauserStatus(assetInfo);
			}

		}
	}
	/**
	 * 删除数据
	 * @param assetClean
	 */
	@Transactional(readOnly = false)
	public void delete(AssetClean assetClean) {
		super.delete(assetClean);
		AssetCleanDtl assetCleanDtl = new AssetCleanDtl();
		assetCleanDtl.preUpdate();
		assetCleanDtlDao.delete(assetCleanDtl);
	}
	@Transactional(readOnly = false)
	public void update1(String assetCode) {
		AssetInfo assetInfo = new AssetInfo();
		assetInfo.setAssetCode(assetCode);
		assetInfo.setAssetStatus("0");
		assetInfoService.updatauserStatus(assetInfo);
		AssetCleanDtl assetCleanDtl = dao.findListjilu(assetCode);
		assetCleanDtl.setCleanerName(UserUtils.getUser().getUserName());
		assetCleanDtl.setCleanerCode(UserUtils.getUser().getUserCode());
		assetCleanDtl.setCleanDate(new Date());
		assetCleanDtl.setId(IdGen.nextId());
		assetCleanDtl.preInsert();
		dao.reduction(assetCleanDtl);
		assetCleanDtl.setAssetCode(assetCode);
		assetCleanDtl.setAssetStatus("0");
		assetCleanDtlDao.updateDtl(assetCleanDtl);
	}

	/**
	 * 通过assetUsedDtl中usedcode得到子表数据
	 * @return
	 */
	public List<AssetCleanDtl> findUsedCode(AssetCleanDtl assetCleanDtl) {
		return assetCleanDtlDao.findUsedCode(assetCleanDtl);
	}
	/**
	 * 通过查询清理人
	 */
	public List<AssetCleanDtl> assetCleanJilu(AssetCleanDtl assetCleanDtl) {
		return dao.assetCleanJilu(assetCleanDtl);
	}
	/**
	 * 查询清理数据
	 * @return
	 */
	public List<AssetCleanDtl> findCleanData(AssetCleanDtl assetCleanDtl) {
		return assetCleanDtlDao.findCleanData(assetCleanDtl);
	}

	@Transactional(readOnly = false)
	public List<AssetCleanDtl> findListDtl(AssetCleanDtl assetCleanDtl) {
		return   dao.findListDtl(assetCleanDtl);
	}
	/**
	 * @Title: getCompanyCode
	 * @Description: 根据userCode查询公司编码
	 * @return
	 */
	public String getCompanyCode(AssetClean assetClean){
		return dao.getCompanyCode(assetClean);
	}

	/**
	 * 分类汇总数据
	 */
	public List<AssetClean> summaryData(AssetClean assetClean) {
		return dao.summaryData(assetClean);
	}
}