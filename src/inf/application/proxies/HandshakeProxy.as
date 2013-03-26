package inf.application.proxies {
	import flash.events.Event;
	import flash.net.URLRequestMethod;
	
	import inf.application.models.HandshakeModel;
	import inf.utils.Logger;
	
	/**
	 * This proxy loads handshake data from server and creates a <code>HandshakeModel</code> object  
	 * @author inf
	 */
	public class HandshakeProxy extends JSONProxy {
		
		public static const NAME:String = "handshakeProxy";
		
		/**
		 * Model
		 * @var HandshakeModel _model (read only)
		 */
		private var _model:HandshakeModel;
		
		
		/**
		 * Constructor
		 * @param String url the url which serves the load request
		 */
		public function HandshakeProxy(url:String) {
			super(url, HandshakeProxy.NAME);
		}
		
		
		/**
		 * Starts loading handshake data from server
		 */
		public function loadHandshakeData():void {
			super.load({}, URLRequestMethod.GET);
		}
		
		
		/**
		 * Called when response came from server
		 * @param Event event
		 * @return Object
		 */
		protected override function onComplete(event:Event):void {
			
			Logger.info("Handshake data arrived..");
			
			var response:Object = super.onComplete(event);
			
			if (response != null) {
				
				// create model...
				
				
			}
			
			return response;
		}
		
		/**
		 * Returns model
		 * @return HandshakeModel
		 */
		public function get model():HandshakeModel {
			return this._model;
		}
	}
}