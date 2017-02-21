package com.stp.absm.controller;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.StringReader;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.stp.absm.model.dz.DzDept;
import com.stp.absm.model.XUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

import com.stp.absm.mybatis.MyBatisConfig;

@RestController
public class UserController extends RootController {

    @Autowired
    protected PasswordEncoder passwordEncoder;


    /**
     * 사용자 등록 form
     * @param userId
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/user/form", method = RequestMethod.GET)
    public ModelAndView form(
            @RequestParam(value = "userId", required = false) String userId,
            ModelAndView mav, WebRequest request
    ) {
        Map<String, Object> comboParams = new HashMap<String, Object>();

        if( userId != null ){

            XUser user = xUserRepository.findOne(userId);

            mav.addObject("member", user);
        }
        List<DzDept> dzDepts            = kamsRecordMapper.selectTbDeptsGrpByDeptCd(comboParams);

        mav.addObject("dzDepts", dzDepts);

        mav.setViewName("user/user_form");

        return mav;
    }

    @RequestMapping(value = "/user/form_pre", method = RequestMethod.GET)
    public ModelAndView form_pre(
            @RequestParam(value = "userId", required = false) String userId,
            ModelAndView mav, WebRequest request
    ) {
        Map<String, Object> comboParams = new HashMap<String, Object>();

        List<DzDept> dzDepts            = kamsRecordMapper.selectTbDeptsGrpByDeptCd(comboParams);

        mav.addObject("dzDepts", dzDepts);

        mav.setViewName("user/user_form_1");

        return mav;
    }

    /**
     * 사용자 등록
     * @param userId
     * @param email
     * @param password
     * @param name
     * @param request
     * @return
     */
    @Transactional
    @RequestMapping(value = "/user/form", method = RequestMethod.POST)
    public XUser save(
            @RequestParam(value = "userId", required = false) String userId,
            @RequestParam(value = "empNo", required = true) String empNo,
            @RequestParam(value = "password", required = true) String password,
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "deptCd", required = true) String deptCd,
            @RequestParam(value = "adminType", required = true) String adminType,
            @RequestParam(value = "phone", required = false) String phone,
            @RequestParam(value = "profileImageUrl", required = true) String profileImageUrl,
            @RequestParam(value = "status", required = false) String status,
            WebRequest request
    ) throws IllegalBlockSizeException, InvalidAlgorithmParameterException, NoSuchAlgorithmException, IOException, BadPaddingException, NoSuchPaddingException, InvalidKeyException {
        XUser user = null;

        // 사용자 수정
        if( StringUtils.isEmpty(userId) == false ){

            user = xUserRepository.findOne(userId);
            user.setEmpNo(empNo);
            //user.setPassword(passwordEncoder.encode(password));
            user.setName(name);
            user.setEmail(email);
            user.setDeptCd(deptCd);
            user.setAdminType(adminType);
            user.setPhone(phone);
            user.setProfileImageUrl(profileImageUrl);
            user.setUpdateDate(new Date());

            if(StringUtils.isEmpty(password) == false)
            {
                System.out.println("password : [" + password + "]");
                user.setPassword(passwordEncoder.encode(password));
            }

            xUserRepository.save(user);

        // 사용자 등록
        }else{

            user = new XUser();
            user.setEmpNo(empNo);
            user.setPassword(passwordEncoder.encode(password));
            user.setName(name);
            user.setEmail(email);
            user.setDeptCd(deptCd);
            user.setAdminType(adminType);
            user.setPhone(phone);
            user.setProfileImageUrl(profileImageUrl);
            user.setRegDate(new Date());
            XUser userResult = xUserRepository.save(user);

        }

        return user;
    }

    @Transactional
    @RequestMapping(value = "/user/form_pw", method = RequestMethod.POST)
    public XUser save_pw(
            @RequestParam(value = "userId", required = false) String userId,
            @RequestParam(value = "password", required = true) String password,
            WebRequest request
    ) throws IllegalBlockSizeException, InvalidAlgorithmParameterException, NoSuchAlgorithmException, IOException, BadPaddingException, NoSuchPaddingException, InvalidKeyException {
        XUser user = null;

        // 사용자 수정
        if( StringUtils.isEmpty(userId) == false ){

            user = xUserRepository.findOne(userId);
            user.setUpdateDate(new Date());

            if(StringUtils.isEmpty(password) == false)
            {
                System.out.println("password : [" + password + "]");
                user.setPassword(passwordEncoder.encode(password));
            }

            xUserRepository.save(user);


        }

        return user;
    }
    /**
     * 사용자 삭제
     * @param userIds
     * @param request
     * @return
     */
    @RequestMapping(value = "/user", method = RequestMethod.DELETE)
    public Map<String, Object> delete(
            @RequestParam(value = "userIds", required = true) String userIds,
            WebRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();

        String[] users = userIds.split(",");

        for(String userId : users){

            XUser user = xUserRepository.findOne(userId);
            user.setDeleteDate(new Date());
            xUserRepository.save(user);
        }

        return result;
    }

    /**
     * 사용자 리스트 조회
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/user/list", method = RequestMethod.GET)
    public ModelAndView list(
            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {
        mav.setViewName("user/user_list");
        Sort sortObj = new Sort(Sort.Direction.DESC, "regDate");
        mav.addObject("order", sortObj.iterator().next());

        return mav;
    }


    /**
     * 사용자 리스트 div 조회
     * @param userType
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/user/list_div", method = RequestMethod.GET)
    public ModelAndView listDiv(
            @RequestParam(value = "userType", required = false) String userType,
            @RequestParam(value = "regStDt", required = false) String regStDt,
            @RequestParam(value = "regNdDt", required = false) String regNdDt,
            @RequestParam(value = "keyword", required = false) String keyword,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("regStDt"   , (regStDt != null) ? regStDt.replaceAll("-", "") : null);
        params.put("regNdDt"   , (regNdDt != null) ? regNdDt.replaceAll("-", "") : null);

        if(org.springframework.util.StringUtils.isEmpty(keyword) == false ){

            params.put("keyword"        , MyBatisConfig.aes.encryptString(keyword));
        }

        params.put("userType"    , userType);
        params.put("pageable"   , pageable);

        int count = xUserMapper.selectUsersCount(params);

        List<XUser> users = xUserMapper.selectUsers(params);

        String paging = pagingUtil.getPagingLink((int)Math.ceil((double)count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
        //String paging = pagingUtil.getPagingLink((count / pagingUtil.getPageSize())+1, count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        mav.addObject("users"   , users);
        mav.addObject("paging", paging);

        mav.setViewName("user/user_list_div");

        return mav;
    }


    /**
     * 탈퇴사용자 리스트 조회
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/user/out/list", method = RequestMethod.GET)
    public ModelAndView outList(
            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {
        mav.setViewName("user/user_out_list");
        Sort sortObj = new Sort(Sort.Direction.DESC, "regDate");
        mav.addObject("order", sortObj.iterator().next());

        return mav;
    }


    /**
     * 사용자 리스트 div 조회
     * @param userType
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/user/out/list_div", method = RequestMethod.GET)
    public ModelAndView outListDiv(
            @RequestParam(value = "userType", required = false) String userType,
            @RequestParam(value = "outStDt", required = false) String outStDt,
            @RequestParam(value = "outNdDt", required = false) String outNdDt,
            @RequestParam(value = "keyword", required = false) String keyword,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("outStDt"    , (outStDt != null) ? outStDt.replaceAll("-", "") : null);
        params.put("outNdDt"    , (outNdDt != null) ? outNdDt.replaceAll("-", "") : null);
        params.put("keyword"    , keyword);
        params.put("pageable"   , pageable);

        int count = xUserMapper.selectOutUsersCount(params);

        List<XUser> users = xUserMapper.selectOutUsers(params);

        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);
        //String paging = pagingUtil.getPagingLink((count / pagingUtil.getPageSize())+1, count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        mav.addObject("users", users);
        mav.addObject("paging", paging);

        mav.setViewName("user/user_out_list_div");

        return mav;
    }


    @RequestMapping(value = "/testpdf", method = RequestMethod.GET)
    public void outListDiv(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException, DocumentException {
        // Document 생성
        Document document = new Document(PageSize.A4, 50, 50, 50, 50); // 용지 및 여백 설정

// PdfWriter 생성
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("/Users/bridge/Documents/develop/intellij-workspace/wicrowd-java/test2.pdf")); // 바로 다운로드.
        //PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
        writer.setInitialLeading(12.5f);

        // 파일 다운로드 설정
        response.setContentType("application/pdf");
        String fileName = URLEncoder.encode("한글파일명", "UTF-8"); // 파일명이 한글일 땐 인코딩 필요
        response.setHeader("Content-Transper-Encoding", "binary");
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".pdf");

        // Document 오픈
        document.open();
        XMLWorkerHelper helper = XMLWorkerHelper.getInstance();

        // CSS
        CSSResolver cssResolver = new StyleAttrCSSResolver();
        CssFile cssFile = helper.getCSS(new FileInputStream("/Users/bridge/Documents/develop/intellij-workspace/wicrowd-java/test.css"));
        cssResolver.addCss(cssFile);

        // HTML, 폰트 설정
        XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
        fontProvider.register("/Users/bridge/Documents/develop/intellij-workspace/wicrowd-java/MALGUN.TTF", "MalgunGothic"); // MalgunGothic은 alias,
        CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);

        HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
        htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());

        // Pipelines
        PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
        HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
        CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);

        XMLWorker worker = new XMLWorker(css, true);
        XMLParser xmlParser = new XMLParser(worker, Charset.forName("UTF-8"));

        // 폰트 설정에서 별칭으로 줬던 "MalgunGothic"을 html 안에 폰트로 지정한다.
        String htmlStr = "<html><head><body style='font-family: MalgunGothic;'>"
                + "<p>PDF 안에 들어갈 내용입니다.</p>"
                + "<h3>한글, English, 漢字.</h3>"
                + "</body></head></html>";

        StringReader strReader = new StringReader(htmlStr);
        xmlParser.parse(strReader);

        document.close();
        writer.close();
    }


}
