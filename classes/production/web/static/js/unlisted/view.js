/**
 * Created by sj on 16. 3. 4..
 */
$( document ).ready(function() {
    $('.all_wrap').addClass('sub');

    var data = '', sort = '', txt = '';
    var page = 0;
    var hasData = false;

    $(window).scroll(function()
    {
        if($(window).scrollTop() == $(document).height() - $(window).height())
        {
            if(!hasData) return;

            page++;
            data = '?page='+page+'&sort=reg_date,desc&size=5';

            $('.loading').show();
            $.ajax({
                url: '/unlisted/' + unlistedId + '/update_div'+data,
                type: 'GET',
                dataType:'html',
                async: false,
                success: function(html)
                {
                    if(html) {
                        setTimeout( function(){
                            $('.loading').hide();
                            $('#unlistedUpdateList').append(html);
                        },500);
                    } else {
                        $('.loading').hide();
                    }
                }
            });
        }
    });

    data = '?page='+page+'&sort=reg_date,desc&size=5';
    $.ajax({
        url: '/unlisted/'+unlistedId+'/update_div'+data,
        type: 'GET',
        dataType: 'html',
        async: false,
        success: function (result) {
            console.log(result);
            if (result) {
                hasData = true;
                $('#unlistedUpdateList').html(result);
            }
        }
    });

    //관리자 셋팅 메뉴처리
    $(document).on('click', '.hidden_menu p', function(){
        $(this).next('ul').toggleClass('none');
    });

    //업데이트 글 삭제
    $(document).on('click', '.post_box .hidden_menu a.delete', function(){

        var obj = $(this);
        var updateId = obj.attr('update_id');

        NoticeCommon.Dialog.confirm({
            title: '알림',
            content: '등록된 글을 삭제하시겠습니까?'
            ,ok: function(){
                $.ajax({
                    url : '/unlisted/'+unlistedId+'/update?updateId='+updateId,
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

    //댓글 등록
    $(document).on('click', '.comment_input .btn_submit', function(){
        var idx = $(this).attr('idx');
        var url = '', data = '';
        var comment = $(this).prev('textarea');
        var chk = true;

        if(!comment.val()) {
            NoticeCommon.Dialog.alert('등록할 글을 작성해주세요.');
            chk = false;
            return false;
        }
        if(!chk) return false;

        var updateId = $(this).attr('updateId');
        url = '/unlisted/update/'+updateId+'/comment';
        data = 'content='+encodeURIComponent(comment.val());

        if(idx) {
            data += '&parentCommentId='+idx;
        }

        $.ajax({
            url : url,
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
                    insertComment += '<p>'+data.user['name']+' <span class="date">'+today+'</span></p>';
                    insertComment += '<div class="msg">'+data.content.replace(/\n/g,'<br />')+'</div>';
                    insertComment += '<div class="mt10">';
                    insertComment += '<a class="btn_type02 delete comment" updateId="'+updateId+'" idx="'+data.commentId+'">삭제</a>';
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
                    insertComment += '<div class="mt10">';
                    insertComment += '<a class="btn_type02 delete" updateId="'+updateId+'" idx="'+data.commentId+'">삭제</a>';
                    insertComment += '</div>';
                    insertComment += '</div>';
                    insertComment += '<ul class="comment_tx"></ul>';
                    insertComment += '</div>';
                    insertComment += '</li>';

                    comment.val('');

                    var commentCnt = parseInt(comment.parent().parent().parent().next().find('.comment_list > h4 span').text());
                    comment.parent().parent().parent().next().find('.comment_list > h4 span').text(commentCnt+1);

                    comment.parent().parent().parent().next().find('.comment_list > ul').append(insertComment);
                }
            }
        });
    });

    $(document).on('click', '.comment_list .comment_tx a.delete', function(){
        var obj = $(this);
        var idx = obj.attr('idx');
        var updateId = $(this).attr('updateId');

        NoticeCommon.Dialog.confirm({
            title: '알림',
            content: '등록된 댓글을 삭제하시겠습니까?'
            ,ok: function(){
                $.ajax({
                    url : '/unlisted/update/'+idx+'/comment?updateId='+updateId,
                    type: 'DELETE',
                    dataType:'JSON',
                    async: false,
                    success:function(data)
                    {
                        if(!obj.hasClass('comment')) {
                            var parentObj = obj.parent().parent().parent().parent().parent().prev().find('span');
                            var updateCCnt = parseInt(parentObj.text());
                            parentObj.text(updateCCnt-1);
                        }

                        obj.parent().parent().parent().parent().remove();
                    }
                });
            }
        });
    });

    //댓글 textarea 생성
    $(document).on('click', '.comment_tx a.reply', function(){
        var insertHtml = '';
        var idx = $(this).attr('idx');
        var updateId = $(this).attr('updateId');

        insertHtml += '<li>';
        insertHtml += '<div class="comment_input">';
        insertHtml += '<div class="input_wrap">';
        insertHtml += '<textarea placeholder="댓글을 남겨주세요."></textarea>';
        insertHtml += '<input class="btn_type02 t-c btn_submit" updateId="'+updateId+'" idx="'+idx+'" type="submit" value="게시">';
        insertHtml += '</div>';
        insertHtml += '</div>';
        insertHtml += '</li>';

        var insertComment = $(this).parent().parent().next('ul.reply');
        var chkText = insertComment.find('div');

        if(chkText.hasClass('comment_input')) {
            insertComment.find('div.comment_input').parent().remove();
        } else {
            insertComment.append(insertHtml);
        }
    });

    //댓글 더보기 버튼
    $(document).on('click', 'a.plus.more', function(){
        var page = parseInt($(this).attr('page'));
        var updateId = $(this).attr('updateId');
        var totalPage = $(this).attr('totalPage');
        var insertPlace = $(this);

        page++;

        var loading = '<div id="loading" class="loading"><img src="/images/bx_loader.gif" style="width: 32px; height: 32px;" /></div>';
        insertPlace.parent().after(loading);

        $('#loading').show();

        $.ajax({
            url : '/unlisted/update/'+updateId+'/comment_div?page='+page+'&sort=comment_id,desc&size=5',
            type: 'GET',
            dataType:'HTML',
            async: false,
            success:function(html)
            {
                setTimeout(function(){
                    $('#loading').remove();

                    insertPlace.parent().next('ul').prepend(html);
                    insertPlace.attr('page', page);

                    var cmt_len = insertPlace.parent().next('ul').children('li').length;
                    if(cmt_len == totalPage) {
                        insertPlace.parent().remove();
                    }
                }, 500);
            }
        });
    });
});