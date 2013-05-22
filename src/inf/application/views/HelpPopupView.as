package inf.application.views {
	
	import inf.application.models.BoxModel;
	import inf.application.views.components.BackgroundedComponent;
	import inf.application.views.components.BaseComponent;
	import inf.application.views.components.BoxComponent;
	import inf.application.views.components.ScrollComponent;
	
	/**
	 * HelpPopupView class
	 * @author inf
	 */
	public class HelpPopupView extends BoxComponent {
		
		/**
		 * Scroll component
		 * @var ScrollComponent
		 */
		private var _scrollComponent:ScrollComponent;
		
		private var _scrollContainer:BackgroundedComponent;
		
		
		public function HelpPopupView(model:BoxModel) {
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
		 * Creates scroll container
		 * @oaram Number width
		 * @return BaseComponent
		 */
		public function createScrollContainer(width:Number):BaseComponent {
			if (this._scrollContainer == null) {
				this._scrollContainer = new BaseComponent(width);
			}
			if (! this.contains(this._scrollContainer)) {
				this.addChild(this._scrollContainer);
			}
			return this._scrollContainer;
		}
		
		
	}
}