/**
 * Created by thomas on 2017-03-15.
 */


/* 개인특성 정보 업로드 처리 */
//$('#PrivateForm #save').on('click', function(){
function savePrivate() {
    console.log("save button click");

    var form = $('#PrivateForm')[0];
    var formData = new FormData(form);
    console.log("formData " + formData);

    $.ajax({
        type : "POST",
        url : "/input/baseline_form",
        data : formData,
        processData: false,
        contentType: false,
        cache: false,
        success: function(data) {

            var retCode = data.retCode;
            var retMsg  = data.retMsg;
            var caId    = data.caId;

            if (retCode == "S_PAGE1001") {
                // 조회 api 호출
                getPrivateInfo(caId);
            }
            else {
                alert(retMsg);
            }
        },
        error: function(request, status, error) {
            alert("개인정보 등록 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });
}

// 개인특성 등록 후 조회
function getPrivateInfo(caId) {

    $.ajax({
        type : "GET",
        url : "/input/baseline_div?caId="+caId,

        success: function(data) {

            var gridData = data.boards;

            console.log("grid 생성" + gridData.rows);

            $("#jsGrid").jsGrid({
                width: "100%",
                height: "400px",

                //inserting: true,
                // editing: true,
                sorting: true,
                paging: true,

                data: gridData.rows,

                fields: [
                    { name: "케이스명", type: "text", width: 100 , align: "center"},
                    { name: "참가번호", type: "number", width: 100 , align: "center"},
                    { name: "이름", type: "text",  width: 100 , align: "center"},
                    { name: "나이", type: "text",  width: 100 , align: "center"},
                    { name: "성별", type: "text",  width: 100 , align: "center"}
                ]
            });

        },
        error: function(request, status, error) {
            alert("개인정보 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

/* 이벤트 정보 업로드 처리 */
function saveEvent() {
    console.log("save button click");

    var form = $('#EventForm')[0];
    var formData = new FormData(form);
    console.log("formData " + formData);

    $.ajax({
        type : "POST",
        url : "/input/event_form",
        data : formData,
        processData: false,
        contentType: false,
        cache: false,
        success: function(data) {

            var retCode = data.retCode;
            var retMsg  = data.retMsg;
            var caId    = data.caId;

            if (retCode == "S_PAGE2001") {
                // 조회 api 호출
                getEventInfo(caId);
            }
            else {
                alert(retMsg);
            }
        },
        error: function(request, status, error) {
            alert("개인정보 등록 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });
}

// 이벤트 등록 후 조회
function getEventInfo(caId) {

    $.ajax({
        type : "GET",
        url : "/input/event_div?caId="+caId,
        success: function(data) {

            var gridData = data.boards;
            console.log("data " + data);
            console.log("grid 생성" + gridData);
            console.log("grid rows 생성" + gridData.rows);

            $("#jsGrid").jsGrid({
                width: "100%",
                height: "400px",

                //inserting: true,
                // editing: true,
                sorting: true,
                paging: true,

                data: gridData.rows,

                fields: [
                    { name: "이름", type: "text", width: 100 , align: "center"},
                    { name: "이벤트1", type: "number", width: 100 , align: "center"},
                    { name: "이벤트2", type: "number",  width: 100 , align: "center"},
                    { name: "이벤트3", type: "number",  width: 100 , align: "center"},
                    { name: "이벤트4", type: "number",  width: 100 , align: "center"},
                    { name: "이벤트5", type: "number", width: 100 , align: "center"},
                    { name: "이벤트6", type: "number", width: 100 , align: "center"},
                    { name: "이벤트7", type: "number", width: 100 , align: "center"},
                    { name: "이벤트8", type: "number", width: 100 , align: "center"},
                    { name: "이벤트9", type: "number", width: 100 , align: "center"},
                    { name: "이벤트10", type: "number", width: 100 , align: "center"},
                ]
            });

        },
        error: function(request, status, error) {
            alert("개인정보 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

// 케이스 목록 조회
function getCaseList() {

    $.ajax({
        type : "GET",
        url : "/input/caseList",
        success: function(data) {

            var cases = data.cases;
            $.each(cases, function(index, item) {
                $('#EventForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
            });
        },
        error: function(request, status, error) {
            alert("케이스 목록 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

