import 'package:picasso/models/workflow.dart';
import 'package:picasso/utils/images_linker.dart';

import 'theme.dart';

enum Environment {
  prod('prod'),
  dev('dev');

  const Environment(this.value);

  final String value;
}

enum Client {
  regular('regular'),
  pro('pro');

  const Client(this.name);

  final String name;
}

extension StringX on String {
  Client toClient() {
    switch (this) {
      case 'regular':
        return Client.regular;
      case 'pro':
        return Client.pro;
      default:
        return Client.regular;
    }
  }
}

extension BaseStatusX on Client {
  bool get isRegular => this == Client.regular;

  bool get isPro => this == Client.pro;
}

class Config {
  Environment? environment;
  Client? domain;
  PicassoTheme? theme;
  Workflow? workflow;

  Config({
    this.environment,
    this.domain,
    this.theme,
    this.workflow,
  });

  void initFlavorSettings() {
    ImagesLinker().init('assets/images/${domain!.name}/');
  }

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        environment: json['environment'],
        domain: (json['domain'] as String).toClient(),
        theme: json['theme'] != null ? PicassoTheme.fromJson(json['theme']) : null,
        workflow: json['workflow'] != null ? Workflow.fromJson(json['workflow']) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['environment'] = environment!.value;
    data['domain'] = domain!.name;

    if (theme != null) {
      data['theme'] = theme!.toJson();
    }

    if (workflow != null) {
      data['workflow'] = workflow!.toJson();
    }

    return data;
  }

  bool get isProd => environment == Environment.prod;

  bool get isDev => environment == Environment.dev;
}
