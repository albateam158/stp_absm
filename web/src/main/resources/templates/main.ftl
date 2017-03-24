<@layout.extends name="layout/base.ftl">

	<@layout.put block="head">

	</@layout.put>
	<@layout.put block="contents">
    <section class="mb10">

        <table border="0" cellpadding="0" cellspacing="0">
            <colgroup>
                <col width="10%" />
                <col width="20%" />
                <col width="20%" />
                <col width="20%" />
                <col width="30%" />
            </colgroup>
            <thead>
            <tr class="title2">
                <th>1Depth</th>
                <th>2Depth</th>
                <th>Folder</th>
                <th>File</th>
                <th>Comment</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td rowspan="4">자료입력</td>
                <td>기초자료 및 개인특성 자료 입력</td>
                <td rowspan="4">input</td>
                <td><a href="/input/baseline" target="_blank">baseline.html</a></td>
                <td class="cm">2017-03-13</td>
            </tr>
            <tr>
                <td>생체신호 측정자료 입력</td>
                <td><a href="/input/biosignal" target="_blank">biosignal.html</a></td>
                <td class="cm">2017-03-13</td>
            </tr>
            <tr>
                <td>이벤트 자료 입력</td>
                <td><a href="/input/event" target="_blank">event.html</a></td>
                <td class="cm">2017-03-13</td>
            </tr>
            <tr>
                <td>동영상 자료 입력</td>
                <td><a href="/input/video" target="_blank">video.html</a></td>
                <td class="cm">2017-03-13</td>
            </tr>
            <tr>
                <td>자료 조회</td>
                <td></td>
                <td>search</td>
                <td><a href="/search/search" target="_blank">search.html</a></td>
                <td class="cm">2017-03-13</td>
            </tr>
            <tr>
                <td>결과 보기</td>
                <td></td>
                <td>result</td>
                <td><a href="/result/result" target="_blank">result.html</a></td>
                <td class="cm">2017-03-13</td>
            </tr>
            </tbody>
        </table>
    </section>
	</@layout.put>


	<@layout.put block="script">
    <script type="text/javascript">
    </script>
	</@layout.put>

</@layout.extends>