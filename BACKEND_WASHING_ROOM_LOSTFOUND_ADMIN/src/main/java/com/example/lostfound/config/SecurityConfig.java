package com.example.lostfound.config;

import com.example.lostfound.security.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private CustomUserDetailsService userDetailsService;

    // —— Configure authentication (who are you?) ——
    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth
          .userDetailsService(userDetailsService)
          .passwordEncoder(passwordEncoder());
    }

    // —— Configure authorization (what can you access?) ——
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
        .authorizeRequests()
            .antMatchers("/admin/**").hasRole("ADMIN")
            // require login for upload, washing, and room booking:
            .antMatchers("/upload", "/washing/**", "/rooms/**").authenticated()
            .anyRequest().permitAll()
        .and()
            .formLogin()
            .loginPage("/login")
            .defaultSuccessUrl("/upload", true)
        .and()
            .logout().permitAll();
    }


    // —— Password encoder bean ——
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
