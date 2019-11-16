package com.xiaofwang.epub_kitty;

import android.app.Activity;
import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** EpubKittyPlugin */
public class EpubKittyPlugin implements MethodCallHandler {

  private Reader reader;
  static private Activity activity;
  static private Context context;
  static BinaryMessenger messenger;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {

    context = registrar.context();
    activity = registrar.activity();
    messenger = registrar.messenger();

    final MethodChannel channel = new MethodChannel(registrar.messenger(), "epub_kitty");
    channel.setMethodCallHandler(new EpubKittyPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {

    if (call.method.equals("open")){

      Map<String,Object> arguments = (Map<String, Object>) call.arguments;
      String bookPath = arguments.get("bookPath").toString();

      reader = new Reader(context,messenger);
      reader.open(bookPath);

    }else if(call.method.equals("close")){
      reader.close();
    }

    else {
      result.notImplemented();
    }
  }
}
