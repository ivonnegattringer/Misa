import { Restaurant } from "./Restaurant";

interface RestaurantDTO<T>{
    restaurant: string,
    data: T
}