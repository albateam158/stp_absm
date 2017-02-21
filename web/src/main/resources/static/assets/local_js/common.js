$( document ).ready(function() {
    sideBarOpen(mainId, subId);

    $(document).on('click', '.unit.all', function(){
        if($(this).is(':checked'))
        {
            $('.unit').prop('checked', true);
        }
        else
        {
            $('.unit').prop('checked', false);
        }
    });

    // $('form.chkData').validate();

    //Date Pickers
    $('.datepicker-component').datepicker({
        format: $('.datepicker-component').find('input').attr('data-format')
    });
});

function sideBarOpen(mainId, subId){
    // $('#sidebar-menu .menu-items > li:nth-child('+mainId+')').addClass('active open');
    // $('#sidebar-menu .menu-items > li:nth-child('+mainId+') > .icon-thumbnail').addClass('bg-success');
    // $('#sidebar-menu .menu-items > li:nth-child('+mainId+') .arrow').addClass('active open');
    // $('#sidebar-menu .menu-items > li:nth-child('+mainId+') > ul > li:nth-child('+subId+')').addClass('active');
    $('#sidebar-menu > li:nth-child('+mainId+')').addClass('active');
    $('#sidebar-menu > li:nth-child('+mainId+') > ul > li:nth-child('+subId+')').addClass('active');
}


$.ajaxSetup({
    global: true,
    beforeSend: function(xhr) {
        $('.loading.wrap').removeClass('none');
        xhr.setRequestHeader("AJAX", true);
    },
    complete: function(jqXHR, textStatus) {
        $('.loading.wrap').addClass('none');
    }
});

$( document ).ajaxError(function( event, jqxhr, settings, thrownError ) {
    if( jqxhr.status == 0 ) return;

    if (jqxhr.status == 401 ||jqxhr.status == 403 ) {
        NoticeCommon.Dialog.alert({
            title: '경고',
            content: '세션이 만료가 되었습니다. 로그인 페이지로 이동합니다.'
            ,ok: function(){
                location.href = "/logout";
            }
        });

    } else if(jqxhr.status == 400){

        var msg = '요청 파라미터 검증 오류입니다.';

        if( jqxhr.responseJSON.message ){

            msg = jqxhr.responseJSON.message;
        }
        NoticeCommon.Dialog.alert({
            title: '경고',
            content: msg
        });
    } else {

        NoticeCommon.Dialog.alert({
            title: '경고',
            content: '서버 오류가 발생하였습니다. 관리자에게 문의하여 주십시오.'
        });

    }
});

var NoticeCommon = {};
NoticeCommon.Dialog = {
    /**
     * Dialog Id
     */
    DialogInfo: {
        titleId: 'common-modal-title',
        okBtnId: 'common-modal-ok-btn',
    },

    /**
     * Default Item Message
     */
    Message: {
        title: '알림',
        ok: '확인',
        cancel: '취소'
    },

    /**
     * Element 생성
     *
     * @param elementTag Element Tag
     * @param attributeData Set Attribute Object
     * @param appendElement AppendChild Element Object
     * @return Element Object
     */
    createElement: function(elementTag, attributeData, appendElement){
        // Element 생성
        var elementObj = document.createElement(elementTag);
        // Attrbute 추가
        for(var key in attributeData){
            //console.log(key, attrbutes[key]);
            elementObj.setAttribute(key, attributeData[key]);
        };
        // Element Append
        if(appendElement){
            appendElement.appendChild(elementObj);
        }

        return elementObj;
    },

    /**
     * Modal Dialog Make
     */
    makeModalDialog: function(data){
        // UUID 생성
        var uuid;
        if(typeof(Util) === 'object' && typeof(Util.uuid) === 'function'){
            uuid = Util.uuid();
        }else{
            uuid = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
                var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
                return v.toString(16);
            });
        }

        // Dialog Id
        data.dialogId = 'common-modal-dialog-' + data.dialogType + '-' + uuid;

        /***************************************************************************/
        // ---------------- Modal Main Div ----------------
        var modalDiv = this.createElement('div'
            , {'id': data.dialogId,'class': 'modal fade slide-up disable-scroll','tabindex': '-1','role': 'dialog','aria-labelledby': this.DialogInfo.titleId,'aria-hidden': 'true'}
            , document.body);
        var modalDialogDiv = this.createElement('div', {'class': 'modal-dialog modal-sm'}, modalDiv);
        var modalContentWrapperDiv = this.createElement('div', {'class': 'modal-content-wrapper'}, modalDialogDiv);
        var modalContentDiv = this.createElement('div', {'class': 'modal-content'}, modalContentWrapperDiv);

        // ---------------- Modal Header ----------------
        // var modalHeaderDiv = this.createElement('div', {'class': 'modal-header'}, modalContentDiv);

        // Close Header
        // if(data.closeBtn){
        //     var modalHeaderCloseBtn = this.createElement('button', {'type': 'button', 'class': 'close', 'data-dismiss': 'modal', 'aria-hidden': 'true'}, modalHeaderDiv);
        //     modalHeaderCloseBtn.innerHTML ='x';
        // }

        // title
        // var modalHeaderTitle = this.createElement('h4', {'class': 'modal-title', 'id': this.DialogInfo.titleId}, modalHeaderDiv);
        // modalHeaderTitle.innerHTML = data.title ? data.title : this.Message.title;

        // ---------------- Modal Body ----------------
        var modalBodyDiv = this.createElement('div', {'class': 'modal-body text-center m-t-20', 'style': 'word-break: break-all'}, modalContentDiv);;
        modalBodyDiv.innerHTML = data.content ? data.content : '';

        // ---------------- Modal Footer ----------------
        var modalFooterDiv = this.createElement('div', {'class': 'modal-footer text-center'}, modalContentDiv);
        // Cancle Button
        if(data.dialogType == 'confirm'){
            var modalFooterCancleBtn = this.createElement('button', {'type': 'button', 'class': 'btn btn-default btn-cons pull-left inline', 'data-dismiss': 'modal'}, modalFooterDiv);
            modalFooterCancleBtn.innerHTML = this.Message.cancel;
        }
        // Ok Button
        var modalFooterOkAttr = {'type': 'button', 'class': 'btn btn-primary btn-cons no-margin inline', 'id': this.DialogInfo.okBtnId};
        if(data.dialogType == 'alert'){
            modalFooterOkAttr['data-dismiss'] = 'modal';
        }
        var modalFooterOkBtn = this.createElement('button', modalFooterOkAttr, modalFooterDiv);
        modalFooterOkBtn.innerHTML = this.Message.ok;
        /***************************************************************************/
        // Modal Default option Setting
        var modalOption = {
            keyboard: false // ESC 키 눌렀을때 모달을 닫음
            ,backdrop: 'static' // 모달의 배경을 포함. 클릭 시 모달을 닫지 않을 시 'static'
            ,show: false // 초기화 시 모달을 보여줍니다.
        }
        // 사용자 지정 정보 설정
        $.extend(modalOption, data);

        // Jquery Dialog 변수 선언
        var dialog = $('#' + data.dialogId);

        // Bootstrap Modal Setting
        dialog.modal(modalOption)

        // Modal의 hide가 완료된 이후 Event 실행
        dialog.on('hidden.bs.modal', function(e){
            // Modal Element 제거
            dialog.remove();
        });

        // Confirm 일 경우 확인 버튼 클릭 이벤트 지정
        if(data.dialogType == 'confirm'){
            dialog.find(" #" + this.DialogInfo.okBtnId).on('click', function(){
                // ok button event function 실행
                if(data.ok && typeof(data.ok) === 'function'){
                    data.ok();
                }else{
                    console.warn('not function ok event. dialogId: ' + data.dialogId);
                }

                // Modal 창 닫기
                dialog.modal('hide');
                // click enevt 제거
                $(this).off('click');
            });
        }

        if(data.dialogType == 'alert'){
            dialog.find(" #" + this.DialogInfo.okBtnId).on('click', function(){
                // ok button event function 실행
                if(data.ok && typeof(data.ok) === 'function'){
                    data.ok();
                }

                // Modal 창 닫기
                dialog.modal('hide');

                // click enevt 제거
                $(this).off('click');
            });
        }

        // Modal Dialog Show
        dialog.modal('show');
    },

    /**
     * Modal Dialog Show
     */
    show: function(type, data){
        if(!data){data = {};}
        data.dialogType = type ? type : 'alert';
        this.makeModalDialog(data);
    },

    /**
     * Alert Modal Dialog
     *
     * data:
     *  title: Dialog Title Message
     *  content: Dialog Content Message
     *  closeBtn: Header Close Btn(x)
     *
     */
    alert: function(data){
        // data가 Object 가 아닌 경우 content 로 설정한다.
        if(typeof(data) != 'object'){
            var content = data;
            data = {content: content};
        }
        this.show('alert', data);
    },

    /**
     * Confirm Modal Dialog
     *
     * data:
     *  title: Dialog Title Message
     *  content: Dialog Content Message
     *  ok: Ok Button Click Event function
     *  closeBtn: Header Close Btn(x)
     *
     */
    confirm: function(data){
        this.show('confirm', data);
    }

};

function fillZeros(n, digits) {
    var zero = '';
    n = n.toString();

    if (n.length < digits) {
        for (i = 0; i < digits - n.length; i++)
            zero += '0';
    }
    return zero + n;
}

function getNowTimeStamp() {
    var d = new Date();

    var s = fillZeros(d.getFullYear(), 4) +
        fillZeros(d.getMonth() + 1, 2) +
        fillZeros(d.getDate(), 2)
    return s;
}