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
                    <li><a>투자 신청</a></li>
                    <li><a class="active">Add</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>투자 신청</h3>
                            <p>WiCrowd 투자 신청 수정 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->

    <div class="container-fluid container-fixed-lg">
        <!-- START PANEL -->
        <div class="panel panel-transparent">
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-12">

                        <form id="form-work" class="form-horizontal" role="form" autocomplete="off">
                            <div class="form-group">
                                <label for="fname" class="col-sm-3 control-label">회사 이름</label>
                                <div class="col-sm-9">
                                    <p>${(publisherRequest.corpName) !}</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fname" class="col-sm-3 control-label">위치</label>
                                <div class="col-sm-9">
                                    <p>${(publisherRequest.location) !}</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fname" class="col-sm-3 control-label">매니저 이름</label>
                                <div class="col-sm-9">
                                    <p>${(publisherRequest.managerName) !}</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fname" class="col-sm-3 control-label">매니저 전화번호</label>
                                <div class="col-sm-9">
                                    <p>${(publisherRequest.managerPhone) !}</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fname" class="col-sm-3 control-label">매니저 이메일</label>
                                <div class="col-sm-9">
                                    <p>${(publisherRequest.managerEmail) !}</p>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="fname" class="col-sm-3 control-label">회사 소개서</label>
                                <div class="col-sm-9">
                                    <p>${(publisherRequest.fileId1.filename) !} <a href="/file/${(publisherRequest.fileId1.fileId) !}">[다운받기]</a></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fname" class="col-sm-3 control-label">사업 계획서</label>
                                <div class="col-sm-9">
                                    <p>${(publisherRequest.fileId2.filename) !} <a href="/file/${(publisherRequest.fileId2.fileId) !}">[다운받기]</a></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fname" class="col-sm-3 control-label">직전 회계연도 또는 분기 재무 제표</label>
                                <div class="col-sm-9">
                                    <p>${(publisherRequest.fileId3.filename) !} <a href="/file/${(publisherRequest.fileId3.fileId) !}">[다운받기]</a></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fname" class="col-sm-3 control-label">제품 설명서</label>
                                <div class="col-sm-9">
                                    <#if publisherRequest.fileId4?exists >
                                    <p>${(publisherRequest.fileId4.filename) !} <a href="/file/${(publisherRequest.fileId4.fileId) !}">[다운받기]</a></p>
                                    </#if>
                                </div>
                            </div>


                            <div class="clearfix padding-20">
                                <button class="btn btn-primary btn-cons pull-right m-b-10 go-list" type="button">
                                    <i class="pg-form"></i>
                                    <span class="bold">List</span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- END PANEL -->
    </div>
    <!-- END CONTAINER FLUID -->

    </@layout.put>


    <@layout.put block="script">

    <script src="/assets/plugins/boostrap-form-wizard/js/jquery.bootstrap.wizard.min.js" type="text/javascript"></script>
    <script src="/assets/js/form_wizard.js" type="text/javascript"></script>
    <script src="/assets/plugins/dropzone/dropzone.js" type="text/javascript"></script>
    <script src="/xeditor/js/xeditor.js"></script>
    <script type="text/javascript">
        var mainId = 4, subId = 0;


        $( document ).ready(function()
        {
            $('#summernote').summernote({
                height: 500,
                onImageUpload : function(files, editor, welEditable) {
                    var formData = new FormData();
                    formData.append("file", files[0]);

                    console.log(files[0]);

                    var xUpload = new XUpload();
                    var uploadResult = xUpload.crossUpload(formData, function (data) {
                        editor.insertImage(welEditable, data.url);
                    });
                }
            });

            //$("#summernote").summernote("insertHTML", '${(news.content) !}');

            //$("#summernote").insertHTML('${(news.content) !}');
            $('#summernote').code('${(news.content) !}');

            $('.go-list').click(function () {
                document.location.href = '/request/list';
            });







            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                var target = $(e.target).attr("href") // activated tab
                var url = $(e.target).attr("url") // activated tab

                $(target).load(url, function(responseTxt, statusTxt, xhr){

                    if(statusTxt == "success") {

                        //alert("Error: " + xhr.status + ": " + xhr.statusText);

                    }

                    if(statusTxt == "error")
                        alert("Error: " + xhr.status + ": " + xhr.statusText);
                });
            });




            $('#main_image').change(function () {
                var formData = new FormData();
                var mainImageObj = {
                    'fileName': $(this)[0].files[0].name,
                    'fileSize': $(this)[0].files[0].size
                };

                formData.append("file", $(this)[0].files[0]);

                var xUpload = new XUpload();
                var uploadResult = xUpload.crossUpload(formData, function (data) {
                    $("#main_image_div").css('background-image',"url("+data.url+")");

                    mainImageObj.url = data.url;
                    mainImageObj.width = data.width;
                    mainImageObj.height = data.height;

                    $('#mainImage').val(JSON.stringify(mainImageObj));
                });
            });


            $('#frmData').submit(function(){
                var newsId = $('input[name=newsId]').val()
                var title = $('input[name=title]').val()
                var content = $('#summernote').code();
                console.log(content);

                var alert_message = '등록 성공하였습니다.';

                if($('#formType').val() == 'update')
                {
                    alert_message = '수정 성공하였습니다.';
                }

                $.ajax({
                    url: '/news/form',
                    type: 'POST',
                    dataType: 'json',
                    data: 'newsId='+newsId+'&title='+title+'&content='+content,
                    error: function (result) {
                        console.log(result);
                    },
                    success: function (result) {
                        console.log(result);

                        if($('#form_type').val())
                        {
                            alert('수정 성공하였습니다.');
                        }
                        else {
                            alert('등록 성공하였습니다.');
                            location.href = '/news/list';
                        }
                    }
                });
                return false;
            });


        });

        function setStringToNumber(val, sel) {
            return val.replace(/,/gi, '');
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                    results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

    </script>
    </@layout.put>
</@layout.extends>