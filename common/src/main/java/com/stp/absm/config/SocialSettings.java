package com.stp.absm.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@Data
@ConfigurationProperties(prefix="social")
public class SocialSettings {

    @Value("${social.facebook.fbAppId}")
    private String fbAppId;
}