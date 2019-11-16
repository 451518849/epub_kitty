package com.xiaofwang.epub_kitty;

import android.content.Context;
import android.util.Log;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.folioreader.Config;
import com.folioreader.FolioReader;
import com.folioreader.model.HighLight;
import com.folioreader.model.locators.ReadLocator;
import com.folioreader.ui.base.OnSaveHighlight;
import com.folioreader.util.AppUtil;
import com.folioreader.util.OnHighlightListener;
import com.folioreader.util.ReadLocatorListener;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class Reader  implements OnHighlightListener, ReadLocatorListener, FolioReader.OnClosedListener{

    public FolioReader folioReader;
    private Context context;
    public MethodChannel.Result result;
    private EventChannel.EventSink pageEventSink;
    private BinaryMessenger messenger;

    private static final String PAGE_CHANNEL = "com.xiaofwang.epub_reader/page";

    Reader(Context context, BinaryMessenger messenger){

        getHighlightsAndSave();

        folioReader = FolioReader.get()
                .setOnHighlightListener(this)
                .setReadLocatorListener(this)
                .setOnClosedListener(this);

        this.context = context;
        setPageHandler(messenger);
    }

    public void open(String bookPath){

        ReadLocator readLocator = getLastReadLocator();

        Config config = AppUtil.getSavedConfig(context);
        if (config == null)
            config = new Config();
        config.setAllowedDirection(Config.AllowedDirection.VERTICAL_AND_HORIZONTAL);
        config.setThemeColorInt(0xfffdd82c);
        folioReader.setReadLocator(readLocator);
        folioReader.setConfig(config, true)
                .openBook(bookPath);

    }

    public void close(){
        folioReader.close();
    }

    private void setPageHandler(BinaryMessenger messenger){

        new EventChannel(messenger,PAGE_CHANNEL).setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {
                pageEventSink = eventSink;
            }

            @Override
            public void onCancel(Object o) {

            }
        });
    }

    private ReadLocator getLastReadLocator() {

        String jsonString = loadAssetTextAsString("Locators/LastReadLocators/last_read_locator_1.json");
        return ReadLocator.fromJson(jsonString);
    }

    private void getHighlightsAndSave() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                ArrayList<HighLight> highlightList = null;
                ObjectMapper objectMapper = new ObjectMapper();
                try {
                    highlightList = objectMapper.readValue(
                            loadAssetTextAsString("highlights/highlights_data.json"),
                            new TypeReference<List<HighlightData>>() {
                            });
                } catch (IOException e) {
                    e.printStackTrace();
                }

                if (highlightList == null) {
                    folioReader.saveReceivedHighLights(highlightList, new OnSaveHighlight() {
                        @Override
                        public void onFinished() {
                            //You can do anything on successful saving highlight list
                        }
                    });
                }
            }
        }).start();
    }


    private String loadAssetTextAsString(String name) {
        BufferedReader in = null;
        try {
            StringBuilder buf = new StringBuilder();
            InputStream is = context.getAssets().open(name);
            in = new BufferedReader(new InputStreamReader(is));

            String str;
            boolean isFirst = true;
            while ((str = in.readLine()) != null) {
                if (isFirst)
                    isFirst = false;
                else
                    buf.append('\n');
                buf.append(str);
            }
            return buf.toString();
        } catch (IOException e) {
            Log.e("Reader", "Error opening asset " + name);
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    Log.e("Reader", "Error closing asset " + name);
                }
            }
        }
        return null;
    }

    @Override
    public void onFolioReaderClosed() {

    }

    @Override
    public void onHighlight(HighLight highlight, HighLight.HighLightAction type) {

    }

    @Override
    public void saveReadLocator(ReadLocator readLocator) {
        Log.e("readLocator","readLocator path:"+readLocator.getLocations().getXpath());
        Log.e("readLocator","readLocator positoin:"+readLocator.getLocations().getPosition());
        Log.e("readLocator","readLocator progress:"+readLocator.getLocations().getProgression());
        Log.e("readLocator","readLocator id:"+readLocator.getLocations().getId());

        if (pageEventSink != null){
            pageEventSink.success(readLocator.getLocations().getXpath());
        }
    }


}
