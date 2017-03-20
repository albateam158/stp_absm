<@layout.extends name="layout/base.ftl">
    <@layout.put block="head">

    </@layout.put>
    <@layout.put block="contents">
    <section class="mb10">
        <div class="pd7">
            <h2 class="result">결과 보기</h2><!-- result, input, search 클래스 명에 따라 왼쪽 아이콘이 달라집니다. -->
            <div class="bg_wh">
                <form id="ResultForm">
                    <label for="caId" class="wd55">케이스명</label>
                    <select name="caId" id="caId"  class="box_bd wd80">
                        <option value="">선택하세요</option>
                    </select>
                    <label for="name" class="wd35">이름</label><input type="text" id="name" name="name" class="box_bd wd80" />
                    <label for="filter">측정자료</label>
                    <select name="filter" id="filter"  class="box_bd wd80">
                        <option value="">선택하세요</option>
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
                        <button type="button" id="search" name="search" class="sch_btn fl" onclick="getChartInfo();">조회</button><!-- fl 클래스명은 왼쪽으로 붙는 클래스명입니다. -->
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
                        <video width="100%" height="280px" controls>
                            <source src="/video/sample.mp4" type="video/mp4">
                        </video>
                    </div>
                    <div class="fl result_box">
                        <h3>스트레스 측정 결과</h3>
                        <div class="stress_box">
                            <p>스트레스지수</p>
                            <div class="stress_boxin">
                                <div>
                                    <img src="/images/tri.png" alt="스트레스 표시" class="stress_mark"/>
                                </div>
                                <img src="/images/stress_bar.jpg" alt="스트레스 지수 측정" class="stress_bar"/>
                                <ul>
                                    <li class="taL">정상</li>
                                    <li class="taC">초기</li>
                                    <li class="taC">진행</li>
                                    <li class="taR">만성</li>
                                </ul>
                                <span class="line2"></span>
                                <h4>스트레스 지수해석</h4>
                                <article>스트레스 정도를 보여주는 가로 Bar와 지수에 대한 해석 정보가 나타남 스트레스 정도를 보여주는 가로 Bar와 지수에 대한 해석 정보가 나타남</article>
                            </div><!-- //stress_boxin -->
                        </div><!-- //stress_box -->
                    </div><!-- //result_box -->
                </div><!-- //row_box -->
            </div><!-- //bg_wh -->
        </div><!-- //pd7 -->
    </section>
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript">

        $(document).ready(function() {
            //getCaseList("SearchForm");
            /* 넘어온 파라미터 정보로 바로 조회 */

        });

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

            var sin = [], cos = [];
            for (var i = 0; i < 24; i += 0.5) {
                sin.push([i, Math.sin(i)]);
                cos.push([i, Math.cos(i)]);
            }
            var line_data1 = {
                data: sin,
                color: "#3c8dbc"
            };
            var line_data2 = {
                data: cos,
                color: "#00c0ef"
            };
            $.plot("#line-chart", [line_data1, line_data2], {
                grid: {
                    hoverable: true,
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
            //Initialize tooltip on hover
            $('<div class="tooltip-inner" id="line-chart-tooltip"></div>').css({
                position: "absolute",
                display: "none",
                opacity: 0.8
            }).appendTo("body");

            $("#line-chart").bind("plothover", function (event, pos, item) {

                if (item) {
                    var x = item.datapoint[0].toFixed(2),
                            y = item.datapoint[1].toFixed(2);

                    $("#line-chart-tooltip").html(item.series.label + " of " + x + " = " + y)
                            .css({top: item.pageY + 5, left: item.pageX + 5})
                            .fadeIn(200);
                } else {
                    $("#line-chart-tooltip").hide();
                }

            });
        });

        /* END LINE CHART */
    </script>
    </@layout.put>

</@layout.extends>

