export class Drink{
    name : string =""
    price :number = 0

    constructor(name: string="", price: number=0){
        this.name = name
        this.price = price
    }
}
export var drinkConverter = {
    toFirestore: function(table: Drink) {
        return {
            name: table.name,
            price: table.price,
            }
    },
    fromFirestore: function(snapshot: any, options: any){
        const data = snapshot.data(options);
        return new Drink(data.name, data.price)
    }
}