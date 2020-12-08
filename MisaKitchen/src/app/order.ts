export interface Order {
    table: {
        tableId: number,
        tableIdentifier: string
    };
    foods: {
        ingredients: string,
        name: string,
        price: number
    }[];
    drinks: {
        name: string,
        price: number
    }[];
}
