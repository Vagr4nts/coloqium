class Todo {
  int id = 0; 
  String name;
  String description;
  String completeBy;
  int priority;

  Todo(this.name, this.description, this.completeBy, this.priority);

  Map<String, dynamic> toMap() {
   return {
      'name': name,
      'description': description,
      'completeBy': completeBy,
      'priority': priority,
    };
  }


}


