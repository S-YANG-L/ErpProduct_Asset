/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsclassify.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.service.TreeService;
import cn.net.ecode.modules.ass.assetsclassify.entity.AssetSort;
import cn.net.ecode.modules.ass.assetsclassify.dao.AssetSortDao;

/**
 * assetsortService
 * @author tiantongwang
 * @version 2018-09-11
 */
@Service
@Transactional(readOnly = true)
public class AssetSortService extends TreeService<AssetSortDao, AssetSort> {

	/**
	 * 获取单条数据
	 * @param assetSort
	 * @return
	 */
	public AssetSort get(AssetSort assetSort) {
		return super.get(assetSort);
	}
	
	/**
	 * 查询列表
	 */
	public List<AssetSort> findList(AssetSort assetSort) {
		return dao.findList(assetSort);
	}
	
	/**
	 * 查询全部列表
	 * @return
	 */
	public List<AssetSort> findAllList(AssetSort assetSort) {
		return dao.findAllList(assetSort);
	}
	

	/**
	 * 保存数据（插入或更新）
	 */
	@Transactional(readOnly = false)
	public void save(AssetSort assetSort) {
		super.save(assetSort);
		dao.updateSortcode(assetSort);
	}


	/**
	 * 保存数据（删除）
	 */
	@Transactional(readOnly = false)
	public void delete(AssetSort assetSort) {
		super.delete(assetSort);
	}
	
	/**
	 * 获取当前节点下的启用列表
	 * 
	 * @param assetSort
	 * @return
	 */
	public List<AssetSort> getEnabledList(AssetSort assetSort) {
		return dao.getEnabledList(assetSort);
	}

	/**
	 * 停用当前节点
	 */
	@Transactional(readOnly = false)
	public void disable(AssetSort assetSort) {
		dao.disable(assetSort);
	}

	/**
	 * 停用当前节点和子节点
	 */
	@Transactional(readOnly = false)
	public void disableByGroup(AssetSort assetSort) {
		dao.disableByGroup(assetSort);
	}

	/**
	 * 启用当前节点
	 */
	@Transactional(readOnly = false)
	public void enable(AssetSort assetSort) {
		dao.enable(assetSort);
	}

	/**
	 * 启用当前节点和子节点
	 */
	@Transactional(readOnly = false)
	public void enableByGroup(AssetSort assetSort) {
		dao.enableByGroup(assetSort);
	}
	
	/** 
	 * 获取子节点中最大的排序号
	 * @param assetSort
	 * @return int  
	 */
	public int getMaxSort(AssetSort assetSort) {
		return dao.getMaxSort(assetSort);
	}
	
	/** 
	 * 获取子节点最大的个数
	 * @param assetSort
	 * @return int  
	 */
	public int getMaxSize(AssetSort assetSort) {
		return dao.getMaxSize(assetSort);
	}

	/**
	 * 获取所有分类编码
	 * @return
	 */
	public List<AssetSort> getSortCodes(AssetSort assetSort) {
		return  dao.getSortCodes(assetSort);
	}

    public List<AssetSort> findListTop(AssetSort assetSort) {
	    return  dao.findListTop(assetSort);
    }

    public AssetSort getIdSql(AssetSort assetSort) {
        return dao.getIdSql(assetSort);
    }
}