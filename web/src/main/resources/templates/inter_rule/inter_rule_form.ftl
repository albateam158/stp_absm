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
                    <li><a>사내 규정</a></li>
                    <li><a class="active">입력</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Internal Regulation</h3>
                            <p>사내 규정 등록 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->

    <!-- START CONTAINER FLUID -->
    <div class="container-fluid container-fixed-lg">
        <div id="rootwizard">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs nav-tabs-linetriangle nav-tabs-separator nav-stack-sm">
                <li class="active">
                    <a data-toggle="tab" href="#tab1"><i class="fa fa-file-text tab-icon"></i> <span>Basic Information</span></a>
                </li>
            </ul>

            <!-- START PANEL -->
            <div class="tab-content">
                <div class="tab-pane padding-20 active slide-left" id="tab1">
                    <form id="frmData" role="form" autocomplete="off">
                        <input type="hidden" name="ruleId" value="${(inRule.ruleId) !}">
                        <input type="hidden" name="docSeq" value="${(inRule.docSeq) !}">

                        <input type="hidden" name="recentFile" id="recentFile" value="${(inRule.recentFile) !}">
                        <input type="hidden" name="beforeFile" id="beforeFile" value="${(inRule.beforeFile) !}">

                        <div class="pull-left">
                            <button class="btn btn-danger btn-cons pull-left delete" style="min-width:100px;">
                                <i class="pg-trash"></i> <span>Delete</span>
                            </button>
                        </div>
                        <div class="clearfix padding-10">
                            <button class="btn btn-primary btn-cons pull-right m-b-10" type="submit">
                                <i class="pg-form"></i>
                                <span class="bold">저장</span>
                            </button>
                            <button class="btn btn-primary btn-cons pull-right m-b-10 go-add" type="button">
                                <i class="pg-form"></i>
                                <span class="bold">새로작성</span>
                            </button>
                            <button class="btn btn-primary btn-cons pull-right m-b-10 go-inq" type="button">
                                <i class="pg-form"></i>
                                <span class="bold">조회</span>
                            </button>
                        </div>

                        <div class="row m-t-10">
                            <div class="col-md-4" style="padding-left:0;">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>구분</label><br/>

                                                    <select name="groupId" id="groupId" class="form-control" style="padding: 2px 2px 2px 9px" required>
                                                    <#--<select class="cs-select cs-skin-slide" name="deptCd" data-init-plugin="cs-select" required>-->
                                                        <#list IRGs as IRG>
                                                            <option value="${IRG.data1}" <#if inRule?exists  && inRule.groupId == IRG.data1>selected</#if> >${IRG.codeName}</option>
                                                        </#list>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>소구분</label><br/>

                                                    <select name="docGroup" id="docGroup" class="form-control" style="padding: 2px 2px 2px 9px" required>
                                                    <#--<select class="cs-select cs-skin-slide" name="deptCd" data-init-plugin="cs-select" required>-->
                                                        <option value="0">-</option>
                                                        <#list RDGs as RDG>
                                                            <option value="${RDG.data1}" <#if inRule?exists  && inRule.docGroup == RDG.data1>selected</#if> >${RDG.codeName}</option>
                                                        </#list>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <label>사규ID</label><br/>
                                                <div>
                                                    <input type="text" id="docId" name="docId" class="form-control" value="${(inRule.docId) !}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <label>사규명</label><br/>
                                                <div>
                                                    <input type="text" id="ruleNm" name="ruleNm" class="form-control" value="${(inRule.ruleNm) !}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>제정일자</label>
                                                <#--<input type="text" name="dt" id="dt" value="${(record.dt) !}" data-format="yyyymmdd" required>-->
                                                    <div class="datepicker-component input-group date">
                                                        <input type="text" name="estDt" id="estDt" class="form-control" value="${(inRule.establishDt) !}" data-format="yyyymmdd" required>
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>최근개정일</label>
                                                <#--<input type="text" name="dt" id="dt" value="${(record.dt) !}" data-format="yyyymmdd" required>-->
                                                    <div class="datepicker-component input-group date">
                                                        <input type="text" name="reformDt" id="reformDt" class="form-control" value="${(inRule.reformDt) !}" data-format="yyyymmdd">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>소관부서(담당)</label><br/>
                                                <div>
                                                    <select name="chargeDept" id="chargeDept" class="form-control" style="padding: 2px 2px 2px 9px">
                                                        <#list dzDepts as dzDept>
                                                            <option value="${dzDept.deptCd}" <#if inRule?exists  && inRule.chargeDept == dzDept.deptCd>selected</#if> >${dzDept.deptNm}</option>
                                                        </#list>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <br/>
                                                <div>
                                                    <input type="text" id="chargeDeptDetail" name="chargeDeptDetail" class="form-control" value="${(inRule.chargeDeptDetail) !}">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-8" style="overflow-y:scroll; height:500px; padding-right:0;">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div id="paging_div" class="table-responsive m-t-30">
                                            <div class="col-sm-12 text-center" style="padding:100px 0;">
                                                <div class="progress-circle-indeterminate"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                    <h5>
                        파일 업로드
                    </h5>
                    <div class="row">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="col-sm-6">
                                    <div id="add_file_list">
                                        <div class="add_file_div recent" fileId="${(inRule.recentFile) !}">
                                            <div class="form-group">
                                                <label style="display: block;">신규파일 이름</label>
                                                <input type="text" name="recent_file_name" class="form-control recent_file_name" value="${(inRule.recentFileName) !}" style="display:inline-block; width: 90%;">
                                                <#--<button class="btn btn-danger btn-cons btn-del-file" style="min-width: 50px; float: right;"><i class="fa fa-close"></i></button>-->
                                            </div>
                                             <div class="form-group">
                                                <input type="file" name="recent_file" class="form-control recent_file" value="${(inRule.recentFileName) !}">
                                            </div>
                                            </div>
                                        </div>
                                        <div class="add_file_div before" fileId="${(inRule.beforeFile) !}">
                                            <div class="form-group">
                                                <label style="display: block;">이전파일 이름</label>
                                                <input type="text" name="before_file_name" class="form-control before_file_name" value="${(inRule.beforeFileName) !}" style="display:inline-block; width: 90%;">
                                                <#--<button class="btn btn-danger btn-cons btn-del-file" style="min-width: 50px; float: right;"><i class="fa fa-close"></i></button>-->
                                            </div>
                                            <div class="form-group">
                                                <input type="file" name="before_file" class="form-control before_file" value="${(inRule.beforeFileName) !}">
                                            </div>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>

    </@layout.put>

    <@layout.put block="script">

    <script src="/assets/plugins/boostrap-form-wizard/js/jquery.bootstrap.wizard.min.js" type="text/javascript"></script>
    <script src="/assets/js/form_wizard.js" type="text/javascript"></script>
    <script src="/assets/plugins/dropzone/dropzone.js" type="text/javascript"></script>
    <script src="/xeditor/js/xeditor.js"></script>
    <script type="text/javascript">
        var mainId = 3, subId = 2;
        var projectId = '${(project.projectId)!}';

        $( document ).ready(function()
        {

//            $('.btn_addfile').click(function () {
//                var innerHtml = '';
//                innerHtml += '<div class="add_file_div">';
//                innerHtml += '<div class="form-group">';
//                innerHtml += '<label style="display: block;">파일 이름</label>';
//                innerHtml += '<input type="text" name="file_name" class="form-control file_name" value="" style="display:inline-block; width: 90%;">';
//                innerHtml += '<button class="btn btn-danger btn-cons btn-del-file" style="min-width: 50px; float: right;"><i class="fa fa-close"></i></button>';
//                innerHtml += '</div>';
//                innerHtml += '<div class="form-group">';
//                innerHtml += '<input type="file" name="files" class="form-control files" value="">';
//                innerHtml += '</div>';
//                innerHtml += '</div>';
//
//                $('#add_file_list').append(innerHtml);
//            });
            var paging = new Paging('#paging_div', '#record_list_table', '/inter_rule/form_list_div', 'docId', 'desc', '#frmData', function(){
            });
//
            paging.initPaging();


            $('#estDt').datepicker({
                format: "yyyy-mm-dd",
                startView: 1,
                todayBtn:"linked",
                language: "kr",
                orientation: "top auto",
                keyboardNavigation: true,
                forceParse: false,
                autoclose: false,
                todayHighlight: true,
                showOn: "both",
                closeText: '닫기'
            });


            $('#reformDt').datepicker({
                format: "yyyy-mm-dd",
                startView: 1,
                todayBtn:"linked",
                language: "kr",
                orientation: "top auto",
                keyboardNavigation: true,
                forceParse: false,
                autoclose: false,
                todayHighlight: true,
                showOn: "both",
                closeText: '닫기'
            });

            $('.go-inq').click(function () {

                paging.params = $('#frmData').serialize();
                paging.url = '/inter_rule/form_list_div?sort='+paging.sortField+','+paging.sortOrder;
                paging.loadDiv();

                return false;
            });
            $('.go-add').click(function () {

                location.href = '/inter_rule/form';

                return false;
            });

            // 삭제 버튼
            $("button.delete").click(function()
            {
                var rule_ids = "";
                var rule_count = 0;

                $("#paging_div tbody .unit").each(function() {
                    if($(this).is(':checked'))
                    {
                        if(rule_count == 0) {
                            rule_ids = $(this).parent().parent().parent().attr('rule_id');
                        } else {
                            rule_ids += ',' + $(this).parent().parent().parent().attr('rule_id');
                        }
                        rule_count++;
                    }
                });

                if(rule_count == 0) {
                    NoticeCommon.Dialog.alert('체크박스를 선택해주세요.');
                    return false;
                } else {
                    NoticeCommon.Dialog.confirm({
                        content: '사규를 삭제하시겠습니까?'
                        ,ok: function(){
                            $.ajax({
                                url: "/inter_rule/form?id="+rule_ids,
                                type: "DELETE",
                                dataType: 'json',
                                success: function (result) {
                                    location.reload();
                                }
                            });
                        }
                    });
                }
            });
            $(document).on('click', '.btn-del-file', function(){
                var fileId = $(this).parent().parent('.add_file_div').attr('fileId');
                var addFileDiv = $(this).parent().parent('.add_file_div');
                if(fileId == undefined) {
                    $(addFileDiv).remove();
                }
                else {
                    NoticeCommon.Dialog.confirm({
                        content: '선택된 파일을 삭제하시겠습니까?'
                        ,ok: function(){
                            $.ajax({
                                url: "/inter_rule/file?fileId="+fileId+"&dropzoneId=dropzone-attached",
                                type: "DELETE",
                                dataType: 'json',
                                data: '',
                                success: function (result) {
                                    //location.reload();
                                    console.log(result);
                                    $(addFileDiv).remove();
                                }
                            });
                        }
                    });
                }
            });

            $('.go-list').click(function () {
                document.location.href = '/inter_rule/list';
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

            $('input.number').keyup(function(event) {

                // skip for arrow keys
                if(event.which >= 37 && event.which <= 40) return;

                // format number
                $(this).val(function(index, value) {
                    return value
                            .replace(/\D/g, "")
                            .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                            ;
                });
            });


            $(document).on('change', '.recent_file', function () {
                var addFileDiv = $(this).parents('.add_file_div recent');
                var ruleId = $('input[name=ruleId]').val();
//                var fileName = $(this).parent().prev().find('.recent_file_name').val();
//                if(fileName == '') {
//                    fileName = $(this)[0].files[0].name;
//                }
                var fileName = $(this)[0].files[0].name;

                var fileSize = $(this)[0].files[0].size;
                var formData = new FormData();
                formData.append("file", $(this)[0].files[0]);

                var xUpload = new XUpload();
                var uploadResult = xUpload.crossUpload(formData, function (data) {
                    var projectId = $('input[name=projectId]').val();
                    var dropzoneId = 'dropzone-attached';

                    data.fileName = fileName;
                    data.fileSize = fileSize;

                    console.log(data);

                    $.ajax({
                        url: '/inter_rule/upload',
                        type: 'POST',
                        dataType: 'json',
                        data: 'uploadedFile='+JSON.stringify(data)+'&projectId='+projectId+'&dropzoneId='+dropzoneId,
                        error: function (result) {
                            console.log(result);
                        },
                        success: function (result) {
                            console.log(result);

                            $(addFileDiv).attr('fileId', result.file.fileId);
                            $('input[name=recentFile]').val(result.file.fileId);
                        }
                    });

                });

//                if(/\s/g.test(fileName)) {
//                    NoticeCommon.Dialog.alert('띄어쓰기가 있는 파일은 업로드 할 수 없습니다.');
//                    $(this).val('');
//                }
//                else {
//
//                }
            });
            $(document).on('change', '.before_file', function () {
                var addFileDiv = $(this).parents('.add_file_div before');
//                var fileName = $(this).parent().prev().find('.before_file_name').val();
//                if(fileName == '') {
//                    fileName = $(this)[0].files[0].name;
//                }
                var fileName = $(this)[0].files[0].name;
                var fileSize = $(this)[0].files[0].size;
                var formData = new FormData();
                formData.append("file", $(this)[0].files[0]);

                var xUpload = new XUpload();
                var uploadResult = xUpload.crossUpload(formData, function (data) {
                    var projectId = $('input[name=projectId]').val();
                    var dropzoneId = 'dropzone-attached';

                    data.fileName = fileName;
                    data.fileSize = fileSize;

                    console.log(data);

                    $.ajax({
                        url: '/inter_rule/upload',
                        type: 'POST',
                        dataType: 'json',
                        data: 'uploadedFile='+JSON.stringify(data)+'&projectId='+projectId+'&dropzoneId='+dropzoneId,
                        error: function (result) {
                            console.log(result);
                        },
                        success: function (result) {
                            console.log(result);

                            $(addFileDiv).attr('fileId', result.file.fileId);
                            $('input[name=beforeFile]').val(result.file.fileId);
                        }
                    });

                });

//                if(/\s/g.test(fileName)) {
//                    NoticeCommon.Dialog.alert('띄어쓰기가 있는 파일은 업로드 할 수 없습니다.');
//                    $(this).val('');
//                }
//                else {
//
//                }
            });

            $('#frmData').submit(function(){
                //var content = save();
                var alert_message = '등록 성공하였습니다.';

                if($('#form_type').val())
                {
                    alert_message = '수정 성공하였습니다.';
                }


                var formData = new FormData($('#frmData')[0]);
                //formData.append("content", $('#summernote').code());

                $.ajax({
                    url: '/inter_rule/form',
                    type: 'POST',
                    dataType: 'json',
                    data: $('#frmData').serialize(),
//                    contentType: false,
                    error: function (result) {
                        console.log(result);
                    },
                    success: function (result) {
                        console.log(result);

                        if($('#form_type').val())
                        {
                            alert('수정 성공하였습니다.');
                            location.reload();
                        }
                        else {
                            alert('등록 성공하였습니다.');
                            location.reload();
                            //location.href = '/inter_rule/form?ruleId='+result.ruleId;
                        }
                    }
                });
                return false;
            });

            $('#formSubmitBtn').click(function () {

                console.log($('#frmData').validate());

                if($('#frmData').validate()) {
                    $('#frmData').trigger('submit');
                }

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

        function deleteSbscInfo() {
            var sbscIssNo = $('input[name=sbscIssNo]').val();
            NoticeCommon.Dialog.confirm({
                content: '청약정보를 삭제하시겠습니까?'
                ,ok: function(){
                    var projectId = $('input[name=projectId]').val();
                    $.ajax({
                        url: "/project/insertSbscInfo",
                        type: "POST",
                        dataType: 'json',
                        data: 'projectId='+projectId+'&sbscIssNo='+sbscIssNo+'&flag=delete',
                        success: function (result) {
                            //location.reload();
                            console.log(result);

                            if(result.success) {
                                NoticeCommon.Dialog.alert('청약정보삭제 성공하였습니다.');

                                $('input[name=sbscIssNo]').val('');
                            }
                            else {
                                NoticeCommon.Dialog.alert(result.message);
                            }
                        }
                    });
                }
            });
        }

        function openFile(fileName, fileUrl) {
            var extension = fileName.substr( (fileName.lastIndexOf('.') +1)).toLowerCase();
            switch(extension) {
                case 'jpg':
                case 'png':
                case 'gif':
                    return fileUrl;
                    break;                         // the alert ended with pdf instead of gif.
                case 'doc':
                case 'docx':
                    return '/assets/img/local/ic_doc.png';
                    break;
                case 'pdf':
                    return '/assets/img/local/ic_pdf.png'
                    break;
                default:
                    return '/assets/img/local/ic_file.png';
            }
        }


    </script>
    </@layout.put>
</@layout.extends>