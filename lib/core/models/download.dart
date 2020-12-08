class Download {
  String sha;
  String nodeId;
  int size;
  String url;
  String content;
  String encoding;

  Download(
      {this.sha,
        this.nodeId,
        this.size,
        this.url,
        this.content,
        this.encoding});

  Download.fromJson(Map<String, dynamic> json) {
    sha = json['sha'];
    nodeId = json['node_id'];
    size = json['size'];
    url = json['url'];
    content = json['content'];
    encoding = json['encoding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sha'] = this.sha;
    data['node_id'] = this.nodeId;
    data['size'] = this.size;
    data['url'] = this.url;
    data['content'] = this.content;
    data['encoding'] = this.encoding;
    return data;
  }
}
