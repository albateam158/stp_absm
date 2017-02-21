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
                    <li><a>Mail</a></li>
                    <li><a class="active">Add</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Mail</h3>
                            <p>WiCrowd 메일 등록 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->



    <div class="container-fluid container-fixed-lg">
        <form id="frmData" role="form" autocomplete="off">
            <input type="hidden" id="formType" value="insert">

            <!-- START PANEL -->
            <div class="panel panel-default">
                <div class="panel-heading">

                </div>
                <div class="panel-body no-scroll ">
                    <label>모집</label><br/>
                    <select class="cs-select cs-skin-slide" name="projectId" data-init-plugin="cs-select" required>
                        <#list projects as project>
                            <option value="${project.projectId}" <#if mail?exists && mail.project.projectId == project.projectId>selected</#if>>${project.name}</option>
                        </#list>
                    </select>
                    <br><br>
                    <label>청약 상태</label><br/>
                    <select class="cs-select cs-skin-slide" name="sbscState" data-init-plugin="cs-select" required>
                        <option value="all" <#if mail?exists && mail.sbscState == "all">selected</#if>>전체</option>
                        <option value="pay_complete" <#if mail?exists && mail.sbscState == "pay_complete">selected</#if>>청약 완료</option>
                        <option value="cancel" <#if mail?exists && mail.sbscState == "cancel">selected</#if>>청약 취소</option>
                    </select>
                    <br><br>
                    <label>제목</label>
                    <input type="text" name="title" class="form-control" value="${(mail.title) !}">
                    <br>
                    <label>내용</label>
                    <div class="summernote-wrapper">
                        <div id="summernote">${(mail.content) !}</div>
                    </div>
                </div>
            </div>
            <div class="clearfix padding-10">
                <#if !mail?exists>
                    <button class="btn btn-primary btn-cons pull-right m-b-10" type="submit">
                        <i class="pg-form"></i>
                        <span class="bold">Submit</span>
                    </button>
                </#if>

                <button class="btn btn-primary btn-cons pull-right m-b-10 go-list" type="button">
                    <i class="pg-form"></i>
                    <span class="bold">List</span>
                </button>
            </div>
            <!-- END PANEL -->
        </form>
    </div>

    </@layout.put>


    <@layout.put block="script">

    <script src="/assets/plugins/boostrap-form-wizard/js/jquery.bootstrap.wizard.min.js" type="text/javascript"></script>
    <script src="/assets/js/form_wizard.js" type="text/javascript"></script>
    <script src="/assets/plugins/dropzone/dropzone.js" type="text/javascript"></script>
    <script src="/xeditor/js/xeditor.js"></script>
    <script type="text/javascript">
        var mainId = 7, subId = 1;
        $( document ).ready(function()
        {
            $('#summernote').summernote({
                oninit : function () {
                    $('.note-editable').css('min-height','300px');
                },
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

            $('.go-list').click(function () {
                document.location.href = '/mails';
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



            $('#frmData').submit(function(){
                var title = $('input[name=title]').val()
                var content = $("#summernote").code().replace(/<\/?[^>]+(>|$)/g, "");

                if(title == '') {
                    NoticeCommon.Dialog.alert('제목을 입력해주세요.');
                }
                else if(content == '') {
                    NoticeCommon.Dialog.alert('내용을 입력해주세요.');
                }
                else {
                    NoticeCommon.Dialog.confirm({
                        content: '이메일 전송 등록시 해당 모집의 사용자에게 이메일이 전송됩니다.주의 부탁드립니다.<br/><br/>이메일을 보내시겠습니까?'
                        ,ok: function(){
                            var formData = new FormData($('#frmData')[0]);
                            formData.append("content", $("#summernote").code());

                            $.ajax({
                                url: '/mail/form',
                                type: 'POST',
                                dataType: 'json',
                                data: formData,
                                processData: false,
                                contentType: false,
                                error: function (result) {
                                    console.log(result);
                                },
                                success: function (result) {
                                    console.log(result);

                                    NoticeCommon.Dialog.alert({
                                        title: '경고',
                                        content: '등록 성공하였습니다.'
                                        ,ok: function(){
                                            location.href = "/mails";
                                        }
                                    });
                                }
                            });
                        }
                    });
                }

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