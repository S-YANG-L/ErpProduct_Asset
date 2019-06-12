/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.codingrule.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.modules.ass.codingrule.entity.CodeRules;
import cn.net.ecode.modules.ass.codingrule.dao.CodeRulesDao;

/**
 * 编码规范子表Service
 * @author zhaohongbin
 * @version 2018-09-10
 */
@Service
@Transactional(readOnly = true)
public class CodeRulesService extends CrudService<CodeRulesDao, CodeRules> {
	
	/**
	 * 获取单条数据
	 * @param codeRules
	 * @return
	 */
	public CodeRules get(CodeRules codeRules) {
		return super.get(codeRules);
	}
	
	/**
	 * 查询列表数据
	 * @param codeRules
	 * @return
	 */
	public List<CodeRules> findList(CodeRules codeRules) {
		return super.findList(codeRules);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param codeRules
	 * @return
	 */
	public Page<CodeRules> findPage(Page<CodeRules> page, CodeRules codeRules) {
		return super.findPage(page, codeRules);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param codeRules
	 */
	@Transactional(readOnly = false)
	public void save(CodeRules codeRules) {
		super.save(codeRules);
	}
	
	/**
	 * 删除数据
	 * @param codeRules
	 */
	@Transactional(readOnly = false)
	public void delete(CodeRules codeRules) {
		super.delete(codeRules);
	}
    /**
     *保存编码规则
     */
    @Transactional(readOnly = false)
    public void updateCodeRules(CodeRules codeRules) {
        dao.updateCodeRules(codeRules);
    }
}