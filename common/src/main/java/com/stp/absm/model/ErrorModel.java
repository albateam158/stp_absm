package com.stp.absm.model;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * Created by bridge on 15. 4. 10..
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ErrorModel {

    private String errorCode;
    private String errorMessage;

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
}
