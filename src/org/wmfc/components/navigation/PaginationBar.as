package org.wmfc.components.navigation
{
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import org.wmfc.components.navigation.events.PaginationEvent;
	import org.wmfc.utils.Resource;
	
	[Event(name="goToPage", type="org.wmfc.componentes.navigation.events.PaginationEvent")]
	
	public class PaginationBar extends PaginationBarView
	{
		public static const GO_TO_FIRST:int = 0;
		public static const GO_TO_PREVIOUS:int = 1;
		public static const GO_TO_NEXT:int = 2;
		public static const GO_TO_LAST:int = 3;
		
		private var _page:int;
		public function get page():int
		{
			return _page;
		}

		public function set page(value:int):void
		{
			_page = value;
		}

		private var _totalPages:int;
		public function get totalPages():int
		{
			return _totalPages;
		}

		public function set totalPages(value:int):void
		{
			_totalPages = value;
		}
		
		private var _showTotalPages:Boolean;
		public function get showTotalPages():Boolean
		{
			return _showTotalPages;
		}

		public function set showTotalPages(value:Boolean):void
		{
			_showTotalPages = value;
		}
		
		private var _pageOfPageLabel:String = Resource.getValue(Resource.PAGINATIONBAR_PAGEOFPAGE_LABEL);
		
		protected override function childrenCreated():void {
			super.childrenCreated();
			
			botFirst.addEventListener(MouseEvent.CLICK, botFirst_onClick);
			botPrevious.addEventListener(MouseEvent.CLICK, botPrevious_onClick);
			botNext.addEventListener(MouseEvent.CLICK, botNext_onClick);
			botLast.addEventListener(MouseEvent.CLICK, botLast_onClick);
			
			lblPages.text = "0 " + _pageOfPageLabel + " 0";
		}
		
		public function commit():void {
			
			botFirst.enabled = (_page > 1);
			botPrevious.enabled = (_page > 1);
			botNext.enabled = (!_showTotalPages || _page < _totalPages);
			botLast.enabled = (!_showTotalPages || _page < _totalPages);
			
			lblPages.text = _page + _pageOfPageLabel + _totalPages;
		}
		
		protected function botFirst_onClick(event:MouseEvent):void {
			browse(GO_TO_FIRST);
		}
		
		protected function botPrevious_onClick(event:MouseEvent):void {
			browse(GO_TO_PREVIOUS);
		}
		
		protected function botNext_onClick(event:MouseEvent):void {
			browse(GO_TO_NEXT);
		}
		
		protected function botLast_onClick(event:MouseEvent):void {
			browse(GO_TO_LAST);
		}
		
		protected function browse(action:int):void {
			this.dispatchEvent(new PaginationEvent(action));
		}
	}
}