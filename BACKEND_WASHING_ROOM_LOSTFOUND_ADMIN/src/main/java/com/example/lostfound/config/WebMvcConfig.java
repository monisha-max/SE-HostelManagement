// src/main/java/com/example/lostfound/config/WebMvcConfig.java
package com.example.lostfound.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
  @Value("${file.upload-dir}")
  private String uploadDir;

  @Override
  public void addResourceHandlers(ResourceHandlerRegistry registry) {
    // map all /images/** URLs to files in your uploadDir
    registry
      .addResourceHandler("/images/**")
      .addResourceLocations("file:" + uploadDir + "/");
  }
}
