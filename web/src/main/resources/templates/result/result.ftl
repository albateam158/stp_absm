<@layout.extends name="layout/base.ftl">
    <@layout.put block="head">

    </@layout.put>
    <@layout.put block="contents">
    <section class="mb10">
        <div class="pd7">
            <h2 class="result">결과 보기</h2><!-- result, input, search 클래스 명에 따라 왼쪽 아이콘이 달라집니다. -->
            <div class="bg_wh">
                <form id="ResultForm">
                    <input id="sex" type="hidden" value="${(LPri.sex)!}">
                    <input id="age" type="hidden" value="${(LPri.age)!}">
                    <input id="aPri" type="hidden" value="${(aPri.caId)!}">

                    <label for="caId" class="wd55">케이스명</label>
                    <select name="caId" id="caId"  class="box_bd wd160">
                        <option value="">선택하세요</option>
                        <#list cases as case>
                            <option value="${case.caId!}"
                                    <#if aPri.caId?exists && aPri.caId == case.caId>selected</#if>
                            >${case.caseNm}</option>
                        </#list>
                    </select>
                    <label for="prNo" class="wd35">이름</label>
                <#--<input type="text" id="name" name="name" class="box_bd wd80" />-->
                    <select name="pNo" id="pNo"  class="box_bd wd160">
                        <option value="">선택하세요</option>
                        <#list LPris as LPri>
                            <option value="${LPri.prNo}"
                                    <#if aPri.prNo?exists && aPri.prNo == LPri.prNo>selected</#if>
                            >${LPri.name}</option>
                        </#list>
                    </select>
                    <label for="filter">측정자료</label>
                    <select name="filter" id="filter"  class="box_bd wd160">
                        <option value="1">meanRR(s)</option>
                        <option value="2">SDNN(s)</option>
                        <option value="3">RMSD(s)</option>
                        <option value="4">pnn50(%)</option>
                        <option value="5">meanHR</option>
                        <option value="6">stdHR</option>
                        <option value="7">LF/HF</option>
                        <option value="8">n-meanSCL</option>
                    </select>
                    <div class="btns fr">
                        <button type="button" id="search" name="search" class="sch_btn fl" onclick="vaildationCheck();">조회</button><!-- fl 클래스명은 왼쪽으로 붙는 클래스명입니다. -->
                        <button type="button" id="isShow" name="isShow" class="graph_btn fl">그래프2 보기</button>
                    </div>
                </form>
                <span class="line"></span>
                <div class="row_box">
                    <div class="fl graph_box1">
                        <div class="box">
                            <h3>그래프1</h3>
                            <div class="box-body" style="display: block;">
                                <div id="line-chart" style="width:100%;height: 300px; padding: 0px; position: relative;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="fl graph_box2">
                        <div class="box">
                            <h3>그래프2</h3>
                            <div class="box-body" style="background-color:#fff">
                                <div id="interactive" style="width:100%;height: 300px; padding: 0px; position: relative;"></div>
                            </div>
                        </div>
                    </div>
                </div><!-- row_box -->
                <div class="row_box">
                    <div class="fl video_box">
                        <h3>동영상</h3>
                        <video id="MyVideo" width="100%" height="280px" controls>
                            <source src="" type="video/mp4">
                            <source src="" type="video/avi">
                            <source src="" type="video/ogg">
                            <source src="" type="video/wmv">
                        </video>
                    </div>
                    <!-- 20170327 결과보기 수정 -->
                    <div class="fl result_box">
                        <h3>스트레스 측정 결과</h3>
                        <div class="stress_box">
                            <ul class="p_info">
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                            <ul class="face_ul">
                                <li class="level1 on"></li><!-- class명 on / off로 이미지변경됩니다. -->
                                <li class="level2 off"></li>
                                <li class="level3 off"></li>
                                <li class="level4 off"></li>
                            </ul>
                            <div class="mark_div">
                                <img src="/images/tri.png" alt="스트레스 표시" class="stress_mark"/><!-- left값이 px기준, 0~559px까지로 100%(는 559px로 표기)를 제외한 것은 %로 위치를 바꿀 수 있습니다. -->
                            </div>
                            <img src="/images/stress_bar.jpg" alt="스트레스 지수 측정" class="stress_bar"/>
                            <ul class="step">
                                <li>정상</li>
                                <li>초기</li>
                                <li>진행</li>
                                <li>만성</li>
                            </ul>
                            <span class="line2"></span>
                            <article>스트레스 정도를 보여주는 가로 Bar와 지수에 대한 해석 정보가 나타남 </article>
                        </div><!-- //stress_box -->
                    </div><!-- //result_box -->  <!-- //20170327 결과보기 수정 -->
                </div><!-- //row_box -->
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

        $(document).ready(function(){


            $('.stress_mark').css( 'left','11%');
            if($("#aPri").val() != '') {
                vaildationCheck();
            }

        });

        function vaildationCheck() {

            var msg = '';

            if ($('#caId').val() == '') {
                msg = '케이스명을 선택하세요';
                createToast('info', msg);
                return;
            }

            if ($('#name').val() == '') {
                msg = '이름을 선택하세요';
                createToast('info', msg);
                return;
            }

            if ($('#filter').val() == '') {
                msg = '측정자료를 선택하세요';
                createToast('info', msg);
                return;
            }
            getChartInfo();

        }

        $(function () {
            /*
             * Flot Interactive Chart
             * -----------------------
             */
            // We use an inline data source in the example, usually data would
            // be fetched from a server
            var data = [], totalPoints = 100;

            function getRandomData() {

                if (data.length > 0)
                    data = data.slice(1);

                // Do a random walk
                while (data.length < totalPoints) {

                    var prev = data.length > 0 ? data[data.length - 1] : 50,
                            y = prev + Math.random() * 10 - 5;

                    if (y < 0) {
                        y = 0;
                    } else if (y > 100) {
                        y = 100;
                    }

                    data.push(y);
                }

                // Zip the generated y values with the x values
                var res = [];
                for (var i = 0; i < data.length; ++i) {
                    res.push([i, data[i]]);
                }

                return res;
            }

            var interactive_plot = $.plot("#interactive", [getRandomData()], {
                grid: {
                    borderColor: "#f3f3f3",
                    borderWidth: 1,
                    tickColor: "#f3f3f3"
                },
                series: {
                    shadowSize: 0, // Drawing is faster without shadows
                    color: "#3c8dbc"
                },
                lines: {
                    fill: true, //Converts the line chart to area chart
                    color: "#3c8dbc"
                },
                yaxis: {
                    min: 0,
                    max: 100,
                    show: true
                },
                xaxis: {
                    show: true
                }
            });

            var updateInterval = 500; //Fetch data ever x milliseconds
            var realtime = "on"; //If == to on then fetch data every x seconds. else stop fetching
            function update() {

                interactive_plot.setData([getRandomData()]);

                // Since the axes don't change, we don't need to call plot.setupGrid()
                interactive_plot.draw();
                if (realtime === "on")
                    setTimeout(update, updateInterval);
            }

            //INITIALIZE REALTIME DATA FETCHING
            if (realtime === "on") {
                update();
            }
            //REALTIME TOGGLE
            $("#realtime .btn").click(function () {
                if ($(this).data("toggle") === "on") {
                    realtime = "on";
                }
                else {
                    realtime = "off";
                }
                update();
            });
            /*
             * END INTERACTIVE CHART
             */


            /*
             * LINE CHART
             * ----------
             */
            //LINE randomly generated data
            var temp = [];
            var line_data1 = {
                data: temp,
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
                }
            });

        });

        /* END LINE CHART */

        $("#caId").change(function() {
            comboChange1($(this).val());
        });

        function comboChange1() {
            var caId = $("#caId option:selected").val();

            $.ajax({
                type:"get",
                url:"/result/pri_combo",
                datatype: "json",
                data: "caId="+caId,
                success: function(data) {
                    var html = '<option value="">선택</option>';

                    if(data != "") {
                        $("#pNo").find("option").remove();

                        $.each(data, function(index, item) {
                            html += '<option value="'+ item.prNo +'" >'+item.name  +'</option>' ;
                        });
                        $("#pNo").find("option").remove().end().append(html);
                    } else {
                        $("#pNo").find("option").remove().end().append(html);
                        return;
                    }
                },
                error: function(x, o, e) {
                    var msg = "페이지 호출 중 에러 발생 \n" + x.status + " : " + o + " : " + e;
                    alert(msg);
                }
            });
        }
    </script>
    </@layout.put>

</@layout.extends>

