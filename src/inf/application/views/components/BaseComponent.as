package inf.application.views.components {
	import flash.display.Sprite;
	
	/**
	 * BaseComponent class
	 * @author inf
	 */
	public class BaseComponent extends Sprite {
		
		private var _width:Number;
		private var _height:Number;
		
		public function BaseComponent(width:Number = 0, height:Number = 0) {
			super();
			
			this._width = width;
			this._height = height;
		}
		
		public function render():void {
			// should override and implement this function
		}
		
		public override function set width(value:Number):void {
			this._width = value;
		}
		
		public override function set height(value:Number):void {
			this._height = value;
		}
		
		public override function get width():Number {
			return this._width;
		}
		
		public override function get height():Number {
			return this._height;
		}
	}
}