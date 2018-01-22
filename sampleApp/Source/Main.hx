package;

import Assertion.*;
import haxe.io.Path;
import openfl.display.Sprite;
import sys.FileSystem;
import sys.io.File;

class Main extends Sprite {
	var errCnt:Int;

	public function new () {
		super ();
#if android
		trace("STARTING NEW EXECUTION AT " + Date.now());
		errCnt = 0;
		try {
			runExternalStorageExample();
		} catch (e1:Dynamic) {
			trace("FAILED");
			show(e1);
			errCnt++;
		}
		trace("EXECUTION RESULT: " + (errCnt == 0 ? "all good" : "ERROR"));
#else
		trace("Nothing to show for !android builds");
#end
	}

	function runExternalStorageExample()
	{
		/* get the available paths for external storage */
		var ext = extension.AndroidStorage.getExternalStorage();
		show(ext.length);

		for (i in ext) {
			show(i);

			/* print basic information about this path */
			var available = Math.floor(i.availableBytes/1024/1024);
			var total = Math.round(i.totalBytes/1024/1024);
			trace('${i.path} (emulated=${i.emulated}, removable=${i.removable}) has $available MiB available out of a total size of $total MiB');

			try {
				var tpath = Path.join([i.path, ".openfl-android-storage"]);
				var now = Date.now();

				/* save a timestamp in a temporary file */
				File.saveContent(tpath, now.toString());

				/* read it back and check if it matches what we wrote */
				var read = File.getContent(tpath);
				show(tpath, now.toString(), read);
				assert(now.toString() == read);

				/* use other fs operations like rename and stat */
				FileSystem.rename(tpath, tpath + ".1");
				show(FileSystem.stat(tpath + ".1"));
			} catch (err:Dynamic) {
				trace("FAILED");
				show(err);
				errCnt++;
			}
		}
	}
}

