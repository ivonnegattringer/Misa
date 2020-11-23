import { Drink, drinkConverter } from "./Entities/Drink"
import { Food, foodConverter } from "./Entities/Food";
import { Order, orderConverter } from "./Entities/Order";
import { Restaurant, RestaurantConverter } from "./Entities/Restaurant";
import { Table, tableConverter } from "./Entities/Table";

const admin = require('firebase-admin');
admin.initializeApp();

export class Repository{
    static food = 'foods'
    static drinks = 'drinks'
    static orders = 'orders'
    static tables = 'tables'
    static restaurants = 'restaurants'

    static async setOrderDone(order: Order) {
        await admin.firestore().collection(this.orders)
        .doc()
        .withConverter(orderConverter)
        .set()
    }
    static async createDrinks(drinks: Drink[]){
        await Promise.all(drinks.map(async (drink) => {
            await this.createDrink(drink);
          }));
        return "created";
    }
    static async createFoods(foods: Food[]){
        await Promise.all(foods.map(async (food) => {
            await this.createFood(food);
          }));
        return "created";
    }
    static async createTables(tables: Table[]){
        await Promise.all(tables.map(async (table) => {
            await this.createTable(table);
          }));
        return "created";
    }

    static async createDrink(drink : Drink) {
        await admin.firestore().collection(this.drinks)
        .doc(drink.name)
        .withConverter(drinkConverter)
        .set(drink)
        
        return "created";
    }
    static async createTable(table : Table){
        await admin.firestore().collection(this.tables)
            .doc(table.tableId)
            .withConverter(tableConverter)
            .set(table)
        return "created";
    }
    static async createFood(food : Food){
        await admin.firestore().collection(this.food)
            .doc(food.name)
            .withConverter(foodConverter)
            .set(food)
        return "created"
    }
    static async createOrder(order : Order){
        var ref = await admin.firestore().collection(this.orders).doc()
        order.id = ref.id;

        await ref.withConverter(orderConverter)
            .set(order)

        return "created";
    }

    static async createRestaurant(order : Restaurant){
        await admin.firestore().collection(this.restaurants)
            .doc(order.name)
            .withConverter(RestaurantConverter)
            .add(order)
        
        return "created";
    }

    static async restaurantExists(restaurant: string) : Promise<boolean>{
        var snapshot = await admin.firestore().collectionGroup(this.restaurants).where('name', '==', restaurant).get();

        if(snapshot.length ==0){
            return false;
        }
        return true;
    }

    static async getFoods() :Promise<Food[]>{
        return this.getAll<Food>(this.food);
    };

    static async getAllOrders() :Promise<Order[]>{
        return this.getAll<Order>(this.orders);
    };

    static async getDrinks() :Promise<Drink[]>{
        return this.getAll<Drink>(this.drinks);
    };

    static async getTables() :Promise<Table[]>{
        return this.getAll<Table>(this.tables);

    };
    
    static async getAll<T>(arr : string) : Promise<T[]> {
        const snapshot = await admin.firestore().collection(arr).get();
        let t : T[]=[]

        snapshot.forEach((doc: { id: string | number; data: () => T; }) => {
            t.push(doc.data())   
        });

        return t
    }
}