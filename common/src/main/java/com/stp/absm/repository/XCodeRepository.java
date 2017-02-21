package com.stp.absm.repository;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.XCode;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by bridge on 15. 12. 24..
 */
@Master
public interface XCodeRepository extends JpaRepository<XCode, Integer> {
    List<XCode> findAllByCodeGroupAndDeleteDateIsNull(String pir);
    List<XCode> findAllByCodeGroupAndDeleteDateIsNullOrderByOrderNoDesc(String pir);

    XCode findAllByCodeAndCodeGroupAndDeleteDateIsNull(String code, String codeGroup);

    List<XCode> findAllByCodeGroupAndDeleteDateIsNullOrderByOrderNoAsc(String tpc);
}
