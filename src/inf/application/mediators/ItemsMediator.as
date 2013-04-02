package inf.application.mediators {
	import inf.application.views.ItemsView;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ItemsMediator
	 * @author inf
	 */
	public class ItemsMediator extends Mediator {
		
		public static const NAME:String = "itemsMediator";
		
		public function ItemsMediator(viewComponent:ItemsView) {
			super(ItemsMediator.NAME, viewComponent);
		}
		
		public function get view():ItemsView {
			return this.viewComponent as ItemsView;
		}
	}
}