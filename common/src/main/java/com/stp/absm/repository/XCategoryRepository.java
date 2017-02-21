package com.stp.absm.repository;

import com.stp.absm.model.XCategory;
import com.stp.absm.repository.support.Master;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by bridge on 15. 12. 24..
 */
@Master
@Resource(name = "MasterMyBatisConfig")
public interface XCategoryRepository extends JpaRepository<XCategory, Integer> {

    List<XCategory> findAllByDeleteDateIsNullAndParentCategoryIdIsNotNull(Sort sortObj);

    List<XCategory> findAllByDeleteDateIsNullAndParentCategoryIdIsNotNullOrderByOrderNo();

    List<XCategory> findAllByDeleteDateIsNullAndParentCategoryIdIsNotNullAndIsCollectOrderByName(String isCollect);

    List<XCategory> findAllByDeleteDateIsNullAndParentCategoryIdIsNotNullAndTypeOrderByName(String type);

    List<XCategory> findAllByDeleteDateIsNullAndParentCategoryIdIsNotNullOrderByName();

    XCategory findByDeleteDateIsNullAndParentCategoryIdIsNotNull(Integer categoryId);

    List<XCategory> findAllByDeleteDateIsNullAndParentCategoryIdIsNotNullOrderByOrderNoAsc();

    XCategory findTop1ByDeleteDateIsNullAndParentCategoryIdIsNotNullOrderByOrderNoDesc();
}
