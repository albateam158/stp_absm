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
                    <li><a>Holiday</a></li>
                    <li><a class="active">Add</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Holiday</h3>
                            <p>WiCrowd 공지사항 등록 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->



    <div class="container-fluid container-fixed-lg">
        <form id="frmData" role="form" autocomplete="off">
            <input type="hidden" id="formType" value="<#if holiday?exists>update<#else>insert</#if>">
            <input type="hidden" name="holidayId" value="${(holiday.holidayId) !}">
            <!-- START PANEL -->
            <div class="panel panel-default">
                <div class="panel-heading">

                </div>
                <div class="panel-body no-scroll ">
                    <label>제목</label>
                    <input type="text" name="title" class="form-control" value="${(holiday.title) !}" required>
                    <br>
                    <label>휴일</label>
                    <div class="datepicker-component input-group date">
                        <input type="text" name="holidayDate" class="form-control" value="${(project.holidayDate) !}" data-format="yyyymmdd" required>
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
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
        var mainId = 8, subId = 1;
        $( document ).ready(function()
        {

            $('.go-list').click(function () {
                document.location.href = '/holidays';
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
                var holidayId = $('input[name=holidayId]').val()
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
                    url: '/holiday/form',
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

                        if(result.duplication) {
                            NoticeCommon.Dialog.alert("이미 등록되어있는 휴일입니다.");
                        }
                        else {
                            if($('#form_type').val())
                            {
                                NoticeCommon.Dialog.alert({
                                    content: '수정 성공하였습니다.',
                                    ok: function(){
                                        location.href = '/holidays';
                                    }
                                });
                            }
                            else {
                                NoticeCommon.Dialog.alert({
                                    content: '등록 성공하였습니다.',
                                    ok: function(){
                                        location.href = '/holidays';
                                    }
                                });

                            }
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