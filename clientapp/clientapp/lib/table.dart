class Table{
  String tableIdentifier;
  int tableId;


  Table({this.tableIdentifier, this.tableId});

  factory Table.fromJson(Map<String, dynamic> json){
    return Table(
      tableIdentifier: json['tableIdentifier'],
      tableId: int.parse(json['tableId'])
    );
  }

  Map toJson() => {
    'tableIdentifier': tableIdentifier,
    'tableId': tableId,
  };
}