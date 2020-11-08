import { Drink } from "./Drink"
import { Food } from "./Food"
import { Table } from "./Table"

export class Order{
    constructor (created : Date, table: Table, foods: Food[], drinks : Drink[], done : boolean){
        this.created = created;
        this.table = table;
        this.foods = foods;
        this.drinks = drinks;
        this.done = done
    }
    done: boolean = false;
    created : Date = new Date()
    table : Table = new Table()
    foods : Food[] = []
    drinks : Drink[] = []
}
export var orderConverter = {
    toFirestore: function(table: Order) {
        return {
            created: table.created,
            table: table.table,
            foods: table.foods,
            drinks: table.drinks,
            done: table.done
            }
    },
    fromFirestore: function(snapshot: any, options: any){
        const data = snapshot.data(options);
        return new Order(data.created, data.table, data.foods, data.drinks,data.done)
    }
}

