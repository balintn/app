package inf.application.mediators {
	import flash.display.Sprite;
	
	import inf.application.models.EnvironmentModel;
	import inf.application.views.EditorView;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * EditorMediator class
	 * @author inf
	 */
	public class EditorMediator extends Mediator {
		
		public static const NAME:String = "editorMediator";
		
		public function EditorMediator(viewComponent:EditorView) {
			super(EditorMediator.NAME, viewComponent);
		}
		
		/**
		 * Returns the view component
		 * @return Sprite
		 */
		public function get view():Sprite {
			return this.viewComponent as Sprite;
		}
	}
}