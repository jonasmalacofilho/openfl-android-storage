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
		var buf = [];
		var ext = extension.AndroidStorage.getExternalStorage();
		show(ext.length);
		for (i in ext) {
			var available = Math.floor(i.availableBytes/1024/1024);
			var total = Math.round(i.totalBytes/1024/1024);
			show(i.path, i.emulated, i.removable, i.probablyRemovable, available, total);
			var msg = '${i.path} (emulated=${i.emulated}, removable=${i.removable}) has $available MiB available out of a total size of $total MiB';
			show(msg);
			buf.push(msg);

			try {
				var tpath = Path.join([i.path, ".openfl-android-storage"]);
				var now = Date.now();

				File.saveContent(tpath, now.toString());
				var read = File.getContent(tpath);
				show(tpath, now.toString(), read);
				assert(now.toString() == read);

				FileSystem.rename(tpath, tpath + ".1");
				show(FileSystem.stat(tpath + ".1"));
			} catch (err:Dynamic) {
				show("FAILED", err);
			}
		}
		// var t = new openfl.text.TextField();
		// t.width = 800;
		// t.text = buf.join("\r");
		// addChild(t);
#end
	}
}

