package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.model.XCategory;
import com.stp.absm.repository.support.Master;

/**
 * Created by bridge on 15. 12. 30..
 */

@Master
public interface KamsCategoryMapper {

    int selectCategoriesCount(Map<String, Object> params);

    List<XCategory> selectCategories(Map<String, Object> params);
}
