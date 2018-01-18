package;

import Assertion.*;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new () {
		
		super ();
		
#if android
		var buf = [];
		var ext = extension.AndroidStorage.getExternalStorage();
		for (i in ext) {
			var available = Math.floor(i.availableBytes/1024/1024);
			var total = Math.round(i.totalBytes/1024/1024);
			show(i.path, i.emulated, i.removable, i.probablyRemovable, available, total);
			var msg = '${i.path} (emulated=${i.emulated}, removable=${i.removable}) has $available MiB available out of a total size of $total MiB';
			show(msg);
			buf.push(msg);
		}
		show(buf.length);
		// var t = new openfl.text.TextField();
		// t.width = 800;
		// t.text = buf.join("\r");
		// addChild(t);
#end
	}
}

