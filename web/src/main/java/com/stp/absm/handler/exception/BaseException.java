package com.stp.absm.handler.exception;

/**
 * Created by shpark on 2017-03-30.
 */
public class BaseException extends RuntimeException {
    private static final long serialVersionUID = 1L;
    private String message;

    public BaseException(String message) {
        this.message = message;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
}
