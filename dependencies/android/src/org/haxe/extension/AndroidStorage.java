package org.haxe.extension;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.AssetManager;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.StatFs;
import android.view.View;
import java.io.File;

public class AndroidStorage extends Extension {
	/**
	Get all available application-specific directories on external storage

	No additional permissions are required for the calling app to read or write
	files under the returned path.
	**/
	public static String[] getExternalFilesDirs(String type)
	{
		File[] dirs = Extension.mainContext.getExternalFilesDirs(type);
		String [] res = new String[dirs.length];
		for (int i = 0; i < dirs.length; i++)
			res[i] = dirs[i] != null ? dirs[i].toString() : null;
		return res;
	}

	/**
	Check whether the primary external storage is emualated
	**/
	public static boolean isPrimaryExternalStorageEmulated()
	{
		return Environment.isExternalStorageEmulated();
	}

	/**
	Check whether some external storage is emualated
	**/
	public static boolean isExternalStorageEmulated(String path)
	{
		return Environment.isExternalStorageEmulated(new File(path));
	}

	/**
	Check whether the primary external storage is removable
	**/
	public static boolean isPrimaryExternalStorageRemovable()
	{
		return Environment.isExternalStorageRemovable();
	}

	/**
	Check whether some external storage is removable
	**/
	public static boolean isExternalStorageRemovable(String path)
	{
		return Environment.isExternalStorageRemovable(new File(path));
	}

	/**
	Get filesystem statistics for path
	**/
	public static double[] getStorageStats(String path)
	{
		StatFs s = new StatFs(path);
		double[] r = { s.getTotalBytes(), s.getFreeBytes(), s.getAvailableBytes() };
		return r;
	}

	/*
	What follows was set up by openfl...

	You can use the Android Extension class in order to hook
	into the Android activity lifecycle. This is not required
	for standard Java code, this is designed for when you need
	deeper integration.
	
	You can access additional references from the Extension class,
	depending on your needs:
	
	- Extension.assetManager (android.content.res.AssetManager)
	- Extension.callbackHandler (android.os.Handler)
	- Extension.mainActivity (android.app.Activity)
	- Extension.mainContext (android.content.Context)
	- Extension.mainView (android.view.View)
	
	You can also make references to static or instance methods
	and properties on Java classes. These classes can be included 
	as single files using <java path="to/File.java" /> within your
	project, or use the full Android Library Project format (such
	as this example) in order to include your own AndroidManifest
	data, additional dependencies, etc.
	
	These are also optional, though this example shows a static
	function for performing a single task, like returning a value
	back to Haxe from Java.
	*/
	
	/**
	Called when an activity you launched exits, giving you the requestCode 
	you started it with, the resultCode it returned, and any additional data 
	from it.
	**/
	public boolean onActivityResult(int requestCode, int resultCode, Intent data)
	{
		return true;
	}
	
	/**
	Called when the activity is starting.
	**/
	public void onCreate(Bundle savedInstanceState) { }
	
	/**
	Perform any final cleanup before an activity is destroyed.
	**/
	public void onDestroy() { }
	
	/**
	Called as part of the activity lifecycle when an activity is going into
	the background, but has not (yet) been killed.
	**/
	public void onPause() { }
	
	/**
	Called after {@link #onStop} when the current activity is being 
	re-displayed to the user (the user has navigated back to it).
	**/
	public void onRestart() { }
	
	/**
	Called after {@link #onRestart}, or {@link #onPause}, for your activity 
	to start interacting with the user.
	**/
	public void onResume() { }
	
	/**
	Called after {@link #onCreate} &mdash; or after {@link #onRestart} when  
	the activity had been stopped, but is now again being displayed to the 
	user.
	**/
	public void onStart() { }
	
	/**
	Called when the activity is no longer visible to the user, because 
	another activity has been resumed and is covering this one. 
	**/
	public void onStop() { }
}

