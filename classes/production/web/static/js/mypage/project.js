/**
 * Created by sj on 16. 3. 4..
 */
$( document ).ready(function() {

    $('.all_wrap').addClass('sub');

    $('.content_box .step_box h2').click(function(){
        $(this).toggleClass('active');
        $(this).next().toggle();
    });

    var paging = new Paging('#projectListDiv', '#projectList', '/mypage/project_list_div', 'reg_date', 'desc', '', function(){});
    paging.initPaging();

    $(document).on('click', '.btn_type02.print', function(){
        var sbscId = $(this).attr('sbsc_id');

        window.open('/sbsc/'+sbscId+'/print', "fullscreen=no, width=920, height=1200, toolbar=no, menubar=no, scrollbars=no, resizable=yes")
    });

    $(document).on('click', '.crs_cancel', function() {
        var sbscId = $(this).attr('sbsc_id');
        $.ajax({
            url : '/project/working',
            type: 'GET',
            dataType:'JSON',
            async: false,
            success:function(data)
            {
                console.log(data);
                if(data != undefined) {
                    if(data.isWorkingTime) {
                        // set sbscId
                        $('input[name=sbscId]').val(sbscId);

                        // required cancel
                        $('.select_box label, textarea').removeClass('required');
                        $('.essential_text').addClass('none');

                        $('.pop_box').toggleClass('none');
                    }else{
                        NoticeCommon.Dialog.alert({
                            title: '안내',
                            content: '청약취소 가능 시간은 09:00 ~ 17:00 입니다. </br>(중앙기록관리기관 시스템 오픈 시간에 따른 일정입니다 토,일,공휴일제외)'
                        });
                    }
                }
            }
        });
    });

    $(document).on('click', '.btn_leave,.btn_cancel', function() {
        $('.pop_box').toggleClass('none');
    });

    $('.select_box select').change(function(e){
        var val = $(this).parent().find('select :selected').text();
        $(this).parent().find('label').text(val);
        $(this).parent().find('label').removeClass('required');
    });


    $('textarea').keyup(function () {
        $(this).removeClass('required');
    });


    $('.pop_box.cancel_project .btn_submit').click(function() {
        var chk = true;
        var sbscId = $('input[name=sbscId]').val();

        //var crsType = $('select[name=crsType]').val();
        //if(crsType == '0') {
        //    $('.select_box label').addClass('required');
        //    $('.essential_text').text('필수항목을 선택해주셔야 합니다.');
        //    $('.essential_text').removeClass('none');
        //    $('.crs_msg').addClass('none');
        //    chk = false;
        //}

        var crsType = '02';
        var crsReason = $('textarea[name=cancelReason]').val();
        if(!crsReason) {
            $('textarea').addClass('required');
            $('.essential_text').text('필수항목을 입력하셔야 합니다.');
            $('.essential_text').removeClass('none');
            $('.crs_msg').addClass('none');
            chk = false;
        }

        if(chk){
            $.ajax({
                type:'post',
                url: '/mypage/'+sbscId+'/cancel',
                data: 'sbscId='+sbscId+'&cancelCd='+crsType+'&cancelMsg='+crsReason,
                dataType: 'json',
                error: function(data) {
                    console.log(data);
                    $('.pop_box').addClass('none');
                },
                success: function(data) {
                    console.log(data);
                    NoticeCommon.Dialog.complete({
                        content: data.message,
                        ok : function(){
                            location.reload();
                        }
                    });
                }
            });
        }

        return false;
    });


});