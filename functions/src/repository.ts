import { Drink, drinkConverter } from "./Entities/Drink"
import { Food, foodConverter } from "./Entities/Food";
import { Order, orderConverter } from "./Entities/Order";
import { Restaurant, restaurantConverter } from "./Entities/Restaurant";
import { Table, tableConverter } from "./Entities/Table";

const admin = require('firebase-admin');
admin.initializeApp();

export class Repository{
    static food = 'foods'
    static drinks = 'drinks'
    static orders = 'orders'
    static tables = 'tables'
    static restaurants = 'restaurants'

    static async setOrderDone(order: Order, restaurant: string) {
        if(!this.restaurantExists(restaurant)) throw new Error( "Restaurant does not exist")
        order.done = true
        await admin.firestore().collection(restaurant+this.orders)
            .doc(order.id)
            .withConverter(orderConverter)
            .set(order)
        return order
    }
    static async createDrinks(drinks: Drink[], restaurant: string){
        if(!this.restaurantExists(restaurant)) throw new Error( "Restaurant does not exist")
        await Promise.all(drinks.map(async (drink) => {
            await this.createDrink(drink, restaurant);
          }));
        return "created";
    }
    static async createFoods(foods: Food[], restaurant: string){
        if(!this.restaurantExists(restaurant)) throw new Error( "Restaurant does not exist")
        await Promise.all(foods.map(async (food) => {
            await this.createFood(food,restaurant);
          }));
        return "created";
    }
    static async createTables(tables: Table[], restaurant: string){
        if(!this.restaurantExists(restaurant)) throw new Error( "Restaurant does not exist")
        await Promise.all(tables.map(async (table) => {
            await this.createTable(table,restaurant);
          }));
        return "created";
    }

    static async createDrink(drink : Drink, restaurant: string) {
        if(!this.restaurantExists(restaurant)) throw new Error( "Restaurant does not exist")
        await admin.firestore().collection(restaurant+this.drinks)
        .doc(drink.name)
        .withConverter(drinkConverter)
        .set(drink)
        
        return "created";
    }
    static async createTable(table : Table, restaurant: string){
        if(!this.restaurantExists(restaurant)) throw new Error( "Restaurant does not exist")
        var ref = null;
        if(table.tableId == undefined){
            ref = await admin.firestore().collection(restaurant+this.tables).doc()
            table.tableId = ref.id;
        }
        else{
            ref = await admin.firestore().collection(restaurant+this.tables).doc(table.tableId)
        }

        await ref.withConverter(tableConverter)
            .set(table)

        return table.tableId;
    }
    static async createFood(food : Food, restaurant: string){
        if(!this.restaurantExists(restaurant)) throw new Error( "Restaurant does not exist")
        await admin.firestore().collection(restaurant+this.food)
            .doc(food.name)
            .withConverter(foodConverter)
            .set(food)
        return "created"
    }
    static async createOrder(order : Order, restaurant: string){
        if(!this.restaurantExists(restaurant)) throw new Error( "Restaurant does not exist")
        var ref = await admin.firestore().collection(restaurant+this.orders).doc()
        order.id = ref.id;

        await ref.withConverter(orderConverter)
            .set(order)

        return order.id;
    }

    static async createRestaurant(order : Restaurant):Promise<string>{
        await admin.firestore().collection(this.restaurants)
            .doc(order.name)
            .withConverter(restaurantConverter)
            .set(order)
        
        return "created";
    }

    static async restaurantExists(restaurant: string) : Promise<boolean>{
        var snapshot = await admin.firestore().collectionGroup(this.restaurants).where('name', '==', restaurant).get();

        if(snapshot.empty){
            return false;
        }
        return true;
    }
    static async idExistsInCollection(collection: string, id:string) : Promise<boolean>{
        var snapshot = await admin.firestore().collectionGroup(collection).doc(id).get();

        if(snapshot.exists){
            return true;
        }
        return false;
    }

    static async getFoods(restaurant: string) :Promise<Food[]>{
        return this.getAll<Food>(this.food,restaurant);
    };

    static async getAllOrders(restaurant: string) :Promise<Order[]>{
        return this.getAll<Order>(this.orders,restaurant);
    };

    static async getDrinks(restaurant: string) :Promise<Drink[]>{
        return this.getAll<Drink>(this.drinks,restaurant);
    };

    static async getTables(restaurant: string) :Promise<Table[]>{
        return this.getAll<Table>(this.tables,restaurant);

    };
    
    static async getAll<T>(arr : string, restaurant:string) : Promise<T[]> {
        if(!this.restaurantExists(restaurant)) throw new Error( "Restaurant does not exist")
        const snapshot = await admin.firestore().collection(restaurant+arr).get();
        let t : T[]=[]

        snapshot.forEach((doc: { id: string | number; data: () => T; }) => {
            t.push(doc.data())   
        });

        return t
    }
}