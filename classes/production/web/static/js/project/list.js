/**
 * Created by sj on 16. 3. 7..
 */
var paging_project = null;

$( document ).ready(function() {
    // call project list div
    paging_project = new morePaging('.thum_wrap.project.sub_index', '.thum_wrap.project.sub_index', '/projects/div', 'regDate', 'desc', 0, 100, false, function(){});

    paging_project.initPaging();

    // 상단 메뉴 on
    $('.icon.mn1, .menu li:nth-child(1) a').addClass('on');

    //배너 숫자
    var dataPrice = $('#crowdTotal').attr('data-price');
    $('#crowdTotal').animateNumber(
        {
            number: dataPrice,
            'font-size': '45px',
            numberStep: function(now, tween) {
                var floored_number = Math.floor(now), target = $(tween.elem);
                floored_number = floored_number.toString();
                floored_number = floored_number.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");

                target.text('크라우드 펀딩 금액: ' + floored_number + '원');
            }
            //numberStep: comma_separator_number_step
        },
        4000
    );


    $('.graph').each(function (i, v) {
        $('.circleGraphic'+(i+1)).circleGraphic();
    });

    $('input.ui-autocomplete-input').attr('readonly', 'readonly');
    $('#singleFieldTags').tagit({
        readOnly: true,
        singleField: true,
        singleFieldNode: $('#mySingleField')
    });

    $('.search_keys h2').click(function(){
        if($(this).find('i').hasClass('up')) {
            $(this).find('i').removeClass('up').removeClass('ic_arrow_w').addClass('ic_arrow');
            $(this).removeClass('active');
            $(this).next().addClass('none');
        } else {
            $('.search_keys h2').removeClass('active');
            $('.search_keys h2 i').removeClass('up').removeClass('ic_arrow_w').addClass('ic_arrow');
            $('.search_keys .sub').addClass('none');

            $(this).find('i').addClass('up').removeClass('ic_arrow').addClass('ic_arrow_w');
            $(this).addClass('active');
            $(this).next().removeClass('none');
        }
    });

    $('.search_keys input[type=checkbox]').click(function(){
        var checkboxType = $(this).attr('name');

        if($(this).is(':checked')) {
            var val = $('#mySingleField').val();

            if(val) val+= ",";
            val += $(this).val();

            var innerHtml = '<li class="tagit-choice ui-widget-content ui-state-default ui-corner-all tagit-choice-editable" id="tagit-'+$(this).val()+'" tag_id="'+$(this).val()+'" checkboxType="'+checkboxType+'" data="'+$(this).attr('data')+'">';
            innerHtml += '<span class="tagit-label">'+$(this).val()+'</span>';
            innerHtml += '<a class="tagit-close">';
            innerHtml += '<span class="text-icon del_tag_btn">×</span>';
            innerHtml += '<span class="ui-icon ui-icon-close"></span>';
            innerHtml += '</a>';
            innerHtml += '</li>';

            $("#singleFieldTags li.tagit-new").before(innerHtml);
            $('#mySingleField').val(val);

            $('.btn_search.clear').removeClass('none');
            $('.tags_txt').addClass('none');


            // add project data
            var dataInput = $('#'+checkboxType).val();
            if(dataInput) {
                dataInput+= ",";
            }
            dataInput += $(this).attr('data');
            $('#'+checkboxType).val(dataInput);

            call_project(false);
        } else {
            var tag_id = $(this).val();
            del_tagit(tag_id);


            // sub category ids
            var dataInput = $('#'+checkboxType).val();
            var dataInputArray = dataInput.split(',');

            dataInputArray.splice( $.inArray($(this).attr('data'), dataInputArray), 1 );

            dataInput = dataInputArray.join(',');
            $('#'+checkboxType).val(dataInput);

            call_project(false);
        }
    });

    $('.btn_search.clear').click(function(){
        var tag_len = $('li.tagit-choice').length;
        for(var i=0; i<tag_len;i++) {
            var tag_id = $('li.tagit-choice').eq(i).attr('tag_id');
            del_tagit(tag_id);
            $('.search_keys input[type=checkbox][value='+tag_id+']').attr('checked', false);

            $('#category_id').val('');
            $('#secn_tpcd').val('');
            $('#success_state').val('');
            $('#publisher_stage').val('');
            call_project(true);
        }

        $('.btn_search.clear').addClass('none');
        $('.tags_txt').removeClass('none');
    });

    $(document).on("click", ".del_tag_btn", function(){
        var tag_id = $(this).parent().parent().attr('tag_id');
        del_tagit(tag_id);
        $('.search_keys input[type=checkbox][value='+tag_id+']').attr('checked', false);

        var dataInput = $('#'+$(this).parent().parent().attr('checkboxType')).val();
        var dataInputArray = dataInput.split(',');

        dataInputArray.splice( $.inArray($(this).parent().parent().attr('data'), dataInputArray), 1 );

        dataInput = dataInputArray.join(',');
        $('#'+$(this).parent().parent().attr('checkboxType')).val(dataInput);

        call_project(false);
    });
});

function call_project(isInit) {

    var urlData = '';

    if(!isInit) {
        var categoryIds = $('#category_id').val();
        urlData += '?categorySeq='+categoryIds;

        var secnTpcd = $('#secn_tpcd').val();
        urlData += '&secnTpcd='+secnTpcd;

        var successState = $('#success_state').val();
        urlData += '&successState='+successState;

        var publisherStage = $('#publisher_stage').val();
        urlData += '&publisherStage='+publisherStage;
    }

    paging_project.url = '/projects/div'+urlData;
    paging_project.loadDiv();
}


function del_tagit(id) {
    var obj_id = $('#tagit-'+id);

    console.log(obj_id.find('.tagit-label').text().trim());
    var m_tag_lebel = obj_id.find('.tagit-label').text().trim();
    $("#singleFieldTags").tagit("removeTagByLabel", m_tag_lebel);

    var val = $('#mySingleField').val();
    if(!val) {
        $('.btn_search.clear').addClass('none');
        $('.tags_txt').removeClass('none');
    }

    return;
}



function remain(){
    var now = new Date();
    var gap = Math.round((time2 - now.getTime()) / 1000);

    if(gap < 0) {
        clearInterval(counter);
        $('.icon.clock').text('0일 0시간 0분 0초');

        return;
    }

    var D = Math.floor(gap / 86400);
    var H = Math.floor((gap - D * 86400) / 3600 % 3600);
    var M = Math.floor((gap - H * 3600) / 60 % 60);
    var S = Math.floor((gap - M * 60) % 60);

    $('.icon.clock').text(D + '일 ' + H + '시간 ' + M + '분 ' + S + '초');
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
        appId      : '1865799810313126', //858343284260732
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
