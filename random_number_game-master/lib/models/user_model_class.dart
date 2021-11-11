class UserDetails{

  String? displayName;
  String? email;
  String? photoUrl;

  UserDetails({this.displayName, this.email, this.photoUrl, String? photoURL});

  UserDetails.fromJson(Map<String,dynamic> json){
    displayName=json["displayName"];
    email=json["email"];
    photoUrl=json["photoUrl"];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data['displayName']=this.displayName;
    data['email']=this.email;
    data['photoUrl']=this.photoUrl;

    return data;

  }
}