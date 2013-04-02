package inf.application.models {
	/**
	 * BoxModel class
	 * @author inf
	 */
	public class BoxModel extends BaseModel {
		
		private var _width:Number;
		private var _height:Number;
		private var _align:String;
		private var _x:Number;
		private var _y:Number;
		private var _backgroundColor:uint;
		private var _backgroundAlpha:Number;
		private var _borderSize:Number;
		private var _borderColor:uint;
		private var _borderAlpha:Number;
		
		public function BoxModel() {
			super();
		}
		
		internal function setWidth(value:Number):void {
			this._width = value;	
		}
		
		internal function setHeight(value:Number):void {
			this._height = value;
		}
		
		internal function setAlign(value:String):void {
			this._align = value;
		}
		
		internal function setX(value:Number):void {
			this._x = value;
		}
		
		internal function setY(value:Number):void {
			this._y = value;
		}
		
		internal function setBackgroundColor(value:String):void {
			this._backgroundColor = parseInt(value, 16);
		}
		
		internal function setBackgroundAlpha(value:Number):void {
			this._backgroundAlpha = value;
		}
		
		internal function setBorderSize(value:Number):void {
			this._borderSize = value;
		}
		
		internal function setBorderColor(value:String):void {
			this._borderColor = parseInt(value, 16);
		}
		
		internal function setBorderAlpha(value:Number):void {
			this._borderAlpha = value;
		}
		
		public function get width():Number {
			return this._width;
		}
		
		public function get height():Number {
			return this._height;
		}
		
		public function get align():String {
			return this._align;
		}
		
		public function get x():Number {
			return this._x;
		}
		
		public function get y():Number {
			return this._y;
		}
		
		public function get backgroundColor():uint {
			return this._backgroundColor;
		}
		
		public function get backgroundAlpha():Number {
			return this._backgroundAlpha;
		}
		
		public function get borderSize():Number {
			return this._borderSize;
		}
		
		public function get borderColor():uint {
			return this._borderColor;
		}
		
		public function get borderAlpha():Number {
			return this._borderAlpha;
		}
	}
}