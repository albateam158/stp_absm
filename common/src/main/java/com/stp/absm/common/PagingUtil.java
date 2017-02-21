package com.stp.absm.common;

import java.util.Map;

import java.util.Map;
import java.util.Set;

public class PagingUtil {

	private int blockSize 	= 10;

	public String getPagingLink(int totalPageCount, int totalItemCount, int currentPage, String requestUri, Map params ){


		if( totalPageCount == 0 ) totalPageCount = 1;
//		StringBuffer paramsBf = new StringBuffer();
//
//		Set<Object> keySet = params.keySet();
//
//		for (Object key : keySet) {
//
//			Object obj = params.get(key.toString());
//
//			if( obj == null ) continue;
//
//			String value = obj.toString();
//
//			paramsBf.append(key + "=" + value + "&");
//		}

		String request = requestUri + "?"; // + paramsBf.toString();

//		if( totalItemCount % pageSize > 0) totalPageCount++;

		int currentBlock = ( currentPage / blockSize ) + 1;

		if( currentPage % blockSize == 0 ) currentBlock--;

		int prevPage = ((currentPage-1)==0)?1:(currentPage);
		int nextPage = ((currentPage+1)>totalPageCount)?totalPageCount:(currentPage);


		int endBlock = currentBlock * blockSize;
		if (endBlock > totalPageCount) endBlock = totalPageCount;

		StringBuffer buf = new StringBuffer();

		buf.append("<div class=\"row\">\n");
		buf.append("	<div class=\"col-sm-5\">\n");
		buf.append("		<div class=\"dataTables_info\" id=\"notice_list_table_info\" role=\"status\" aria-live=\"polite\">\n");
		buf.append("		Showing 1 to 10 of 57 entries\n");
		buf.append("		</div>\n");
		buf.append("	</div>\n");
		buf.append("	<div class=\"col-sm-7\">\n");
		buf.append("		<div class=\"dataTables_paginate paging_simple_numbers\" id=\"notice_list_table_paginate\">\n");
		buf.append("			<ul class=\"pagination\">\n");




		if( currentPage > 1 ){
//			buf.append("<li class='arrow_left'><a href='" + request + "page=" + (prevPage-2) + "'><i class=\"fa fa-angle-left\"></i></a></li>");

			buf.append("<li class=\"paginate_button previous \" id=\"notice_list_table_previous\">\n" +
					"<a href='" + request + "page=" + (prevPage-2) + "' aria-controls=\"notice_list_table\" data-dt-idx=\"0\" tabindex=\"0\">Previous</a></li>");

		}else{
			buf.append("<li class=\"paginate_button previous disabled\" id=\"notice_list_table_previous\">\n" +
					"<a aria-controls=\"notice_list_table\" data-dt-idx=\"0\" tabindex=\"0\">Previous</a></li>");
//			buf.append("<li class='arrow_left'><a class='disable'><i class=\"fa fa-angle-left\"></a></i></li>");
		}



		int startBlock = ((currentBlock * blockSize) - blockSize) + 1;

		for(int i = startBlock; i <= endBlock; i++){

			if( i == startBlock ){

				if ( i == currentPage){

//					buf.append("<li><a href=\"#\" class=\"active\">" +  i  + "</a></li>");
					buf.append("<li class=\"paginate_button active\">\n" +
							"<a  aria-controls=\"notice_list_table\" data-dt-idx=\""+i+"\" tabindex=\"0\">" +  i  + "</a></li>");

				} else {

//					buf.append("<li><a href='" + request + "page=" + (i-1) + "'>" +  i  + "</a></li>");
					buf.append("<li class=\"paginate_button\">\n" +
							"<a href='" + request + "page=" + (i-1) + "' aria-controls=\"notice_list_table\" data-dt-idx=\""+i+"\" tabindex=\"0\">" +  i  + "</a></li>");
				}

			}else{

				if ( i == currentPage){

//					buf.append("<li><a href=\"#\" class=\"active\">" +  i  + "</a></li>");
					buf.append("<li class=\"paginate_button active\">\n" +
							"<a aria-controls=\"notice_list_table\" data-dt-idx=\""+i+"\" tabindex=\"0\">" +  i  + "</a></li>");
				} else {

//					buf.append("<li><a href='" + request + "page=" + (i-1) + "'>" +  i  + "</a></li>");
					buf.append("<li class=\"paginate_button\">\n" +
							"<a href='" + request + "page=" + (i-1) + "' aria-controls=\"notice_list_table\" data-dt-idx=\""+i+"\" tabindex=\"0\">" +  i  + "</a></li>");
				}

			}


		}


		if(currentPage < totalPageCount){

			buf.append("<li class=\"paginate_button next\" id=\"notice_list_table_next\">\n" +
//					"<a href='" + request + "page=" + nextPage + "'><i class=\"fa fa-angle-right\"></i></a></li>");
			"<a href='" + request + "page=" + nextPage + "' aria-controls=\"notice_list_table\" data-dt-idx=\""+endBlock+"\" tabindex=\"0\">Next</a></li>");

		}else{

//			buf.append( "<li class='arrow_right'><a class='disable'><i class=\"fa fa-angle-right\"></a></i></li>");
			buf.append("<li class=\"paginate_button next disabled\" id=\"notice_list_table_next\">\n" +
					"<a aria-controls=\"notice_list_table\" data-dt-idx=\""+endBlock+"\" tabindex=\"0\">Next</a></li>");
		}

		buf.append("</ul></div></div></div>");

		return  buf.toString();

	}


	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}



}
