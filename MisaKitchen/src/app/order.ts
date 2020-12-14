export interface Order {
    id: string;
    table: {
        tableId: string,
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
    done: boolean;
    created: string;
}
