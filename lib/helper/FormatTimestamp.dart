class FormatTimestamp{
  static String getTimeFromTimestamp(String timestamp){
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
    String hour = date.hour.toString().padLeft(2, '0'); // Adiciona um zero à esquerda para manter o formato HH:MM:SS
    String minute = date.minute.toString().padLeft(2, '0');
    String time = '$hour:$minute';
    return time;
  }
}