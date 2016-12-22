package
{
    import feathers.controls.Alert;
    import feathers.controls.Button;
    import feathers.controls.Header;
    import feathers.controls.Label;
    import feathers.controls.List;
    import feathers.controls.PanelScreen;
    import feathers.controls.renderers.DefaultListItemRenderer;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.events.FeathersEventType;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import starling.display.DisplayObject;

    import starling.events.Event;

    public class RecordListScreen extends PanelScreen
    {
        private var _cashier:Cashier;

        private var _list:List;
        private var _emptyLabel:Label;

        public function RecordListScreen()
        {
            super();

            _cashier = Cashier.instance;

            initUI();

            addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
        }

        private function initUI():void
        {
            title = "Records";

            headerFactory = function():Header
            {
                var header:Header = new Header();

                var addButton:Button = new Button();
                addButton.label = "Add";
                addButton.addEventListener(Event.TRIGGERED, onAddButton);
                header.leftItems = new <DisplayObject>[addButton];

                var clearButton:Button = new Button();
                clearButton.label = "Clear";
                clearButton.addEventListener(Event.TRIGGERED, onClearButton);
                header.rightItems = new <DisplayObject>[clearButton];

                return header;
            };

            layout = new AnchorLayout();

            _list = new List();
            _list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
            _list.itemRendererFactory = itemRendererFactory;
            addChild(_list);

            _emptyLabel = new Label();
            _emptyLabel.text = "No Record";
            _emptyLabel.layoutData = new AnchorLayoutData(30, NaN, NaN, NaN, 0);
            addChild(_emptyLabel);
        }

        private function itemRendererFactory():IListItemRenderer
        {
            var itemRenderer:DefaultListItemRenderer = new DefaultListItemRenderer();
            itemRenderer.labelField = "name";
            itemRenderer.accessoryLabelField = "amount";
            itemRenderer.isLongPressEnabled = true;
            itemRenderer.addEventListener(FeathersEventType.LONG_PRESS, onLongPress);
            return itemRenderer;
        }

        private function onAddButton():void
        {
            dispatchEventWith(RecordScreen.RECORD_START);
        }

        private function onClearButton():void
        {
            function onTrigger():void
            {
                Cashier.instance.clearRecords();
                update();
            }

            Alert.show("Are you sure?", "Clear Records", new ListCollection([{label:"Yes", triggered:onTrigger}, {label:"No"}]));
        }

        private function onAddToStage(event:Event):void
        {
            update();
        }

        private function update():void
        {
            var records:Array = _cashier.records;
            _list.dataProvider = new ListCollection(records);
            _emptyLabel.visible = (records.length == 0);
        }

        private function onLongPress(event:Event):void
        {
            var item:DefaultListItemRenderer = event.target as DefaultListItemRenderer;

            function onTrigger():void
            {
                _cashier.removeRecord(item.data.id);
                update();
            }

            Alert.show("Are you sure?", "Delete this record", new ListCollection([{label:"Yes", triggered:onTrigger}, {label:"No"}]));
        }
    }
}
