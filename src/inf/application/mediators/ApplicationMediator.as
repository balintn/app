package inf.application.mediators {
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator {
		
		
		public function ApplicationMediator(mediatorName:String=null, viewComponent:Object=null) {
			super(mediatorName, viewComponent);
		}
	}
}