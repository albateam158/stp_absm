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
                    <li><a>Unlisted</a></li>
                    <li><a class="active">Add</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="col-lg-4 no-padding m-b-10">
                            <h3>Unlisted</h3>
                            <p>WiCrowd 비상장기업 등록 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->

    <!-- START CONTAINER FLUID -->
    <div class="container-fluid container-fixed-lg">
        <div id="rootwizard">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs nav-tabs-linetriangle nav-tabs-separator nav-stack-sm">
                <li class="active">
                    <a data-toggle="tab" href="#tab1"><i class="fa fa-file-text tab-icon"></i> <span>Basic Information</span></a>
                </li>
                <#--<li <#if !(unlisted)?exists>style="display: none;"</#if>>-->
                    <#--<a data-toggle="tab" href="#update" url="/unlisted/update/list?unlistedId=${(unlisted.unlistedId) !}"><i class="fa fa-list-alt tab-icon"></i> <span>Project Update</span></a>-->
                <#--</li>-->
                <#--<li <#if !(unlisted)?exists>style="display: none;"</#if>>-->
                    <#--<a data-toggle="tab" href="#feedback" url="/unlisted/feedback/list?unlistedId=${(unlisted.unlistedId) !}"><i class="fa fa-list-alt tab-icon"></i> <span>Project Feedback</span></a>-->
                <#--</li>-->
                <#--<li <#if !(unlisted)?exists>style="display: none;"</#if>>-->
                    <#--<a data-toggle="tab" href="#investors" url="/unlisted/investors/list?unlistedId=${(unlisted.unlistedId) !}"><i class="fa fa-list-alt tab-icon"></i> <span>Investors</span></a>-->
                <#--</li>-->
            </ul>

            <!-- START PANEL -->
            <div class="tab-content">
                <div class="tab-pane padding-20 active slide-left" id="tab1">
                    <form id="frmData" role="form" autocomplete="off">

                        <input type="hidden" name="unlistedId" value="${(unlisted.unlistedId) !}" />
                        <input type="hidden" id="form_type" value="${(unlisted.unlistedId) !}" />
                        <input type="hidden" id="unlistedContent" value="${(unlisted.content?html) !}" />


                        <div class="clearfix padding-10">
                            <button class="btn btn-primary btn-cons pull-right m-b-10" type="submit">
                                <i class="pg-form"></i>
                                <span class="bold">Submit</span>
                            </button>
                            <button class="btn btn-primary btn-cons pull-right m-b-10 go-list" type="button">
                                <i class="pg-form"></i>
                                <span class="bold">List</span>
                            </button>
                        </div>

                        <div class="row m-t-10">
                            <div class="col-md-6" style="padding-left:0;">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label>종목명</label>
                                            <input type="text" name="name" class="form-control" value="${(unlisted.name) !}" required>
                                        </div>
                                        <div class="form-group">
                                            <label>업종</label>
                                            <input type="text" name="businessType" class="form-control" value="${(unlisted.businessType) !}" required>
                                        </div>
                                        <div class="form-group">
                                            <label>분류</label><br/>
                                            <select class="cs-select cs-skin-slide" name="section" data-init-plugin="cs-select">
                                                <#list unlistedBusinessTypeCodes as unlistedBusinessTypeCode>
                                                    <option value="${unlistedBusinessTypeCode.code}" <#if unlisted?exists && unlistedBusinessTypeCode.code == unlisted.section?default('')>selected</#if>>${unlistedBusinessTypeCode.codeName}</option>
                                                </#list>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>자본금</label><br/>
                                            <input type="text" name="capital" class="form-control" style="width:90%; display: inline-block;margin-right: 5px;" value="${(unlisted.capital?default(0)) !}">백만원
                                        </div>
                                        <div class="form-group">
                                            <label>자산총계</label><br/>
                                            <input type="text" name="totalCapital" class="form-control" style="width:90%; display: inline-block;margin-right: 5px;" value="${(unlisted.totalCapital?default(0)) !}">백만원
                                        </div>
                                        <div class="form-group">
                                            <label>부채총계</label><br/>
                                            <input type="text" name="totalLiability" class="form-control" style="width:90%; display: inline-block;margin-right: 5px;" value="${(unlisted.totalLiability?default(0)) !}">백만원
                                        </div>
                                        <div class="form-group">
                                            <label>매출액</label><br/>
                                            <input type="text" name="sales" class="form-control" style="width:90%; display: inline-block;margin-right: 5px;" value="${(unlisted.sales?default(0)) !}">백만원
                                        </div>
                                        <div class="form-group">
                                            <label>영업이익</label><br/>
                                            <input type="text" name="businessProfits" class="form-control" style="width:90%; display: inline-block;margin-right: 5px;" value="${(unlisted.businessProfits?default(0)) !}">백만원
                                        </div>
                                        <#--<div class="form-group">-->
                                            <#--<label>당기순이익</label><br/>-->
                                            <#--<input type="text" name="termProfitsString" class="form-control number" style="width:90%; display: inline-block;margin-right: 5px;" value="${(unlisted.termProfits?default(0)) !}">원-->
                                            <#--<input type="hidden" name="termProfits" class="form-control" value="${(unlisted.termProfits) !}">-->
                                        <#--</div>-->
                                        <#--<div class="form-group">-->
                                            <#--<label>EPS</label><br/>-->
                                            <#--<input type="text" name="epsString" class="form-control number" style="width:90%; display: inline-block;margin-right: 5px;" value="${(unlisted.eps?default(0)) !}">원-->
                                            <#--<input type="hidden" name="eps" class="form-control" value="${(unlisted.eps) !}">-->
                                        <#--</div>-->
                                        <div class="form-group">
                                            <label>주요주주</label>
                                            <input type="text" name="majorStockholder" class="form-control" value="${(unlisted.majorStockholder?default("-")) !}">
                                        </div>
                                        <div class="form-group">
                                            <label>지분율</label><br/>
                                            <input type="text" name="stock" class="form-control" style="width:90%; display: inline-block;margin-right: 5px;" value="${(unlisted.stock?default(0)) !}">%
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6" style="padding-right:0;">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>대표이사</label>
                                                        <input type="text" name="ceo" class="form-control" value="${(unlisted.ceo?default("-")) !}">
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>대표전화</label>
                                                        <input type="text" name="phone" class="form-control" value="${(unlisted.phone?default("-")) !}">
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>직원수</label>
                                                        <input type="number" name="staff" class="form-control" value="${(unlisted.staff?default(0)) !}">
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>설립일</label>
                                                        <input type="text" name="establishDate" class="form-control" value="${(unlisted.establishDate?default("-")) !}">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>매매담당자</label>
                                                        <input type="text" name="managerName" class="form-control" value="${(unlisted.managerName?default("-")) !}">
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>매매담당자 전화번호1</label>
                                                        <input type="text" name="managerPhone1" class="form-control" value="${(unlisted.managerPhone1?default("-")) !}">
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>매매담당자 이메일</label>
                                                        <input type="text" name="managerEmail" class="form-control" value="${(unlisted.managerEmail?default("-")) !}">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                        <label>본사 주소</label>
                                                        <input type="text" name="address" class="form-control" value="${(unlisted.address?default("-")) !}">
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                        <label>홈페이지</label>
                                                        <input type="text" name="homepage" class="form-control" value="${(unlisted.homepage?default("-")) !}">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                        <label>결산월</label><br/>
                                                        <input type="number" name="settlementMonth" class="form-control" style="width:90%; display: inline-block;margin-right: 5px;" value="${(unlisted.settlementMonth?default(1)) !}">월
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                        <label>벤처기업</label>
                                                        <div class="radio radio-success">
                                                            <input type="radio" name="venture" value="Y" id="venture01" <#if unlisted?exists && unlisted.venture?default("Y") == "Y">checked<#else>checked</#if> />
                                                            <label for="venture01">지정</label>
                                                            <input type="radio" name="venture" value="N" id="venture02" <#if unlisted?exists && unlisted.venture?default("Y") == "N">checked</#if> />
                                                            <label for="venture02">미지정</label>
                                                            <input type="radio" name="venture" value="-" id="venture03" <#if unlisted?exists && unlisted.venture?default("Y") == "-">checked</#if> />
                                                            <label for="venture03">정해지지 않음</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">

                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>전체주식수</label>
                                                    <div class="required">
                                                        <input type="text" name="totalStockString" class="form-control number" value="${(unlisted.totalStock?default(0)) !}">
                                                        <input type="hidden" name="totalStock" class="form-control" value="${(unlisted.totalStock) !}">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>액면가</label>
                                                    <div class="required">
                                                        <input type="text" name="faceValueString" class="form-control number" value="${(unlisted.faceValue?default(0)) !}">
                                                        <input type="hidden" name="faceValue" class="form-control" value="${(unlisted.faceValue) !}">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>주권구분</label>
                                                    <div class="required">
                                                        <input type="text" name="stockSection" class="form-control" value="${(unlisted.stockSection?default("-")) !}">
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal -->
    <div class="modal fade slide-up disable-scroll" id="infoFormDiv" tabindex="-1" role="dialog" aria-hidden="false">
        <div class="modal-dialog ">
            <div class="modal-content-wrapper">
                <div class="modal-content">
                    <div class="modal-header clearfix text-left">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="pg-close fs-14"></i>
                        </button>
                        <h5>모집 정보 다운로드</h5>
                    </div>
                    <div class="modal-body">
                        <p>
                            파일을 만드는데 시간이 오래 걸릴 수 있습니다. <br/>파일 생성 완료 후 아래 생성되는 다운로드 링크를 클릭하여 해당 파일을 다운로드 해주세요.
                        </p>
                        <p>
                            <a href="#" id="unlisted_info_download"></a>
                        </p>
                        <div class="progress">
                            <div id="progress_div" class="progress-bar-indeterminate"></div>
                        </div>
                    <#--<div class="row">-->
                    <#--<div class="col-sm-8">-->
                    <#--<div class="p-t-20 clearfix p-l-10 p-r-10">-->
                    <#--<div class="pull-left">-->

                    <#--</div>-->
                    <#--<div class="pull-right">-->

                    <#--</div>-->
                    <#--</div>-->
                    <#--</div>-->
                    <#--<div class="col-sm-4 m-t-10 sm-m-t-10">-->
                    <#--<button type="button" class="btn btn-primary btn-block m-t-5 btn_admin_submit">확인</button>-->
                    <#--</div>-->
                    <#--</div>-->
                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
    </div>



    </@layout.put>





    <@layout.put block="script">

    <script src="/assets/plugins/boostrap-form-wizard/js/jquery.bootstrap.wizard.min.js" type="text/javascript"></script>
    <script src="/assets/js/form_wizard.js" type="text/javascript"></script>
    <script src="/assets/plugins/dropzone/dropzone.js" type="text/javascript"></script>
    <script src="/xeditor/js/xeditor.js"></script>
    <script type="text/javascript">
        var mainId = 9, subId = 0;
        var unlistedId = '${(unlisted.unlistedId)!}';

        $( document ).ready(function()
        {


            $('.go-list').click(function () {
                document.location.href = '/unlisted/list';
            });



            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                var target = $(e.target).attr("href") // activated tab
                var url = $(e.target).attr("url") // activated tab

                $(target).load(url, function(responseTxt, statusTxt, xhr){

                    if(statusTxt == "success") {

                        //alert("Error: " + xhr.status + ": " + xhr.statusText);

                    }

                    if(statusTxt == "error")
                        alert("Error: " + xhr.status + ": " + xhr.statusText);
                });
            });

            $('input.number').keyup(function(event) {

                // skip for arrow keys
                if(event.which >= 37 && event.which <= 40) return;

                // format number
                $(this).val(function(index, value) {
                    return value
                            .replace(/\D/g, "")
                            .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                            ;
                });
            });




            $('#frmData').submit(function(){
                // set string to number
//                $('input[name=capital]').val(setStringToNumber($('input[name=capitalString]').val()));
//                $('input[name=totalCapital]').val(setStringToNumber($('input[name=totalCapitalString]').val()));
//                $('input[name=totalLiability]').val(setStringToNumber($('input[name=totalLiabilityString]').val()));
//                $('input[name=sales]').val(setStringToNumber($('input[name=salesString]').val()));
//                $('input[name=businessProfits]').val(setStringToNumber($('input[name=businessProfitsString]').val()));
//                $('input[name=termProfits]').val(setStringToNumber($('input[name=termProfitsString]').val()));
//                $('input[name=eps]').val(setStringToNumber($('input[name=epsString]').val()));
                $('input[name=totalStock]').val(setStringToNumber($('input[name=totalStockString]').val()));
                $('input[name=faceValue]').val(setStringToNumber($('input[name=faceValueString]').val()));

                var formData = new FormData($('#frmData')[0]);
                //formData.append("content", $('#summernote').code());

                $.ajax({
                    url: '/unlisted/form',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    error: function (result) {
                        console.log(result);
                    },
                    success: function (result) {
                        console.log(result);

                        if($('#form_type').val())
                        {
                            NoticeCommon.Dialog.alert('수정 성공하였습니다.');
                        }
                        else {
                            NoticeCommon.Dialog.alert({
                                content: '등록 성공하였습니다.',
                                ok: function () {
                                    location.href = '/unlisted/form?unlistedId='+result.unlistedId;
                                }
                            });

                        }
                    }
                });
                return false;
            });

            $('#formSubmitBtn').click(function () {

                console.log($('#frmData').validate());

                if($('#frmData').validate()) {
                    $('#frmData').trigger('submit');
                }

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