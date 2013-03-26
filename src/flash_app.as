package {
	import flash.display.Sprite;
	
	import inf.application.ApplicationFacade;
	import inf.utils.Logger;
	
	public class flash_app extends Sprite {
		
		private var _facade:ApplicationFacade;
		
		public function flash_app() {
			
			Logger.enableLogging();
			
			Logger.setLogLevel(Logger.LEVEL_DEBUG);
			
			Logger.info("Initializing application...");
			
			this._facade = ApplicationFacade.getInstance();
			
			this._facade.startup(this);
			
		}
	}
}