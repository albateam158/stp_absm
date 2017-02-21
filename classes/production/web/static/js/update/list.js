/**
 * Created by sj on 16. 3. 4..
 */
$( document ).ready(function() {

    $('.all_wrap').addClass('sub');

    // 상단 메뉴 on
    $('.icon.mn3, .menu li:nth-child(3) a').addClass('on');

    var page = 0;
    var hasData = false;
    var iScrollPos = 0;

    $(window).scroll(function()
    {
        if($(window).scrollTop() == $(document).height() - $(window).height())
        {
            if(!hasData) return;

            page++;
            var data = '?page='+page+'&sort=reg_date,desc&size=5';

            $('.loading').show();
            $.ajax({
                url: '/updates/update_div'+data,
                type: 'GET',
                dataType:'html',
                async: false,
                success: function(html)
                {
                    if(html) {
                        setTimeout( function(){
                            $('.loading').hide();
                            $('.tab_cont .cont_list').append(html);
                        },500);
                    } else {
                        $('.loading').hide();
                    }
                }
            });
        }
    });

    $.ajax({
        url: '/updates/update_div?page='+page+'&sort=reg_date,desc&size=5',
        type: 'GET',
        dataType: 'html',
        async: false,
        success: function (result) {
            console.log(result);
            if (result) {
                hasData = true;
                $('.tab_cont > .cont_list').html(result);
            }
        }
    });

    //관리자 셋팅 메뉴처리
    $(document).on('click', '.post_box .top .hidden_menu p', function(){
        $(this).next('ul').toggleClass('none');
    });

    $(document).on('click', '.comment_input .btn_submit', function(){
        var idx = $(this).attr('idx');
        var comment = $(this).parent().parent().find('textarea');
        var updateId = $(this).attr('updateId');
        var userType = $(this).attr('userType');
        var chk = true;

        if(!comment.val()) {
            NoticeCommon.Dialog.alert('등록할 글을 작성해주세요.');
            chk = false;
            return false;
        }
        if(!chk) return false;

        var data = 'content='+encodeURIComponent(comment.val());

        if (idx) {
            data += '&parentCommentId='+idx;
        }

        $.ajax({
            url : '/update/'+updateId+'/comment',
            type: 'POST',
            dataType:'JSON',
            data: data,
            async: false,
            success:function(data)
            {
                var insertComment = '';
                var nowdate = new Date();
                var today = nowdate.getFullYear() + "." + (nowdate.getMonth()+1) + "." + nowdate.getDate();

                if(data.user['profileImageUrl']) {
                    var profile_url = data.user['profileImageUrl'];
                } else {
                    var profile_url = '/images/img-person.jpg';
                }

                if (idx) {
                    insertComment += '<div>';
                    insertComment += '<p class="img profile_thum fl" style="background:url('+profile_url+')"></p>';
                    insertComment += '<div class="comment_tx">';
                    insertComment += '<p>관리자 <span class="date">'+today+'</span></p>';
                    insertComment += '<div class="msg">'+data.content.replace(/\n/g,'<br />')+'</div>';
                    insertComment += '<div class="fr">';
                    insertComment += '<a class="btn_type02 delete comment" data-form="update" user-type="'+userType+'" idx="'+data.commentId+'">삭제</a>';
                    insertComment += '</div>';
                    insertComment += '</div>';
                    insertComment += '</div>';

                    comment.parent().parent().parent().html(insertComment);
                } else {

                    insertComment += '<li>';
                    insertComment += '<div>';
                    insertComment += '<p class="img profile_thum fl" style="background:url('+profile_url+')"></p>';
                    insertComment += '<div class="comment_tx">';
                    insertComment += '<p>'+data.user['name']+' <span class="date">'+today+'</span></p>';
                    insertComment += '<div class="msg">'+data.content.replace(/\n/g,'<br />')+'</div>';
                    insertComment += '<div class="fr">';
                    insertComment += '<a class="btn_type02 delete" data-form="update" user-type="'+userType+'" idx="'+data.commentId+'">삭제</a>';
                    insertComment += '</div>';
                    insertComment += '</div>';
                    insertComment += '<ul class="comment_tx"></ul>';
                    insertComment += '</div>';
                    insertComment += '</li>';

                    comment.val('');

                    var commentCnt = parseInt(comment.parent().parent().parent().find('.comment_list > h4 span').text());
                    comment.parent().parent().parent().find('.comment_list > h4 span').text(commentCnt+1);

                    comment.parent().parent().parent().find('.comment_list > ul').append(insertComment);
                }
            }
        });
    });

    $(document).on('click', '.comment_list .comment_tx a.reply', function(){
        var insertHtml = '';
        var updateId = $(this).attr('updateId');
        var idx = $(this).attr('idx');


        insertHtml += '<li>';
        insertHtml += '<div class="comment_input">';
        insertHtml += '<div class="input_wrap">';
        insertHtml += '<textarea cols="75" rows="4" placeholder="댓글을 남겨주세요."></textarea>';
        insertHtml += '<p class="fr t-c"><input class="btn_type02 btn_submit" usertype="1" data-form="update" updateId="'+updateId+'" idx="'+idx+'" type="submit" value="확인"></p>';
        insertHtml += '</div>';
        insertHtml += '</div>';
        insertHtml += '</li>';

        var insertComment = $(this).parent().parent().parent().find('ul.reply');
        var chkText = insertComment.find('div');

        if(chkText.hasClass('comment_input')) {
            insertComment.find('div.comment_input').parent().remove();
        } else {
            insertComment.append(insertHtml);
        }
    });

    $(document).on('click', '.comment_list .comment_tx a.delete', function(){
        var obj = $(this);
        var idx = obj.attr('idx');
        var data = '', userType = '';

        if(!obj.hasClass('comment')) {
            userType = obj.attr('user-type');
            data = '?userType='+userType;
        }

        NoticeCommon.Dialog.confirm({
            title: '알림',
            content: '등록된 댓글을 삭제하시겠습니까?'
            ,ok: function(){
                $.ajax({
                    url : '/update/'+idx+'/comment' + data,
                    type: 'DELETE',
                    dataType:'JSON',
                    async: false,
                    success:function(data)
                    {
                        if(userType == 1) { //관리자삭제
                            obj.parent().find('.msg').text('관리자에 의해 삭제된 글입니다.');
                            obj.parent().parent().next('ul.reply').html('');
                        } else {
                            var parentObj = obj.parent().parent().parent().parent().parent().parent().find('h4 span');
                            var updateCCnt = parseInt(parentObj.text());
                            parentObj.text(updateCCnt-1);

                            obj.parent().parent().parent().parent().remove();
                        }
                    }
                });
            }
        });
    });

    $(document).on('click', '.post_box .hidden_menu a.delete', function(){

        var obj = $(this);
        var updateId = obj.attr('update_id');
        var projectId = obj.attr('project_id');

        NoticeCommon.Dialog.confirm({
            title: '알림',
            content: '등록된 업데이트글을 삭제하시겠습니까?'
            ,ok: function(){
                $.ajax({
                    url : '/project/'+projectId+'/update?updateId='+updateId,
                    type: 'DELETE',
                    dataType:'JSON',
                    async: false,
                    success:function(data)
                    {
                        location.reload();
                    }
                });
            }
        });
    });

    $(document).on('click', 'button.comment_more', function(){
        var page = parseInt($(this).attr('page'));
        var updateId = $(this).attr('updateId');
        var projectId = $(this).attr('projectId');
        var insertPlace = $(this);

        page++;

        var loading = '<div id="loading" class="loading"><img src="/images/bx_loader.gif" style="width: 32px; height: 32px;" /></div>';
        insertPlace.after(loading);

        $('#loading').show();


        $.ajax({
            url : '/update/'+updateId+'/comment_div?projectId='+projectId+'&page='+page+'&sort=comment_id,desc&size=5',
            type: 'GET',
            dataType:'HTML',
            async: false,
            success:function(html)
            {
                setTimeout(function(){
                    $('#loading').remove();

                    insertPlace.next('ul').prepend(html);
                    insertPlace.attr('page', page);

                    var cmt_len = insertPlace.parent().parent().find('.comment_list > ul > li').length;
                    var cmt_total = insertPlace.parent().parent().find('h4 > span').text();

                    if(cmt_len == cmt_total) {
                        insertPlace.remove();
                    }
                }, 500);
            }
        });
    });
});