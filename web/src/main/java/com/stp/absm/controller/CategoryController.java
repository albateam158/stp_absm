package com.stp.absm.controller;

import com.stp.absm.model.XCategory;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class CategoryController extends RootController{

    /**
     * 카테고리 모달 Div
     * @param categoryId
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/category/form", method = RequestMethod.GET)
    public ModelAndView form(
            @RequestParam(value = "categoryId", required = false) Integer categoryId,
            ModelAndView mav, WebRequest request
    ) {




        mav.setViewName("category/category_form");

        return mav;
    }

    /**
     * 카테고리 저장
     * @param categoryId
     * @param name
     * @param request
     * @return
     */
    @RequestMapping(value = "/category/form", method = RequestMethod.POST)
    public XCategory save(
            @RequestParam(value = "categoryId", required = false) Integer categoryId,
//            @RequestParam(value = "featuredProjectId", required = false) Integer featuredProjectId,
            @RequestParam(value = "type", required = true) String type,
            @RequestParam(value = "name", required = true) String name,
            @RequestParam(value = "categoryImage", required = false) String categoryImage,
            @RequestParam(value = "isCollect", required = false) Boolean isCollect,
            WebRequest request
    ) {
        XCategory category = null;

        if( categoryId != null ){

            category = xCategoryRepository.findOne(categoryId);
//            category.setFeaturedProjectId(featuredProjectId);
            category.setUpdateDate(new Date());
        }else{
            XCategory dbCategory = xCategoryRepository.findTop1ByDeleteDateIsNullAndParentCategoryIdIsNotNullOrderByOrderNoDesc();

            category = new XCategory();
            category.setRegDate(new Date());
            category.setParentCategoryId(0);
            category.setOrderNo(dbCategory.getOrderNo() + 1);
        }
        category.setType(type);
        category.setName(name);
        category.setImageUrl(categoryImage);
        category.setIsCollect("N");
        if(isCollect) {
            category.setIsCollect("Y");
        }


        xCategoryRepository.save(category);

        return category;
    }


    /**
     * 카테고리 삭제
     * @param categoryIds
     * @param request
     * @return
     */
    @RequestMapping(value = "/category", method = RequestMethod.DELETE)
    public Map<String, Object> delete(
            @RequestParam(value = "categoryIds", required = true) String categoryIds,
            WebRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();

        String[] categories = categoryIds.split(",");

        for(String categoryId : categories){

            XCategory category = xCategoryRepository.findOne(Integer.parseInt(categoryId));
            category.setDeleteDate(new Date());
            xCategoryRepository.save(category);
        }

        return result;
    }


    /**
     * 카테고리 조회 List
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/category/list", method = RequestMethod.GET)
    public ModelAndView list(
            ModelAndView mav, WebRequest request
    ) {
        mav.setViewName("category/category_list");


        return mav;
    }


    /**
     * 카테고리 조회 List Div
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/category/list_div", method = RequestMethod.GET)
    public ModelAndView list(
            Pageable pageable,
            ModelAndView mav, WebRequest request
    ) {

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("pageable"   , pageable);

        List<XCategory> categories = xCategoryMapper.selectCategories(params);

        mav.addObject("categories"  , categories);

        mav.setViewName("category/category_list_div");

        return mav;
    }


    /**
     * 카테고리별 프로젝트 리스트
     * @param categoryId
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/category/project_list", method = RequestMethod.GET)
    public ModelAndView listDiv(
            @RequestParam(value = "categoryId", required = true) Integer categoryId,
            @RequestParam(value = "featuredProjectId", required = false) Integer featuredProjectId,
            Pageable pageable,
            ModelAndView mav, HttpServletRequest request
    ) {

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("categorySeq" , categoryId);
        params.put("pageable"   , pageable);


        return mav;
    }
}
