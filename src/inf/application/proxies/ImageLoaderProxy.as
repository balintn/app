package inf.application.proxies {
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import inf.application.ApplicationFacade;
	import inf.utils.Hash;
	import inf.utils.Logger;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ImageLoaderProxy class
	 * @author inf
	 */
	public class ImageLoaderProxy extends Proxy {
		
		public static const NAME:String = "ImageLoaderProxy";
		
		private var _queue:Hash;
		
		
		public function ImageLoaderProxy() {
			super(ImageLoaderProxy.NAME);
			this._queue = new Hash();
		}
		
		
		public function loadImage(url:String, additionalInfo:Object = null):void {
			
			var loader:Loader = new Loader();
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
			
			loader.load(new URLRequest(url));
			
			this._queue.set(loader, additionalInfo);			
			
		}
		
		protected function onComplete(event:Event):void {
			
			var loader:Loader = event.currentTarget.loader as Loader;
			var additionalInfo:Object = this._queue.get(loader, null);
			
			this.sendNotification(ApplicationFacade.IMAGE_ITEM_BITMAP_LOADED, {displayObject: loader.content, additionalInfo: additionalInfo});
			
		}
		
		protected function onIOError(event:IOErrorEvent):void {
			Logger.error("IO error occured during image download!");
			
			var loader:Loader = event.currentTarget.loader as Loader;
			var additionalInfo:Object = this._queue.get(loader, null);
			
			this.sendNotification(ApplicationFacade.IMAGE_ITEM_BITMAP_ERROR, {displayObject: loader.content, additionalInfo: additionalInfo});
		}
		
	}
}