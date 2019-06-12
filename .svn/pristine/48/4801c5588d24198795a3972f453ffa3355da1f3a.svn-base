/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.usedinfo.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;
import cn.net.ecode.modules.ass.usedinfo.dao.AssetUsedDtlDao;

/**
 * 资产领用子表Service
 * @author zhaohongbin
 * @version 2018-09-20
 */
@Service
@Transactional(readOnly = true)
public class AssetUsedDtlService extends CrudService<AssetUsedDtlDao, AssetUsedDtl> {
	
	/**
	 * 获取单条数据
	 * @param assetUsedDtl
	 * @return
	 */
	public AssetUsedDtl get(AssetUsedDtl assetUsedDtl) {
		return super.get(assetUsedDtl);
	}
	
	/**
	 * 查询列表数据
	 * @param assetUsedDtl
	 * @return
	 */
	public List<AssetUsedDtl> findList(AssetUsedDtl assetUsedDtl) {
		return super.findList(assetUsedDtl);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param assetUsedDtl
	 * @return
	 */
	public Page<AssetUsedDtl> findPage(Page<AssetUsedDtl> page, AssetUsedDtl assetUsedDtl) {
		return super.findPage(page, assetUsedDtl);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param assetUsedDtl
	 */
	@Transactional(readOnly = false)
	public void save(AssetUsedDtl assetUsedDtl) {
		super.save(assetUsedDtl);
	}
	
	/**
	 * 删除数据
	 * @param assetUsedDtl
	 */
	@Transactional(readOnly = false)
	public void delete(AssetUsedDtl assetUsedDtl) {
		super.delete(assetUsedDtl);
	}

    /**
     * 通过assetUsedDtl中usedcode得到子表数据
     * @param assetUsedDtl
     * @return
     */
    public List<AssetUsedDtl> findUsedCode(AssetUsedDtl assetUsedDtl) {
        return dao.findUsedCode(assetUsedDtl);
    }
    /**
     * 退库时得到子表数据
     * @param assetUsedDtl
     * @return
     */
    public List<AssetUsedDtl> findUsedCodeReturn(AssetUsedDtl assetUsedDtl) {
        return dao.findUsedCodeReturn(assetUsedDtl);
    }
    /**
     * 退库时改变退库状态
     * @param assetCode
     * @return
     */
    public void updateReturn(String assetCode) {
         dao.updateReturn(assetCode);
    }

    public void updateUserinfo(AssetUsedDtl assetUsedDtl) {
        dao.updateUserinfo(assetUsedDtl);
    }
}