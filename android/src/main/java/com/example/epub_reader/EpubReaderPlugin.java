package com.example.epub_reader;

import android.app.Activity;
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
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** EpubReaderPlugin */
public class EpubReaderPlugin implements MethodCallHandler{

  private Reader reader;
  static private Activity activity;
  static private Context context;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {

    context = registrar.context();
    activity = registrar.activity();

    final MethodChannel channel = new MethodChannel(registrar.messenger(), "epub_reader");
    channel.setMethodCallHandler(new EpubReaderPlugin());

  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {


    if (call.method.equals("open")){

      Map<String,Object> arguments = (Map<String, Object>) call.arguments;
      String bookPath = arguments.get("bookPath").toString();

      System.out.println("bookPath:" + bookPath);

      reader = new Reader(context);
      reader.open(bookPath);

    }

    else {
      result.notImplemented();
    }
  }


}
