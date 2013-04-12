package inf.application.views {
	import inf.application.models.ItemsBoxModel;
	import inf.application.views.components.BaseComponent;
	import inf.application.views.components.BoxComponent;
	import inf.application.views.components.ScrollComponent;
	
	public class ItemsView extends BoxComponent {
		
		public static var PADDING:int = 20;
		
		/**
		 * DisplayObject container which gives plase to ImageItemComponent instances
		 * @var BaseComponent
		 */
		private var _itemsContainer:BaseComponent;
		
		/**
		 * Scroll component
		 * @var ScrollComponent
		 */
		private var _scrollComponent:ScrollComponent;
		
		
		public function ItemsView(model:ItemsBoxModel) {
			super(model);
		}
		
		public override function render():void {
			super.render();			
		}
		
		/**
		 * Creates scroll component and adds it to displaylist
		 * @param Number width
		 * @param Number height
		 * @return ScrollComponent
		 */
		public function createScrollComponent(width:Number, height:Number):ScrollComponent {
			if (this._scrollComponent == null) {
				this._scrollComponent = new ScrollComponent(width, height);
			}
			if (! this.contains(this._scrollComponent)) {
				this.addChild(this._scrollComponent);
			}
			return this._scrollComponent;
		}
		
		/**
		 * Creates items container component and adds to displaylist
		 * @oaram Number width
		 * @return BaseComponent
		 */
		public function createItemsContainer(width:Number):BaseComponent {
			if (this._itemsContainer == null) {
				this._itemsContainer = new BaseComponent(width);
			}
			if (! this.contains(this._itemsContainer)) {
				this.addChild(this._itemsContainer);
			}
			return this._itemsContainer;
		}
		
		public function get scrollComponent():ScrollComponent {
			return this._scrollComponent;
		}
		
		public function get itemsContainer():BaseComponent {
			return this._itemsContainer;
		}
	}
}