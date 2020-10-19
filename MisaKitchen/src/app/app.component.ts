import { Component, OnInit } from '@angular/core';
import { Order } from './order';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit{
  title = 'MisaKitchen';
  orders: Array<Order>;


  ngOnInit() {
    this.orders = new Array<Order>();
    let newOrder = new Order(0);
    this.orders.push(newOrder);
    console.log("Test");
  }
}
