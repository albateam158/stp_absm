<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="step_box">
                <ol>
                    <li>
                        <p><i class="icon ic_check"></i> 청약신청</p>
                    </li>
                    <li class="t-c">
                        <p><i class="icon ic_check"></i> 청약 증거금 이체</p>
                    </li>
                    <li class="t-r">
                        <p class="active"><i class="icon ic_check"></i> 투자완료</p>
                    </li>
                </ol>
            </div>
            <div class="form_box mobile">
                <form method="">
                    <h2><#if success>투자완료<#else>투자실패</#if></h2>
                    <div class="top">
                        <div class="publisher_box">
                            <div class="sbsc_result">
                                <p class="icon ic_sbsc <#if success>active</#if>"></p>
                                <p class="result_msg">${(resultMessage) !}</p>
                            </div>
                        </div>
                    </div>
                    <div class="bottom">
                        <#if !success>
                            <ul>
                                <li class="fl"><input class="btn_type02 dark btn_retry" type="button" value="재시도" /></li>
                                <li class="fr"><input class="btn_type03 btn_submit" id="btn_submit" type="button" value="확인" /></li>
                            </ul>
                        <#else>
                            <input class="btn_type03 btn_submit" id="btn_submit" type="button" value="확인" />
                        </#if>
                    </div>
                </form>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script>
        var projectId = '${projectId}';
    </script>
    <script type="text/javascript" src="/js/sbsc/result.js"></script>

    </@layout.put>

</@layout.extends>