package;

import Assertion.*;
import haxe.io.Path;
import openfl.display.Sprite;
import sys.FileSystem;
import sys.io.File;

class Main extends Sprite {
	public function new () {
		
		super ();
		
#if android
		var errcnt = 0;
		try {
			var ext = extension.AndroidStorage.getExternalStorage();
			show(ext.length);
			for (i in ext) {
				var available = Math.floor(i.availableBytes/1024/1024);
				var total = Math.round(i.totalBytes/1024/1024);
				trace('${i.path} (emulated=${i.emulated}, removable=${i.removable}) has $available MiB available out of a total size of $total MiB');
				show(i);

				try {
					var tpath = Path.join([i.path, ".openfl-android-storage"]);
					var now = Date.now();

					File.saveContent(tpath, now.toString());
					var read = File.getContent(tpath);
					show(tpath, now.toString(), read);
					assert(now.toString() == read);

					FileSystem.rename(tpath, tpath + ".1");
					show(FileSystem.stat(tpath + ".1"));
				} catch (e2:Dynamic) {
					trace("FAILED");
					show(e2);
					errcnt++;
				}
			}
		} catch (e1:Dynamic) {
			trace("FAILED");
			show(e1);
			errcnt++;
		}
		trace("RESULT: " + (errcnt == 0 ? "all good" : "ERROR"));
#end
	}
}

