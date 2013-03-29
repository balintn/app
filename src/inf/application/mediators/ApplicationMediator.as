package inf.application.mediators {
	
	import inf.application.ApplicationFacade;
	import inf.application.proxies.HandshakeProxy;
	import inf.utils.Logger;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ApplicationMediator class
	 * 
	 * @author inf
	 */
	public class ApplicationMediator extends Mediator {
		
		public static const NAME:String = "applicationMediator";
		
		public function ApplicationMediator(viewComponent:Object=null) {
			super(ApplicationMediator.NAME, viewComponent);
		}
		
		/**
		 * Returns notification list
		 * @return Array
		 */
		public override function listNotificationInterests():Array{
			return [
				ApplicationFacade.APP_INITALIZED,
				ApplicationFacade.APP_HANDSHAKE_DATA_LOADED
			];
		}
		
		/**
		 * Notification handling
		 * @param INotification notification
		 */
		public override function handleNotification(notification:INotification):void {
			
			switch (notification.getName()) {
				
				case ApplicationFacade.APP_INITALIZED:
					
					// now start loading handshake data
					var proxy:HandshakeProxy = this.facade.retrieveProxy(HandshakeProxy.NAME) as HandshakeProxy;
					proxy.loadHandshakeData();					
					break;
				
				case ApplicationFacade.APP_HANDSHAKE_DATA_LOADED:
					
					// TODO init app view mediators end views
					
					break;
				
			}
		}
	
	}
}