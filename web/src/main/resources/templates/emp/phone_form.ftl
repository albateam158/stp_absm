<@layout.extends name="layout/base_1.ftl">
    <@layout.put block="head">
    <style type="text/css">

    </style>
    </@layout.put>
    <@layout.put block="contents">
    <!-- START JUMBOTRON -->
    <div class="jumbotron" data-pages="parallax">
        <div class="container-fixed-lg">
            <div class="row">
                <!-- START BREADCRUMB -->
                <ul class="breadcrumb">
                    <li><a>Home</a></li>
                    <li><a>사내연락망</a></li>
                    <li><a class="active">전화번호부</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>전화번호부</h3>
                            <p>전화번호부 상세 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->

    <!-- START CONTAINER FLUID -->
    <div class="container-fluid container-fixed-lg bg-white p-t-30 p-b-10">
        <!-- START PANEL -->


        <form class="chkData" role="form" autocomplete="off" id="frm" enctype="multipart/form-data" method="post">
            <input type="hidden" id="user_id" name="userId" value="${(member.userId)!}" />
            <input type="hidden" id="profileImage" name="profileImageUrl" value="${(member.profileImageUrl) !}" />

            <div class="panel panel-default">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-5">
                                    <div class="form-group required">
                                        <label>부문</label>
                                        <input type="text" name="sectNm" class="form-control" value="${(member.sectNm)!}" required>
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>본부/팀</label><br/>
                                        <select class="cs-select cs-skin-slide" name="deptCd" data-init-plugin="cs-select" required>
                                            <#list dzDepts as dzDept>
                                                <option value="${dzDept.deptCd}" <#if member?exists  && member.deptCd == dzDept.deptCd>selected</#if> >${dzDept.deptNm}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group required">
                                        <label>사원번호</label>
                                        <input type="text" name="empCd" class="form-control" value="${(member.empCd)!}" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>직위</label>
                                        <input type="text" name="hclsNm" id="hclsNm" class="form-control" value="${(member.hclsNm)!}" >
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group required">
                                        <label>성명</label>
                                        <input type="text" name="korNm" class="form-control" value="${(member.korNm)!}" required>
                                    </div>
                                </div>
                                <div class="col-sm-5">
                                    <div class="form-group">
                                        <label>이메일(ID)</label>
                                        <input type="email" name="emalAdd" class="form-control" value="${(member.emalAdd)!}" <#if (member)?exists>readonly</#if> >
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-5">
                                    <div class="form-group">
                                        <label>전화번호</label>
                                        <input type="text" name="tel" id="tel" class="form-control" value="${(member.tel)!}" >
                                    </div>
                                </div>
                                <div class="col-sm-5">
                                    <div class="form-group">
                                        <label>휴대번호</label>
                                        <input type="text" name="hp" id="hp" class="form-control" value="${(member.hp)!}" >
                                    </div>
                                </div>
                                <div class="col-sm-10">
                                    <div class="form-group">
                                        <label>비고</label>
                                        <input type="text" name="hrspNm" id="hrspNm" class="form-control" value="${(member.hrspNm)!}" >
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label>사진</label>
                            <img alt="" src="/getByteImage1/${(member.empCd)!}" style="margin-bottom: 13px;min-height: 185px;max-height: 300px;" />
                            <#--<div id="profile_image_div" style="background-image: url("/getByteImage1/${(member.empCd)!}");background-size: contain;background-repeat: no-repeat;margin-bottom: 13px;min-height: 185px;">-->
                            <#--</div>-->
                            <#--<input type="file" id="profile_image" class="form-control" style="width: 50%;" >-->
                        </div>
                    </div>
                </div>
            </div>

            <#--<table id="emp_list" class="table basic table-striped dataTable">-->
                <#--<thead>-->
                <#--<tr>-->
                    <#--<th class="sort" sort="name" style="width:10%">입사일</th>-->
                    <#--<th class="sort" sort="name" style="width:10%">퇴사일</th>-->
                    <#--<th class="sort" sort="name" style="width:15%">근무기간</th>-->
                    <#--<th style="width:25%">근무회사</th>-->
                    <#--<th style="width:20%">부서/팀</th>-->
                    <#--<th style="width:10%">직책/직급</th>-->
                    <#--<th style="width:10%">퇴직사유</th>-->
                <#--</tr>-->
                <#--</thead>-->
                <#--<tbody>-->
                    <#--<#if dzCrers?has_content>-->
                        <#--<#list dzCrers as dzCrer>-->
                        <#--<tr emp_cd="${dzCrer.empCd !}">-->
                            <#--<#assign joindt = dzCrer.joinDt?datetime("yyyyMMdd")>-->
                            <#--<#assign rtrDt = dzCrer.rtrDt?datetime("yyyyMMdd")>-->
                            <#--<td class="v-align-middle text-center">-->
                                <#--<p class="link">${joindt?string("yyyy-MM-dd") !}</p>-->
                            <#--</td>-->
                            <#--<td class="v-align-middle text-center">-->
                                <#--<p class="link">${rtrDt?string("yyyy-MM-dd") !}</p>-->
                            <#--</td>-->
                            <#--<td class="v-align-middle text-center">-->
                                <#--<p class="link">${dzCrer.dutyDc !}</p>-->
                            <#--</td>-->
                            <#--<td class="v-align-middle text-center">-->
                                <#--<p>${dzCrer.hplcNm !}</p>-->
                            <#--</td>-->
                            <#--<td class="v-align-middle text-center">-->
                                <#--<p>${dzCrer.jbchDc !}</p>-->
                            <#--</td>-->
                            <#--<td class="v-align-middle text-center">-->
                                <#--<p>${dzCrer.hrtNm !}</p>-->
                            <#--</td>-->
                            <#--<td class="v-align-middle text-center">-->
                                <#--<p>${dzCrer.rtrsDc !}</p>-->
                            <#--</td>-->
                        <#--</tr>-->
                        <#--</#list>-->
                    <#--<#else>-->
                    <#--<tr>-->
                        <#--<td colspan="8" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>-->
                    <#--</tr>-->
                    <#--</#if>-->
                <#--</tbody>-->
            <#--</table>-->

            <#--${paging}-->
            <br>
            <div class="tab-content">
                <div class="clearfix m-b-20">
                    <div class="pull-right">
                        <#--<button class="btn btn-info btn-cons pull-right" type="submit">-->
                            <#--<i class="pg-form"></i> <span>Submit</span>-->
                        <#--</button>-->
                        <button class="btn btn-info btn-cons pull-right" type="button" onclick="javascript:location.href='/emp/phoneV'">
                            <i class="pg-form"></i> <span>List</span>
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    </@layout.put>


    <@layout.put block="script">
    <script src="/xeditor/js/xeditor.js"></script>
    <script src="/assets/js/md5.min.js"></script>
    <script type="text/javascript">
        var mainId = 2, subId = 1;
        var userId = '${(member.userId) !}';

        $( document ).ready(function() {
            $("input[name=userType]").click(function(){
                console.log($(this).val());

                $(".tab-pane").hide();
                $("#tab_"+$(this).val()).show();

//                $(".tab-pane").removeClass("active");
//                $("#tab_"+$(this).val()).addClass("active");
            });


            $('#main_image').change(function () {
                var formData = new FormData();
                var mainImageObj = {
                    'fileName': $(this)[0].files[0].name,
                    'fileSize': $(this)[0].files[0].size
                };

                formData.append("file", $(this)[0].files[0]);

                console.log($(this)[0].files[0]);

                var xUpload = new XUpload();
                var uploadResult = xUpload.crossUpload(formData, function (data) {
                    $("#main_image_div").css('background-image',"url("+data.url+")");

                    $('#mainImage').val(data.url);
                });
            });


            $('#profile_image').change(function () {
                var formData = new FormData();
                var mainImageObj = {
                    'fileName': $(this)[0].files[0].name,
                    'fileSize': $(this)[0].files[0].size
                };

                formData.append("file", $(this)[0].files[0]);

                console.log($(this)[0].files[0]);

                var xUpload = new XUpload();
                var uploadResult = xUpload.crossUpload(formData, function (data) {
                    $("#profile_image_div").css('background-image',"url("+data.url+")");

                    $('#profileImage').val(data.url);
                });
            });

            $.validator.setDefaults({
                ignore: []
            });

            $('#frm').validate().settings.ignore = [];


        });
    </script>
    </@layout.put>
</@layout.extends>