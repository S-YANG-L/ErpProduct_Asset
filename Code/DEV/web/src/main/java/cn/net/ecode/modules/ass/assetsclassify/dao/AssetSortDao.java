/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsclassify.dao;
import java.util.List;

import cn.net.ecode.common.persistence.TreeDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.assetsclassify.entity.AssetSort;

/**
 * assetsortDAO接口
 * @author tiantongwang
 * @version 2018-09-11
 */
@MyBatisDao
public interface AssetSortDao extends TreeDao<AssetSort> {
	List<AssetSort> getSortCodes(AssetSort assetSort);
	public int updateSortcode(AssetSort assetSort);

	/**
	 * 获取当前节点下的启用节点列表
	 * @param assetSort
	 * @return
	 */
	public List<AssetSort> getEnabledList(AssetSort assetSort);

	/**
	 * 停用当前节点
	 * @param assetSort
	 * @return
	 */
	public int disable(AssetSort assetSort);

	/**
	 * 停用当前节点和子节点
	 * @param assetSort
	 * @return
	 */
	public int disableByGroup(AssetSort assetSort);

	/**
	 * 启用当前节点
	 * @param assetSort
	 * @return
	 */
	public int enable(AssetSort assetSort);

	/**
	 * 启用当前节点和子节点
	 * @param assetSort
	 * @return
	 */
	public int enableByGroup(AssetSort assetSort);
	
	/** 
	 * 获取子节点中最大的排序号
	 * @param assetSort
	 * @return int  
	 */
	public int getMaxSort(AssetSort assetSort);
	
	/** 
	 * 获取子节点最大的个数
	 * @param assetSort
	 * @return int  
	 */
	public int getMaxSize(AssetSort assetSort);

    List<AssetSort> findListTop(AssetSort assetSort);

    AssetSort getIdSql(AssetSort assetSort);
}