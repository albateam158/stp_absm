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
                    <li><a>FaQ</a></li>
                    <li><a class="active">Add</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>FaQ</h3>
                            <p>WiCrowd FaQ 등록 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->



    <div class="container-fluid container-fixed-lg">
        <form id="frmData" role="form" autocomplete="off">
            <input type="hidden" name="faqSeq" value="${(faq.faqSeq) !}">
            <!-- START PANEL -->
            <div class="panel panel-default">
                <div class="panel-heading">

                </div>
                <div class="panel-body no-scroll ">
                    <label>질문유형</label><br>
                    <select name="faqType" class="cs-select cs-skin-slide" data-init-plugin="cs-select">
                        <option value="invest" <#if faq?exists && faq.faqType == "investor">selected</#if>>투자자</option>
                        <option value="publisher" <#if faq?exists && faq.faqType == "publisher">selected</#if>>발행기업</option>
                    </select>
                    <br><br>
                    <label>질문</label>
                    <input type="text" name="question" class="form-control" value="${(faq.question) !}" required>
                    <br>
                    <label>답변</label>
                    <div class="summernote-wrapper">
                        <div id="summernote" style="min-height: 200px;">${(faq.answer) !}</div>
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
    <script type="text/javascript">
        var mainId = 6, subId = 4;


        $( document ).ready(function()
        {
            $('#summernote').summernote({
                onImageUpload : function(files, editor, welEditable) {
                    var formData = new FormData();
                    formData.append("file", files[0]);

                    console.log(files[0]);

                    var xUpload = new XUpload();
                    var uploadResult = xUpload.crossUpload(formData, function (data) {
                        editor.insertImage(welEditable, data.url);
                    });
                },
                oninit : function () {
                    $('.note-editable').css('min-height','300px');
                }
            });


            $('.go-list').click(function () {
                document.location.href = '/faq/list';
            });


            $('#frmData').submit(function(){
                var faqSeq = $('input[name=faqSeq]').val();
                var answer = $('#summernote').code();

                var alert_message = '등록 성공하였습니다.';

                if(faqSeq) {
                    alert_message = '수정 성공하였습니다.';
                }

                var formData = new FormData($('#frmData')[0]);
                formData.append("answer", answer);


                $.ajax({
                    url: '/faq/form',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    error: function (result) {
                        console.log(result);
                    },
                    success: function (result) {
                        console.log(result);

                        if(faqSeq)
                        {
                            alert('수정 성공하였습니다.');
                        }
                        else {
                            alert('등록 성공하였습니다.');
                            location.href = '/faq/list';
                        }
                    }
                });
                return false;
            });
        });
    </script>
    </@layout.put>
</@layout.extends>