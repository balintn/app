package inf.application.views {
	import inf.application.models.EditorBoxModel;
	import inf.application.views.widgets.BoxComponent;
	
	/**
	 * EditorView class
	 * @author inf
	 */
	public class EditorView extends BoxComponent {
		
		public function EditorView(model:EditorBoxModel) {
			super(model);
		}
		
		public override function render():void {
			super.render();
			
		}
	}
}