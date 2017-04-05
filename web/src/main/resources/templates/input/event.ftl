<@layout.extends name="layout/base.ftl">

    <@layout.put block="head">

    </@layout.put>
    <@layout.put block="contents">
    <section class="mb10">
        <div class="pd7">
            <h2 class="input">이벤트 자료 입력</h2>
            <div class="bg_wh">
                <form id="EventForm">
                    <h3> 전체 피험자의 이벤트정보 및 생체파라미터 입력</h3>

                    <label for="caId" class="wd100">케이스명</label>
                    <select name="caId" id="caId"  class="box_bd wd160 mb10">
                        <option value="">선택하세요</option>
                    </select>
                    <br />
                    <label for="" class="wd160">이벤트 파일명(엑셀)</label>
                    <input type="text" class="box_bd mr0 wd164" title="파일찾기" readonly="readonly"  id="eventFile">
                    <label for="file1" id="" class="file_label">파일찾기</label>
                    <input id="file1" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('eventFile').value=this.value" onkeydown="return false" >
                    <input type="hidden" name="fileType" value="EVENT" />

                    <label for="" class="wd160">생체파라미터 파일명(엑셀)</label>
                    <input type="text" class="box_bd mr0 wd189" title="파일찾기" readonly="readonly"  id="filterfindFile">
                    <label for="file2" id="" class="file_label">파일찾기</label><!-- lable의 for : file2 -->
                    <input id="file2" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('filterfindFile').value=this.value" onkeydown="return false" ><!-- input의 id : file2 -->
                    <input type="hidden" name="fileType" value="FILTER" />

                    <button type="button" id="" name="save" class="input_btn fr" onclick="vaildationCheck();">입력</button>
                </form>
                <span class="line"></span>
                <div id="jsGrid"></div>
            </div><!-- //bg_wh -->
        </div><!-- //pd7 -->
    </section>
    <!-- 20170326 추가 loading -->
    <div class="loading hide">
        <img src="/images/loading.gif" class="loading_img" alt="로딩중입니다." />
    </div>
    <!-- //20170326 추가 loading -->
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript">

        function vaildationCheck() {

            var msg = '';

            if ($('#caId').val() == '') {
                msg = '케이스명을 선택하세요';
                createToast('info', msg);
                return;
            }

            if ($('#file1')[0].files.length == 0) {
                msg = '이벤트 파일을 선택하세요';
                createToast('info', msg);
                return;
            }

            if ($('#file2')[0].files.length == 0) {
                msg = 'SPSS 파일을 선택하세요';
                createToast('info', msg);
                return;
            }

            saveEvent();

        }

        $(document).ready(function() {
            getCaseList("EventForm");
        });

        var clients = [];

        $("#jsGrid").jsGrid({
            width: "100%",
            height: "400px",

            //inserting: true,
            // editing: true,
            sorting: true,
            paging: true,

            data: clients,

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
    </script>
    </@layout.put>

</@layout.extends>