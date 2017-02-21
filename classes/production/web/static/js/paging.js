/**
 * Created by sj on 16. 3. 4..
 */
var Paging = function (pagingDiv, tableDiv, url, sortField, sortOrder, searchform, callback){

    this.pagingView = $(pagingDiv);
    this.searchform = $(searchform);
    this.tableDiv;
    this.url = url;
    this.sortField = sortField;
    this.sortOrder = sortOrder;
    this.finalUrl;
    this.size = 10;
    this.params;

    this.initPaging = function(){

        var paging = this;

        this.loadDiv();

        if( this.searchform ){

            this.searchform.submit(function(){

                paging.params = $(this).serialize();
                paging.loadDiv();

                return false;
            });
        }

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
    }

    this.loadDiv = function(){

        var paging = this;

        this.makeUrl();

        this.pagingView.load(this.finalUrl, function(responseTxt, statusTxt, xhr){

            if(statusTxt == "success") {

                paging.tableDiv=$(tableDiv);
                paging.initClick();
                paging.initSort();
                callback();
            }

            if(statusTxt == "error")
                alert("Error: " + xhr.status + ": " + xhr.statusText);
        });
    }

    this.initClick = function(){

        var paging = this;

        this.pagingView.find('.pagination').find('a').click(function(){

            paging.url = $(this).attr('href');

            paging.loadDiv();

            return false;
        });
    }

    this.initSort = function(){

        var paging = this;

        var sortThs = this.tableDiv.find('th.sort');

        for(var i=0; i<sortThs.length; i++){

            $(sortThs[i]).removeClass (function (index, css) {
                return (css.match (/(^|\s)sorting\S*/g) || []).join(' ');
            });

            $(sortThs[i]).addClass('sorting');
        }

        this.tableDiv.find('th[sort=' + this.sortField + ']').addClass('sorting_' + this.sortOrder);

        sortThs.click(function(){

            paging.sortField = $(this).attr('sort');

            if( $(this).hasClass('sorting_desc') == true ){

                paging.sortOrder = "asc";
            }else if( $(this).hasClass('sorting_asc') == true ){

                paging.sortOrder = "desc";
            }else{

                paging.sortOrder = "desc";
            }




            paging.loadDiv();
        });
    }

}