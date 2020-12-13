import { Component, Input, ViewChild } from '@angular/core';
import { from } from 'rxjs';
import { HttpService } from '../http.service';
import { Order } from '../order'

@Component({
  selector: 'order-detail',
  templateUrl: './order-detail.component.html',
  styleUrls: ['./order-detail.component.css']
})
export class OrderDetailComponent{
  @Input() order: Order;
  http : HttpService;
  constructor(http : HttpService) {
    this.http = http
  }


  setDone() : void{
    this.http.setDone(this.order)
  }
}
