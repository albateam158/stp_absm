<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">
    <div class="contents_wrap">
        <div class="content_box">
            <div class="cont_bottom">
                <div class="tab_page">
                    <div class="tab_cont cont_update">
                        <div class="cont_list"></div>
                    </div>
                </div>
                <div class="loading"><img src="/images/bx_loader.gif" style="width: 32px; height: 32px;"/></div>
            </div>
        </div>
    </div>
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript" src="/js/update/list.js"></script>

    </@layout.put>

</@layout.extends>