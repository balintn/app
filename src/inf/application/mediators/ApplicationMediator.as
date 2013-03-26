package inf.application.mediators {
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator {
		
		public static const NAME:String = "applicationMediator";
		
		public function ApplicationMediator(viewComponent:Object=null) {
			super(ApplicationMediator.NAME, viewComponent);
			
			// start loading handshake data
			// TODO na itt roffentsuk be a handshake proxy-t
		}
	}
}