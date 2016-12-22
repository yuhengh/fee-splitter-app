package
{
    import feathers.controls.Alert;
    import feathers.controls.Button;
    import feathers.controls.PanelScreen;
    import feathers.controls.PickerList;
    import feathers.controls.TextInput;
    import feathers.data.ListCollection;

    import starling.core.Starling;

    import starling.display.DisplayObject;

    import starling.events.Event;

    public class RecordAddScreen extends PanelScreen
    {
        public var _nameList:PickerList;
        public var _numInput:TextInput;
        public var _addButton:Button;
        public var _cancelButton:Button;

        public function RecordAddScreen()
        {
            title = "Add record";

            var data:Object = JSON.parse(new EmbeddedLayouts.RECORD());

            var root:DisplayObject = App.uiBuilder.create(data, true, this) as DisplayObject;
            root.x = (Starling.current.stage.stageWidth - root.width) * 0.5;
            root.y = 50;
            addChild(root);

            addEventListener(Event.ADDED_TO_STAGE, onAddToStage);

            _addButton.addEventListener(Event.TRIGGERED, onAdd);
            _cancelButton.addEventListener(Event.TRIGGERED, onCancel);
        }

        private function onAdd(event:Event):void
        {
            var amount:Number = parseFloat(_numInput.text);
            if (isNaN(amount))
            {
                Alert.show("Invalid amount", "Add Failed", new ListCollection([{label: "OK"}]));
                return;
            }

            var data:Object = {name:_nameList.selectedItem, amount:amount};

            Cashier.instance.addRecord(data);

            dispatchEventWith(RecordScreen.RECORD_END);
        }

        private function onCancel(event:Event):void
        {
            dispatchEventWith(RecordScreen.RECORD_END);
        }

        private function onAddToStage(event:Event):void
        {
            var contacts:Array = Cashier.instance.contacts;
            contacts = contacts.map(function(data:Object, index:int, array:Array):Object{return data.name});
            _nameList.dataProvider = new ListCollection(contacts);
        }
    }
}
