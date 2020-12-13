import { Component, OnInit, ViewChild } from '@angular/core';
import { Order } from './order';
import { AngularFirestore } from '@angular/fire/firestore'
import { Observable } from 'rxjs';
import { HttpService } from "./http.service";
import { OrderDetailComponent } from './order-detail/order-detail.component';


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
  http: HttpService

  @ViewChild(OrderDetailComponent ) childs: OrderDetailComponent[] ;

  constructor(db: AngularFirestore, http: HttpService){
    this.orders = db.collection('Misaorders').valueChanges();
    /*this.orders.forEach(order => {
      console.log(order);
    });*/
    this.http = http;
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

  onDone(): void {
    if (this.selectedOrder != null) {
      this.selectedOrder = null;
    }
  }
}
