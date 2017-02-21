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
                    <li><a href="/">Home</a></li>
                    <li><a href="/project/list">Project</a></li>
                    <li><a class="active">발행인 게재사항</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Project 발행인 게재사항</h3>
                            <p>WiCrowd 프로젝트 발행인 게재사항 등록 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->



    <div class="container-fluid container-fixed-lg">
        <form id="frmData" role="form" autocomplete="off">
            <input type="hidden" name="projectId" value="${(project.projectId) !}">
            <!-- START PANEL -->
            <div class="panel panel-default">
                <div class="panel-heading">

                </div>
                <div class="panel-body no-scroll ">
                    <label>프로젝트 제목</label>
                    <input type="text" name="title" class="form-control" value="${(project.name) !}" disabled required>
                    <br>
                    <label>내용</label>
                    <div class="summernote-wrapper">
                        <div id="summernote" style="min-height: 200px;">${(project.publishNotice) !}</div>
                    </div>
                </div>
            </div>
            <div class="clearfix padding-10">
                <button class="btn btn-primary btn-cons pull-right m-b-10" type="submit">
                    <i class="pg-form"></i>
                    <span class="bold">Submit</span>
                </button>
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
        var mainId = 2, subId = 0;
        var projectId = $('input[name=projectId]').val();


        $( document ).ready(function()
        {
            $('#summernote').summernote({
                onImageUpload : function(files, editor, welEditable) {
                    var formData = new FormData();
                    formData.append("file", files[0]);

                    var xUpload = new XUpload();
                    var uploadResult = xUpload.crossUpload(formData, function (data) {
                        editor.insertImage(welEditable, data.url);
                    });
                },
                oninit : function () {
                    $('.note-editable').css('min-height','300px');

                    $('.note-toolbar').hcSticky({
                        top: 60
                    });
                }
            });

            $('.go-list').click(function () {
                document.location.href = '/project/list';
            });



            $('#frmData').submit(function(){
                var content = $('#summernote').code();

                var formData = new FormData($('#frmData')[0]);
                formData.append("content", content);

                $.ajax({
                    url: '/project/'+projectId+'/board',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    error: function (result) {
                        console.log(result);
                    },
                    success: function (result) {
                        console.log(result);

                        if(result) {
                            NoticeCommon.Dialog.alert('수정 성공하였습니다.');
                        }
                        else {
                            NoticeCommon.Dialog.alert('수정 실패하였습니다.');
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