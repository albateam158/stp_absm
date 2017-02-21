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
                    <li><a>QnA</a></li>
                    <li><a class="active">Answer</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>QnA</h3>
                            <p>WiCrowd 1:1문의 답변 등록 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->



    <div class="container-fluid container-fixed-lg">
        <form id="frmData" role="form" autocomplete="off">
            <input type="hidden" name="qnaId" value="${(qna.qnaId) !}">
            <!-- START PANEL -->
            <div class="panel panel-default">
                <div class="panel-heading">

                </div>
                <div class="panel-body no-scroll ">
                    <label>유형</label>
                    <input type="text" name="title" class="form-control" value="${(qna.codeName) !}" disabled required>
                    <br>
                    <label>작성자</label>
                    <input type="text" name="title" class="form-control" value="${(qna.userName) !}" disabled required>
                    <br>
                    <label>이메일</label>
                    <input type="text" name="title" class="form-control" value="${(qna.email) !}" disabled required>
                    <br>
                    <label>전화번호</label>
                    <input type="text" name="title" class="form-control" value="${(qna.phone) !}" disabled required>
                    <br>
                    <label>제목</label>
                    <input type="text" name="title" class="form-control" value="${(qna.title) !}" disabled required>
                    <br>
                    <label>내용</label>
                    <textarea class="form-control" rows="5" disabled>${(qna.content) !}</textarea>
                    <br/>
                    <label>답변</label>
                    <textarea class="form-control" name="answer" rows="5">${(qna.answer) !}</textarea>
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
        var mainId = 6, subId = 3;


        $( document ).ready(function()
        {
            $('.go-list').click(function () {
                document.location.href = '/qna/list';
            });



            $('#frmData').submit(function(){
                var formData = new FormData($('#frmData')[0]);

                if($('textarea[name=answer]').val() == '') {
                    NoticeCommon.Dialog.alert('답변을 입력해주세요.');
                }
                else {
                    $.ajax({
                        url: '/qna/form',
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        error: function (result) {
                            console.log(result);
                        },
                        success: function (result) {
                            console.log(result);

                            NoticeCommon.Dialog.alert('답변 등록 성공하였습니다.');
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