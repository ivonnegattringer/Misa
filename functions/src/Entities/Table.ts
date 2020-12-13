export class Table{
    tableIdentifier : string =""
    tableId : string = ""

    constructor (identifier : string = "", tableId : string = ""){
        this.tableIdentifier = identifier
        this.tableId = tableId
    }
}
export var tableConverter = {
    toFirestore: function(table: Table) {
        return {
            tableIdentifier: table.tableIdentifier,
            tableId: table.tableId,
            }
    },
    fromFirestore: function(snapshot: any, options: any){
        const data = snapshot.data(options);
        return new Table(data.tableIdentifier, data.tableId)
    }
}
