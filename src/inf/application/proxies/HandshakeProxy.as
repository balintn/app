package inf.application.proxies {
	import flash.events.Event;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import inf.application.ApplicationFacade;
	import inf.application.handlers.ImageItemHandler;
	import inf.application.models.EditorBoxModel;
	import inf.application.models.EnvironmentModel;
	import inf.application.models.ImageItemModel;
	import inf.application.models.ItemsBoxModel;
	import inf.utils.Logger;
	import inf.utils.ObjectUtil;
	
	/**
	 * This proxy loads handshake data from server and creates a <code>EnvironmentModel</code> object  
	 * @author inf
	 */
	public class HandshakeProxy extends JSONProxy {
		
		public static const NAME:String = "handshakeProxy";
		
		public static const PROP_APP_SETTINGS:String = "appSettings";
		public static const PROP_ITEMS:String = "items";
		public static const PROP_BOXES:String = "boxes";
		
		public static const PROP_BOX_EDITOR:String = "editor";
		public static const PROP_BOX_ITEMS:String = "items";
		
		/**
		 * Stores last response object
		 * @var Object
		 */
		private var _lastResponse:Object;
		
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
			
			try {
				if (response != null) {
					
					// create environment model...
					if (response.hasOwnProperty(HandshakeProxy.PROP_APP_SETTINGS) && response[HandshakeProxy.PROP_APP_SETTINGS] is Object) {
						var env:EnvironmentModel = EnvironmentModel.getInstance();
						env.populateData(response[HandshakeProxy.PROP_APP_SETTINGS]);
						Logger.info("Environment model created..");
					} else {
						throw new Error("Failed to create environment model!");
					}
					
					// editor box model
					if (ObjectUtil.deepObjectKeyExists(response, [HandshakeProxy.PROP_BOXES, HandshakeProxy.PROP_BOX_EDITOR]) &&
						response[HandshakeProxy.PROP_BOXES][HandshakeProxy.PROP_BOX_EDITOR] is Object) {
						
						var editorModel:EditorBoxModel = EditorBoxModel.getInstance();
						editorModel.populateData(response[HandshakeProxy.PROP_BOXES][HandshakeProxy.PROP_BOX_EDITOR]);
						
						Logger.info("Editor box model created..");
					} else {
						throw new Error("Failed to create editor box model!");
					}
					
					
					// items box model
					if (ObjectUtil.deepObjectKeyExists(response, [HandshakeProxy.PROP_BOXES, HandshakeProxy.PROP_BOX_ITEMS]) &&
						response[HandshakeProxy.PROP_BOXES][HandshakeProxy.PROP_BOX_ITEMS] is Object) {
						
						var itemsModel:ItemsBoxModel = ItemsBoxModel.getInstance();
						itemsModel.populateData(response[HandshakeProxy.PROP_BOXES][HandshakeProxy.PROP_BOX_ITEMS]);
						
						Logger.info("Items box model created..");
					} else {
						throw new Error("Failed to create items box model!");
					}
					
					
					// create image items
					if (response.hasOwnProperty(HandshakeProxy.PROP_ITEMS) && response[HandshakeProxy.PROP_ITEMS] is Array) {
						ImageItemHandler.createModelsFromArray(response[HandshakeProxy.PROP_ITEMS]);
						Logger.info("Item models created..");
					}
					
					
					// sending notification
					this.sendNotification(ApplicationFacade.APP_HANDSHAKE_DATA_LOADED, response);
					
				} else {
					throw new Error("No valid response came from server");
				}
			} catch(e:Error) {
				Logger.error("Failed to process handshake data! Exception: " + e.message);
			}
			
			return response;
		}
		
		/**
		 * Returns a clone object from the last response or null if response is null
		 * @return Object
		 */
		public function getResponseClone():Object {
			
			if (this._lastResponse != null) {
				var byteArray = new ByteArray(); 
				byteArray.writeObject( this._lastResponse ); 
				byteArray.position = 0; 
				
				return byteArray.readObject();
			} else {
				return null;
			}
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