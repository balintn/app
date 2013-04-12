package inf.application.views {
	import inf.application.models.ItemsBoxModel;
	import inf.application.views.components.BaseComponent;
	import inf.application.views.components.BoxComponent;
	
	public class ItemsView extends BoxComponent {
		
		public static var PADDING:int = 20;
		
		/**
		 * DisplayObject container which gives plase to ImageItemComponent instances
		 * @var BaseComponent
		 */
		private var _itemsContainer:BaseComponent;
		
		public function ItemsView(model:ItemsBoxModel) {
			super(model);
		}
		
		public override function render():void {
			super.render();			
		}
		
		/**
		 * Creates items container component and adds to displaylist
		 * @oaran Number width
		 */
		public function createItemsContainer(width:Number):void {
			if (this._itemsContainer == null) {
				this._itemsContainer = new BaseComponent(width);
			}
			if (! this.contains(this._itemsContainer)) {
				this.addChild(this._itemsContainer);
			}
		}
		
		public function get itemsContainer():BaseComponent {
			return this._itemsContainer;
		}
	}
}