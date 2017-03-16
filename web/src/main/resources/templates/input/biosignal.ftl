<@layout.extends name="layout/base.ftl">

	<@layout.put block="head">

	</@layout.put>
	<@layout.put block="contents">
    <section class="mb10">
        <div class="pd7">
            <h2 class="input">생체신호 측정자료 입력</h2>
            <div class="bg_wh">
                <form action="">
                    <label for="caId" class="wd100">케이스명</label>
                    <select name="caId" id="caId"  class="box_bd wd80 mb10">
                        <option value="">1</option>
                        <option value="">2</option>
                    </select>
                    <label for="name" class="wd35">이름</label>
                    <select name="name" id=""  class="box_bd wd80 mb10">
                        <option value="">한후자</option>
                        <option value="">이옥자</option>
                    </select>
                    <br />

                    <label for="" class="wd100">ECG 파일명</label>
                    <input type="text" class="box_bd mr0 mb10 wd164" title="파일찾기" readonly="readonly"  id="ecgFindFile">
                    <label for="fileName" id="" class="file_label">파일찾기</label>
                    <input id="" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('ecgFindFile').value=this.value" onkeydown="return false" >
                    <br />

                    <label for="" class="wd100">GSR 파일명</label>
                    <input type="text" class="box_bd mr0 wd164" title="파일찾기" readonly="readonly"  id="gsrfindFile">
                    <label for="fileName" id="" class="file_label">파일찾기</label>
                    <input id="" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('gsrfindFile').value=this.value" onkeydown="return false" >
                    <br />

                    <label for="" class="wd100">GSR 파일명</label>
                    <input type="text" class="box_bd mr0 wd164" title="파일찾기" readonly="readonly"  id="gsrfindFile">
                    <label for="fileName" id="" class="file_label">파일찾기</label>
                    <input id="" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('gsrfindFile').value=this.value" onkeydown="return false" >
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
            { "이름": "한후자", "구간": "판교역입구", "mean RRI": 0.57041, "std RRI": 0.05712, "mean HRV":106.4155, "std HRV":6.61581,"RMSDD":0.05865,"pNN50":1.36612,"LFHF":0.97293},
            { "이름": "한후자", "구간": "플랫폼", "mean RRI": 0.54897, "std RRI": 0.01737, "mean HRV":109.5003, "std HRV":4.36538,"RMSDD":0.03055,"pNN50":4.62963,"LFHF":0.33043},
            { "이름": "한후자", "구간": "지하철탑승", "mean RRI": 0.65029, "std RRI": 0.05463, "mean HRV":93.15767, "std HRV":5.79013,"RMSDD":0.05213,"pNN50":0.66667,"LFHF":0.51272},
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
                { name: "이름", type: "text", width: 100 , align: "center"},
                { name: "구간", type: "text", width: 100 , align: "center"},
                { name: "mean RRI", type: "number",  width: 100 , align: "center"},
                { name: "std RRI", type: "number",  width: 100 , align: "center"},
                { name: "mean HRV", type: "number",  width: 100 , align: "center"},
                { name: "std HRV", type: "number", width: 100 , align: "center"},
                { name: "RMSDD", type: "number", width: 100 , align: "center"},
                { name: "pNN50", type: "number", width: 100 , align: "center"},
                { name: "LFHF", type: "number", width: 100 , align: "center"}
            ]
        });
    </script>
	</@layout.put>

</@layout.extends>