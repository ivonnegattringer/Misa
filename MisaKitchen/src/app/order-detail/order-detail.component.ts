import { Component, Input } from '@angular/core';
import { from } from 'rxjs';
import { Order } from '../order'

@Component({
  selector: 'order-detail',
  templateUrl: './order-detail.component.html',
  styleUrls: ['./order-detail.component.css']
})
export class OrderDetailComponent{
  @Input() order: Order;
  constructor() { }

}
