/**
 * Copyright (c) 2013-Now 山东易科德软件有限公司 All rights reserved.
 */
package cn.net.ecode.modules.config;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;

import cn.net.ecode.common.utils.PropertiesLoader;

/**
 * EcodeDP App
 * @author ThinkGem
 * @version 2018年5月2日
 */
@SpringBootApplication(scanBasePackages={"cn.net.ecode.modules"})
public class Application extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication app = new SpringApplication(Application.class);
		app.setDefaultProperties(PropertiesLoader.getInstance().getProperties());
		app.run(args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		this.setRegisterErrorPageFilter(false); // 错误页面有容器来处理，而不是SpringBoot
		builder.properties(PropertiesLoader.getInstance().getProperties());
		return builder.sources(Application.class);
	}

}