<@layout.extends name="layout/base.ftl">
    <@layout.put block="head">
    <style type="text/css">

    </style>
    </@layout.put>
    <@layout.put block="contents">

    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            공지사항
            <small>상세보기</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">사내 게시판</a></li>
            <li class="active">공지사항</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">

            <!-- /.col -->
            <div class="col-md-9">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">공지사항</h3>

                        <div class="box-tools pull-right">
                            <a href="#" class="btn btn-box-tool" data-toggle="tooltip" title="Previous"><i class="fa fa-chevron-left"></i></a>
                            <a href="#" class="btn btn-box-tool" data-toggle="tooltip" title="Next"><i class="fa fa-chevron-right"></i></a>
                        </div>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body no-padding">
                        <div class="mailbox-read-info">
                            <h3>${(notice.title) !}</h3>
                        </div>
                        <!-- /.mailbox-read-info -->
                        <div class="mailbox-controls with-border text-center">
                            <#--<div class="btn-group">-->
                                <#--<button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" data-container="body" title="Delete">-->
                                    <#--<i class="fa fa-trash-o"></i></button>-->
                                <#--<button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" data-container="body" title="Reply">-->
                                    <#--<i class="fa fa-reply"></i></button>-->
                                <#--<button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" data-container="body" title="Forward">-->
                                    <#--<i class="fa fa-share"></i></button>-->
                            <#--</div>-->
                            <!-- /.btn-group -->
                            <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print">
                                <i class="fa fa-print"></i></button>
                        </div>
                        <!-- /.mailbox-controls -->
                        <div class="mailbox-read-message">
                        ${(notice.content) !}
                        </div>
                        <!-- /.mailbox-read-message -->
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <ul class="mailbox-attachments clearfix">
                            <li>
                                <span class="mailbox-attachment-icon"><i class="fa fa-file-pdf-o"></i></span>

                                <div class="mailbox-attachment-info">
                                    <a href="#" class="mailbox-attachment-name"><i class="fa fa-paperclip"></i> Sep2014-report.pdf</a>
                                    <span class="mailbox-attachment-size">
                          1,245 KB
                          <a href="#" class="btn btn-default btn-xs pull-right"><i class="fa fa-cloud-download"></i></a>
                        </span>
                                </div>
                            </li>
                            <li>
                                <span class="mailbox-attachment-icon"><i class="fa fa-file-word-o"></i></span>

                                <div class="mailbox-attachment-info">
                                    <a href="#" class="mailbox-attachment-name"><i class="fa fa-paperclip"></i> App Description.docx</a>
                                    <span class="mailbox-attachment-size">
                          1,245 KB
                          <a href="#" class="btn btn-default btn-xs pull-right"><i class="fa fa-cloud-download"></i></a>
                        </span>
                                </div>
                            </li>
                            <li>
                                <span class="mailbox-attachment-icon has-img"><img src="../../dist/img/photo1.png" alt="Attachment"></span>

                                <div class="mailbox-attachment-info">
                                    <a href="#" class="mailbox-attachment-name"><i class="fa fa-camera"></i> photo1.png</a>
                                    <span class="mailbox-attachment-size">
                          2.67 MB
                          <a href="#" class="btn btn-default btn-xs pull-right"><i class="fa fa-cloud-download"></i></a>
                        </span>
                                </div>
                            </li>
                            <li>
                                <span class="mailbox-attachment-icon has-img"><img src="../../dist/img/photo2.png" alt="Attachment"></span>

                                <div class="mailbox-attachment-info">
                                    <a href="#" class="mailbox-attachment-name"><i class="fa fa-camera"></i> photo2.png</a>
                                    <span class="mailbox-attachment-size">
                          1.9 MB
                          <a href="#" class="btn btn-default btn-xs pull-right"><i class="fa fa-cloud-download"></i></a>
                        </span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- /.box-footer -->

                    <div class="box-footer">
                        <div class="pull-right">
                            <button type="button" class="btn btn-default go-list"><i class="fa fa-reply"></i>목록</button>
                            <button type="button" class="btn btn-default"><i class="fa fa-pencil"></i> 글수정</button>
                            <button type="button" class="btn btn-primary go-add"><i class="fa fa-envelope-o"></i> 글쓰기</button>
                        </div>
                        <button type="reset" class="btn btn-default"><i class="fa fa-times"></i> 글삭제</button>
                        <button type="button" class="btn btn-default"><i class="fa fa-print"></i> 출력</button>

                    </div>
                    <!-- /.box-footer -->
                </div>
                <!-- /. box -->
            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->
    </section>
    <!-- /.content -->

    </@layout.put>


    <@layout.put block="script">

    <script src="/xeditor/js/xeditor.js"></script>
    <script type="text/javascript">
        var cat = "${kamsBoardSetting.category2List}";
        var cats = cat.split("^");
        var boardId = "${boardId}";
        var mainId = cats[0], subId = cats[1];

        $( document ).ready(function()
        {
//            $('#summernote').summernote({
//                oninit : function () {
//                    $('.note-editable').css('min-height','300px');
//                },
//                onImageUpload : function(files, editor, welEditable) {
//                    var formData = new FormData();
//                    formData.append("file", files[0]);
//
//                    console.log(files[0]);
//
//                    var xUpload = new XUpload();
//                    var uploadResult = xUpload.crossUpload(formData, function (data) {
//                        editor.insertImage(welEditable, data.url);
//                    });
//                }
//            });
            $('.mailbox-read-message').css('min-height','300px');
            $('.go-list').click(function () {
                document.location.href = '/knotice/list/'+boardId;
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
                var uid = $('input[name=uid]').val()
                var title = $('input[name=title]').val()
                var content = $('#summernote').code();
                console.log(content);

                var alert_message = '등록 성공하였습니다.';

                if($('#formType').val() == 'update')
                {
                    alert_message = '수정 성공하였습니다.';
                }

                var formData = new FormData($('#frmData')[0]);
                formData.append("content", content);

                $.ajax({
                    url: '/knotice/form/'+boardId,
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

                        if($('#form_type').val())
                        {
                            alert('수정 성공하였습니다.');
                        }
                        else {
                            alert('등록 성공하였습니다.');
                            location.href = '/knotice/list/'+boardId;
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