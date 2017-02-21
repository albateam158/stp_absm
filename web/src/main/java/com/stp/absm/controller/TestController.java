package com.stp.absm.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by sj on 16. 3. 2..
 */
@RestController
public class TestController {
    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public Map<String, Object> test(

    ) {
        Map<String, Object> result = new HashMap<String, Object>();

        return result;
    }
}
