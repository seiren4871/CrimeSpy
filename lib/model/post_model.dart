import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' ;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/locale.dart';


String crimeType, crimeDetail = "";
String post_id= "";

//add new crime report
Future<void> addCrimeReport(String userid, String crimeid, DateTime time ) async {
//  Intl.defaultLocale = 'th_TH';
  initializeDateFormatting('th_TH', null);
  // print("time = "); print( time);
  final timeutc = time.toUtc();
  // print("toUtc = " ); print(timeutc);
  final timelocal = timeutc.toLocal();
  // print("timelocal = " ); print( timelocal);
  try{
    await Firestore.instance.collection("CrimeRecord").document(crimeid).setData({
      "reporter": userid,
      "type": crimeType,
      "detail": crimeDetail,
//      "time" : time,// collect from click on submit button
      "trustworthy": 0,
      "unreliability": 0,
      "datetime": DateFormat('d MMMM yyyy H:mm').format(timelocal)
    });
  }catch(err){
    print( "Error on adding new crime Report" + err.toString() );
  }
}

//add picture url(s) to db
Future<void> addpictureToCrimeRecs(String crimeid, int orderimage, String imageurl ) async {
  try{
    await Firestore.instance.collection("CrimeRecord").document(crimeid ).updateData({
      "picture$orderimage": imageurl,
      "amountOfimages": orderimage+1,
    });
  }catch(err){
    print(err);
  }
}
//add video url(s) to db
Future<void> addVideoToCrimeRecs(String crimeid, int orderimage, String videourl ) async {
  try{
    await Firestore.instance.collection("CrimeRecord").document(crimeid ).updateData({
      "video$orderimage": videourl,
      "amountOfvideo": orderimage+1,
    });
  }catch(err){
    print(err);
  }
}

//vote
String returnvalue;
Future<String > getVoteValue(String userid, List<DocumentSnapshot> votes, String crimeid) async {
  returnvalue = "";
  for(final vote in votes ){
    if(vote.data["voter"] == userid && vote.data["crimerecord"] == crimeid )
      return returnvalue = vote.data["votevalue"];
  }
}
// get doc id
String getVoteDocument( String userid, String crimeid,List<DocumentSnapshot> votes ) {
  for(final vote in votes ){
    if(vote.data["voter"] == userid && vote.data["crimerecord"] == crimeid )
      return vote.documentID;

  }
}
//update trust, unrelie on db
Future<void> vote(postid, rumor, trust ) async {
  try{
    await Firestore.instance.collection("CrimeRecord")
        .document(postid).updateData({
      "trustworthy":  trust,
      "unreliability": rumor,
    }).then((val ) {
      print("add votes sucess");
    });
  }catch(err){
    print(err );
  }
}
//change vote value(trustworthy , .. ) on db (Vote collection)
Future<void > changeVotevalue(String userid, String crimeid, String votevalue, String voteId )  async  {

  try{
    print("voteId = " + voteId );
      await Firestore.instance.collection("Vote").document(voteId).updateData({
        "voter" : userid,
        "crimerecord": crimeid,
        "votevalue": votevalue,
      }).then((value) {
        print("change vote value success ");
      });
  print("change vote value sucessfully, new vote value = " + votevalue );
  }catch(err){
    print(err);
  }
}
// first time vote the report
Future<void> newVote(String userid, String crimeid, String newvotevalue ) async {
  try{
    await Firestore.instance.collection("Vote").add({
      "voter" : userid,
      "crimerecord": crimeid,
      "votevalue": newvotevalue,
    });
    print("make a new vote successful");
  }catch(err){
    print(err);
  }
}

//get number of comment
int getAmountOfComment(List<DocumentSnapshot> comments, String postid ) {
  int count = 0;
  for(final comment in comments) {
    if(comment.data["crime_post_id"] == postid ) count++;
  }
  return count;
}

String  getUserEmailFromStream(List<DocumentSnapshot > users, String reporter ) {
  for (final user in users) {
    if (user.documentID == reporter)
      return user.data["email"].toString();
  }
}

String useremail, crimedetail;

Future<void > getUserEmailFromCrimeId(crimeid )async{
String reporter = "";
 final crimereccord = Firestore.instance
     .collection("CrimeRecord").document(crimeid)
     .snapshots(includeMetadataChanges: true);

 if(crimereccord == null ) print("crimerecord = null" );

   await crimereccord.forEach( (element) {
    reporter = element.data["reporter"];
    print("reporter = " + reporter);
    getuserEmail(reporter);
   });
}

Future<void > getuserEmail(String reporter ) async {
  useremail = "";
  final user = Firestore.instance.collection("User")
      .document(reporter)
      .snapshots(includeMetadataChanges: true );
  await user.forEach((element) {
    useremail = element.data["email"].toString();
    print("useremail =" + useremail);
  });
}

Future<void> getCrimeDetail(crimeid) async {
  crimedetail = "";
  final crime = await Firestore.instance.collection("CrimeRecord").document(crimeid)
      .snapshots(includeMetadataChanges: true);
  if(crime != null ) {
    crime.forEach((element) {
      crimedetail = element.data["detail"].toString();
    });
  }
}
