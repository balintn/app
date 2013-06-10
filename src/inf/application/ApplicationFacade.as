package inf.application {
	
	import flash.display.Sprite;
	
	import inf.application.commands.StartupCommand;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * This class responsible for starting up the application
	 * @author inf
	 */
	public class ApplicationFacade extends Facade {
		
		
		/**
		 * Application startup
		 * @var String
		 */
		public static const APP_STARTUP:String = "onAppStartUp";
		
		/**
		 * Notification after the startup commands executed
		 * @var String
		 */
		public static const APP_INITALIZED:String = "onAppInitialized";
		
		/**
		 * Notification when handshake data arrived from server
		 * @var String
		 */
		public static const APP_HANDSHAKE_DATA_LOADED:String = "onHandshakeDataLoaded";
		
		/**
		 * Notification after image source loaded from server
		 * @var String
		 */
		public static const IMAGE_ITEM_BITMAP_LOADED:String = "onImageItemBitmapLoaded";
		
		/**
		 * Notification if failed to load image from the server (IO)
		 * @var String
		 */
		public static const IMAGE_ITEM_BITMAP_ERROR:String = "onImageItemBitmapError";
		/**
		 * Application
		 * @var Sprite
		 */
		private var _app:Sprite;
		
		
		
		
		public function ApplicationFacade() {
			super();
		}
		
		
		/**
		 * Initalizes pure MVC environment
		 * @param Sprite app
		 */
		public function startup(app:Sprite):void {
			this._app = app;
			this.sendNotification(ApplicationFacade.APP_STARTUP, this._app);
		}
		
		/**
		 * Returns facade instance
		 * @return ApplicationFacade
		 */
		public static function getInstance():ApplicationFacade {
			if (Facade.instance == null) Facade.instance = new ApplicationFacade();
			return Facade.instance as ApplicationFacade;
		}
		
		/**
		 * Register commands in this function
		 */ 
		protected override function initializeController():void {
			super.initializeController();
			
			this.registerCommand(ApplicationFacade.APP_STARTUP, StartupCommand);
		}
		
		
		/**
		 * Getter for the application
		 * @return Sprite
		 */  
		public function get app():Sprite {
			return this._app;
		}
	}
}