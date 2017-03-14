<@layout.extends name="layout/base.ftl">

	<@layout.put block="head">

	</@layout.put>
	<@layout.put block="contents">
    <section class="mb10">
        <div class="pd7">
            <h2 class="input">기초자료 및 개인특성 자료 입력</h2>
            <div class="bg_wh">
                <form action="">
                    <label for="dt" class="wd102">측정일자</label><input type="text" id="dt" name="dt" class="box_bd wd80" />
                    <label for="cassNm">케이스명</label>
                    <input type="text" id="cassNm" name="cassNm" class="box_bd wd80" />
                    <label for="note" class="wd35">설명</label><input type="text" id="note" name="note" class="box_bd wd150 mb10" /><br />

                    <label for="" class="wd100">개인특성 파일명</label>
                    <input type="text" class="box_bd mr0 mb10 wd189" title="파일찾기" readonly="readonly"  id="file_sch1">
                    <label for="fileName" id="" class="file_label">파일찾기</label>
                    <input id="" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('file_sch1').value=this.value" onkeydown="return flase" ><br />

                    <label for="" class="wd100">설문조사 파일명</label>
                    <input type="text" class="box_bd mr0 wd189" title="파일찾기" readonly="readonly"  id="file_sch2">
                    <label for="fileName" id="" class="file_label">파일찾기</label>
                    <input id="" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('file_sch2').value=this.value" onkeydown="return flase" >
                    <button type="button" id="" name="save" class="input_btn fr">입력</button>
                </form>
                <span class="line"></span>
                <div id="jsGrid"></div>
            </div><!-- //bg_wh -->
        </div><!-- //pd7 -->
    </section>
	</@layout.put>


	<@layout.put block="script">
    <script type="text/javascript">
        var clients = [
            {"케이스명": "측정1","참가번호": 1,"이름": "한후자", "나이": "77세", "성별": "남"},
            {"케이스명": "측정1","참가번호": 2,"이름": "이옥자", "나이": "75세", "성별": "여"},
            {"케이스명": "측정1","참가번호": 3,"이름": "이시응", "나이": "74세", "성별": "남"}
        ];

        // var countries = [
        //     { Name: "", Id: 0 },
        //     { Name: "United States", Id: 1 },
        //     { Name: "Canada", Id: 2 },
        //     { Name: "United Kingdom", Id: 3 }
        // ];

        $("#jsGrid").jsGrid({
            width: "100%",
            height: "400px",

            //inserting: true,
            // editing: true,
            sorting: true,
            paging: true,

            data: clients,

            fields: [
                { name: "케이스명", type: "text", width: 100 , align: "center"},
                { name: "참가번호", type: "number", width: 100 , align: "center"},
                { name: "이름", type: "text",  width: 100 , align: "center"},
                { name: "나이", type: "text",  width: 100 , align: "center"},
                { name: "성별", type: "text",  width: 100 , align: "center"}
            ]
        });
    </script>
	</@layout.put>

</@layout.extends>