/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.test.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.modules.sys.entity.Area;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.User;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 单表生成Entity
 * @author ThinkGem
 * @version 2014-10-27
 */
public class TestData extends DataEntity<TestData> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 归属用户
	private Office office;		// 归属部门
	private Area area;		// 归属区域
	private String name;		// 名称
	private String sex;		// 性别
	private Date inDate;		// 加入日期
	
	private String upload1;		// 上传附件1
	private String upload2;		// 上传附件2
	
	public TestData() {
		super();
	}

	public TestData(String id){
		super();
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
	@Length(min=0, max=100, message="名称长度不能超过 100 个字符")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=1, message="性别长度不能超过 1 个字符")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getInDate() {
		return inDate;
	}

	public void setInDate(Date inDate) {
		this.inDate = inDate;
	}

	public String getUpload1() {
		return upload1;
	}

	public void setUpload1(String upload1) {
		this.upload1 = upload1;
	}

	public String getUpload2() {
		return upload2;
	}

	public void setUpload2(String upload2) {
		this.upload2 = upload2;
	}
	
}