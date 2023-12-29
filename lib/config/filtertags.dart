
List<Map<String, dynamic>> filtertags(List<Map<String, dynamic>> items,String filter){
    List<Map<String, dynamic>> elements = [];
    if (filter == "All"){
        return items;
    }
    elements = items.where((element) => element["info"][0]["tags"].contains(filter.toLowerCase())).toList();
    return elements;
}
List<Map<String, dynamic>> filtertagsS(List<Map<String, dynamic>> items,String filter){
    List<Map<String, dynamic>> elements = [];
    if (filter == "All"){
        return items;
    }
    elements = items.where((element) => element["tags"].contains(filter.toLowerCase())).toList();
    return elements;
}