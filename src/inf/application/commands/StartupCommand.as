package inf.application.commands {
	
	import inf.application.ApplicationFacade;
	import inf.utils.Logger;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartupCommand extends SimpleCommand implements ICommand {
		
		
		public override function execute(notification:INotification):void {
			
			Logger.debug("Executing startup command...");
			
			// commands....
			
			this.sendNotification(ApplicationFacade.APP_INITALIZED, null);
		}
	}
}