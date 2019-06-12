/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetdepre.service;

import java.lang.reflect.Method;
import java.util.List;

import cn.net.ecode.common.ueditor.ActionEnter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.assetdepre.entity.AssetDepre;
import cn.net.ecode.modules.ass.assetdepre.dao.AssetDepreDao;
import cn.net.ecode.modules.ass.assetdepre.entity.AssetDepreDtl;
import cn.net.ecode.modules.ass.assetdepre.dao.AssetDepreDtlDao;

/**
 * 计提折旧Service
 * @author zhaohongbin
 * @version 2018-11-07
 */
@Service
@Transactional(readOnly = true)
public class AssetDepreService extends CrudService<AssetDepreDao, AssetDepre> {
	
	@Autowired
	private AssetDepreDtlDao assetDepreDtlDao;
	
	/**
	 * 获取单条数据
	 * @param assetDepre
	 * @return
	 */
	public AssetDepre get(AssetDepre assetDepre) {
		AssetDepre entity = super.get(assetDepre);
		return entity;
	}
	
	/**
	 * 查询列表数据
	 * @param assetDepre
	 * @return
	 */
	public List<AssetDepre> findList(AssetDepre assetDepre) {
		return super.findList(assetDepre);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param assetDepre
	 * @return
	 */
	public Page<AssetDepre> findPage(Page<AssetDepre> page, AssetDepre assetDepre) {
		return super.findPage(page, assetDepre);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param assetDepre
	 */
	@Transactional(readOnly = false)
	public void save(AssetDepre assetDepre) {
		super.save(assetDepre);
		for (AssetDepreDtl assetDepreDtl : assetDepre.getAssetDepreDtlList()){
			if (!AssetDepreDtl.STATUS_DELETE.equals(assetDepreDtl.getStatus())){
				assetDepreDtl.setDepreCode(assetDepre.getSysId());
				if (assetDepreDtl.getIsNewRecord()){
					assetDepreDtl.preInsert();
					assetDepreDtlDao.insert(assetDepreDtl);
				}else{
					assetDepreDtl.preUpdate();
					assetDepreDtlDao.update(assetDepreDtl);
				}
			}else{
				assetDepreDtlDao.delete(assetDepreDtl);
			}
		}
	}

	/**
	 * 删除数据
	 * @param assetDepre
	 */
	@Transactional(readOnly = false)
	public void delete(AssetDepre assetDepre) {
		super.delete(assetDepre);
		AssetDepreDtl assetDepreDtl = new AssetDepreDtl();
		assetDepreDtl.setDepreCode(assetDepre.getSysId());
		assetDepreDtl.preUpdate();
		assetDepreDtlDao.delete(assetDepreDtl);
	}

    public List<AssetDepre> findListDepre(AssetDepre assetDepre) {
	    return  dao.findListDepre(assetDepre);
    }

    @Transactional(readOnly = false)
    public void saveDtl(AssetDepreDtl assetDepreDtl) {
        assetDepreDtlDao.insert(assetDepreDtl);
    }

	public List<AssetDepreDtl> findListDtl(AssetDepreDtl assetDepreDtl) {
		return assetDepreDtlDao.findListDtl(assetDepreDtl);
	}
	public Page<AssetDepreDtl> findPageDtl(Page<AssetDepreDtl> page, AssetDepreDtl entity) {
		Page var10000;
		label13: {
			try {
				Class var5 = this.entityClass;
//				String var10001 = ActionEnter.ALLATORIxDEMO("\"\u000f%:0\r4");
				Class[] var10002 = new Class[1];
				boolean var10004 = true;
				var10002[0] = Page.class;
//				Method var6 = var5.getMethod(var10001, var10002);
				Object[] var7 = new Object[1];
				var10004 = true;
				var7[0] = page;
//				var6.invoke(entity, var7);
			} catch (Exception var4) {
				var10000 = page;
				var4.printStackTrace();
				break label13;
			}

			var10000 = page;
		}

		var10000.setList(assetDepreDtlDao.findListDtl(entity));
		return page;
	}

	public Page<AssetDepreDtl> findListDtlPage(Page<AssetDepreDtl> newPage, AssetDepreDtl assetDepreDtl) {
		assetDepreDtl.setSubmitStatus("1");
		return  this.findPageDtl(newPage,assetDepreDtl);
	}
}