<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>

    <@layout.put block="contents">

        <div class="contents_wrap">
            <div class="content_box">
                <div class="form_box community">
                    <form id="frmData" method="">
                        <h2>커뮤니티</h2>
                        <div class="top">
                            <div class="update_box">
                                <div class="overflow-h mb10">
                                    <div class="input fl">
                                        <input type="text" name="title" class="full" placeholder="제목을 입력해주세요." value="${(community.title) !}" />
                                    </div>
                                    <div class="select_box fr category">
                                        <label>카테고리 선택</label>
                                        <select name="category" class="data select" text="카테고리 선택">
                                            <option value="">카테고리 선택</option>
                                            <#if categories?has_content>
                                                <#list categories as category>
                                                    <option value="${(category.categoryId) !}" <#if communityId?? && community.category == category.categoryId?string> selected </#if>>${(category.name) !}</option>
                                                </#list>
                                            </#if>
                                        </select>
                                    </div>
                                </div>
                                <div class="summernote-wrapper">
                                    <div id="summernote">${(community.content) !}</div>
                                </div>
                            </div>
                        </div>
                        <div class="bottom">
                            <ul>
                                <li class="fl"><a href="/community" class="btn_type02">취소</a></li>
                                <li class="fr"><a class="btn_type03 btn_submit">등록</a></li>
                            </ul>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </@layout.put>

    <@layout.put block="script">
    <link href="/boostrapv3/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="/summernote/css/summernote.css" rel="stylesheet" type="text/css" media="screen">
    <script src="/boostrapv3/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="/js/modernizr.custom.js" type="text/javascript"></script>
    <script src="/summernote/js/summernote.min.js" type="text/javascript"></script>
    <!-- BEGIN CORE TEMPLATE JS -->
    <link href="/pages/css/pages-icons.css" rel="stylesheet" type="text/css">
    <link href="/pages/css/pages.css" class="main-stylesheet" rel="stylesheet" type="text/css" />
    <script src="/pages/js/pages.min.js"></script>
    <script>
        var communityId = '${communityId !}';
    </script>
    <script type="text/javascript" src="/js/community/community_form.js"></script>
    </@layout.put>

</@layout.extends>