<@layout.extends name="layout/modalBase.ftl">

    <@layout.put block="contents">
        <!-- MODAL dialog  -->
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header clearfix ">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="pg-close fs-14"></i>
                    </button>
                    <h4 class="category-title p-b-5"></h4>
                </div>

                <form role="form" name="frmCategory" class="chkData" autocomplete="off">
                    <input type="hidden" id="categoryImage" name="categoryImage" value="${(category.imageUrl) !}" />

                    <div class="modal-body">
                        <p class="small-text">카테고리 정보를 입력해주세요.</p>
                        <input type="hidden" name="category_id" value="${(category.categoryId)!}" />
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group form-group-default required">
                                    <label>카테고리명</label>
                                    <input type="text" name="category_name" class="form-control" value="${(category.name)!}" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group form-group-default required">
                                    <label>카테고리 타입</label>
                                    <div class="radio radio-success">
                                        <input type="radio" name="type" value="project" id="type01" <#if (category.type)?default("project") == "project">checked</#if> />
                                        <label for="type01">모집</label>
                                        <input type="radio" name="type" value="community" id="type02" <#if (category.type)?default("project") == "community">checked</#if> />
                                        <label for="type02">커뮤니티</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group form-group-default">
                                    <label>카테고리 이미지</label>
                                    <div id="category_image_div" style="background-image: url(<#if category?exists && category.imageUrl?exists>${category.imageUrl}<#else >'/assets/img/gallery/2_1.jpg'</#if>);background-size: contain;background-repeat: no-repeat;margin-bottom: 13px;min-height: 185px;"></div>
                                    <input type="file" name="imageUrl" id="category_image" class="form-control" >
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group form-group-default">
                                    <label>카테고리 모음</label>
                                    <div class="radio radio-success">
                                        <input type="checkbox" name="isCollect" <#if category?exists && category.isCollect?exists && category.isCollect?default("Y") == "Y">checked</#if>>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <#--<#if category?exists>-->
                            <#--<div class="row m-t-10">-->
                                <#--<div class="col-sm-12">-->
                                    <#--<div class="form-group">-->
                                        <#--<label>특집공고</label>-->
                                        <#--<span class="help">카테고리에 속한 기사들중 선택해주세요.</span>-->
                                        <#--<input type="hidden" name="featuredProjectId" value="${(category.featuredProjectId)!}" />-->
                                        <#--<div class="input-group">-->
                                            <#--<input type="text" name="featuredProjectName" class="form-control" readonly value="${(project.name)!}">-->
                                            <#--<a  class="input-group-addon btn-project-cancel">-->
                                                <#--<span>-->
                                                    <#--<i class="fa fa-close"></i>-->
                                                <#--</span>-->
                                            <#--</a>-->
                                            <#--<a  class="input-group-addon btn-project-list">-->
                                                <#--<span>-->
                                                    <#--<i class="fa fa-align-justify"></i>-->
                                                <#--</span>-->
                                            <#--</a>-->
                                        <#--</div>-->
                                    <#--</div>-->
                                <#--</div>-->
                            <#--</div>-->
                        <#--</#if>-->
                    </div>
                    <div class="modal-footer">
                        <input type="button" id="btn_category_submit" class="btn btn-primary" style="margin-right:0;" value="Submit" />
                    </div>
                </form>
            </div>
            <!-- /.modal-content -->
        </div>

        <div class="modal-dialog extra-dialog none">
            <div class="modal-content">
                <div class="modal-header clearfix ">
                    <button type="button" class="close">
                        <i class="pg-close fs-14"></i>
                    </button>
                    <h4 class="p-b-5"><span class="semi-bold">Project</span> List</h4>
                </div>
                <div class="modal-body" id="project_list_div"></div>
            </div>
        </div>
    </@layout.put>


    <@layout.put block="script">
    <script src="/xeditor/js/xeditor.js"></script>
    <script type="text/javascript">
        $( document ).ready(function() {
            var categoryId = $("input[name='category_id']").val();

            $('form.chkData').validate();

            // 카테고리 등록/수정
            $("#btn_category_submit").click(function()
            {
                var c_name = $("input[name='category_name']").val();
                var c_type = $('input[name=type]:checked').val();
                var data = 'categoryId='+ categoryId+'&type=' + c_type+'&name=' + c_name+'&categoryImage=' + $('input[name=categoryImage]').val()+'&isCollect=' + $('input[name=isCollect]').is(':checked');

                if(c_name) {
//                    if(categoryId) {
//                        var projectId = $("input[name='featuredProjectId']").val();
//                        data += '&featuredProjectId='+projectId;
//                    }

                    $.ajax({
                        url: '/category/form',
                        type: 'POST',
                        dataType: 'json',
                        data: data,
                        async: false,
                        cache: false,
                        success: function (result) {
                            location.reload();
                        }
                    });
                }
            });



            $('#category_image').change(function () {
                var formData = new FormData();

                formData.append("file", $(this)[0].files[0]);

                console.log($(this)[0].files[0]);

                var xUpload = new XUpload();
                var uploadResult = xUpload.crossUpload(formData, function (data) {
                    $("#category_image_div").css('background-image',"url("+data.url+")");

                    $('#categoryImage').val(data.url);
                });
            });




            $('.modal-dialog.extra-dialog button.close').click(function()
            {
                $('.modal-dialog.extra-dialog').addClass('none');
            });

//            $(".btn-project-list").click(function()
//            {
//                $('.modal-dialog.extra-dialog').removeClass('none');
//                var projectId = $("input[name='featuredProjectId']").val();
//
//                var paging = new Paging('#project_list_div', '#project_list', '/category/project_list?categoryId='+categoryId+'&featuredProjectId='+projectId+'&size=8', 'reg_date', 'desc', null, function(){
//                });
//                paging.initPaging();
//
//                paging.params = 'categoryId='+categoryId+'&featuredProjectId='+projectId+'&size=8';
//            });

//            $('.btn-project-cancel').click(function()
//            {
//                $("input[name='featuredProjectId']").val('');
//                $("input[name='featuredProjectName']").val('');
//            });
//
//            $(document).on('click', '.gallery-item', function(){
//               if($(this).hasClass('active')) {
//                   alert('이미 선택된 프로젝트 입니다.');
//                   return false;
//               } else {
//                   var projectId = $(this).find("input[name^=projectId]").val();
//                   var projectName = $(this).find("input[name^=projectName]").val();
//                   $("input[name='featuredProjectId']").val(projectId);
//                   $("input[name='featuredProjectName']").val(projectName);
//                   $('.modal-dialog.extra-dialog').addClass('none');
//               }
//            });
        });
    </script>
    </@layout.put>

</@layout.extends>