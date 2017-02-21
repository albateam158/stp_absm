package com.stp.absm.mail;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.util.Map;

/**
 * Created by bridge on 15. 12. 20..
 */
@Service
public class MailService {

    private final Logger log = LoggerFactory.getLogger(MailService.class);

    @Autowired
    private JavaMailSender javaMailService;

    @Autowired
    Configuration configuration;

    public void sendmail(Map<String, Object> data, String viewname, String tomail, String subject) {


        try{

            //Template t = configuration.getTemplate("mail/password.ftl");
            Template t = configuration.getTemplate(viewname);

            String readyParsedTemplate = FreeMarkerTemplateUtils.processTemplateIntoString(t, data);


            MimeMessage message = javaMailService.createMimeMessage();

            MimeMessageHelper helper = new MimeMessageHelper(message);

            helper.setFrom("wicrowd@kasset.co.kr");
            helper.setTo(tomail);
            helper.setSubject(subject);
            helper.setText(readyParsedTemplate, true);


            javaMailService.send(message);

        }catch (Exception e){

            log.error("[메일링 오류]" + e.getMessage() );

        }

    }


    public void sendmail(String content, String tomail, String subject) throws IOException, TemplateException, MessagingException {


        MimeMessage message = javaMailService.createMimeMessage();

        MimeMessageHelper helper = new MimeMessageHelper(message);

        helper.setFrom("wicrowd@kasset.co.kr");
        helper.setTo(tomail);
        helper.setSubject(subject);
        helper.setText(content, true);


        javaMailService.send(message);
    }




}
