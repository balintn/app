package inf.application.commands {
	
	import inf.application.ApplicationFacade;
	import inf.application.mediators.ApplicationMediator;
	import inf.application.models.EnvironmentModel;
	import inf.application.proxies.HandshakeProxy;
	import inf.application.proxies.ImageLoaderProxy;
	import inf.utils.Logger;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartupCommand extends SimpleCommand implements ICommand {
		
		
		public override function execute(notification:INotification):void {
			
			Logger.debug("Executing startup command...");
			
			// commands....
			var facade:ApplicationFacade = ApplicationFacade.getInstance();
			
			// register handshake proxy
//			facade.registerProxy(new HandshakeProxy("getInitialData.php"));
			facade.registerProxy(new HandshakeProxy("http://localhost/flashapp/getInitialData.php"));			
			
			// register image loader proxy
			Logger.debug("Register ImageLoaderProxy...");
			this.facade.registerProxy(new ImageLoaderProxy());
			
			if (notification.getBody() is flash_app) {
				// register ApplicationMediator
				this.facade.registerMediator(new ApplicationMediator(notification.getBody() as flash_app));
			}
			
			this.sendNotification(ApplicationFacade.APP_INITALIZED, null);
		}
	}
}