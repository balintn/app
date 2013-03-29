package inf.application.proxies {
	import flash.events.Event;
	import flash.net.URLRequestMethod;
	
	import inf.application.ApplicationFacade;
	import inf.application.models.EnvironmentModel;
	import inf.utils.Logger;
	
	/**
	 * This proxy loads handshake data from server and creates a <code>EnvironmentModel</code> object  
	 * @author inf
	 */
	public class HandshakeProxy extends JSONProxy {
		
		public static const NAME:String = "handshakeProxy";
		
		private static const PROP_APP_SETTINGS:String = "appSettings";
		private static const PROP_THUMBNAILS:String = "thumbnails";
		
		/**
		 * Model
		 * @var HandshakeModel _model (read only)
		 */
		private var _model:EnvironmentModel;
		
		
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
		protected override function onComplete(event:Event):Object {
			
			Logger.info("Handshake data arrived..");
			
			var response:Object = super.onComplete(event);
			
			if (response != null) {
				
				// create environment model...
				if (response.hasOwnProperty(HandshakeProxy.PROP_APP_SETTINGS) && response[HandshakeProxy.PROP_APP_SETTINGS] instanceof Object) {
					var env:EnvironmentModel = EnvironmentModel.getInstance();
					env.populateData(response[HandshakeProxy.PROP_APP_SETTINGS]);
				}
				
				// TODO create thumb list
				
				// sending notification
				this.sendNotification(ApplicationFacade.APP_HANDSHAKE_DATA_LOADED, response);
			}
			
			return response;
		}
		
		/**
		 * Returns model
		 * @return EnvironmentModel
		 */
		public function get model():EnvironmentModel {
			return this._model;
		}
	}
}