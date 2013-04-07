package inf.application.views.components {
	import inf.application.models.BoxModel;
	
	/**
	 * BoxComponent class
	 * @author inf
	 */
	public class BoxComponent extends BackgroundedComponent {
		
		public function BoxComponent(model:BoxModel) {
			super(model.width, model.height, BackgroundedComponent.LEFT_TOP, model.backgroundColor, model.backgroundAlpha, model.borderSize, model.borderColor, model.borderAlpha);
		}
		
		public override function render():void {
			super.render();
		}
	}
}