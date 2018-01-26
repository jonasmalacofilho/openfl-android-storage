package extension;

import Assertion.*;

#if android
import openfl.utils.JNI;
#end

typedef StorageInfo = {
	path : String,
	availableBytes : Float,
	totalBytes : Float,
	emulated : Null<Bool>,
	removable : Null<Bool>,
	probablyRemovable : Null<Bool>,
}

class AndroidStorage {
	public static function getPrivateStorage():StorageInfo
	{
		throw "Not implemented yet";
		return null;
	}

	public static function getExternalStorage():Array<StorageInfo>
	{
#if android
		var alts:Array<StorageInfo> = [];
		for (path in _getExternalFilesDirs(null)) {
			if (path == null)
				continue;
			var stat = _getStorageStats(path);
			var info:StorageInfo = {
				path : path,
				availableBytes : stat[2],
				totalBytes : stat[0],
				emulated : null,
				removable : null,
				probablyRemovable : null
			}
			if (_SDK_INT >= 21) {
				info.emulated = _isExternalStorageEmulated(path);
				info.removable = _isExternalStorageRemovable(path);
				info.probablyRemovable = info.removable;
			} else if (alts.length == 0) {
				info.emulated = _isPrimaryExternalStorageEmulated();
				info.removable = _isPrimaryExternalStorageRemovable();
				info.probablyRemovable = info.removable;
			} else {
				info.probablyRemovable = !alts[0].removable;
			}
			alts.push(info);
		}
		return alts;
#else
		return [];
#end
	}

	public static function getPublicStorage():StorageInfo
	{
		throw "Not implemented yet";
		return null;
	}

	public static function getPrivateCacheStorage():StorageInfo
	{
		throw "Not implemented yet";
		return null;
	}

	public static function getExternalCacheStorage():Array<StorageInfo>
	{
		throw "Not implemented yet";
		return [];
	}

	#if android
	static var _getExternalFilesDirs:Null<String>->Array<Dynamic> =
			JNI.createStaticMethod("org.haxe.extension.AndroidStorage",
					"getExternalFilesDirs", "(Ljava/lang/String;)[Ljava/lang/String;");

	static var _isPrimaryExternalStorageEmulated:Void->Bool =
			JNI.createStaticMethod("org.haxe.extension.AndroidStorage",
					"isPrimaryExternalStorageEmulated", "()Z");

	static var _isExternalStorageEmulated:String->Bool =
			JNI.createStaticMethod("org.haxe.extension.AndroidStorage",
					"isExternalStorageEmulated", "(Ljava/lang/String;)Z");

	static var _isPrimaryExternalStorageRemovable:Void->Bool =
			JNI.createStaticMethod("org.haxe.extension.AndroidStorage",
					"isPrimaryExternalStorageRemovable", "()Z");

	static var _isExternalStorageRemovable:String->Bool =
			JNI.createStaticMethod("org.haxe.extension.AndroidStorage",
					"isExternalStorageRemovable", "(Ljava/lang/String;)Z");

	static var _getStorageStats:String->Array<Float> =
			JNI.createStaticMethod("org.haxe.extension.AndroidStorage",
					"getStorageStats", "(Ljava/lang/String;)[D");

	static var _SDK_INT:Int =
			JNI.createStaticField("android.os.Build$VERSION", "SDK_INT", "I").get();
	#end
}

