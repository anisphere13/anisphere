/// 🎯 Canaux de logs IA AniSphère (tri par type de message)
library;

enum IAChannel {
  system,
  rule,
  execution,
  scheduler,
  sync,
  notification,
  context,
  user,
  // Ajoute ici d'autres canaux si besoin
}

extension IAChannelName on IAChannel {
  String get name {
    switch (this) {
      case IAChannel.system:
        return 'SYSTEM';
      case IAChannel.rule:
        return 'RULE';
      case IAChannel.execution:
        return 'EXECUTION';
      case IAChannel.scheduler:
        return 'SCHEDULER';
      case IAChannel.sync:
        return 'SYNC';
      case IAChannel.notification:
        return 'NOTIFICATION';
      case IAChannel.context:
        return 'CONTEXT';
      case IAChannel.user:
        return 'USER';
      default:
        return 'UNKNOWN';
    }
  }
}
