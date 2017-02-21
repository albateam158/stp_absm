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
                    <li><a>사용자 관리</a></li>
                    <li><a class="active">사용자 정보</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>User</h3>
                            <p>사용자 페이지 입니다.</p>
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
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>사용자 타입</label>
                                        <div class="radio radio-success">
                                            <input type="radio" name="adminType" value="EMP" id="user_type01" <#if (member.userType)?default('EMP') == "EMP">checked</#if> />
                                            <label for="user_type01">일반</label>
                                            <input type="radio" name="adminType" value="DEPT" id="user_type02" <#if (member.userType)?default('DEPT') == "DEPT">checked</#if> />
                                            <label for="user_type02">부서관리자</label>
                                            <input type="radio" name="adminType" value="HR" id="user_type05" <#if (member.userType)?default('HR') == "HR">checked</#if> />
                                            <label for="user_type05">인사관리자</label>
                                            <input type="radio" name="adminType" value="RECORD" id="user_type03" <#if (member.userType)?default('RECORD') == "RECORD">checked</#if> />
                                            <label for="user_type03">실적관리자</label>
                                            <input type="radio" name="adminType" value="ADMIN" id="user_type04" <#if (member.userType)?default('ADMIN') == "ADMIN">checked</#if> />
                                            <label for="user_type04">시스템관리자</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group required">
                                        <label>사원번호</label>
                                        <input type="text" name="empNo" class="form-control" value="${(member.empNo)!}" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group required">
                                        <label>이름</label>
                                        <input type="text" name="name" class="form-control" value="${(member.name)!}" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>이메일(ID)</label>
                                        <input type="email" name="email" class="form-control" value="${(member.email)!}"  >
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>부서</label><br/>
                                        <select class="cs-select cs-skin-slide" name="deptCd" data-init-plugin="cs-select" required>
                                            <#list dzDepts as dzDept>
                                                <option value="${dzDept.deptCd}" <#if member?exists  && member.deptCd == dzDept.deptCd>selected</#if> >${dzDept.deptNm}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>비밀번호</label>
                                        <input type="password" name="password" id="password" class="form-control" <#if !(member)?exists>required</#if>>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>비밀번호 체크</label>
                                        <input type="password" name="password_re" class="form-control" <#if !(member)?exists>required</#if>>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>전화번호</label>
                                        <input type="number" name="phone" id="phone" class="form-control" value="${(member.phone)!}" >
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <#--<div class="col-sm-6">-->
                        <#--<div class="form-group">-->
                            <#--<label>프로필 사진</label>-->
                            <#--<div id="profile_image_div" style="background-image: url(<#if member?exists && member.profileImageUrl?exists && member.profileImageUrl != "">${member.profileImageUrl}<#else >'/assets/img/gallery/2_1.jpg'</#if>);background-size: contain;background-repeat: no-repeat;margin-bottom: 13px;min-height: 185px;">-->
                            <#--</div>-->
                            <#--<input type="file" id="profile_image" class="form-control" style="width: 50%;" >-->
                        <#--</div>-->
                    <#--</div>-->
                </div>
            </div>

            <div class="tab-content">
                <div class="clearfix m-b-20">
                    <div class="pull-right">
                        <button class="btn btn-info btn-cons pull-right" type="submit">
                            <i class="pg-form"></i> <span>Submit</span>
                        </button>
                        <button class="btn btn-info btn-cons pull-right" type="button" onclick="javascript:location.href='/user/list'">
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
        var mainId = 5, subId = 1;
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

            $('#frm').submit(function(){
                if($('#frm').valid()) {
                    var pwd = $("#password").val();
                    alert(pwd);
                    var pwd_check = $('input[name=password_re]').val();

                    if(pwd != pwd_check) {
                        NoticeCommon.Dialog.alert('비밀번호가 서로 다릅니다.');
                    }
                    else {
                        if(pwd != '') {
                            //$("#password").val(md5(pwd));
                            $("#password").val(pwd);
                        }

                        console.log($(this)[0]);

                        var form_data = new FormData($(this)[0]);

                        $.ajax({
                            type: 'post',
                            url: '/user/form',
                            data: form_data,
                            processData: false,
                            contentType: false,
                            error: function (data) {
                                console.log(data);
                            },
                            success: function (data) {
                                console.log(data);
                                //$('.pop_box').css('display', 'block');

                                NoticeCommon.Dialog.alert('등록되었습니다.');
                            }
                        });
                    }
                }
                else {
                    NoticeCommon.Dialog.alert('모든 항목을 입력바랍니다.');
                }

                return false;
            });
        });
    </script>
    </@layout.put>
</@layout.extends>