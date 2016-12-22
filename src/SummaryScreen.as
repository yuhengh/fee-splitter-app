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
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;

    import starling.display.DisplayObject;

    import starling.events.Event;

    import starlingbuilder.engine.util.StageUtil;

    public class SummaryScreen extends PanelScreen
    {
        private var _cashier:Cashier;

        private var _list:List;
        private var _emptyLabel:Label;

        public function SummaryScreen()
        {
            super();

            _cashier = Cashier.instance;

            initUI();

            addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
        }

        private function initUI():void
        {
            title = "Summary";

            headerFactory = function():Header
            {
                var header:Header = new Header();

                if (StageUtil.isAndroid() || StageUtil.isiOS())
                {
                    var copyButton:Button = new Button();
                    copyButton.label = "Copy";
                    copyButton.addEventListener(Event.TRIGGERED, onCopyButton);
                    header.leftItems = new <DisplayObject>[copyButton];
                }

                return header;
            };

            layout = new AnchorLayout();

            _list = new List();
            _list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
            _list.itemRendererFactory = itemRendererFactory;
            addChild(_list);

            _emptyLabel = new Label();
            _emptyLabel.text = "No Summary";
            _emptyLabel.layoutData = new AnchorLayoutData(30, NaN, NaN, NaN, 0);
            addChild(_emptyLabel);
        }

        private function itemRendererFactory():IListItemRenderer
        {
            var itemRenderer:DefaultListItemRenderer = new DefaultListItemRenderer();
            itemRenderer.labelFunction = function(data:Object):String
            {
                return data.from + " -> " + data.to;
            }
            itemRenderer.accessoryLabelField = "amount";
            return itemRenderer;
        }

        private function onAddToStage(event:Event):void
        {
            update();
        }

        private function update():void
        {
            var summary:Array = _cashier.summary;
            _list.dataProvider = new ListCollection(summary);
            _emptyLabel.visible = (summary.length == 0);
        }

        private function onCopyButton(event:Event):void
        {
            var text:String = print(_cashier.summary);
            //trace(text);
            Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, text);

            Alert.show("Already copied to clipboard", "Success", new ListCollection([{label: "OK"}]));
        }

        private function print(array:Array):String
        {
            var res:Array = [];
            for each (var data:Object in array)
                res.push(data.from + " -> " + data.to + " = " + data.amount);
            return res.join("\n");
        }
    }
}
