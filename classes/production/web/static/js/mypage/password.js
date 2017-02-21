/**
 * Created by sj on 16. 3. 10..
 */
$( document ).ready(function() {

    $('.all_wrap').addClass('sub');

    $('.content_box .step_box h2').click(function(){
        $(this).toggleClass('active');
        $(this).next().toggle();
    });

    $("#btn_submit").click(function() {

        if($("#old_password").val().trim() == '') {
            NoticeCommon.Dialog.alert("현재 비밀번호를 정확하게 입력하셔야 합니다.");
            $("#old_password").parent().parent().prev('div').find('h3').addClass('required');
            $("#old_password").focus();
            return;
        }

        if($("#new_password").val().trim() == '') {
            NoticeCommon.Dialog.alert("신규 비밀번호를 정확하게 입력하셔야 합니다.");
            $("#new_password").parent().parent().prev('div').find('h3').addClass('required');
            $("#new_password").focus();
            return;
        }

        if($("#new_password2").val().trim() == '') {
            NoticeCommon.Dialog.alert("신규 비밀번호 재입력을 정확하게 입력하셔야 합니다.");
            $("#new_password2").parent().parent().prev('div').find('h3').addClass('required');
            $("#new_password2").focus();
            return;
        }

        if($("#new_password2").val() != $("#new_password").val()) {
            NoticeCommon.Dialog.alert("신규 비밀번호가 서로 다릅니다. 확인해 주시기 바랍니다.");
            $("#new_password").parent().parent().prev('div').find('h3').addClass('required');
            $("#new_password").focus();
            return;
        }

        if(!checkPwd($("#new_password").val())) {
            $("#new_password").focus();
            return;
        }

        $("#new_password").val($.md5($("#new_password").val()));
        $("#new_password2").val($.md5($("#new_password2").val()));
        $("#old_password").val($.md5($("#old_password").val()));

        $.ajax({

            url:'/updatePassword',
            type:'post',
            data:$('#frmData').serialize(),
            success:function(data){
                if(data.success) {
                    NoticeCommon.Dialog.complete(
                        {
                            content: "비밀번호 변경이 완료되었습니다",
                            ok: function () {
                                window.location.reload();
                            }
                        }
                    );
                }
                else {
                    NoticeCommon.Dialog.alert(data.message);
                }
            }

        });
    });
});