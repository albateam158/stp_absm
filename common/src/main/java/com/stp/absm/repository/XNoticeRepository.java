package com.stp.absm.repository;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.XNotice;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by bridge on 15. 12. 24..
 */
@Master
public interface XNoticeRepository extends JpaRepository<XNotice, Integer> {
    Integer countByTitleLikeAndDeleteDateIsNull(String keyword);

    List<XNotice> findByTitleLikeAndDeleteDateIsNull(String keyword);
}
