import { Drink, drinkConverter } from "./Entities/Drink"
import { Food, foodConverter } from "./Entities/Food";
import { Order, orderConverter } from "./Entities/Order";
import { Table, tableConverter } from "./Entities/Table";

const admin = require('firebase-admin');
admin.initializeApp();

export class Repository{
    static food = 'foods'
    static drinks = 'drinks'
    static orders = 'orders'
    static tables = 'tables'

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
        await admin.firestore().collection(this.orders)
            .withConverter(orderConverter)
            .add(order)

        return "created";
    }
    static async getFoods() :Promise<Food[]>{
        const snapshot = await admin.firestore().collection(this.food).get();
        let foods : Food[]=[]

        snapshot.forEach((doc: { id: string | number; data: () => Food; }) => {
            foods.push(doc.data())
        });

        return foods
    };

    static async getAllOrders() :Promise<Order[]>{
        const snapshot = await admin.firestore().collection(this.orders).get();
        let order : Order[]=[]

        snapshot.forEach((doc: { id: string | number; data: () => Order; }) => {
            order.push(doc.data())   
        });

        return order
    };

    static async getDrinks() :Promise<Drink[]>{
        const snapshot = await admin.firestore().collection(this.drinks).get();
        let foods : Drink[]=[]

        snapshot.forEach((doc: { id: string | number; data: () => Drink; }) => {
            foods.push(doc.data())   
        });

        return foods
    };

    static async getTables() :Promise<Table[]>{
        const snapshot = await admin.firestore().collection(this.tables).get();
        let foods : Table[]=[]

        snapshot.forEach((doc: { id: string | number; data: () => Table; }) => {
            foods.push(doc.data())   
        });

        return foods
    };
  
}