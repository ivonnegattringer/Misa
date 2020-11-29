export class Restaurant{
    name : string =""

    constructor (identifier : string = ""){
        this.name = identifier
    }
}
export var restaurantConverter = {
    toFirestore: function(restaurant: Restaurant) {
        return {
            name: restaurant.name
            }
    },
    fromFirestore: function(snapshot: any, options: any){
        const data = snapshot.data(options);
        return new Restaurant(data.name)
    }
}