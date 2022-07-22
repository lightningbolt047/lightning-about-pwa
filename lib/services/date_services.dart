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

String getMonthFromInt(int monthNumber){
  switch(monthNumber){
    case 0: return "January";
    case 1: return "February";
    case 2: return "March";
    case 3: return "April";
    case 4: return "May";
    case 5: return "June";
    case 6: return "July";
    case 7: return "August";
    case 8: return "September";
    case 9: return "October";
    case 10: return "November";
    case 11: return "December";
    default: return "";
  }
}

String getNiceStringDateFromISO(String isoString){
  DateTime dateTime=DateTime.parse(isoString);
  return "${getMonthFromInt(dateTime.month)} ${dateTime.day}, ${dateTime.year}";
}