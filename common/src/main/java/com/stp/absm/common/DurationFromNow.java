package com.stp.absm.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.MissingResourceException;

/**
 * Created by sj on 16. 2. 29..
 */
@Service(value = "durationFromNow")
public class DurationFromNow {

    @Autowired
    private MessageSource messageSource;


    /**
     * 현재부터 "yyyyMMddHHmmss" 포맷의 날짜 차이 레이블
     * @param date1
     * @return String
     */
    public String getTimeDiffLabel(String date1) {

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            return getTimeDiffLabel(sdf.parse(date1), new Date());
        } catch (ParseException e) {
            return "-";
        }
    }


    /**
     * 현재부터 Date 포맷의 날짜 차이 레이블
     * @param d1
     * @return String
     */
    public String getTimeDiffLabel(Date d1) {
        return getTimeDiffLabel(d1, new Date());
    }

    /**
     * "yyyyMMddHHmmss" 포맷의 날짜 차이 레이블
     * @param date1
     * @param date2
     * @return String
     */
    public String getTimeDiffLabel(String date1, String date2) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        try {
            return getTimeDiffLabel(sdf.parse(date1), sdf.parse(date2));
        } catch (ParseException e) {
            return "-";
        }
    }

    /**
     * java.util.Date 포맷의 날짜 차이 레이블
     * @param d1
     * @param d2
     * @return String
     */
    public String getTimeDiffLabel(Date d1, Date d2) {
        long diff = d2.getTime() - d1.getTime();
        int sec = (int)(diff / 1000);
        if (sec < 5) return getString("lessthan5seconds");
        if (sec < 60) return getString(sec , "seconds");

        int min = (int)(sec / 60);
        if (min < 60) return getString(min , "minutes");

        int hour = (int)(min / 60);
        if (hour < 24) return getString(hour , "hours");

        Calendar c1 = Calendar.getInstance();
        Calendar c2 = (Calendar) c1.clone();
        c1.setTime(d1);
        c2.setTime(d2);

        int day = c2.get(Calendar.DATE) - c1.get(Calendar.DATE);
        if (day <= 0) {
            day = hour / 24;
        }

        if (hour/24 < 30) {
            if (day == 1) return getString("yesterday");
            if (day == 2) return getString("twodays");
            return getString(day , "days");
        }

        int month = hour / 24 / 30;
        if (month == 1) return getString("onemonth");
        if (month == 2) return getString("twomonths");
        if (month < 12) return getString(month , "months");

        int year = month / 12;
        if (year == 1) return getString("lastyear");
        return getString(year , "years");

    }
    //private static final String BUNDLE_NAME = "kr.pe.okjsp.util.messages";

    //private static ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle(BUNDLE_NAME);

    //public static void setLocale(Locale locale) {
    //RESOURCE_BUNDLE = ResourceBundle.getBundle(BUNDLE_NAME, locale);
    //}

    /**
     * add space between number and label according to locale
     * @param value
     * @param key
     * @return DateLabel
     */
    private String getString(int value, String key) {




        String space = (Locale.KOREA.equals(Locale.getDefault()) == true) ? "" : " ";


        return value + space + getString(key);
    }

    public String getString(String key) {
        try {

            //String packageName = BridgeApplication.getApplication().getPackageName();
            //int resId = BridgeApplication.getApplication().getResources().getIdentifier(key, "string", packageName);


            //return RESOURCE_BUNDLE.getString(key);
            return messageSource.getMessage("DateLabel." + key, null, Locale.getDefault());
        } catch (MissingResourceException e) {
            return '!' + key + '!';
        }
    }
}