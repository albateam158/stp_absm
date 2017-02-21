package com.stp.absm.repository;

import com.stp.absm.model.XFile;
import com.stp.absm.repository.support.Master;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by bridge on 16. 1. 23..
 */
@Master
public interface XFileRepository extends JpaRepository<XFile, Integer> {
}
