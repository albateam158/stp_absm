package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.model.dz.DzEmp;
import com.stp.absm.model.dz.DzDept;

import com.stp.absm.model.dz.DzHhmcrer;
import com.stp.absm.repository.support.Slave;

/**
 * Created by bridge on 15. 12. 29..
 */
@Slave
public interface DzEmpMapper {

    List<DzEmp> selectEmps(Map<String, Object> params);

    DzEmp selectEmp(Map<String, Object> params);

    int selectEmpsCount(Map<String, Object> params);

    List<DzEmp> selectSyncEmp();

//    DzPicture selectPicture1(Map<String, Object> params);

    Map<String, Object> selectPicture(Map<String, Object> params);

    List<DzHhmcrer> selectEmpCrer(Map<String, Object> params);

    List<DzDept> selectDepts(Map<String, Object> params);

    List<DzDept> selectDeptsGrpByDeptCd();

    DzDept selectDept(Map<String, Object> params);

    int selectDeptsCount(Map<String, Object> params);

    List<DzEmp>  selectPhone(Map<String, Object> params);

    int selectPhoneCount(Map<String, Object> params);

}
