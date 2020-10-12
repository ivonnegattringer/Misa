export class Food{
    name: string = ""
    price : number =0
    ingredients : string =""

    constructor (name: string = "", price : number = 0, ingredients : string = ""){
        this.name = name
        this.price = price
        this.ingredients = ingredients
    }
}
export var foodConverter = {
    toFirestore: function(table: Food) {
        return {
            name: table.name,
            price: table.price,
            ingredients : table.ingredients
            }
    },
    fromFirestore: function(snapshot: any, options: any){
        const data = snapshot.data(options);
        return new Food(data.name, data.price, data.ingredients)
    }
}