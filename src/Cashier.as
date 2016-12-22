package
{
    import flash.net.SharedObject;

    public class Cashier
    {
        private static var _cashier:Cashier;

        public static function get instance():Cashier
        {
            if (_cashier == null)
                _cashier = new Cashier();

            return _cashier;
        }

        private var _contacts:Array;
        private var _records:Array;

        private var _calculator:FeeCalculator;

        public function Cashier()
        {
            _contacts = [];
            _records = [];

            _calculator = new FeeCalculator();

            recoverData();

            //mockData();
        }

        public function get contacts():Array
        {
            return _contacts;
        }

        public function get records():Array
        {
            return _records;
        }

        public function get summary():Array
        {
            return _calculator.calculate(_contacts, _records);
        }

        private function mockData():void
        {
            _contacts.push({name:"Jim", num:1});
            _contacts.push({name:"Tom", num:2});

            _records.push({id:1, name:"Jim", amount:10});
            _records.push({id:2, name:"Tom", amount:11});
        }

        public function addContact(data:Object):Boolean
        {
            if (_contacts.filter(function(item:Object, index:int, array:Array):Boolean
            {
                return item.name == data.name;
            }).length == 0)
            {
                _contacts.push(data);
                setChanged();
                return true;
            }
            else
            {
                return false;
            }
        }

        public function removeContact(name:String):void
        {
            for (var i:int = _contacts.length - 1; i >= 0; --i)
            {
                if (_contacts[i].name == name)
                {
                    removeRecordByName(name);
                    _contacts.removeAt(i);
                    setChanged();
                    break;
                }
            }
        }

        public function addRecord(data:Object):void
        {
            data.id = generateRecordId();
            _records.push(data);
            setChanged();
        }

        public function clearContacts():void
        {
            _contacts.length = 0;
            _records.length = 0;
            setChanged();
        }

        public function removeRecord(id:int):void
        {
            for (var i:int = _records.length - 1; i >= 0; --i)
            {
                if (_records[i].id == id)
                {
                    _records.removeAt(i);
                    setChanged();
                    break;
                }
            }
        }

        public function clearRecords():void
        {
            _records.length = 0;
            setChanged();
        }

        private function removeRecordByName(name:String):void
        {
            for (var i:int = _records.length - 1; i >= 0; --i)
            {
                if (_records[i].name == name)
                {
                    _records.removeAt(i);
                }
            }

            setChanged();
        }

        private function generateRecordId():int
        {
            var max:int = 0;
            for each (var item:Object in _records)
            {
                max = Math.max(max, item.id);
            }
            return max + 1;
        }

        private function setChanged():void
        {
            saveData();
        }

        private function saveData():void
        {
            var so:SharedObject = SharedObject.getLocal("data");
            so.data.contacts = _contacts;
            so.data.records = _records;
            so.flush();
        }

        private function recoverData():void
        {
            var so:SharedObject = SharedObject.getLocal("data");
            if (so.data)
            {
                if (so.data.contacts)
                    _contacts = so.data.contacts;

                if (so.data.records)
                    _records = so.data.records;
            }
        }

    }
}
