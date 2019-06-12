/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.test.entity;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Length;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 主子表增删改Entity
 * @author ThinkGem
 * @version 2016-10-09
 */
public class TestDataChild extends DataEntity<TestDataChild> {
	
	private static final long serialVersionUID = 1L;
	private TestDataMain testDataMain;		// 业务主表ID 父类
	private String name;		// 名称
	
	public TestDataChild() {
		super();
	}

	public TestDataChild(String id){
		super();
		this.id = id;
	}

	public TestDataChild(TestDataMain testDataMain){
		this.testDataMain = testDataMain;
	}

	public TestDataMain getTestDataMain() {
		return testDataMain;
	}

	public void setTestDataMain(TestDataMain testDataMain) {
		this.testDataMain = testDataMain;
	}
	
	@NotBlank(message="名称不能为空")
	@Length(min=0, max=100, message="名称长度不能超过 100 个字符")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}