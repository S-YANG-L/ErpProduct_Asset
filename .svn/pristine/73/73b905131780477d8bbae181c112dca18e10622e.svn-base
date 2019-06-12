/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.borrow.service;

import java.util.List;

import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowDtl;
import cn.net.ecode.modules.ass.borrow.dao.AssetBorrowDtlDao;

/**
 * 资产借用归还子表Service
 * @author sunhuijun
 * @version 2018-09-20
 */
@Service
@Transactional(readOnly = true)
public class AssetBorrowDtlService extends CrudService<AssetBorrowDtlDao, AssetBorrowDtl> {

	/**
	 * 获取单条数据
	 * @param assetBorrowDtl
	 * @return
	 */
	public AssetBorrowDtl get(AssetBorrowDtl assetBorrowDtl) {
		return super.get(assetBorrowDtl);
	}

	/**
	 * 查询列表数据
	 * @param assetBorrowDtl
	 * @return
	 */
	public List<AssetBorrowDtl> findList(AssetBorrowDtl assetBorrowDtl) {
		return super.findList(assetBorrowDtl);
	}

	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param assetBorrowDtl
	 * @return
	 */
	public Page<AssetBorrowDtl> findPage(Page<AssetBorrowDtl> page, AssetBorrowDtl assetBorrowDtl) {
		return super.findPage(page, assetBorrowDtl);
	}

	/**
	 * 保存数据（插入或更新）
	 * @param assetBorrowDtl
	 */
	@Transactional(readOnly = false)
	public void save(AssetBorrowDtl assetBorrowDtl) {
		super.save(assetBorrowDtl);
	}

	/**
	 * 删除数据
	 * @param assetBorrowDtl
	 */
	@Transactional(readOnly = false)
	public void delete(AssetBorrowDtl assetBorrowDtl) {
		super.delete(assetBorrowDtl);
	}
	/**
	 * 通过assetUsedDtl中usedcode得到子表数据
	 * @return
	 */
	public List<AssetBorrowDtl> findUsedCode(AssetBorrowDtl assetBorrowDtl) {
		return dao.findUsedCode(assetBorrowDtl);
	}

	/**
	 * 查询闲置数据
	 * @return
	 */
	public List<AssetBorrowDtl> findListdtl(AssetBorrowDtl assetBorrowDtl) {
		return dao.findListdtl(assetBorrowDtl);
	}
	/**
	 * 改变状态跟使用人
	 * @return
	 */
	public void updatauserStatus2(AssetBorrowDtl assetBorrowDtl) {
		dao.updatauserStatus2(assetBorrowDtl);
	}
	public void updatauserStatus(AssetBorrowDtl assetBorrowDtl) {
		dao.updatauserStatus(assetBorrowDtl);
	}
}