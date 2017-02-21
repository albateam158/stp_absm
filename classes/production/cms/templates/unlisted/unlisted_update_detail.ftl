<@layout.extends name="layout/base.ftl">
    <@layout.put block="head">
    </@layout.put>
    <@layout.put block="contents">

    <!-- START JUMBOTRON -->
    <div class="jumbotron" data-pages="parallax">
        <div class="container-fixed-lg">
            <div class="row">
                <!-- START BREADCRUMB -->
                <ul class="breadcrumb">
                    <li><a>Home</a></li>
                    <li><a>Unlisted</a></li>
                    <li><a>Update</a></li>
                    <li><a class="active">Detail</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>비상장기업 업데이트</h3>
                            <p>WiCrowd 비상장기업 업데이트 상세 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->



    <div class="container-fluid container-fixed-lg">
        <form id="frmData" role="form" autocomplete="off">
            <input type="hidden" name="unlistedId" value="${(update.unlistedId) !}">
            <input type="hidden" name="updateId" value="${(update.updateId) !}">
            <!-- START PANEL -->
            <div class="panel panel-default">
                <div class="panel-heading">

                </div>
                <div class="panel-body no-scroll ">
                    <label>제목</label>
                    <input type="text" name="title" class="form-control" value="${(update.title) !}" required>
                    <br>
                    <label>내용</label>
                    <div class="summernote-wrapper">
                        <div id="summernote" style="min-height: 200px;">${(update.content) !}</div>
                    </div>
                </div>
            </div>
            <!-- END P /Update Comment -->
        </form>

        <!-- Update Comment -->
        <div class="table-responsive">
            <table class="table table-hover table-condensed table-detailed" id="commentTable">
                <thead>
                <tr>
                    <th style="width:25%">User</th>
                    <th style="width:25%">Content</th>
                    <th style="width:25%">Regist Date</th>
                    <th style="width:25%">Etc.</th>
                </tr>
                </thead>
                <tbody>
                <#if update.comments?has_content>
                    <#list update.comments as comment>
                        <#assign comment_total=update.comments?size>
                        <#if !comment.deleteDate?exists>
                    <tr comment_id="${(comment.commentId) !}" replyString="${(comment.replyString?js_string?replace("\"", "\'")) !}">
                        <td class="v-align-middle semi-bold">${(comment.user.name) !}</td>
                        <td class="v-align-middle">${(comment.content) !}</td>
                        <td class="v-align-middle semi-bold">${(comment.regDate?datetime) !}</td>
                        <td class="v-align-middle">
                            <#if !comment.adminDeleteDate?exists>
                            <button class="btn btn-danger btn-xs m-t-10 comment_del_btn">Delete</button>
                            <#else>
                                삭제됨
                            </#if>
                        </td>
                    </tr>
                        </#if>
                    </#list>
                <#else>
                    <tr>
                        <td colspan="4">등록된 댓글이 없습니다.</td>
                    </tr>
                </#if>
                </tbody>
            </table>
        </div>
        <!-- /Update Comment -->

        <button class="btn btn-primary btn-cons pull-right m-b-10 go-list" style="margin-top: 20px;" type="button">
            <i class="pg-form"></i>
            <span class="bold">List</span>
        </button>
    </div>






    </@layout.put>


    <@layout.put block="script">
    <script src="/assets/plugins/jquery-datatable/media/js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="/assets/plugins/jquery-datatable/extensions/TableTools/js/dataTables.tableTools.min.js" type="text/javascript"></script>
    <script src="/assets/plugins/jquery-datatable/extensions/Bootstrap/jquery-datatable-bootstrap.js" type="text/javascript"></script>
    <script type="text/javascript" src="/assets/plugins/datatables-responsive/js/datatables.responsive.js"></script>
    <script type="text/javascript" src="/assets/plugins/datatables-responsive/js/lodash.min.js"></script>

    <script src="/assets/js/tables.js" type="text/javascript"></script>
    <script type="text/javascript">
        var mainId = 2, subId = 0;
        var unlistedId = '${(update.unlistedId) !}';
        var updateId = '${(update.updateId) !}';

        $( document ).ready(function()
        {
            $('#summernote').summernote({
                onImageUpload : function(files, editor, welEditable) {
                    var formData = new FormData();
                    formData.append("file", files[0]);

                    console.log(files[0]);

                    var xUpload = new XUpload();
                    var uploadResult = xUpload.crossUpload(formData, function (data) {
                        editor.insertImage(welEditable, data.url);
                    });
                },
                oninit : function () {
                    $('.note-editable').css('min-height','300px');
                }
            });


            $('.go-list').click(function () {
                document.location.href = '/unlisted/'+unlistedId+'/update';
            });

            var _format = function(d, replyString) {
                // `d` is the original data object for the row<button class="btn btn-danger btn-xs m-t-10">Delete</button>
                var replyList = JSON.parse(replyString.replace(/\\'/g, '"'));
                var return_string = '';

                if(replyList.length > 0) {
                    if(replyString != '') {
                        var replyList = JSON.parse(replyString.replace(/\\'/g, '"'));

                        return_string = '<table class="table table-inline">';
                        $(replyList).each(function(i, v){
                            return_string += '<tr comment_id="'+ v.commentId+'">' +
                                    '<td>'+v.content+'</td>' +
                                    '<td>'+v.user.name+'</td>' +
                                    '<td><button class="btn btn-danger btn-xs m-t-10 comment_del_btn">Delete</button></td>' +
                                    '</tr>';
                        });
                        return_string += '</table>';
                    }
                }
                else {
                    return '<table class="table table-inline">' +
                            '<tr colspan="3">' +
                            '<td>등록된 댓글이 없습니다.</td>' +
                            '</tr>' +
                            '</table>';

                }

                return return_string;
            }

            var table = $('#commentTable');
            var table_flag = false;

            // Add event listener for opening and closing details
            $('#commentTable tbody').on('click', 'tr', function() {
                //var row = $(this).parent()
                if ($(this).hasClass('shown') && $(this).next().hasClass('row-details')) {
                    $(this).removeClass('shown');
                    $(this).next().remove();
                    return;
                }

                var tr = $(this).closest('tr');
                if($(tr).attr('replyString') != undefined) {

                    if(!table_flag) {
                        table.DataTable({
                            "sDom": "t",
                            "scrollCollapse": true,
                            "paging": false,
                            "bSort": false
                        });

                        table_flag = true;
                    }

                    var row = table.DataTable().row(tr);

                    $(this).parents('tbody').find('.shown').removeClass('shown');
                    $(this).parents('tbody').find('.row-details').remove();

                    row.child(_format(row.data(), $(tr).attr('replyString'))).show();
                    tr.addClass('shown');
                    tr.next().addClass('row-details');
                }
            });


            $(document).on('click', '.comment_del_btn', function () {
                var commentId = $(this).closest('tr').attr('comment_id');
                NoticeCommon.Dialog.confirm({
                    content: '선택된 댓글을 삭제하시겠습니까?'
                    ,ok: function(){
                        $.ajax({
                            url: "/unlisted/"+unlistedId+"/update/"+updateId+"/comment/"+commentId,
                            type: "DELETE",
                            dataType: 'json',
                            data: '',
                            success: function (result) {
                                location.reload();
                            }
                        });
                    }
                });
            });


        });

        function setStringToNumber(val, sel) {
            return val.replace(/,/gi, '');
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                    results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

    </script>
    </@layout.put>
</@layout.extends>