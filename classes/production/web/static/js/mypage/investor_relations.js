/**
 * Created by sj on 16. 3. 10..
 */
$( document ).ready(function() {
    $('.all_wrap').addClass('sub');

    $('.relation_box .check_box input[type=radio]').click(function(){
        $('.relation_box.file').show();
    });

    $('#btn_submit').click(function(){
        var data = new FormData($(this)[0]);
        var chk = true;

        var projectId = $('input[type=radio]:checked').val();

        if(!projectId) {
            chk = false;
            NoticeCommon.Dialog.alert('등록할 프로젝트를 선택해주세요.');
            return false;
        } else {
            data.append("projectId", projectId);
        }
        if(!chk) return false;

        $.each($('.upload_hidden:visible'), function (i, v) {
            if($(v)[0].files[0] == undefined) {

                $(this).parent().parent().prev().addClass('required');
               chk = false;

                NoticeCommon.Dialog.alert('연고자 서류 파일을 업로드해주세요.');
                return false;
            }

            data.append("file", v.files[0]);
        });
        if(!chk) return false;

        if(chk) {
            $.ajax({
                type: 'post',
                url: '/mypage/investor_relations',
                data: data,
                processData: false,
                contentType: false,
                error: function (data) {
                    console.log(data);
                },
                success: function (data) {
                    console.log(data);

                    NoticeCommon.Dialog.complete({
                        title: '알림',
                        content: '연고자 신청이 완료되었습니다.'
                        ,ok: function(){
                            location.href = '/mypage/investor';
                        }
                    });
                }
            });
        }
    });
});