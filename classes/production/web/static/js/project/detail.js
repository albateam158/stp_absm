/**
 * Created by sj on 16. 3. 7..
 */
$( document ).ready(function() {
    $('.cont_feedback, .cont_publisher, .cont_update, .cont_investor').hide();

    $('.all_wrap').addClass('sub');

    // 상단 메뉴 on
    $('.icon.mn1, .menu li:nth-child(1) a').addClass('on');

    // 그래프 초기화
    $('.circleGraphic').circleGraphic({'lineWidth':'10'});

    // 모집 남은시간 카운트
    counter = setInterval(remain, 1000);

    $('.category .ic_deduction span').bind("mouseover",function(){
        $(this).next().removeClass('none');
    });

    $('.category .ic_deduction span').bind("mouseout",function(){
        $(this).next().addClass('none');
    });

    $('.category .ic_deduction span').click(function(){
        $(this).next().toggleClass('none');
    });

    $('.cont_tab.mobile > ul > li > h2').click(function(){
        $(this).toggleClass('active');
        $(this).next('div.sub').toggle();
    });

    var dataForm = undefined;
    var data = '', sort = '', txt = '';
    var page = 0;
    var hasData = false;
    var iScrollPos = 0;

    $(window).scroll(function()
    {
        if($(window).scrollTop() == $(document).height() - $(window).height())
        {
            if(dataForm == undefined) return;
            if(!hasData) return;

            page++;
            if(dataForm == 'update' || dataForm == 'feedback') {
                data = '?page='+page+'&sort=reg_date,desc&size=5';
            } else {
                data = '?page='+page+'&sort=sbsc.reg_date,desc&size=5';
            }

            $('.loading').show();
            $.ajax({
                url: '/project/' + projectId + '/'+ dataForm + '_div'+data,
                type: 'GET',
                dataType:'html',
                async: false,
                success: function(html)
                {
                    if(html) {
                        setTimeout( function(){
                            $('.loading').hide();
                            if(dataForm == 'update') {
                                $('.tab_cont.cont_update .cont_list').append(html);
                            } else if(dataForm == 'feedback') {
                                $('.tab_cont.cont_feedback .comment_list > ul').append(html);
                            } else {
                                $('.tab_cont.cont_investor .comment_list > ul').append(html);
                            }
                        },500);
                    } else {
                        $('.loading').hide();
                    }
                }
            });
        }
    });

    // 하단 텝 클릭
    $('.cont_tab.web > ul > li, .cont_tab.mobile .sub li').click(function () {
        $('.cont_tab > ul > li').removeClass('active');
        $('.cont_bottom').removeClass('feedback');
        dataForm = $(this).attr('data-form');
        hasData = false;
        page = 0;

        $('.cont_tab > ul > li.'+dataForm).addClass('active');

        var innerData = $(this).find('h2').html();

        $('.cont_tab.mobile > ul > li').addClass('active').attr('data-form', dataForm);
        $('.cont_tab.mobile > ul > li > h2').removeClass('active').html(innerData);

        if(!$(this).parent().parent().hasClass('web')) {
            $('.cont_tab.mobile .sub').hide();
        }

        if($('.tab_cont.cont_login').length == 0) {
            $('.tab_cont').hide();
        }

        if(dataForm == 'ir') {
            $('.tab_cont.cont_ir').show();
            $('.tab_cont .contents.ir').removeClass('none');
            $('.tab_cont .contents.publisher').addClass('none');
        }
        else if(dataForm == 'publisher') {
            $('.tab_cont.cont_ir').show();
            $('.tab_cont .contents.publisher').removeClass('none');
            $('.tab_cont .contents.ir').addClass('none');
        }
        else if(dataForm == 'update') {
            $('.tab_cont.cont_update').show();
            data = '?page='+page+'&sort=reg_date,desc&size=5';
            $.ajax({
                url: '/project/' + projectId + '/' + dataForm + '_div'+data,
                type: 'GET',
                dataType: 'html',
                async: false,
                success: function (result) {
                    console.log(result);
                    if (result) {
                        hasData = true;
                        $('.tab_cont.cont_update > .cont_list').html(result);
                    }
                }
            });
        }
        else if(dataForm == 'feedback') {
            $('.cont_bottom').addClass('feedback');
            $('.tab_cont.cont_feedback').show();
            data = '?page='+page+'&sort=reg_date,desc&size=5';
            $.ajax({
                url: '/project/' + projectId + '/feedback_div'+data,
                type: 'GET',
                dataType: 'html',
                async: false,
                success: function (result) {
                    console.log(result);
                    if (result) {
                        hasData = true;
                        $('.tab_cont.cont_feedback .comment_list > ul').html(result);
                    }
                }
            });
        } else {
            $('.tab_cont.cont_investor').show();
            data = '?page='+page+'&sort=sbsc.reg_date,desc&size=5';
            $.ajax({
                url: '/project/' + projectId + '/investor_div'+data,
                type: 'GET',
                dataType: 'html',
                async: false,
                success: function (result) {
                    console.log(result);
                    if (result) {
                        hasData = true;
                        $('.tab_cont.cont_investor .comment_list > ul').html(result);
                    }
                }
            });
        }
    });

    if(tabId) {
        $('.cont_tab li.'+tabId).trigger('click');
    }

    //관리자 셋팅 메뉴처리
    $(document).on('click', '.post_box .top .hidden_menu p', function(){
        $(this).next('ul').toggleClass('none');
    });

    $(document).on('click', '.comment_input .btn_submit', function(){
        var dataType = $(this).attr('data-form');
        var idx = $(this).attr('idx');
        var url = '', data = '';
        var comment = $(this).parent().parent().find('textarea');
        var isSecret = 0;
        var chk = true;

        if(!comment.val()) {
            NoticeCommon.Dialog.alert('등록할 글을 작성해주세요.');
            chk = false;
            return false;
        }
        if(!chk) return false;

        if (idx || dataType == 'update') {
            url = '/'+dataType+'/'+idx+'/comment';
            data = 'content='+encodeURIComponent(comment.val());
            if(dataType == 'update') {
                var updateId = $(this).attr('updateId');
                url = '/'+dataType+'/'+updateId+'/comment';
                if(idx) {
                    data += '&parentCommentId='+idx;
                }
            }
        } else {
            isSecret = $(this).parent().parent().parent().find('input[name^=isSecret]:checked').val();

            if(!isSecret) isSecret = 0;

            url = '/project/' + projectId + '/'+dataType;
            data = 'projectId=' + projectId + '&content='+encodeURIComponent(comment.val())+'&isSecret='+isSecret;
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
                    if(dataType == 'feedback') {
                        insertComment += '<div class="mb15">';
                    } else {
                        insertComment += '<div>';
                    }

                    insertComment += '<p class="img profile_thum fl" style="background:url('+profile_url+')"></p>';
                    insertComment += '<div class="comment_tx">';
                    insertComment += '<p>관리자 <span class="date">'+today+'</span></p>';
                    insertComment += '<div class="msg">'+data.content.replace(/\n/g,'<br />')+'</div>';
                    insertComment += '<div class="fr">';
                    insertComment += '<a class="btn_type02 delete comment" data-form="'+dataType+'" user-type="'+userType+'" idx="'+data.commentId+'">삭제</a>';
                    insertComment += '</div>';
                    insertComment += '</div>';
                    insertComment += '</div>';
 
                    comment.parent().parent().parent().html(insertComment);
                } else {

                    insertComment += '<li>';
                    insertComment += '<div>';
                    insertComment += '<p class="img profile_thum fl" style="background:url('+profile_url+')"></p>';
                    insertComment += '<div class="comment_tx">';
                    insertComment += '<p>'+data.user['name'];

                    if(userInvType == 'investor' && dataType == 'feedback') {
                        if(invSortCd == '01') {
                            insertComment += '<i class="ic_investor1 sm">일반 투자자</i>';
                        } else if(invSortCd == '02') {
                            insertComment += '<i class="ic_investor2 sm">소득전문 투자자</i>';
                        } else {
                            insertComment += '<i class="ic_investor3 sm">전문 투자자</i>';
                        }
                    }
                    insertComment += ' <span class="date">'+today+'</span></p>';

                    insertComment += '<div class="msg">'+data.content.replace(/\n/g,'<br />')+'</div>';
                    insertComment += '<div class="fr">';

                    if(dataType == 'update') {
                        var id = data.commentId;
                    } else {
                        var id = data.feedbackId;
                    }
                    insertComment += '<a class="btn_type02 delete" data-form="'+dataType+'" user-type="'+userType+'" idx="'+id+'">삭제</a>';
                    insertComment += '</div>';
                    insertComment += '</div>';
                    insertComment += '<ul class="reply"></ul>';
                    insertComment += '</div>';
                    insertComment += '</li>';

                    comment.val('');

                    if(dataType == 'update') {
                        var commentCnt = parseInt(comment.parent().parent().parent().find('.comment_list > h4 span').text());
                        comment.parent().parent().parent().find('.comment_list > h4 span').text(commentCnt+1);

                        comment.parent().parent().parent().find('.comment_list > ul').append(insertComment);
                    } else {
                        var feedbackCnt = parseInt($('.feedbackCount').text());
                        $('.feedbackCount').text(feedbackCnt+1);

                        $('.cont_feedback .comment_list > ul').prepend(insertComment);

                    }
                }
            }
        });
    });

    $(document).on('click', '.comment_list .comment_tx a.reply', function(){
        var insertHtml = '', updateId = '';
        var dataType = $(this).attr('data-form');
        var idx = $(this).attr('idx');

        if(dataType == 'update') {
            updateId = 'updateId="'+$(this).attr('updateId')+'"';
        }

        insertHtml += '<li>';
        insertHtml += '<div class="comment_input">';
        insertHtml += '<div class="input_wrap">';
        insertHtml += '<textarea cols="75" rows="4" placeholder="댓글을 남겨주세요."></textarea>';
        insertHtml += '<p class="fr t-c"><input class="btn_type02 btn_submit" data-form="'+dataType+'" '+updateId+' idx="'+idx+'" type="submit" value="확인"></p>';
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
        var dataType = obj.attr('data-form');
        var idx = obj.attr('idx');
        var url = '', data = '', userType = '';
        var msg = '등록된 피드백을 삭제하시겠습니까?';

        if(obj.hasClass('comment')) {
            url = '/'+dataType+'/'+idx+'/comment'
            if(dataType == 'update') {
                msg = '등록된 댓글을 삭제하시겠습니까?';
            }
        } else {
            userType = obj.attr('user-type');
            if(dataType == 'update') {
                url = '/'+dataType+'/'+idx+'/comment?'
                data = 'userType='+userType;
                msg = '등록된 댓글을 삭제하시겠습니까?';
            } else {
                url = '/project/'+projectId+'/'+dataType+'?';
                data = dataType+'Id='+idx+'&userType='+userType;
            }
        }

        NoticeCommon.Dialog.confirm({
            title: '알림',
            content: msg
            ,ok: function(){
                $.ajax({
                    url : url+data,
                    type: 'DELETE',
                    dataType:'JSON',
                    async: false,
                    success:function(data)
                    {
                        if(userType && userType == 1) { //관리자삭제
                            obj.parent().find('.msg').text('관리자에 의해 삭제된 글입니다.');
                            obj.parent().parent().next('ul.reply').html('');
                        } else {
                            if(dataType == 'update' && userType == 2) {
                                var parentObj = obj.parent().parent().parent().parent().parent().parent().find('h4 span');
                                var updateCCnt = parseInt(parentObj.text());
                                parentObj.text(updateCCnt-1);
                            } else {
                                var feedbackCnt = parseInt($('.feedbackCount').text());
                                $('.feedbackCount').text(feedbackCnt-1);

                                if(userInvType == 'investor') {
                                    if(invSortCd == '01') {
                                        var invCount1 = parseInt($('.noti_box li:nth-child(1) span').text());
                                        $('.noti_box li:nth-child(1) span').text(invCount1-1);
                                    } else if(invSortCd == '02') {
                                        var invCount2 = parseInt($('.noti_box li:nth-child(2) span').text());
                                        $('.noti_box li:nth-child(2) span').text(invCount2-1);
                                    } else {
                                        var invCount3 = parseInt($('.noti_box li:nth-child(3) span').text());
                                        $('.noti_box li:nth-child(3) span').text(invCount3-1);
                                    }
                                }
                            }

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
                        //obj.parent().parent().parent().parent().parent().next().remove();
                        //obj.parent().parent().parent().parent().parent().remove();
                        location.reload();
                    }
                });
            }
        });
    });

    $(document).on('click', 'button.comment_more', function(){
        var page = parseInt($(this).attr('page'));
        var updateId = $(this).attr('updateId');
        var insertPlace = $(this);

        page++;

        var loading = '<div id="loading" class="loading"><img src="/images/bx_loader.gif" style="width: 32px; height: 32px;" /></div>';
        insertPlace.after(loading);

        $('#loading').show();


        $.ajax({
            url : '/unlisted/update/'+updateId+'/comment_div?projectId='+projectId+'&page='+page+'&sort=comment_id,desc&size=5',
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

    $('.sns').click(function(){
        var type = $(this).parent().attr("sns_type");
        var u = 'https://wicrowd.co.kr/project/'+projectId;
        var t = $('.sns_box').attr('title');

        if(type == "fb") {
            FB.ui({
                method: 'share',
                href: u,
            }, function(response){});
            //var sns_url = 'http://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(u)+"&t="+encodeURIComponent(t)+"&i="+encodeURIComponent(i);
            //var popup = window.open(sns_url, "facebook", "toolbar=0, status=0, width=700, height=450");
        } else if(type == "tw") {
            var sns_url = 'http://twitter.com/share?text='+encodeURIComponent(t)+"&url="+ encodeURIComponent(u);
            var popup = window.open(sns_url, "twitter", "toolbar=0, status=0, width=700, height=450");
        } else {
            var sns_url = 'http://www.linkedin.com/shareArticle?mini=true&title='+encodeURIComponent(t)+"&url="+ encodeURIComponent(u);
            var popup = window.open(sns_url, "LinkedIn", "toolbar=0, status=0, width=700, height=450");
        }
    });


    $('#go_sbsc').click(function () {
        if(status == 'unapproved') {
            NoticeCommon.Dialog.alert({
                title: '경고',
                content: '아직 투자자전환 인증이 되지 않았습니다.'
            });
        }
        else {
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
                            document.location.href = '/sbsc/'+projectId+'/form';
                        }
                        else {
                            NoticeCommon.Dialog.alert({
                                title: '안내',
                                content: '투자가능 시간은 09:00 ~ 17:00 입니다. </br>(중앙기록관리기관 시스템 오픈 시간에 따른 일정입니다 토,일,공휴일제외)'
                            });
                        }
                    }
                }
            });
        }
    });
});



function remain(){
    var now = new Date();
    if(successState == 'ready') {
        var gap = Math.round((time1 - now.getTime()) / 1000);
    } else {
        var gap = Math.round((time2 - now.getTime()) / 1000);
    }

    if(gap < 0) {
        clearInterval(counter);
        $('.clock_txt').text('0일 0시간 0분 0초');

        return;
    }

    var D = Math.floor(gap / 86400);
    var H = Math.floor((gap - D * 86400) / 3600 % 3600);
    var M = Math.floor((gap - H * 3600) / 60 % 60);
    var S = Math.floor((gap - M * 60) % 60);

    if(successState == 'ready') {
        $('.clock_txt').text('D-' + D + '일');
    } else {
        $('.clock_txt').text(D + '일 ' + H + '시간 ' + M + '분 ' + S + '초');
    }
}














function showAddr(){
    NoticeCommon.Dialog.alert({
        title: '경고',
        content: '투자를 하시려면 주소를 입력하셔야 합니다.',
        ok: function(){
            location.href = "/mypage/profile";
        }
    });
}

function showUnapprove(){

    NoticeCommon.Dialog.alert({
        title: '경고',
        content: '아직 투자자전환 인증이 되지 않았습니다.'

    });
}
window.fbAsyncInit = function() {
    FB.init({
        appId      : fbAppId, //858343284260732
        xfbml      : true,
        version    : 'v2.5'
    });
};

(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/ko_KR/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
