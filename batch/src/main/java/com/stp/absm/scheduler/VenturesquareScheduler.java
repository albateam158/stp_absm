package com.stp.absm.scheduler;

import it.sauronsoftware.feed4j.FeedIOException;
import it.sauronsoftware.feed4j.FeedXMLParseException;
import it.sauronsoftware.feed4j.UnsupportedFeedException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.transaction.*;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by sj on 16. 3. 14..
 */
@Component
public class VenturesquareScheduler {
    private final org.slf4j.Logger log = LoggerFactory.getLogger(VenturesquareScheduler.class);

    @Autowired
    private XMainNewsRepository xMainNewsRepository;

    @Value("${develop}")
    boolean develop;

    public static void main(String[] args) throws IOException {

        System.out.println("==== > start ");


        URL url = new URL("http://www.venturesquare.net/category/news");

        Document document = Jsoup.parse(url, 10000);

        int page = 1;

        do {
            if (document != null) {

                Elements posts = document.body().select(".post");

                XMainNews mainNews;

                if (posts.size() > 0) {

                    for (Element post : posts) {


                        try {
                            Elements textElement = post.select("p");

                            String description = textElement.get(0).text();//elementMatchValue(textElement.get(0).html(), "(.*)<a");

                            Elements contentElement = post.select(".content");

                            String titleString = contentElement.select("a").get(0).text();
                            String linkString = contentElement.select("a").get(0).attr("href");

                            Elements imageElement = post.select("img");
                            String imageUrlString = imageElement.attr("src");


                            String dateTime = Jsoup.parse(new URL(linkString), 10000).body().select(".value-title").get(0).attr("title");

                            Date pubDate = null;


                            Date smallDate = (new SimpleDateFormat("yyyy-M-d", Locale.KOREA)).parse(dateTime);


                            mainNews = new XMainNews();
                            mainNews.setTitle(titleString);
                            mainNews.setDescription(description);
                            mainNews.setImageUrl(imageUrlString);
                            mainNews.setLink(linkString);
                            mainNews.setPubDate(smallDate);

                            // 링크로 중복 체크

                            System.out.println("===" + mainNews);


                        } catch (ParseException e) {
                            e.printStackTrace();
                        }



                    }

                }
            }

            url = new URL("http://www.venturesquare.net/category/news/page/" + Integer.toString(++page));
            document = Jsoup.parse(url, 10000);

        } while (page <= 3); // 3 PAGE


        System.out.println("==== > end ");
    }


    @Scheduled(cron = "0 0 0/1 * * *")
    //@Scheduled(cron = "0 0/1 * * * *")
    public void getNews() throws FeedIOException, UnsupportedFeedException, FeedXMLParseException, MalformedURLException, SystemException, NotSupportedException, HeuristicRollbackException, HeuristicMixedException, RollbackException, IOException {

        if( develop == false) {


            log.info("[GetNews scheduler] Start ====> ");

            URL url = new URL("http://www.venturesquare.net/category/news");

            Document document = Jsoup.parse(url, 10000);

            int page = 1;

            do {
                if (document != null) {

                    Elements posts = document.body().select(".post");

                    XMainNews mainNews;

                    if (posts.size() > 0) {

                        for (Element post : posts) {


                            try {
                                Elements textElement = post.select("p");

                                String description = textElement.get(0).text();//elementMatchValue(textElement.get(0).html(), "(.*)<a");

                                Elements contentElement = post.select(".content");

                                String titleString = contentElement.select("a").get(0).text();
                                String linkString = contentElement.select("a").get(0).attr("href");

                                Elements imageElement = post.select("img");
                                String imageUrlString = imageElement.attr("src");


                                String dateTime = Jsoup.parse(new URL(linkString), 10000).body().select(".value-title").get(0).attr("title");

                                Date pubDate = null;


                                Date smallDate = (new SimpleDateFormat("yyyy-M-d", Locale.KOREA)).parse(dateTime);


                                mainNews = new XMainNews();
                                mainNews.setTitle(titleString);
                                mainNews.setDescription(description);
                                mainNews.setImageUrl(imageUrlString);
                                mainNews.setLink(linkString);
                                mainNews.setPubDate(smallDate);

                                // 링크로 중복 체크
                                int count = xMainNewsRepository.countByLink(mainNews.getLink());

                                if (count == 0) {

                                    xMainNewsRepository.save(mainNews);
                                }

                            } catch (ParseException e) {
                                e.printStackTrace();
                            }



                        }

                    }
                }

                url = new URL("http://www.venturesquare.net/category/news/page/" + Integer.toString(++page));
                document = Jsoup.parse(url, 10000);

            } while (page <= 3); // 3 PAGE

            log.info("[GetNews scheduler] End ====> ");
        }
    }




    /** 벤처스퀘어 사이트 개편으로 파싱 방법 변경 2016.05.11**/
    /*
    @Scheduled(cron = "0 0 0/1 * * *")
    //@Scheduled(cron = "0 0/1 * * * *")
    public void getNews() throws FeedIOException, UnsupportedFeedException, FeedXMLParseException, MalformedURLException, SystemException, NotSupportedException, HeuristicRollbackException, HeuristicMixedException, RollbackException, IOException {

        if( develop == false) {


            log.info("[GetNews scheduler] Start ====> ");

            URL url = new URL("http://www.venturesquare.net/news");

            Document document = Jsoup.parse(url, 10000);

            int page = 1;

            do {
                if (document != null) {

                    Elements posts = document.body().select(".post");

                    XMainNews mainNews;

                    if (posts.size() > 0) {

                        for (Element post : posts) {


                            try {
                                Elements textElement = post.select("p");

                                String description = textElement.get(0).text();//elementMatchValue(textElement.get(0).html(), "(.*)<a");

                                Elements linkElement = post.select(".featured-image-link");

                                String linkString = linkElement.attr("href");
                                ;
                                String titleString = linkElement.attr("title");
                                ;

                                Elements imageElement = post.select("img");
                                String imageUrlString = imageElement.attr("src");

                                Elements pubDateElement = post.select(".published");

                                String pubDateString = pubDateElement.attr("title");
                                String dateTime = pubDateElement.get(0).text();

                                Date pubDate = null;


                                Date smallDate = (new SimpleDateFormat("yyyy년 M월 d일", Locale.KOREA)).parse(dateTime);

                                Calendar cal = Calendar.getInstance();
                                cal.setTime(smallDate);

                                int day = cal.get(Calendar.DAY_OF_MONTH);

                                String str = getDayNumberSuffix(day);

                                try {
                                    pubDate = (new SimpleDateFormat("EEEE, MMM d'" + str + "', yyyy, h:mm a", Locale.KOREA)).parse(pubDateString);
                                } catch (ParseException e) {
                                    e.printStackTrace();
                                }

                                mainNews = new XMainNews();
                                mainNews.setTitle(titleString);
                                mainNews.setDescription(description);
                                mainNews.setImageUrl(imageUrlString);
                                mainNews.setLink(linkString);
                                mainNews.setPubDate(pubDate);

                                // 링크로 중복 체크
                                int count = xMainNewsRepository.countByLink(mainNews.getLink());

                                if (count == 0) {

                                    xMainNewsRepository.save(mainNews);
                                }

                            } catch (ParseException e) {
                                e.printStackTrace();
                            }



                        }

                    }
                }

                url = new URL("http://www.venturesquare.net/news/page/" + Integer.toString(++page));
                document = Jsoup.parse(url, 10000);

            } while (page <= 3); // 3 PAGE

            log.info("[GetNews scheduler] End ====> ");
        }
    }

    */

    private static String elementMatchValue(String elementBody, String patternString)
    {
        Pattern valuePattern = Pattern.compile(patternString);

        Matcher matcher = valuePattern.matcher(elementBody);

        if(matcher.find()) {
            return matcher.group(1);
        }

        return null;
    }

    private static String getDayNumberSuffix(int day) {
        if (day >= 11 && day <= 13) {
            return "th";
        }
        switch (day % 10) {
            case 1:
                return "st";
            case 2:
                return "nd";
            case 3:
                return "rd";
            default:
                return "th";
        }
    }
}
