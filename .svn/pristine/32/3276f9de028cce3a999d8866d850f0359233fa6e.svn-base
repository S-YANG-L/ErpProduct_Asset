/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.articlesfile.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.articlesfile.entity.ArticlesFile;
import cn.net.ecode.modules.ass.articlesfile.dao.ArticlesFileDao;

/**
 * 办公用品档案管理Service
 * @author yangjianjun
 * @version 2018-09-29
 */
@Service
@Transactional(readOnly = true)
public class ArticlesFileService extends CrudService<ArticlesFileDao, ArticlesFile> {
	
	/**
	 * 获取单条数据
	 * @param articlesFile
	 * @return
	 */
	public ArticlesFile get(ArticlesFile articlesFile) {
		return super.get(articlesFile);
	}
	
	/**
	 * 查询列表数据
	 * @param articlesFile
	 * @return
	 */
	public List<ArticlesFile> findList(ArticlesFile articlesFile) {
		return super.findList(articlesFile);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param articlesFile
	 * @return
	 */
	public Page<ArticlesFile> findPage(Page<ArticlesFile> page, ArticlesFile articlesFile) {
		return super.findPage(page, articlesFile);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param articlesFile
	 */
	@Transactional(readOnly = false)
	public void save(ArticlesFile articlesFile) {
		super.save(articlesFile);
	}
	
	/**
	 * 删除数据
	 * @param articlesFile
	 */
	@Transactional(readOnly = false)
	public void delete(ArticlesFile articlesFile) {
		super.delete(articlesFile);
	}
	
}