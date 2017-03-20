<@layout.extends name="layout/base.ftl">

	<@layout.put block="head">

	</@layout.put>
	<@layout.put block="contents">
    <section class="mb10">
        <div class="pd7">
            <h2 class="lookup">자료 조회</h2>
            <div class="bg_wh">
                <form id="SearchForm">
                    <label for="caId" class="wd80">케이스명</label>
                    <select name="caId" id="caId"  class="box_bd wd80 mb10">
                        <option value="">선택하세요</option>
                    </select>
                    <br />
                    <label for="name" class="wd80">이름</label>
                    <input type="text" name="name" class="box_bd wd80" id="name"/>
                    <label for="age" class="wd35">나이</label>
                    <input type="text" name="age" class="box_bd wd80" id="age"/>
                    <label for="sex" class="wd35">성별</label>
                    <select name="sex" id="sex" class="box_bd wd80" class="box_bd wd80 mb10">
                        <option value="남">남</option>
                        <option value="여">여</option>
                    </select>
                    <button type="button" id="search" name="search" class="sch_btn fr" onclick="getAbsmInfo();">조회</button>
                </form>
                <span class="line"></span>
                <div id="jsGrid"></div>
            </div><!-- //bg_wh -->
        </div><!-- //pd7 -->
    </section>
	</@layout.put>


	<@layout.put block="script">
    <script type="text/javascript">

        $(document).ready(function() {
            getCaseList("SearchForm");
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
                { name: "참가번호", type: "text", width: 100 , align: "center"},
                { name: "이름", type: "text", width: 100 , align: "center"},
                { name: "나이", type: "text", width: 100 , align: "center"},
                { name: "성별", type: "text",  width: 100 , align: "center"},
                { name: "설문조사1", type: "number",  width: 100 , align: "center"},
                { name: "설문조사2", type: "number",  width: 100 , align: "center"},
                { name: "설문조사3", type: "number", width: 100 , align: "center"},
                { name: "설문조사4", type: "number", width: 100 , align: "center"},
                { name: "설문조사5", type: "number", width: 100 , align: "center"},
                { name: "설문조사6", type: "number", width: 100 , align: "center"},
                { name: "설문조사7", type: "number", width: 100 , align: "center"},
                { name: "설문조사8", type: "number", width: 100 , align: "center"}
            ]

        });
    </script>
	</@layout.put>

</@layout.extends>