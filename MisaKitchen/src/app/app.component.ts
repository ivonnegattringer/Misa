import { Component, OnInit } from '@angular/core';
import { Order } from './order';
import { AngularFirestore } from '@angular/fire/firestore'
import { Observable, Observer } from 'rxjs';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit{
  title = 'MisaKitchen';
  orders: Observable<any[]>;
  testOrders: Order[];
  selectedOrder: Order;
  //orderObserver: Observer<>;

  constructor(db: AngularFirestore){
    this.orders = db.collection('orders').valueChanges();
    this.orders.forEach(order => {
      console.log(order);
    });
  }

  ngOnInit() {
    this.testOrders = new Array<Order>();
    /*let newOrder = {table: {tableId: 1, tableIdentifier: "dog"}, food: ["Pizza", "Schnitzel"], drinks: ["Cola", "Wasser"]};
    this.testOrders.push(newOrder);
    newOrder = {table: {tableId: 2, tableIdentifier: "cat"}, food: ["Reis"], drinks: ["Fanta"]};
    this.testOrders.push(newOrder);*/
  }

  onSelect(order: Order): void {
    this.selectedOrder = order;
  }
}
