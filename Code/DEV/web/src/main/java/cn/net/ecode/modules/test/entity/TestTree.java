/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.test.entity;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Length;
import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.validation.constraints.NotNull;

import cn.net.ecode.common.persistence.TreeEntity;

/**
 * 树结构数据表Entity
 * @author ThinkGem
 * @version 2016-10-08
 */
public class TestTree extends TreeEntity<TestTree> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 名称
	private Integer sortGrade;		// 树的层次级别
	
	public TestTree() {
		super();
	}

	public TestTree(String id){
		super();
		this.id = id;
	}

	public TestTree(TestTree parent){
		this.parent = parent;
	}
		
	@NotBlank(message="名称不能为空")
	@Length(min=0, max=100, message="名称长度不能超过 100 个字符")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
		
	@JsonBackReference
	@NotNull(message="父级编号不能为空")
	public TestTree getParent() {
		return parent;
	}

	public void setParent(TestTree parent) {
		this.parent = parent;
	}
		
	public Integer getSortGrade() {
		return sortGrade;
	}

	public void setSortGrade(Integer sortGrade) {
		this.sortGrade = sortGrade;
	}
	public String toString() {
		return id;
	}
}