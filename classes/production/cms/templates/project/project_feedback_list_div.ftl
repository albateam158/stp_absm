<#--<table id="project_feedback_list_table" class="table basic table-striped dataTable">-->
    <#--<thead>-->
    <#--<tr>-->
        <#--<th style="width:1%" class="v-align-middle text-left">-->
            <#--<div class="checkbox">-->
                <#--<input type="checkbox" id="checkbox0" class="unit all">-->
                <#--<label for="checkbox0"></label>-->
            <#--</div>-->
        <#--</th>-->
        <#--<th style="width:20%">#</th>-->
        <#--<th class="sort" sort="content" style="width:29%">내용</th>-->
        <#--<th style="width:29%">작성자</th>-->
        <#--<th style="width:29%">상태</th>-->
        <#--<th class="sort" sort="reg_date" style="width:15%">등록일</th>-->
    <#--</tr>-->
    <#--</thead>-->
    <#--<tbody>-->
    <#--<#if projectFeedbacks?has_content>-->
        <#--<#list projectFeedbacks as feedback>-->
        <#--<tr feedback_id="${(feedback.feedbackId) !}">-->
            <#--<td class="v-align-middle">-->
                <#--<div class="checkbox">-->
                    <#--<input type="checkbox" id="checkbox${feedback_index+1}" class="unit">-->
                    <#--<label for="checkbox${feedback_index+1}"></label>-->
                <#--</div>-->
            <#--</td>-->
            <#--<td class="v-align-middle text-center">-->
                <#--<p>${feedback.feedbackId}</p>-->
            <#--</td>-->
            <#--<td class="v-align-middle text-center">-->
                <#--<p><a href="#">${feedback.content}</a></p>-->
            <#--</td>-->
            <#--<td class="v-align-middle text-center">-->
                <#--<p>${feedback.user.name}</p>-->
            <#--</td>-->
            <#--<td class="v-align-middle text-center">-->
                <#--&lt;#&ndash;<p><#if feedback.deleteDate?exists || feedback.adminDeleteDate?exists>삭제<#else>정상</#if></p>&ndash;&gt;-->
                <#--<div class="radio radio-success">-->
                    <#--<input type="radio" value="no" name="feedbackStatus${feedback.feedbackId}" id="normal_${feedback.feedbackId}" <#if !feedback.deleteDate?exists && !feedback.adminDeleteDate?exists>checked</#if>>-->
                    <#--<label for="normal_${feedback.feedbackId}">정상</label>-->
                    <#--<input type="radio" value="yes" name="feedbackStatus${feedback.feedbackId}" id="delete_${feedback.feedbackId}" <#if feedback.deleteDate?exists || feedback.adminDeleteDate?exists>checked</#if>>-->
                    <#--<label for="delete_${feedback.feedbackId}">삭제</label>-->
                <#--</div>-->
            <#--</td>-->
            <#--<td class="v-align-middle text-center">-->
                <#--<p>${feedback.regDate?datetime}</p>-->
            <#--</td>-->
        <#--</tr>-->
        <#--</#list>-->
    <#--<#else>-->
    <#--<tr>-->
        <#--<td colspan="7" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>-->
    <#--</tr>-->
    <#--</#if>-->
    <#--</tbody>-->
<#--</table>-->

<table class="table table-hover table-condensed table-detailed" id="project_feedback_list_table2">
    <colgroup>
        <col style="width:65%;">
        <col style="width:10%;">
        <col style="width:15%;">
        <col style="width:10%;">
    </colgroup>
    <thead>
    <tr>
        <th style="width:25%">내용</th>
        <th style="width:25%">작성자</th>
        <th style="width:25%">등록일</th>
        <th style="width:25%">Etc.</th>
    </tr>
    </thead>
    <tbody>
    <#if projectFeedbacks?has_content>
        <#list projectFeedbacks as feedback>
            <tr feedback_id="${(feedback.feedbackId) !}" commentString="${(feedback.commentString?js_string?replace("\"", "\'")) !}">
                <td class="v-align-middle semi-bold" style="white-space: inherit;text-indent: -8px;">${(feedback.content?replace("\n", "<br>")) !} <span style="font-weight: bold;">[${(feedback.comments?size)}]</span></td>
                <td class="v-align-middle">${(feedback.user.name) !}</td>
                <td class="v-align-middle semi-bold">${feedback.regDate?datetime}</td>
                <td class="v-align-middle">
                    <#if feedback.adminDeleteDate?exists || feedback.deleteDate?exists>
                        <button class="btn btn-complete btn-xs m-t-10 delete_btn" delete="0" feedback="1">복원</button>
                    <#else>
                        <button class="btn btn-danger btn-xs m-t-10 delete_btn" delete="1" feedback="1">삭제</button>
                    </#if>

                </td>
            </tr>
        </#list>
    <#else>
    <tr>
        <td colspan="4">등록된 댓글이 없습니다.</td>
    </tr>
    </#if>
    </tbody>
</table>
${paging !}

<script src="/assets/plugins/jquery-datatable/media/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery-datatable/extensions/TableTools/js/dataTables.tableTools.min.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery-datatable/extensions/Bootstrap/jquery-datatable-bootstrap.js" type="text/javascript"></script>
<script type="text/javascript" src="/assets/plugins/datatables-responsive/js/datatables.responsive.js"></script>
<script type="text/javascript" src="/assets/plugins/datatables-responsive/js/lodash.min.js"></script>
<script src="/assets/js/tables.js" type="text/javascript"></script>
<script type="text/javascript">
    $( document ).ready(function()
    {
        var _format = function(d, replyString) {
            // `d` is the original data object for the row<button class="btn btn-danger btn-xs m-t-10">Delete</button>
            var replyList = JSON.parse(replyString.replace(/\\'/g, '"'));
            var return_string = '';

            if(replyList.length > 0) {
                if(replyString != '') {
                    var replyList = JSON.parse(replyString.replace(/\\'/g, '"'));

                    return_string = '<table class="table table-inline">';
                    return_string += '<colgroup>';
                    return_string += '<col style="width:66%;">';
                    return_string += '<col style="width:10%;">';
                    return_string += '<col style="width:16%;">';
                    return_string += '<col style="width:18%;">';
                    return_string += '</colgroup>';

                    $(replyList).each(function(i, v){
                        var d = new Date(v.regDate);

                        var curr_day = d.getDate();
                        var curr_month = d.getMonth();
                        var curr_year = d.getFullYear();

                        var curr_hour = d.getHours();
                        var curr_min = d.getMinutes();
                        var curr_sec = d.getSeconds();
                        var ampm = curr_hour >= 12 ? '오후' : '오전';
                        curr_hour = curr_hour % 12;
                        curr_hour = curr_hour ? curr_hour : 12; // the hour '0' should be '12'

                        curr_month++ ; // In js, first month is 0, not 1

                        var regDateString = curr_year+'.'+curr_month+'.'+curr_day+' '+ampm+' '+curr_hour+':'+addZero(curr_min)+':'+addZero(curr_sec);

                        return_string += '<tr comment_id="'+ v.commentId+'">' +
                                '<td style="white-space: normal;">'+v.content+'</td>' +
                                '<td>'+v.user.name+'</td>' +
                                '<td>'+regDateString+'</td>' +
                                '<td>';
                        console.log(v);
                        console.log(v.deleteDate);
                        console.log(v.adminDeleteDate);
                        if(v.deleteDate != undefined || v.adminDeleteDate != undefined) {
                            return_string += '<button class="btn btn-complete btn-xs m-t-10 delete_btn" delete="0" feedback="0">복원</button>';
                        }
                        else {
                            return_string += '<button class="btn btn-danger btn-xs m-t-10 delete_btn" delete="1" feedback="0">삭제</button>';
                        }



                        return_string +='</td>' +
                                '</tr>';
                    });
                    return_string += '</table>';
                }
            }
            else {
                return '<table class="table table-inline">' +
                        '<tr colspan="4">' +
                        '<td>등록된 댓글이 없습니다.</td>' +
                        '</tr>' +
                        '</table>';

            }

            return return_string;
        }

        var table = $('#project_feedback_list_table2');
        var table_flag = false;

        // Add event listener for opening and closing details
        $('#project_feedback_list_table2 tbody').on('click', 'tr', function() {
            //var row = $(this).parent()
            if ($(this).hasClass('shown') && $(this).next().hasClass('row-details')) {
                $(this).removeClass('shown');
                $(this).next().remove();
                return;
            }

            var tr = $(this).closest('tr');
            if($(tr).attr('commentString') != undefined) {

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

                row.child(_format(row.data(), $(tr).attr('commentString'))).show();
                tr.addClass('shown');
                tr.next().addClass('row-details');
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

    function addZero(val) {
        if(val < 10) {
            return '0'+val;
        }

        return val;
    }

</script>