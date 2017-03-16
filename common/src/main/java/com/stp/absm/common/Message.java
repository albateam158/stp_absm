package com.stp.absm.common;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Created by thomas on 2017-03-14.
 */
@ConfigurationProperties(prefix="message")
public class Message {
    private static Message ourInstance = new Message();

    public static Message getInstance() {
        return ourInstance;
    }

    public static final String C_PAGE1001 = "파일이 첨부되지 않았습니다.";

    public static final String S_PAGE1001 = "기초자료 및 개인특성 자료 입력이 성공했습니다.";
    public static final String S_PAGE1002 = "기초자료 및 개인특성 자료 조회가 성공했습니다.";
    public static final String E_PAGE1001 = "기초자료 및 개인특성 자료 입력에 실패했습니다.";
    public static final String E_PAGE1002 = "기초자료 및 개인특성 자료 조회에 실패했습니다.";

    public static final String S_PAGE2001 = "이벤트 자료 입력이 성공했습니다.";
    public static final String E_PAGE2001 = "케이스ID가 없습니다.";

    private Message() {
    }
}
