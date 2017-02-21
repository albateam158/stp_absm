package com.stp.absm.common;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.AbstractImageProvider;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

import javax.swing.text.MutableAttributeSet;
import javax.swing.text.html.HTML;
import javax.swing.text.html.HTMLEditorKit;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.Charset;

import org.apache.xerces.impl.dv.util.Base64;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.w3c.tidy.*;

/**
 * Created by bridge on 2016. 4. 5..
 */
public class PDFUtil {

    class Base64ImageProvider extends AbstractImageProvider {

        @Override
        public Image retrieve(String src) {
            int pos = src.indexOf("base64,");
            try {
                if (src.startsWith("data") && pos > 0) {
                    byte[] img = Base64.decode(src.substring(pos + 7));
                    return Image.getInstance(img);
                }
                else {
                    return Image.getInstance(src);
                }
            } catch (BadElementException ex) {
                return null;
            } catch (IOException ex) {
                return null;
            }
        }

        @Override
        public String getImageRootPath() {
            return null;
        }
    }

    public void htmlToPdf(String htmlStr, OutputStream outputStream, String cssfile, String fontFile) throws DocumentException, IOException, TransformerException {

        org.jsoup.nodes.Document doc = Jsoup.parse(htmlStr);

        Elements imgElements = doc.select("img");

        for(Element imgElement : imgElements) {
            imgElement.removeAttr("style");
            imgElement.removeAttr("width");
            imgElement.removeAttr("height");
        }

        htmlStr = doc.html();


        Tidy tidy = new Tidy();
        tidy.setShowWarnings(true);
        tidy.setInputEncoding("UTF-8");
        tidy.setOutputEncoding("UTF-8");
        tidy.setXHTML(true);
        tidy.setMakeClean(true);
        StringReader stringReader = new StringReader(htmlStr);
        StringWriter stringWriter = new StringWriter();
        org.w3c.dom.Document xmlDoc = tidy.parseDOM(stringReader, stringWriter);
        System.out.println(xmlDoc.toString());
        DOMSource domSource = new DOMSource(xmlDoc);
        StringWriter writer1 = new StringWriter();
        StreamResult result = new StreamResult(writer1);
        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer transformer = tf.newTransformer();
        transformer.transform(domSource, result);
        System.out.println("XML IN String format is: \n" + writer1.toString());
        htmlStr = writer1.toString();
        htmlStr = htmlStr.replace("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>", "");



        // Document 생성
        Document document = new Document(PageSize.A4, 50, 50, 50, 50); // 용지 및 여백 설정

        // PdfWriter 생성
        PdfWriter writer = PdfWriter.getInstance(document, outputStream); // 바로 다운로드.
        //PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
        writer.setInitialLeading(12.5f);

        // Document 오픈
        document.open();
        XMLWorkerHelper helper = XMLWorkerHelper.getInstance();

        // CSS
        CSSResolver cssResolver = new StyleAttrCSSResolver();
        //CssFile cssFile = helper.getCSS(new FileInputStream("/Users/bridge/Documents/develop/intellij-workspace/wicrowd-java/test.css"));
        CssFile cssFile = helper.getCSS(new FileInputStream(cssfile));
        cssResolver.addCss(cssFile);

        // HTML, 폰트 설정
        XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
        //fontProvider.register("/Users/bridge/Documents/develop/intellij-workspace/wicrowd-java/MALGUN.TTF", "MalgunGothic"); // MalgunGothic은 alias,
        fontProvider.register(fontFile, "MalgunGothic");
        CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);

        HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
        htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
        htmlContext.setImageProvider(new Base64ImageProvider());

        // Pipelines
        PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
        HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
        CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);

        XMLWorker worker = new XMLWorker(css, true);
        XMLParser xmlParser = new XMLParser(worker, Charset.forName("UTF-8"));

        // 폰트 설정에서 별칭으로 줬던 "MalgunGothic"을 html 안에 폰트로 지정한다.
//        String htmlStr = "<html><head><body style='font-family: MalgunGothic;'>"
//                + "<p>PDF 안에 들어갈 내용입니다.</p>"
//                + "<h3>한글, English, 漢字.</h3>"
//                + "</body></head></html>";

        StringReader strReader = new StringReader(htmlStr);
        xmlParser.parse(strReader);

        document.close();
        writer.close();
    }
}


