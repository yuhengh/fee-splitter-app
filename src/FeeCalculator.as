package {
    public class FeeCalculator
    {
        public function calculate(contacts:Array, records:Array):Array
        {
            var item:Object;

            var r:Object = {};

            for each (item in records)
            {
                var name:String = item.name;
                var amount:Number = item.amount;
                if (!(name in r))
                    r[name] = 0;

                r[name] += amount;
            }

            var c:Object = {};

            for each (item in contacts)
            {
                var name:String = item.name;
                var num:int = item.num;
                c[name] = num;
            }

            return getTransactions(r, c);
        }

        function getTransactions(records, contacts)
        {
            if (contacts === undefined) contacts = {};

            var id, id2;
            var sum = 0;
            var count = 0;

            for (id in contacts)
                if (!(id in records))
                    records[id] = 0;

            for (id in records)
            {
                sum += records[id];
                count += (contacts[id] === undefined ? 1 : contacts[id]);
            }

            var avg = sum / count;

            var sender = {};
            var receiver = {};

            var transactions = [];

            for (id in records)
            {
                var num = (contacts[id] === undefined ? 1 : contacts[id]);
                var delta = records[id] - avg * num;

                if (delta > 0)
                    receiver[id] = delta;
                else if (delta < 0)
                    sender[id] = -delta;
            }

            for (id in sender)
            {
                var amount = sender[id];

                //small optimization
                for (id2 in receiver)
                {
                    if (amount == receiver[id2])
                    {
                        transactions.push({from:id, to:id2, amount:amount.toFixed(2)});
                        delete sender[id];
                        delete receiver[id2];
                        break;
                    }
                }

                for (id2 in receiver)
                {
                    if (amount < receiver[id2])
                    {
                        transactions.push({from:id, to:id2, amount:amount.toFixed(2)});
                        receiver[id2] -= amount;
                        delete sender[id];
                        break;
                    }
                    else if (amount > receiver[id2])
                    {
                        transactions.push({from:id, to:id2, amount:receiver[id2].toFixed(2)});
                        amount -= receiver[id2];
                        delete receiver[id2];
                    }
                    else
                    {
                        transactions.push({from:id, to:id2, amount:amount.toFixed(2)});
                        delete sender[id];
                        delete receiver[id2];
                        break;
                    }
                }
            }

            return transactions;
        }
    }
}
