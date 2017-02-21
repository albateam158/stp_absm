<@layout.extends name="layout/base.ftl">
    <@layout.put block="head">
    <style type="text/css">

    </style>
    </@layout.put>
    <@layout.put block="contents">

    <div class="container-fluid container-fixed-lg bg-white p-t-30 p-b-10 text-center">
            <h1 class="error-number">500</h1>
            <h2 class="semi-bold">서버 오류가 발생하였습니다. 관리자에게 문의하여 주세요.</h2>
            <#--<p>This page you are looking for does not exsist <a href="#">Report this?</a>-->
            </p>
            <#--<div class="error-container-innner text-center">-->
                <#--<form>-->
                    <#--<div class="form-group form-group-default input-group transparent text-left">-->
                        <#--<label>Search</label>-->
                        <#--<input class="form-control" placeholder="Try searching the missing page" type="email">-->
                        <#--<span class="input-group-addon pg-search"></span>-->
                    <#--</div>-->
                <#--</form>-->
            <#--</div>-->
        </div>
    </@layout.put>
</@layout.extends>