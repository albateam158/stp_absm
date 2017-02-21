package com.stp.absm.controller;

import com.google.gson.Gson;
import com.stp.absm.model.*;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@RestController
public class NoticeController extends RootController {


    @RequestMapping(value = "/knotice/list/{boardId}", method = RequestMethod.GET)
    public ModelAndView knoticeList(
            @PathVariable(value = "boardId") final Integer boardId,
            ModelAndView mav
    ) {
        KamsBoardSetting kamsBoardSetting = kBoardSettingRepository.findOne(boardId);
        mav.addObject("kamsBoardSetting", kamsBoardSetting);

        mav.setViewName("notice/k_notice_list");
        mav.addObject("boardId", boardId);

        return mav;
    }

    @RequestMapping(value = "/knotice/read_form/{boardId}", method = RequestMethod.GET)
    public ModelAndView knoticeReadForm(
            @PathVariable(value = "boardId") final Integer boardId,
            @RequestParam(value = "uid", required = false) Integer uid,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        KamsBoardSetting kamsBoardSetting = kBoardSettingRepository.findOne(boardId);
        mav.addObject("kamsBoardSetting", kamsBoardSetting);

        KamsBoardContent notice = new KamsBoardContent();
        if (uid != null) {
            notice = kBoardContentRepository.findOne(uid);
        }
        mav.addObject("boardId", boardId);
        mav.addObject("notice", notice);
        mav.setViewName("notice/k_notice_read_form");
        return mav;
    }

    @RequestMapping(value = "/knotice/form/{boardId}", method = RequestMethod.GET)
    public ModelAndView knoticeForm(
            @PathVariable(value = "boardId") final Integer boardId,
            @RequestParam(value = "uid", required = false) Integer uid,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        KamsBoardSetting kamsBoardSetting = kBoardSettingRepository.findOne(boardId);
        mav.addObject("kamsBoardSetting", kamsBoardSetting);

        KamsBoardContent notice = new KamsBoardContent();
        if (uid != null) {
            notice = kBoardContentRepository.findOne(uid);
        }

        List<KamsBoardAttached> attachList = kBoardAttachedRepository.findByContentUidOrderByUidDesc(uid);

        mav.addObject("boardId", boardId);
        mav.addObject("notice", notice);
        mav.setViewName("notice/k_notice_form");
        return mav;
    }

    @RequestMapping(value = "/knotice/form/{boardId}", method = RequestMethod.POST)
    public Map<String, Object> knoticeFormSubmit(
            @PathVariable(value = "boardId") final Integer boardId,
            @RequestParam(value = "uid", required = false) Integer uid,
            @RequestParam(value = "title", required = true) String title,
            @RequestParam(value = "content", required = false) String content,
            @RequestParam(value = "fileUid1", required = false) Integer fileUid1,
            @RequestParam(value = "fileUid2", required = false) Integer fileUid2,
            @RequestParam(value = "fileUid3", required = false) Integer fileUid3,
            @RequestParam(value = "fileUid4", required = false) Integer fileUid4,
            @RequestParam(value = "fileUid5", required = false) Integer fileUid5,
            WebRequest request
    ) {

        Map<String, Object> result = new HashMap<String, Object>();

        KamsBoardSetting kamsBoardSetting = kBoardSettingRepository.findOne(boardId);
        result.put("kamsBoardSetting", kamsBoardSetting);

        KamsBoardContent notice = new KamsBoardContent();
        Date now = new Date();
        String today = DateFormatUtils.format(now, "yyyyMMddHHmmss");

        XUser user = (XUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (uid != null) {
            notice = kBoardContentRepository.findOne(uid);
            notice.setDate(today);
        } else {
            notice.setUpdate(today);
        }
        notice.setTitle(title);
        notice.setContent(content);
        notice.setBoardId(boardId);
        notice.setParentUid(0);
        notice.setMemberUid(Integer.valueOf(user.getUserId()));
        kBoardContentRepository.save(notice);

        if (fileUid1 > 0) {
            KamsBoardAttached kamsBoardAttached1 = kBoardAttachedRepository.findOne(fileUid1);
            kamsBoardAttached1.setContentUid(notice.getUid());
            kBoardAttachedRepository.save(kamsBoardAttached1);
        }
        if (fileUid2 != null) {
            KamsBoardAttached kamsBoardAttached2 = kBoardAttachedRepository.findOne(fileUid2);
            kamsBoardAttached2.setContentUid(notice.getUid());
            kBoardAttachedRepository.save(kamsBoardAttached2);
        }
        if (fileUid3 != null) {
            KamsBoardAttached kamsBoardAttached3 = kBoardAttachedRepository.findOne(fileUid3);
            kamsBoardAttached3.setContentUid(notice.getUid());
            kBoardAttachedRepository.save(kamsBoardAttached3);
        }

        result.put("boardId", boardId);
        result.put("notice", notice);

        return result;
    }

    /**
     * 프로젝트 업데이트 목록 DIV
     *
     * @param keyword
     * @param pageable
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping(value = "/knotice/list_div/{boardId}", method = RequestMethod.GET)
    public ModelAndView knoticeListDiv(
            @PathVariable(value = "boardId") final Integer boardId,
            @RequestParam(value = "keyword", required = false) String keyword,
            Pageable pageable,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("keyword", keyword);
        params.put("pageable", pageable);
        params.put("boardId", boardId);

        keyword = "CONCAT('%', " + keyword + ", '%')";

        //int count = xNoticeRepository.countByTitleLikeAndDeleteDateIsNull(keyword);

        //List<XNotice> Notices = xNoticeRepository.findByTitleLikeAndDeleteDateIsNull(keyword);

        int count = kamsBoardMapper.selectBoardsCount(params);
        List<KamsBoardContent> Notices = kamsBoardMapper.selectBoards(params);

        int NoticeCount = 0;
//        for(KamsBoardContent Notice : Notices) {
//            int commentCount = xNoticeCommentRepository.countByNoticeIdAndDeleteDateIsNull(Notice.getNoticeId());
//
//            Notices.get(NoticeCount).setCommentCount(commentCount);
//            NoticeCount++;
//        }

        String paging = pagingUtil.getPagingLink((int) Math.ceil((double) count / pageable.getPageSize()), count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        //String paging = pagingUtil.getPagingLink((count / pagingUtil.getPageSize()) + 1, count, pageable.getPageNumber() + 1, request.getRequestURI(), params);

        mav.addObject("notices", Notices);
        mav.addObject("paging", paging);
        mav.addObject("boardId", boardId);

        mav.setViewName("notice/k_notice_list_div");

        return mav;
    }


    @RequestMapping(value = "/knotice/upload", method = RequestMethod.POST)
    public Map<String, Object> projectUpload(
            @RequestParam(value = "uploadedFile", required = true) String uploadedFile,
            HttpServletRequest request
    ) {
        Map<String, Object> map = new HashMap<String, Object>();
        Date now = new Date();
        String today = DateFormatUtils.format(now, "yyyyMMddHHmmss");

        KamsBoardAttached kamsBoardAttached = gson.fromJson(uploadedFile, KamsBoardAttached.class);
        kamsBoardAttached.setDate(today);
        kamsBoardAttached.setFilePath(kamsBoardAttached.getUrl());
        kBoardAttachedRepository.save(kamsBoardAttached);

        map.put("file", kamsBoardAttached);

        return map;
    }


    @RequestMapping(value = "knotice/{noticeId}", method = RequestMethod.GET)
    public ModelAndView updateDetail(
            @PathVariable(value = "noticeId") final Integer NoticeId,
            ModelAndView mav,
            HttpServletRequest request
    ) {
        XNotice notice = xNoticeRepository.findOne(NoticeId);

        List<XNoticeComment> comments = xNoticeMapper.selectNoticeComments(new HashMap<String, Object>() {{

            put("noticeId", NoticeId);
            put("pageable", null);
        }});

        int commentCount = 0;

        for (XNoticeComment comment : comments) {
            List<XNoticeComment> replies = comment.getReplies();

            Gson gson = new Gson();
            String replyString = gson.toJson(replies);

            comments.get(commentCount).setReplies(replies);
            comments.get(commentCount).setReplyString(replyString);

            commentCount++;
        }

        notice.setComments(comments);

        mav.addObject("notice", notice);
        mav.setViewName("notice/k_notice_form");
        return mav;
    }


    /**
     * 프로젝트 업데이트 댓글 삭제
     *
     * @param NoticeId
     * @param commentId
     * @param request
     * @return
     */
    @RequestMapping(value = "/notice/{NoticeId}/comment/{commentId}", method = RequestMethod.DELETE)
    public Map<String, Object> NoticeCommentDelete(
            @PathVariable(value = "noticeId") final Integer NoticeId,
            @PathVariable(value = "commentId") final Integer commentId,
            WebRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();

        XNoticeComment NoticeComment = xNoticeCommentRepository.findOne(commentId);

        if (NoticeComment.getParentCommentId() == commentId) {
            NoticeComment.setAdminDeleteDate(new Date());
        } else {
            NoticeComment.setDeleteDate(new Date());
        }

        xNoticeCommentRepository.save(NoticeComment);

        return result;
    }
//
//
//

    /**
     * 프로젝트 업데이트 삭제
     *
     * @param NoticeIds
     * @param request
     * @return
     */
    @RequestMapping(value = "/notice", method = RequestMethod.DELETE)
    public Map<String, Object> NoticeUpdateDelete(
            @RequestParam(value = "noticeIds", required = true) String NoticeIds,
            WebRequest request
    ) {
        Map<String, Object> result = new HashMap<String, Object>();

        String[] NoticeIdsArr = NoticeIds.split(",");

        for (String sNoticeId : NoticeIdsArr) {
            int NoticeId = Integer.parseInt(sNoticeId);
            XNotice Notice = xNoticeRepository.findOne(NoticeId);
            Notice.setDeleteDate(new Date());

            xNoticeRepository.save(Notice);
        }

        return result;
    }


}
