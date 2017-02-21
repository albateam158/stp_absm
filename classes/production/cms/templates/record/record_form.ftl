<@layout.extends name="layout/base.ftl">
    <@layout.put block="head">
    <style type="text/css">

    </style>
    </@layout.put>
    <@layout.put block="contents">
    <!-- START JUMBOTRON -->
    <div class="jumbotron" data-pages="parallax">
        <div class="container-fixed-lg">
            <div class="row">
                <!-- START BREADCRUMB -->
                <ul class="breadcrumb">
                    <li><a>Home</a></li>
                    <li><a>Record</a></li>
                    <li><a class="active">Add</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Record</h3>
                            <p>실적 등록 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->



    <div class="container-fluid container-fixed-lg">
        <form id="frmData" role="form" autocomplete="off">
            <input type="hidden" id="formType" value="<#if record?exists>update<#else>insert</#if>">
            <input type="hidden" name="id" value="<#if record?exists>${(record.id) !}</#if>">
            <!-- START PANEL -->
            <div class="panel panel-default">
                <div class="row">
                    <div class="col-sm-9">
                        <div class="panel-body">
                            <h5>
                                손익 입력
                            </h5>

                            <div class="row">

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>일자</label>
                                        <div class="datepicker-component input-group date">
                                            <input type="text" name="dt" class="form-control" value="${(record.dt) !}" data-format="yyyymmdd" required>
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>부서</label><br/>
                                        <select class="cs-select cs-skin-slide" name="deptCd" data-init-plugin="cs-select" required>
                                            <#list dzDepts as dzDept>
                                                <option value="${dzDept.deptCd}" <#if record?exists  && record.deptCd == dzDept.deptCd>selected</#if> >${dzDept.deptNm}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>상품</label><br/>
                                        <select class="cs-select cs-skin-slide" name="prod" data-init-plugin="cs-select" required>
                                            <#list kProdCodes as kProdCode>
                                                <option value="${kProdCode.prod}" <#if record?exists  && record.prod == kProdCode.prod>selected</#if> >${kProdCode.prodNm}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>계정</label><br/>
                                        <select class="cs-select cs-skin-slide" name="acc" data-init-plugin="cs-select" required>
                                            <#list kAccCodes as kAccCode>
                                                <option value="${kAccCode.acc}" <#if record?exists  && record.acc == kAccCode.acc>selected</#if> >${kAccCode.accNm}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>금액</label>
                                        <div class="required">
                                            <input type="text" name="amtString" class="form-control number" value="${(record.amt) !}" required>
                                            <input type="hidden" name="amt" class="form-control" value="${(record.amt) !}">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>내용</label>
                                        <input type="text" name="contents" class="form-control" value="${(record.contents)!}"  >
                                    </div>
                                </div>

                            </div>


                            <h5>
                                타부서 보전손익
                            </h5>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>부서</label><br/>
                                        <select class="cs-select cs-skin-slide" name="fixDeptCd" data-init-plugin="cs-select" required>
                                            <#list dzDepts1 as dzDept>
                                                <option value="${dzDept.deptCd}" <#if record?exists  && record.fixDeptCd == dzDept.deptCd>selected</#if> >${dzDept.deptNm}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>조정금액</label>
                                        <div class="required">
                                            <input type="text" name="fixAmtString" class="form-control number" value="${(record.fixAmt) !}" required>
                                            <input type="hidden" name="fixAmt" class="form-control" value="${(record.fixAmt) !}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">

                                <div id="paging_div" class="table-responsive m-t-30">
                                    <h5>
                                        손익 목록
                                    </h5>
                                    <div class="col-sm-12 text-center" style="padding:100px 0;">
                                        <div class="progress-circle-indeterminate"></div>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>

                </div>


            </div>
            <div class="pull-left">
                <button class="btn btn-danger btn-cons pull-left delete" style="min-width:100px;">
                    <i class="pg-trash"></i> <span>Delete</span>
                </button>
            </div>
            <div class="clearfix padding-10">
                <button class="btn btn-primary btn-cons pull-right m-b-10" type="submit">
                    <i class="pg-form"></i>
                    <span class="bold">저장</span>
                </button>
                <button class="btn btn-primary btn-cons pull-right m-b-10 go-list" type="button">
                    <i class="pg-form"></i>
                    <span class="bold">입력</span>
                </button>
            </div>
            <!-- END PANEL -->
        </form>
    </div>

    </@layout.put>


    <@layout.put block="script">

    <script src="/assets/plugins/boostrap-form-wizard/js/jquery.bootstrap.wizard.min.js" type="text/javascript"></script>
    <script src="/assets/js/form_wizard.js" type="text/javascript"></script>
    <script src="/assets/plugins/dropzone/dropzone.js" type="text/javascript"></script>
    <script src="/xeditor/js/xeditor.js"></script>
    <script type="text/javascript">
        var mainId = 6, subId = 1;
        $( document ).ready(function()
        {


            var paging = new Paging('#paging_div', '#record_list_table', '/record/form_list_div', 'dt', 'desc', '#frmData', function(){

            });


            paging.initPaging();

            $('.go-list').click(function () {
                $.ajax({
                    url: '/record/form',
                    type: 'GET',
                    dataType: 'json',
                    data: $('#frmData').serialize(),
                    error: function (result) {
                        alert(result);
                        console.log(result);
                    },
                    success: function (result) {
                        console.log(result);

                        if($('#form_type').val())
                        {
                            alert('수정 성공하였습니다.');
                        }
                        else {
                            alert('등록 성공하였습니다.');
                            location.href = '/record/form';
                        }
                    }
                });
            });


            $('#frmData').submit(function(){

                var alert_message = '등록 성공하였습니다.';

                if($('#formType').val() == 'update')
                {
                    alert_message = '수정 성공하였습니다.';
                }
                console.log($(this)[0]);

                var formData = new FormData($(this)[0]);

                //alert($('#frmData').serialize());
                //var formData = new FormData($('#frmData')[0]);
//alert(formData);
                $.ajax({
                    url: '/record/form',
                    type: 'POST',
                    dataType: 'json',
                    data: $('#frmData').serialize(),
                    error: function (result) {
                        alert(result);
                        console.log(result);
                    },
                    success: function (result) {
                        console.log(result);

                        if($('#form_type').val())
                        {
                            alert('수정 성공하였습니다.');
                        }
                        else {
                            alert('등록 성공하였습니다.');
                            location.href = '/record/form';
                        }
                    }
                });
                return false;
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

        // 카테고리 삭제 버튼
        $("button.delete").click(function()
        {
            var record_ids = "";
            var record_count = 0;

            $("#record_list_div tbody .unit").each(function() {
                if($(this).is(':checked'))
                {
                    if(record_count == 0) {
                        record_ids = $(this).parent().parent().parent().attr('recordId');
                    } else {
                        record_ids += ',' + $(this).parent().parent().parent().attr('recordId');
                    }
                    record_count++;
                }
            });

            if(record_count == 0) {
                NoticeCommon.Dialog.alert('체크박스를 선택해주세요.');
                return false;
            } else {
                NoticeCommon.Dialog.confirm({
                    content: '카테고리를 삭제하시겠습니까?'
                    ,ok: function(){
                        $.ajax({
                            url: "/record/form?id="+record_ids,
                            type: "DELETE",
                            dataType: 'json',
                            success: function (result) {
                                location.reload();
                            }
                        });
                    }
                });
            }
        });

    </script>
    </@layout.put>
</@layout.extends>