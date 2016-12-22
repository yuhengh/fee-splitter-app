package
{
    import feathers.controls.Alert;
    import feathers.controls.Button;
    import feathers.controls.NumericStepper;
    import feathers.controls.PanelScreen;
    import feathers.controls.TextInput;
    import feathers.data.ListCollection;

    import starling.core.Starling;

    import starling.display.DisplayObject;

    import starling.events.Event;

    public class ContactRegisterScreen extends PanelScreen
    {
        public var _nameInput:TextInput;
        public var _numInput:NumericStepper;
        public var _addButton:Button;
        public var _cancelButton:Button;

        public function ContactRegisterScreen()
        {
            title = "Register";

            var data:Object = JSON.parse(new EmbeddedLayouts.REGISTER());

            var root:DisplayObject = App.uiBuilder.create(data, true, this) as DisplayObject;
            root.x = (Starling.current.stage.stageWidth - root.width) * 0.5;
            root.y = 50;
            addChild(root);

            _addButton.addEventListener(Event.TRIGGERED, onAdd);
            _cancelButton.addEventListener(Event.TRIGGERED, onCancel);
        }

        private function onAdd(event:Event):void
        {
            if (_nameInput.text == "")
            {
                Alert.show("Name can't be empty", "Register failed", new ListCollection([{label: "OK"}]));
                return;
            }

            var data:Object = {name:_nameInput.text, num:_numInput.value};

            if (Cashier.instance.addContact(data))
            {
                dispatchEventWith(ContactScreen.REGISTER_END);
            }
            else
            {
                Alert.show("Name already existed", "Register failed", new ListCollection([{label: "OK"}]));
            }
        }

        private function onCancel(event:Event):void
        {
            dispatchEventWith(ContactScreen.REGISTER_END);
        }
    }
}
