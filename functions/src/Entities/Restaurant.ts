export class Restaurant{
    name : string =""

    constructor (identifier : string = ""){
        this.name = identifier
    }
}
export var RestaurantConverter = {
    toFirestore: function(Restaurant: Restaurant) {
        return {
            name: Restaurant.name
            }
    },
    fromFirestore: function(snapshot: any, options: any){
        const data = snapshot.data(options);
        return new Restaurant(data.name)
    }
}