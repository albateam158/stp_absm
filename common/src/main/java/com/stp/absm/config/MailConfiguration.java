package com.stp.absm.config;


import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@Data
@ConfigurationProperties(prefix="mailserver")
public class MailConfiguration {

    private String protocol;
    private String hostl;
    private int port;
    private String user = "finegpsmaster@gmail.com";
    private String gid = "finegpsmaster";
    private String gpwd = "fine2831";
    private String admin = "jhjeon@finedigital.com";
}
