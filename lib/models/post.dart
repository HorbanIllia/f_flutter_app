class Post {
  int userId;
  int id;
  String title;
  String body;
  String img;
  bool isExpanded = false;

  Post({this.userId, this.id, this.title, this.body, this.img, this.isExpanded});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['img'] = this.img;
    return data;
  }
}