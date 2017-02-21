/**
 * Created by sj on 16. 3. 4..
 */
var morePaging = function (pagingDiv, tableDiv, url, sortField, sortOrder, offset, limit, isAppend, callback){

    this.pagingView = $(pagingDiv);
    this.tableDiv;
    this.url = url;
    this.sortField = sortField;
    this.sortOrder = sortOrder;
    this.finalUrl;
    this.size = limit;
    this.offset = offset;
    this.isAppend = isAppend;
    this.params;

    this.initPaging = function(){

        var paging = this;

        this.makeUrl();
        this.loadDiv();
        this.initClick();

    };

    this.makeUrl = function(){

        this.finalUrl = this.url;

        if( this.finalUrl.indexOf("?") > -1 ){
            this.finalUrl += "&";
        }else{
            this.finalUrl += "?";
        }

        this.finalUrl += 'sort=' + this.sortField + "," + this.sortOrder;

        if( this.params ){
            this.finalUrl += "&" + this.params;
        }

        this.finalUrl += '&size=' + this.size;
        this.finalUrl += '&page=' + this.offset;
    }

    this.loadDiv = function(){

        var paging = this;

        this.makeUrl();

        $.get(this.finalUrl, function(data){
            if(paging.isAppend) {
                $(tableDiv).append(data);
            }
            else {
                $(tableDiv).html(data);
            }

            callback();

            var values = $("input.currentPage").map(function(index, el) { return parseInt($(el).val()); }).get();
            var maxPage = Math.max.apply(null, values);

            if(maxPage == $('input.totalPage').val()) {
                $(tableDiv).next('.more_btn').hide();
            }

        });
    }

    this.initClick = function(){

        var paging = this;

        this.pagingView.find('a.plus.more').click(function(){

            paging.isAppend = true;
            paging.offset = $(this).attr('page');
            $(this).attr('page', parseInt($(this).attr('page')) + 1);
            $('input[name=currentPage]').val($('input[name=currentPage]').val() + 1);

            paging.loadDiv();

            return false;
        });
    }


}