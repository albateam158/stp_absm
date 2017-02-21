package com.stp.absm.controller;

import com.stp.absm.model.XAdmin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;

@RestController
public class AdminController extends RootController{

    @Autowired
    protected PasswordEncoder passwordEncoder;


    /**
     * 사용자 등록 form
     * @param adminId
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/admin/form", method = RequestMethod.GET)
    public ModelAndView form(
            @RequestParam(value = "adminId", required = false) Integer adminId,
            ModelAndView mav, WebRequest request
    ) {

        if( adminId != null ){

            XAdmin admin = xAdminRepository.findOne(adminId);

            mav.addObject("admin", admin);
        }
//        List<DzDept> dzDepts            = dzDeptRepository.findAllByOrderByDeptCdAsc();
//        mav.addObject("dzDepts", dzDepts);
        mav.setViewName("admin/admin_form");

        return mav;
    }

    /**
     * 사용자 등록
     * @param adminId
     * @param password
     * @param name
     * @param request
     * @return
     */
    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    public XAdmin save(
            @RequestParam(value = "adminId", required = false) Integer adminId,
            @RequestParam(value = "adminType", required = false) String adminType,
            @RequestParam(value = "password", required = false) String password,
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "empNo", required = false) String empNo,
            @RequestParam(value = "deptCd", required = false) String deptCd,
            WebRequest request
    ) {
        XAdmin admin = null;

        // 사용자 저장
        if( adminId != null ){

            admin = xAdminRepository.findOne(adminId);
            admin.setName(name);
            admin.setPassword(passwordEncoder.encode(password));
            admin.setUpdateDate(new Date());
            admin.setDeptCd(deptCd);
            admin.setEmpNo(empNo);
            admin.setAdminType(adminType);
            xAdminRepository.save(admin);

            Authentication authentication =  new UsernamePasswordAuthenticationToken(admin, null, admin.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(authentication);

        }
        /** 사용자 등록
         admin_id int(10) UN AI PK
         emp_no varchar(10)
         password varchar(255)
         name varchar(45)
         dept_cd varchar(4)
         admin_type varchar(20)
         reg_date timestamp
         update_date timestamp
         delete_date timestamp
         */
        else{
            admin.setEmpNo(empNo);
            admin.setPassword(passwordEncoder.encode(password));
            admin.setName(name);
            admin.setDeptCd(deptCd);
            admin.setAdminType(adminType);
            admin.setRegDate(new Date());
            xAdminRepository.save(admin);
        }

        return admin;
    }
}
