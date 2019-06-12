/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.codingrule.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.codingrule.entity.CodeRule;
import cn.net.ecode.modules.ass.codingrule.entity.CodeRules;

import java.util.List;

/**
 * 编码规则DAO接口
 * @author zhaohongbin
 * @version 2018-09-10
 */
@MyBatisDao
public interface CodeRuleDao extends CrudDao<CodeRule> {
    void deletecodeRules(CodeRules codeRules);
    void savecodeRules(CodeRules codeRules);
    List<CodeRules> findListDtl(CodeRules codeRules);
    CodeRule getCodeRule(String codeObjectId);
    void updateCode(CodeRule codeRule1);
}