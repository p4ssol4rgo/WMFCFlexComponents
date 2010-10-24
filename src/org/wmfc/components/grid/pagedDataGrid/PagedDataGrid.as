package org.wmfc.components.grid.pagedDataGrid
{
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.ListEvent;
	
	import org.wmfc.components.navigation.events.PaginationEvent;

	[Event(name="goToPage", type="org.wmfc.componentes.navigation.events.PaginationEvent")]
	public class PagedDataGrid extends PagedDataGridView
	{
		public static const GO_TO_FIRST:int = 0;
		public static const GO_TO_PREVIOUS:int = 1;
		public static const GO_TO_NEXT:int = 2;
		public static const GO_TO_LAST:int = 3;
		
		protected var _columns:Array;
		public function get columns():Array
		{
			return _columns;
		}

		public function set columns(value:Array):void
		{
			_columns = value;
		}

		protected var _dataProvider:ArrayCollection;
		public function get dataProvider():ArrayCollection
		{
			return _dataProvider;
		}

		public function set dataProvider(value:ArrayCollection):void
		{
			_dataProvider = value;
		}

		
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
		
		public function get selectedItem():Object
		{
			return dataGrid.selectedItem;
		}

		public function set selectedItem(value:Object):void
		{
			dataGrid.selectedItem = value;
		}
		
		public function commit():void {
			
			if(dataGrid == null || paginationBar == null || _columns == null){
				return;
			}
			
			dataGrid.columns = _columns;
			dataGrid.dataProvider = _dataProvider;
			
			paginationBar.page = _page == 0 && _totalPages > 0 ? 1 : _page;
			paginationBar.totalPages = _totalPages;
			paginationBar.showTotalPages = _showTotalPages;
			paginationBar.commit();
		}
		
		protected override function childrenCreated():void {
			super.childrenCreated();
			
			paginationBar.addEventListener(PaginationEvent.GO_TO_PAGE, paginationBar_onPageSearch, false, 0, true);
			
			dataGrid.doubleClickEnabled = true;
			dataGrid.addEventListener(ListEvent.CHANGE, dataGrid_onSelectedItemChange, false, 0, true);
			dataGrid.addEventListener(MouseEvent.DOUBLE_CLICK, dataGrid_onDoubleClick, false, 0, true);
			
			commit();
		}
		
		protected function paginationBar_onPageSearch(event:PaginationEvent):void {
			this.dispatchEvent(event);
		}
		
		protected function dataGrid_onSelectedItemChange(event:ListEvent):void {
			this.dispatchEvent(event);
		}
		
		protected function dataGrid_onDoubleClick(event:MouseEvent):void {
			this.dispatchEvent(event);
		}
	}
}