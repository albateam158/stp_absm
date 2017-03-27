/**
 * Created by thomas on 2017-03-15.
 */

var $window = $(window);
var isSearch = false;

/* 개인특성 정보 업로드 처리 */
function savePrivate() {
    console.log("save button click");

    var form = $('#PrivateForm')[0];
    var formData = new FormData(form);
    console.log("formData " + formData);

    console.log("file path " + $('#file1')[0].files[0].name);

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
        url : "/input/baseline_div",
        data : {"caId" : caId},
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

/* 측정 정보 업로드 처리 */
function saveBiosignal() {
    console.log("save button click");

    var form = $('#BioForm')[0];
    var formData = new FormData(form);
    console.log("formData " + formData);

    $.ajax({
        type : "POST",
        url : "/input/biosignal_form",
        data : formData,
        processData: false,
        contentType: false,
        cache: false,
        success: function(data) {

            var retCode = data.retCode;
            var retMsg  = data.retMsg;
            var caId    = data.caId;
            var prId    = data.prId;
            if (retCode == "S_PAGE2001") {
                // 조회 api 호출
                getBioInfo(caId, prId);
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

// 측정 정보 등록 후 조회
function getBioInfo(caId, prId) {

    $.ajax({
        type : "GET",
        url : "/input/biosignal_div",
        data: {
            "caId": caId,
            "prId": prId
        },
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
                    { name: "참가번호", type: "text", width: 100 , align: "center"},
                    { name: "ECG/GSR구분", type: "text",  width: 100 , align: "center"},
                    { name: "측정시간", type: "text",  width: 100 , align: "center"},
                    { name: "측정값", type: "text",  width: 100 , align: "center"}
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

            if (retCode == "S_PAGE3001") {
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
        url : "/input/event_div",
        data: {
            "caId": caId
        },
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
                    { name: "대기지점출발", type: "number", width: 100 , align: "center"},
                    { name: "판교역 출입구", type: "number",  width: 100 , align: "center"},
                    { name: "판교역 플랫폼", type: "number",  width: 100 , align: "center"},
                    { name: "지하철 탑승", type: "number",  width: 100 , align: "center"},
                    { name: "지하철 하차", type: "number", width: 100 , align: "center"},
                    { name: "강남역 출입구", type: "number", width: 100 , align: "center"},
                    { name: "버스정류장", type: "number", width: 100 , align: "center"},
                    { name: "버스탑승", type: "number", width: 100 , align: "center"},
                    { name: "버스하차", type: "number", width: 100 , align: "center"},
                    { name: "대기지점", type: "number", width: 100 , align: "center"},
                ]
            });

        },
        error: function(request, status, error) {
            alert("개인정보 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

/* 동영상 정보 업로드 처리 */
function saveVideo() {
    console.log("save button click");

    var form = $('#VideoForm')[0];
    var formData = new FormData(form);
    //console.log("formData " + formData);

    $.ajax({
        type : "POST",
        url : "/input/video_form",
        data : formData,
        processData: false,
        contentType: false,
        cache: false,
        enctype: "multipart/form-data",
        success: function(data) {

            var retCode = data.retCode;
            var retMsg  = data.retMsg;
            var caId    = data.caId;
            var prId    = data.prId;

            if (retCode == "S_PAGE4001") {
                // 조회 api 호출
                getVideoInfo(caId, prId);
            }
            else {
                alert(retMsg);
            }
        },
        error: function(request, status, error) {
            alert("동영상 등록 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });
}

// 이벤트 등록 후 조회
function getVideoInfo(caId, prId) {

    $.ajax({
        type : "GET",
        url : "/input/video_div",
        data: {
            "caId": caId,
            "prId": prId,
            "fileCd": "08"
        },
        success: function(data) {

            if (data.url != "") {
                var video = $('#video1')[0];
                video.type = "video/mp4";
                video.src = data.url;
                video.load();
                video.play();
            }

        },
        error: function(request, status, error) {
            alert("동영상 파일 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

// 자료 조회
function searchData(searchCode) {

    console.log("searchData Start");

    var form = $('#SearchForm')[0];
    var formData = new FormData(form);
    var searchCode = formData.get("searchCode");

    $.ajax({
        type : "GET",
        url : '/search/search_div',
        data: {
            "caId": formData.get("caId"),
            "name": formData.get("name"),
            "age": formData.get("age"),
            "sex": formData.get("sex"),
            "searchCode": searchCode
        },

        success: function(data) {

            var gridData = data.boards;

            if (gridData.rows.length <= 0) {
                createToast('info', "조회 결과가 없습니다.");
            }
            else {
                setGrid(gridData, searchCode);
            }
        },
        error: function(request, status, error) {
            alert("개인정보 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

/**
 * 조회 항목에  맞게 그리드 생성
 *
 */
function setGrid(gridData, searchCode) {

    if (searchCode == 1) {

        // 개인정보 그리드
        $("#jsGrid").jsGrid({
            width: "100%",
            height: "400px",
            sorting: true,
            paging: true,

            data: gridData.rows,

            fields: [
                { name: "caId", type: "text", width: 100 , visible: false},
                { name: "케이스명", type: "text", width: 100 , align: "center"},
                { name: "참가번호", type: "number", width: 100 , align: "center"},
                { name: "이름", type: "text",  width: 100 , align: "center"},
                { name: "나이", type: "text",  width: 100 , align: "center"},
                { name: "성별", type: "text",  width: 100 , align: "center"}
            ],
            rowDoubleClick: function(args) {
                //console.log("args " + args);
                var caId  = args.item.caId;
                var pNo  = args.item.참가번호;

                var url = "/result/result?caId="+caId+"&pNo="+pNo;
                $(location).attr('href',url);
            },
        });

    }
    else if (searchCode == 2) {

        // 설문조사 그리드
        $("#jsGrid").jsGrid({
            width: "100%",
            height: "400px",
            sorting: true,
            paging: true,

            data: gridData.rows,

            fields: [
                { name: "caId", type: "text", width: 100 , visible: false},
                { name: "케이스명", type: "text", width: 100 , align: "center"},
                { name: "참가번호", type: "text", width: 100 , align: "center"},
                { name: "이름", type: "text", width: 100 , align: "center"},
                { name: "나이", type: "text", width: 100 , align: "center"},
                { name: "성별", type: "text",  width: 100 , align: "center"},
                { name: "판교역 출입구", type: "number",  width: 100 , align: "center"},
                { name: "판교역 플랫폼", type: "number",  width: 100 , align: "center"},
                { name: "지하철 탑승", type: "number", width: 100 , align: "center"},
                { name: "지하철 하차", type: "number", width: 100 , align: "center"},
                { name: "강남역 출입구", type: "number", width: 100 , align: "center"},
                { name: "버스정류장", type: "number", width: 100 , align: "center"},
                { name: "버스탑승", type: "number", width: 100 , align: "center"},
                { name: "버스하차", type: "number", width: 100 , align: "center"},
            ],
            rowDoubleClick: function(args) {
                //console.log("args " + args);
                var caId  = args.item.caId;
                var pNo  = args.item.참가번호;

                var url = "/result/result?caId="+caId+"&pNo="+pNo;
                $(location).attr('href',url);
            },
        });

    }
    else if (searchCode == 3) {

        // 이벤트 그리드
        $("#jsGrid").jsGrid({
            width: "100%",
            height: "400px",
            sorting: true,
            paging: true,

            data: gridData.rows,

            fields: [
                { name: "caId", type: "text", width: 100 , visible: false},
                { name: "케이스명", type: "text", width: 100 , align: "center"},
                { name: "참가번호", type: "text", width: 100 , align: "center"},
                { name: "이름", type: "text", width: 100 , align: "center"},
                { name: "나이", type: "text", width: 100 , align: "center"},
                { name: "성별", type: "text",  width: 100 , align: "center"},
                { name: "대기지점출발", type: "number", width: 100 , align: "center"},
                { name: "판교역 출입구", type: "number",  width: 100 , align: "center"},
                { name: "판교역 플랫폼", type: "number",  width: 100 , align: "center"},
                { name: "지하철 탑승", type: "number",  width: 100 , align: "center"},
                { name: "지하철 하차", type: "number", width: 100 , align: "center"},
                { name: "강남역 출입구", type: "number", width: 100 , align: "center"},
                { name: "버스정류장", type: "number", width: 100 , align: "center"},
                { name: "버스탑승", type: "number", width: 100 , align: "center"},
                { name: "버스하차", type: "number", width: 100 , align: "center"},
                { name: "대기지점", type: "number", width: 100 , align: "center"},
            ],
            rowDoubleClick: function(args) {

                var caId  = args.item.caId;
                var pNo  = args.item.참가번호;

                var url = "/result/result?caId="+caId+"&pNo="+pNo;
                $(location).attr('href',url);
            },
        });

    }
    else if (searchCode == 4) {

        // 생체정보 그리드
        $("#jsGrid").jsGrid({
            width: "100%",
            height: "400px",
            sorting: true,
            paging: true,

            data: gridData.rows,

            fields: [
                { name: "caId", type: "text", width: 100 , visible: false},
                { name: "케이스명", type: "text", width: 100 , align: "center"},
                { name: "참가번호", type: "text", width: 100 , align: "center"},
                { name: "이름", type: "text", width: 100 , align: "center"},
                { name: "나이", type: "text", width: 100 , align: "center"},
                { name: "성별", type: "text",  width: 100 , align: "center"},
                { name: "ECG/GSR구분", type: "text",  width: 100 , align: "center"},
                { name: "측정시간", type: "text",  width: 100 , align: "center"},
                { name: "측정값", type: "text",  width: 100 , align: "center"}
            ],

            rowDoubleClick: function(args) {
                //console.log("args " + args);
                var caId  = args.item.caId;
                var pNo  = args.item.참가번호;

                var url = "/result/result?caId="+caId+"&pNo="+pNo;
                $(location).attr('href',url);
            },
        });
    }
    else if (searchCode == 5) {

        // 업로드 파일 그리드
        $("#jsGrid").jsGrid({
            width: "100%",
            height: "400px",
            sorting: true,
            paging: true,
            shrinkToFit: false,
            autowidth :true,
            data: gridData.rows,

            fields: [
                { name: "caId", type: "text", visible: false},
                { name: "케이스명", type: "text", align: "center"},
                { name: "참가번호", type: "text", align: "center"},
                { name: "이름", type: "text", align: "center"},
                { name: "나이", type: "text", align: "center"},
                { name: "성별", type: "text",  align: "center"},
                { name: "파일명", type: "text", width: "100%", align: "center"},
                { name: "파일구분", type: "text",  visible: false},
                { name: "업로드일자", type: "text", align: "center"},
                { name: "파일다운", type: "text", width: "100%", align: "center"},
            ],
            rowDoubleClick: function(args) {
                //console.log("args " + args);
                var caId  = args.item.caId;
                var pNo  = args.item.참가번호;

                var url = "/result/result?caId="+caId+"&pNo="+pNo;
                $(location).attr('href',url);
            },
        });
    }

}

// 결과화면에서 case 변경 시 동영상 조회 flag 초기화
$('#ResultForm select#pNo').on('change', function(){
    isSearch = false;
});

// 결과화면에서 참가인원 변경 시 동영상 조회 flag 초기화
$('#ResultForm select#caId').on('change', function(){
    isSearch = false;
});

/* 결과 화면의 데이터 조회 */
function getChartInfo() {

    // 결과 조회를 위한 param 세팅
    // TODO : 조회 화면에서 넘겨받은 데이터로 설정
    var caId    = $('#caId option:selected').val();
    var pNo     = $('#pNo option:selected').val();
    var chartId = $('#filter option:selected').val();
    var vid = document.getElementById("MyVideo");

    $.ajax({
        type : "GET",
        url : "/result/chart",
        data: {
            "caId"   : caId,
            "pNo"    : pNo,
            "chartId": chartId
        },
        success: function(data) {

            var chartInfo = data.chartInfo;

            var filterChart = [];

            $.each(chartInfo, function(index, item) {
                if (chartId == 1)
                    filterChart.push([index, item.meanRri]);
                else if (chartId == 2)
                    filterChart.push([index, item.stdRri]);
                else if (chartId == 3)
                    filterChart.push([index, item.meanHrv]);
                else if (chartId == 4)
                    filterChart.push([index, item.stdHrv]);
                else if (chartId == 5)
                    filterChart.push([index, item.rmssdd]);
                else if (chartId == 6)
                    filterChart.push([index, item.pnn50]);
                else if (chartId == 7)
                    filterChart.push([index, item.lfhf]);
                else if (chartId == 8)
                    filterChart.push([index, item.scl]);
            });

            var markings = [
                { xaxis: { from: 1, to: 2 }, color: "#000" },
                { xaxis: { from: 4, to: 5 }, color: "#000" },
                { xaxis: { from: 7, to: 8 }, color: "#000" },
                { xaxis: { from: 10, to: 11 }, color: "#000" },
                { xaxis: { from: 13, to: 14 }, color: "#000" },
                { xaxis: { from: 16, to: 17 }, color: "#000" },
                { xaxis: { from: 19, to: 20 }, color: "#000" }

            ];

            // 한번 조회가 완료되면 그 후에는 동영상으로 로드하지 않음
            if (isSearch == false) {
                isSearch = true;

                var videoInfo = data.videoInfo;

                /* video url load */
                vid.src = videoInfo.url;
                vid.load();
                vid.play();
            }

            var line_data1 = {
                data: filterChart,
                color: "#3c8dbc"
            };

            $.plot("#line-chart", [line_data1], {
                grid: {
                    hoverable: true,
                    clickable: true,
                    borderColor: "#f3f3f3",
                    borderWidth: 1,
                    tickColor: "#f3f3f3"
                },
                series: {
                    shadowSize: 0,
                    lines: {
                        show: true
                    },
                    points: {
                        show: true
                    }
                },
                lines: {
                    fill: false,
                    color: ["#3c8dbc", "#f56954"]
                },
                yaxis: {
                    show: true,
                },
                xaxis: {
                    show: true
                },
                markings: markings
            });

            //Initialize tooltip on hover
            $('<div class="tooltip-inner" id="line-chart-tooltip"></div>').css({
                position: "absolute",
                display: "none",
                opacity: 0.8
            }).appendTo("body");

            $("#line-chart").bind("plothover", function (event, pos, item) {

                if (item) {
                    var x = item.datapoint[0].toFixed(0),
                        y = item.datapoint[1].toFixed(5);

                    $("#line-chart-tooltip").html("구간 측정정보 (" + x + "분 측정값 = " + y + ")")
                        .css({top: item.pageY + 5, left: item.pageX + 5})
                        .fadeIn(200);
                } else {
                    $("#line-chart-tooltip").hide();
                }

            });
            $("#line-chart").bind("plotclick", function (event, pos, item) {

                if (item) {
                    vid.currentTime = (item.dataIndex) * 60;
                    vid.play();
                } else {
                    $("#line-chart-tooltip").hide();
                }

            });

        },
        error: function(request, status, error) {
            alert("결과 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

// Toast 메세지 생성
function createToast(t, msg){
    var message = "";
    var options = {
        duration: 3000, // 3초 동안 나타남
        sticky: !!Math.round(Math.random() * 1),
        type: t
    };

    switch(t){
        case 'danger': message = '<h4>오류</h4><span class="line3"></span>' + msg; break;
        case 'info': message = '<h4>알림</h4><span class="line3"></span>'+ msg; break;
        case 'success': message = '<h4>성공</h4><span class="line3"></span>'+ msg; break;
    }

    $.toast(message, options);
}

// 케이스 목록 조회
function getCaseList(formName) {

    $.ajax({
        type : "GET",
        url : "/input/caseList",
        success: function(data) {

            var cases = data.cases;

            if (formName == "EventForm") {
                $.each(cases, function(index, item) {
                    $('#EventForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
                });
            }
            else if (formName == "BioForm") {
                $.each(cases, function(index, item) {
                    $('#BioForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
                });
            }
            else if (formName == "VideoForm") {
                $.each(cases, function(index, item) {
                    $('#VideoForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
                });
            }
            else if (formName == "SearchForm") {
                $.each(cases, function(index, item) {
                    $('#SearchForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
                });
            }
        },
        error: function(request, status, error) {
            alert("케이스 목록 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

// 케이스별 참가자 목록 조회
function getPrivateList(formName, caId) {


    $.ajax({
        type : "GET",
        url : "/input/privateList?caId="+caId,
        success: function(data) {

            var pris = data.pris;

            if (formName == "BioForm") {

                $('#BioForm select#name option').not("[value='']").remove();
                $.each(pris, function(index, item) {
                    // TODO 케이스 조회시 리턴 오브젝트에 개인정보 이름 추가
                    $('#BioForm select#name').append("<option value='" + item.prId + "'>" + item.name + "</option> ");
                });
            }
            else if (formName == "VideoForm") {

                $('#VideoForm select#name option').not("[value='']").remove();
                $.each(pris, function(index, item) {
                    // TODO 케이스 조회시 리턴 오브젝트에 개인정보 이름 추가
                    $('#VideoForm select#name').append("<option value='" + item.prId + "'>" + item.name + "</option> ");
                });
            }


        },
        error: function(request, status, error) {
            alert("privateList 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}
