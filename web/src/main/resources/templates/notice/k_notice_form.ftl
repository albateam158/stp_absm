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
            <small>글쓰기</small>
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
            <div class="col-md-12">
                <div class="box box-primary">
                    <form id="frmData" role="form" autocomplete="off">
                        <input type="hidden" id="formType" value="<#if notice?exists>update<#else>insert</#if>">
                        <input type="hidden" name="uid" value="${(notice.uid) !}">
                        <input type="hidden" name="fileUid1" value="">
                        <input type="hidden" name="fileUid2" value="">
                        <input type="hidden" name="fileUid3" value="">
                        <input type="hidden" name="fileUid4" value="">
                        <input type="hidden" name="fileUid5" value="">


                        <div class="box-header with-border">
                            <h3 class="box-title">Compose New Message</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <div class="form-group">
                                <input class="form-control" placeholder="Subject:" name="title" value="${(notice.title) !}">
                            </div>
                            <div class="form-group">

                                <div class="summernote-wrapper">
                                    <div id="summernote"><div id="summernote">${(notice.content) !}</div></div>
                                </div>


                            </div>
                            <div class="form-group">
                                <div class="btn btn-default btn-file attachment1"  >
                                    <i class="fa fa-paperclip"></i> Attachment
                                    <input type="file" name="attachment1" class="attachment_file" id="attachment1" >
                                </div>

                                <div class="btn btn-default btn-file attachment2"  >
                                    <i class="fa fa-paperclip"></i> Attachment
                                    <input type="file" name="attachment2" class="attachment_file" id="attachment2" >
                                </div>

                                <div class="btn btn-default btn-file attachment3"  >
                                    <i class="fa fa-paperclip"></i> Attachment
                                    <input type="file" name="attachment3" class="attachment_file" id="attachment3"  >
                                </div>

                                <div class="btn btn-default btn-file attachment4"  >
                                    <i class="fa fa-paperclip"></i> Attachment
                                    <input type="file" name="attachment3" class="attachment_file" id="attachment4"  >
                                </div>

                                <div class="btn btn-default btn-file attachment5"  >
                                    <i class="fa fa-paperclip"></i> Attachment
                                    <input type="file" name="attachment3" class="attachment_file" id="attachment5"  >
                                </div>
                                <p class="help-block">Max. 32MB</p>
                            </div>

                        </div>
                        <!-- /.box-body -->
                        <div class="box-footer">
                            <div class="pull-right">
                                <button type="button" class="btn btn-default"><i class="fa fa-pencil"></i> 임시저장</button>
                                <button type="submit" class="btn btn-primary"><i class="fa fa-envelope-o"></i> 저장</button>
                            </div>
                            <button type="reset" class="btn btn-default"><i class="fa fa-times"></i> 새로고침</button>
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

        $(document).on('change', '#attachment1', function () {
//            var addFileDiv = $('.mailbox-attachments clearfix');
//            var ruleId = $('input[name=ruleId]').val();
            var addFileDiv = $('.btn btn-default btn-file attachment1');
            var fileName = $(this)[0].files[0].name;

            var fileSize = $(this)[0].files[0].size;
            var formData = new FormData();
            formData.append("file", $(this)[0].files[0]);

            var xUpload = new XUpload();
            var uploadResult = xUpload.crossUpload(formData, function (data) {

                data.fileName = fileName;
                data.fileSize = fileSize;

                console.log(data);

                $.ajax({
                    url: '/knotice/upload',
                    type: 'POST',
                    dataType: 'json',
                    data: 'uploadedFile='+JSON.stringify(data),
                    error: function (result) {
                        console.log(result);
                    },
                    success: function (result) {
                        console.log(result);
                        $(addFileDiv).attr('fileId', result.file.uid);
                        $('input[name=fileUid1]').val(result.file.uid);
                        console.log($('input[name=fileUid1]').val());

                    }
                });

            });

        });


//        $(document).on('change', '.attachment_file', function () {
////            var addFileDiv = $('.mailbox-attachments clearfix');
////            var ruleId = $('input[name=ruleId]').val();
//            var addFileDiv = $('.mailbox-attachments clearfix > li');
//            var fileName = $(this)[0].files[0].name;
//
//            var fileSize = $(this)[0].files[0].size;
//            var formData = new FormData();
//            formData.append("file", $(this)[0].files[0]);
//
//            var xUpload = new XUpload();
//            var uploadResult = xUpload.crossUpload(formData, function (data) {
//
//                data.fileName = fileName;
//                data.fileSize = fileSize;
//
//                console.log(data);
//
//                $.ajax({
//                    url: '/knotice/upload',
//                    type: 'POST',
//                    dataType: 'json',
//                    data: 'uploadedFile='+JSON.stringify(data),
//                    error: function (result) {
//                        console.log(result);
//                    },
//                    success: function (result) {
//                        console.log(result);
//
//                        $(addFileDiv).attr('fileId', result.file.uid);
//                        var attach_str = "<li>"
//                                + "<span class='mailbox-attachment-icon'><i class='fa fa-file-pdf-o'></i></span>"
//                                + "<div class='mailbox-attachment-info'>"
//                                + "<a href='#' class='mailbox-attachment-name'><i class='fa fa-paperclip'></i> "+result.file.fileName+"</a>"
//                                + "<span class='mailbox-attachment-size'> "+result.file.fileSize
//                                + "<a href='#' class='btn btn-default btn-xs pull-right'><i class='fa fa-cloud-download'></i></a>"
//                                + "<input type='hidden' name='file' value='"+result.file.uid+"'>"
//                                + "</span></div></li>";
//                        $(".mailbox-attachments clearfix").append(attach_str);
//                    }
//                });
//
//            });

//                if(/\s/g.test(fileName)) {
//                    NoticeCommon.Dialog.alert('띄어쓰기가 있는 파일은 업로드 할 수 없습니다.');
//                    $(this).val('');
//                }
//                else {
//
//                }
//        });


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