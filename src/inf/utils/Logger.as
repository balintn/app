package inf.utils {
	
	/**
	 * Simple logger class.
	 * You can enable or disable logging with <code>Logger.enableLogging()</code> and <code>Logger.disableLogging()</code>. 
	 * You can set log level with <code>Logger.setLogLevel()</code>.
	 * @author inf
	 */
	public final class Logger {
		
		/**
		 * Debug level
		 * @var uint
		 */
		public static const LEVEL_DEBUG:uint = 0;
		/**
		 * Info level
		 * @var uint
		 */
		public static const LEVEL_INFO:uint = 1;
		/**
		 * Warning level
		 * @var uint
		 */
		public static const LEVEL_WARNING:uint = 2;
		/**
		 * Error level
		 * @var uint
		 */
		public static const LEVEL_ERROR:uint = 3;
		
		/**
		 * Logging level
		 * @var uint
		 */
		protected static var _logLevel:uint = 0;
		
		/**
		 * Is logging enabled
		 * @var Boolean
		 */
		protected static var _logEnabled:Boolean = true;
		
		
		/**
		 * Sets log level
		 * @param uint level
		 */
		public static function setLogLevel(level:uint):void {
			if (level > Logger.LEVEL_ERROR)
				level = Logger.LEVEL_ERROR;
			
			Logger._logLevel = level;
		}
		
		/**
		 * Enable logging
		 */
		public static function enableLogging():void {
			Logger._logEnabled = true;
		}
		
		/**
		 * Disable logging
		 */
		public static function disableLogging():void {
			Logger._logEnabled = false;
		}
		
		/**
		 * Log debug
		 * @param String message
		 */
		public static function debug(msg:String):void {
			if (Logger._logEnabled && Logger._logLevel <= Logger.LEVEL_DEBUG) {
				Logger.log(msg, Logger.LEVEL_DEBUG);
			}
		}
		
		/**
		 * Log info
		 * @param String message
		 */
		public static function info(msg:String):void {
			if (Logger._logEnabled && Logger._logLevel <= Logger.LEVEL_INFO) {
				Logger.log(msg, Logger.LEVEL_INFO);
			}
		}
		
		/**
		 * Log warn
		 * @param String message
		 */
		public static function warn(msg:String):void {
			if (Logger._logEnabled && Logger._logLevel <= Logger.LEVEL_WARNING) {
				Logger.log(msg, Logger.LEVEL_WARNING);
			}
		}
		
		/**
		 * Log error
		 * @param String message
		 */
		public static function error(msg:String):void {
			if (Logger._logEnabled && Logger._logLevel <= Logger.LEVEL_ERROR) {
				Logger.log(msg, Logger.LEVEL_ERROR);
			}
		}
		
		/**
		 * Trace message
		 * @param String message to trace
		 * @param uint log level
		 */
		protected static function log(msg:String, level:uint):void {
			var date:Date = new Date();
			var levelName:String = Logger.getLevelName(level);
			
			var hours:String = date.hours < 10 ? "0" + String(date.hours) : String(date.hours);
			var minutes:String = date.minutes < 10 ? "0" + String(date.minutes) : String(date.minutes);
			var seconds:String = date.seconds < 10 ? "0" + String(date.seconds) : String(date.seconds);
			var msec:String;
			if (date.milliseconds < 10) {
				msec = String(date.milliseconds) + "00";
			} else if (date.milliseconds < 100) {
				msec = String(date.milliseconds) + "0";
			} else {
				msec = String(date.milliseconds);
			}
			trace(hours + ":" + minutes + ":" + seconds + "." + msec + " --[" + levelName + "]-- " + msg);
		}
		
		/**
		 * Returns the log level readable name
		 * @param uint
		 * @return String
		 */
		protected static function getLevelName(level:uint):String {
			switch (level) {
				case Logger.LEVEL_DEBUG:
					return "DEBUG";
					
				case Logger.LEVEL_INFO:
					return "INFO";
					
				case Logger.LEVEL_WARNING:
					return "WARN";
					
				case Logger.LEVEL_ERROR:
					return "ERROR";
					
				default:
					return "UNKNOWN";					
			}
		}
	}
}