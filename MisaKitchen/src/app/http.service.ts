import { Injectable } from '@angular/core';
import { HttpClient } from "@angular/common/http";
import { Order } from "./order";

@Injectable({
  providedIn: 'root'
})
export class HttpService {
  http: HttpClient
  constructor(http: HttpClient) {
    this.http = http
  }

  setDone(order: Order){
    this.http.post("https://us-central1-misa-2021.cloudfunctions.net/rest/Misa/setOrderDone", order)
    .subscribe((data: Response) => console.log(data));
    console.log("Order " + order.id + " done");
  }

}
