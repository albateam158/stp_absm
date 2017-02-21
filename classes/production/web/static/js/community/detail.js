/**
 * Created by sj on 16. 3. 4..
 */
$( document ).ready(function() {

    // 상단 메뉴 on
    $('.icon.mn4, .menu li:nth-child(4) a').addClass('on');

    $(document).on('click', '.comment_list .comment_tx a.reply', function(){
        var insertHtml = '';
        var idx = $(this).attr('idx');

        insertHtml += '<li>';
        insertHtml += '<div class="comment_input">';
        insertHtml += '<div class="input_wrap">';
        insertHtml += '<textarea cols="75" rows="4" placeholder="댓글을 남겨주세요."></textarea>';
        insertHtml += '<p class="fr t-c"><input class="btn_type02 btn_submit" idx="'+idx+'" type="submit" value="확인"></p>';
        insertHtml += '</div>';
        insertHtml += '</div>';
        insertHtml += '</li>';

        var insertComment = $(this).parent().parent().next('.reply');
        var chkText = insertComment.find('div');

        if(chkText.hasClass('comment_input')) {
            insertComment.find('div.comment_input').parent().remove();
        } else {
            insertComment.append(insertHtml);
        }
    });

    $(document).on('click', '.comment_input .btn_submit', function(){
        var idx = $(this).attr('idx');
        var url = '', data = '';
        var comment = $(this).parent().prev('textarea');
        var chk = true;

        if(!comment.val()) {
            NoticeCommon.Dialog.alert('등록할 글을 작성해주세요.');
            chk = false;
            return false;
        }
        if(!chk) return false;

        url = '/community/'+communityId+'/comment';
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
                    insertComment += '<div class="fr">';
                    insertComment += '<a class="btn_type02 delete comment" idx="'+data.commentId+'">삭제</a>';
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
                    insertComment += '<a class="btn_type02 delete" idx="'+data.commentId+'">삭제</a>';
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

    $(document).on('click', '.comment_list .comment_tx a.delete', function(){
        var obj = $(this);
        var idx = obj.attr('idx');
        var data = '';

        NoticeCommon.Dialog.confirm({
            title: '알림',
            content: '등록된 댓글을 삭제하시겠습니까?'
            ,ok: function(){
                $.ajax({
                    url : '/community/'+idx+'/comment',
                    type: 'DELETE',
                    dataType:'JSON',
                    async: false,
                    success:function(data)
                    {
                        var parentObj = obj.parent().parent().parent().parent().parent().parent().find('h4 span');
                        var updateCCnt = parseInt(parentObj.text());
                        parentObj.text(updateCCnt-1);

                        obj.parent().parent().parent().parent().remove();
                    }
                });
            }
        });
    });

    //관리자 셋팅 메뉴처리
    $(document).on('click', '.hidden_menu p', function(){
        $(this).next('ul').toggleClass('none');
    });

    $(document).on('click', '.hidden_menu a.delete', function(){

        var obj = $(this);

        NoticeCommon.Dialog.confirm({
            title: '알림',
            content: '등록된 글을 삭제하시겠습니까?'
            ,ok: function(){
                $.ajax({
                    url : '/community/'+communityId,
                    type: 'DELETE',
                    dataType:'JSON',
                    async: false,
                    success:function(data)
                    {
                        location.href = '/community';
                    }
                });
            }
        });
    });

    $(document).on('click', 'button.comment_more', function(){
        var page = parseInt($(this).attr('page'));
        var insertPlace = $(this);

        page++;

        var loading = '<div id="loading" class="loading"><img src="/images/bx_loader.gif" style="width: 32px; height: 32px;" /></div>';
        insertPlace.after(loading);

        $('#loading').show();


        $.ajax({
            url : '/community/'+communityId+'/comment_div?page='+page+'&sort=comment_id,desc&size=5',
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