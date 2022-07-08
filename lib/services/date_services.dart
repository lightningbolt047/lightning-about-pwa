String getDifferenceInTimeString(String oldDateTimeString){
  DateTime oldDateTime=DateTime.parse(oldDateTimeString);
  DateTime nowDateTime=DateTime.now();
  double difference=(nowDateTime.millisecondsSinceEpoch-oldDateTime.millisecondsSinceEpoch)/1000;
  if(difference<60){
    return "${difference.floor()} second${difference.floor()>1?"s":""} ago";
  }else{
    difference/=60;
    if(difference<(60)){
      return "${difference.floor()} minute${difference.floor()>1?"s":""} ago";
    }else{
      difference/=60;
      if(difference<24){
        return "${difference.floor()} hour${difference.floor()>1?"s":""} ago";
      }else{
        difference/=24;
        if(difference<30){
          return "${difference.floor()} day${difference.floor()>1?"s":""} ago";
        }else{
          difference/=30;
          if(difference<12){
            return "${difference.floor()} month${difference.floor()>1?"s":""} ago";
          }
          difference/=12;
          return "${difference.floor()} year${difference.floor()>1?"s":""} ago";
        }
      }
    }
  }
}