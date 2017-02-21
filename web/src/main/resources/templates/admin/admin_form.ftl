<@layout.extends name="layout/base.ftl">
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
                    <li><a>관리자 정보</a></li>
                    <li><a class="active">등록</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>관리자 정보</h3>
                            <p>관리자 정보 등록 페이지 입니다.</p>
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


        <form class="chkData" role="form" autocomplete="off" id="frm" novalidate>
            <input type="hidden" id="adminId" name="adminId" value="${(admin.adminId)!}" />

            <div class="panel panel-default">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>사용자 타입</label>
                                        <div class="radio radio-success">
                                            <input type="radio" name="userType" value="EMP" id="user_type01" <#if (admin.userType)?default('EMP') == "EMP">checked</#if> />
                                            <label for="user_type01">일반</label>
                                            <input type="radio" name="userType" value="DEPT" id="user_type02" <#if (admin.userType)?default('DEPT') == "DEPT">checked</#if> />
                                            <label for="user_type02">부서관리자</label>
                                            <input type="radio" name="userType" value="RECORD" id="user_type03" <#if (admin.userType)?default('RECORD') == "RECORD">checked</#if> />
                                            <label for="user_type03">실적관리자</label>
                                            <input type="radio" name="userType" value="ADMIN" id="user_type04" <#if (admin.userType)?default('ADMIN') == "ADMIN">checked</#if> />
                                            <label for="user_type04">시스템관리자</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group required">
                                        <label>이름</label>
                                        <input type="text" name="name" class="form-control" value="${(admin.name)!}" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>사번</label>
                                        <input type="text" name="empNo" class="form-control" value="${(admin.empNo)!}" <#if (admin)?exists>readonly</#if> required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>부서</label><br/>
                                        <select class="cs-select cs-skin-slide" name="deptCd" data-init-plugin="cs-select" required>
                                            <#list dzDepts as dzDept>
                                                <option value="${dzDept.deptCd}" <#if admin?exists  && admin.deptCd == dzDept.deptCd>selected</#if> >${dzDept.deptNm}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>비밀번호</label>
                                        <input type="password" name="password" id="password" class="form-control" <#if !(admin)?exists>required</#if>>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>비밀번호 체크</label>
                                        <input type="password" name="password_re" class="form-control" <#if !(admin)?exists>required</#if>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--div class="col-sm-6">
                        <div class="form-group">
                            <label>프로필 사진</label>
                            <div id="profile_image_div" style="background-image: url(<#if member?exists && member.profileImageUrl?exists && member.profileImageUrl != "">${member.profileImageUrl}<#else >'/assets/img/gallery/2_1.jpg'</#if>);background-size: contain;background-repeat: no-repeat;margin-bottom: 13px;min-height: 185px;">
                            </div>
                            <input type="file" id="profile_image" class="form-control" style="width: 50%;" >
                        </div>
                    </div-->
                </div>
            </div>

            <div class="tab-content">
                <div class="panel panel-default tab-pane <#if member?exists && member.userType == "investor">active</#if>" id="tab_investor">
                    <div class="panel-body">
                        <#--<div class="row">-->
                            <#--<div class="col-sm-6">-->
                                <#--<div class="form-group">-->
                                    <#--<label>사업자번호(주민등록번호)</label>-->
                                    <#--<input type="text" name="buzno" class="form-control" required>-->
                                <#--</div>-->
                            <#--</div>-->
                            <#--<div class="col-sm-6">-->
                                <#--<div class="form-group">-->
                                    <#--<label>법인번호</label>-->
                                    <#--<input type="text" name="corpno" class="form-control">-->
                                <#--</div>-->
                            <#--</div>-->
                        <#--</div>-->
                        <#--<div class="row">-->
                            <#--<div class="col-sm-6">-->
                                <#--<div class="form-group">-->
                                    <#--<label>증권계좌</label>-->
                                    <#--<input type="text" name="acno" class="form-control" value="${(member.userInvestor.acno)!}" required>-->
                                <#--</div>-->
                            <#--</div>-->
                            <#--<div class="col-sm-6"></div>-->
                        <#--</div>-->
                        <#--<div class="row">-->
                            <#--<div class="col-sm-6">-->
                                <#--<div class="form-group">-->
                                    <#--<label>요청계좌개설번호</label>-->
                                    <#--<input type="text" name="acopno" class="form-control" value="${(member.userInvestor.acopno)!}" required>-->
                                <#--</div>-->
                            <#--</div>-->
                            <#--<div class="col-sm-6">-->
                                <#--<div class="form-group">-->
                                    <#--<label>요청계좌개설일련번호</label>-->
                                    <#--<input type="text" name="acopseq" class="form-control" value="${(member.userInvestor.acopseq)!}" required>-->
                                <#--</div>-->
                            <#--</div>-->
                        <#--</div>-->
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>투자자실명번호</label>
                                    <input type="text" name="realnmno" class="form-control" value="${(member.userInvestor.realnmno)!}" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label>투자자실명번호구분</label>
                                    <div class="radio radio-success">
                                        <input type="radio" name="realnmnoTpcd" value="11" id="realnmno_tpcd01" <#if (member.userInvestor.realnmnoTpcd)?default("11") == "11">checked</#if> />
                                        <label for="realnmno_tpcd01">주민번호</label>
                                        <input type="radio" name="realnmnoTpcd" value="12" id="realnmno_tpcd02" <#if (member.userInvestor.realnmnoTpcd)?default("11") == "12">checked</#if> />
                                        <label for="realnmno_tpcd02">법인등록번호</label>
                                        <input type="radio" name="realnmnoTpcd" value="21" id="realnmno_tpcd03" <#if (member.userInvestor.realnmnoTpcd)?default("11") == "21">checked</#if> />
                                        <label for="realnmno_tpcd03">외국인(여권번호)</label>
                                        <input type="radio" name="realnmnoTpcd" value="22" id="realnmno_tpcd04" <#if (member.userInvestor.realnmnoTpcd)?default("11") == "22">checked</#if> />
                                        <label for="realnmno_tpcd04">외국인(투자등록번호)</label>
                                        <input type="radio" name="realnmnoTpcd" value="23" id="realnmno_tpcd05" <#if (member.userInvestor.realnmnoTpcd)?default("11") == "23">checked</#if> />
                                        <label for="realnmno_tpcd05">외국인(외국인등록증)</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>계좌확인실명번호</label>
                                    <input type="text" name="buzno1" class="form-control" value="${(member.userInvestor.buzno)!}" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>승인여부</label><br/>
                                    <div class="radio radio-success">
                                        <input type="radio" name="status" value="approved" id="status01" <#if (member.userInvestor.status)?default("approved") == "approved">checked</#if> />
                                        <label for="status01">승인</label>
                                        <input type="radio" name="status" value="unapproved" id="status02" <#if (member.userInvestor.status)?default("approved") == "unapproved">checked</#if> />
                                        <label for="status02">미승인</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="panel panel-default tab-pane <#if member?exists && member.userType == "publisher">active</#if>" id="tab_publisher">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label>사업자번호</label>
                                    <input type="text" name="buzno2" class="form-control" value="${(member.userPublisher.buzno)!}" required>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label>법인번호</label>
                                    <input type="text" name="corpno" class="form-control" value="${(member.userPublisher.corpno)!}" required>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label>회사 이름</label>
                                    <input type="text" name="corpName" class="form-control" value="${(member.userPublisher.corpName)!}" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label>홈페이지</label>
                                    <input type="text" name="homepage" class="form-control" value="${(member.userPublisher.homepage)!}" required>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label>이메일</label>
                                    <input type="text" name="corpEmail" class="form-control" value="${(member.userPublisher.email)!}" required>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label>전화번호</label>
                                    <input type="text" name="phone" class="form-control" value="${(member.userPublisher.phone)!}" required>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>로고</label>
                            <div id="main_image_div" style="background-image: url(<#if member?exists && member.userPublisher?exists && member.userPublisher.logoImageUrl?exists>${member.userPublisher.logoImageUrl}<#else >'/assets/img/gallery/2_1.jpg'</#if>);background-size: contain;background-repeat: no-repeat;margin-bottom: 13px;min-height: 285px;">
                            </div>
                            <input type="file" name="logoImageUrl" id="main_image" class="form-control" <#if !member?exists>required<#else><#if member.userPublisher?exists && !member.userPublisher.logoImageUrl?exists>required</#if></#if>>
                        </div>
                        <div class="form-group">
                            <label>설명</label>
                            <textarea name="description" class="form-control" style="min-height:100px;" required>${(member.userPublisher.description) !}</textarea>
                        </div>
                    </div>
                </div>

                <div class="clearfix m-b-20">
                    <div class="pull-right">
                        <button class="btn btn-info btn-cons pull-right" type="submit">
                            <i class="pg-form"></i> <span>Submit</span>
                        </button>
                        <button class="btn btn-info btn-cons pull-right" type="button" onclick="javascript:location.href='/admin/list'">
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
    <script type="text/javascript">
        $( document ).ready(function() {

            var mainId = 1, subId = 1;

            $("input[name=userType]").click(function(){

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

//            $.validator.setDefaults({
//                ignore: []
//            });

//            $('#frm').validate().settings.ignore = [];

            $('#frm').submit(function(){
                if($('#frm').valid()) {
                    var pwd = $("#password").val();
                    var pwd_check = $('input[name=password_re]').val();

                    if(pwd != pwd_check) {
                        NoticeCommon.Dialog.alert('비밀번호가 서로 다릅니다.');
                    }
                    else {
                        if(pwd != '') {
                            $("#password").val(md5(pwd));
                        }
                        alert($(this).serialize());
                        $.ajax({
                            url : '/signup',
                            type : 'post',
                            data : $(this).serialize(),
                            success : function(data) {
                                console.log(data);
                                alert('등록되었습니다.');
                                document.location.href = '/admin/list';
                            },
                            error: function (data) {
                                console.log(data);
                            }
                        });
                    }
                }

                return false;
            });
        });
    </script>
    </@layout.put>
</@layout.extends>