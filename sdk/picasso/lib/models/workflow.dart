class Workflow {
  final bool autoSync;

  Workflow({
    this.autoSync = true,
  });

  factory Workflow.fromJson(Map<String, dynamic> json) => Workflow(
        autoSync: json['auto_sync'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['auto_sync'] = autoSync;

    return data;
  }
}
