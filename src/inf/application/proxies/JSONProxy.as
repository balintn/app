package inf.application.proxies {
	
	import com.adobe.serialization.json.JSONDecoder;
	import com.adobe.serialization.json.JSONParseError;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import inf.utils.Logger;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	
	/**
	 * Handles loading from server and parses JSON response
	 * 
	 * @author inf
	 */ 
	public class JSONProxy extends Proxy {
		
		/**
		 * @var String _baseUrl
		 */
		protected var _baseUrl:String;
		
		/**
		 * @var URLLoader _loader
		 */
		protected var _loader:URLLoader;
		
		
		/**
		 * Constructor
		 * @param String baseUrl the name of the script with its path (absolute or relative to swf location) that responds to the queries of this proxy
		 * @param String proxyName for pureMVC registration
		 */
		public function JSONProxy(baseUrl:String, proxyName:String = null) {
			
			this._baseUrl = baseUrl;
			
			this._loader = new URLLoader();
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			this._loader.addEventListener(Event.COMPLETE, onComplete);
			
			super(proxyName);
		}
		
		
		/**
		 * Loads data from server 
		 * @param Object params parameters to add to the query for the server
		 * @param String request method GET or POST (<code>URLRequestMethod.GET</code> or <code>URLRequestMethod.POST</code>)
		 */ 
		protected function load(params:Object = null, method:String = URLRequestMethod.GET):void {
			
			var request:URLRequest = new URLRequest(this._baseUrl);
			
			request.data = new URLVariables();
			for (var key:String in params){
				request.data[key] = params[key];
			}

			request.method = method;
			this._loader.load(request);
		}
		
		
		/**
		 * This method called when IO error occure
		 * @param IOErrorEvent event
		 */
		protected function onIOError(event:IOErrorEvent):void {
			Logger.error("Failed to load request! IO error occured!");
		}
		
		/**
		 * This method called when security error occure
		 * @param SecurityErrorEvent
		 */
		protected function onSecurityError(event:SecurityErrorEvent):void {
			Logger.error("Failed to load request! Security error occured!");
		}
		
		/**
		 * This method called when response came from server
		 * @param Event event
		 * @return Object
		 */
		protected function onComplete(event:Event):Object {
			try {
				var decoder:JSONDecoder = new JSONDecoder(_loader.data, false);
				var response:Object = decoder.getValue();
				return response;
			} catch (exception:JSONParseError) {
				Logger.error("Failed to parse JSON response!\nJSON string: " + _loader.data);				
			}
			return null;
		}
	}
}