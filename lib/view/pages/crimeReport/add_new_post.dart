import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:crimespy/view/elements/transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:crimespy/model/post_model.dart' as post_model;
import 'package:crimespy/model/user_model.dart' as user_model;
import 'package:progress_dialog/progress_dialog.dart';
import 'crime_post.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

ProgressDialog pr;

class AddnewpostPage extends StatefulWidget {
  AddnewpostPage({this.storage});
  final FirebaseStorage storage;

  @override
  _AddnewpostPageState createState() => _AddnewpostPageState();
}

class _AddnewpostPageState extends State<AddnewpostPage> {
  VideoPlayerController _controller;

//  Future<void> initializeController(List<File> videospath ) async {
//    vidsurl = [];
//    for(int i = 0; i < videospath.length; i ++  ) {
//      _controller = VideoPlayerController.network(videospath[i].path);
//      vidsurl.add( _controller );
//    }
//  }
  Future<void> _showVideo() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Video'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('close'),
              onPressed: () {
                _controller.pause();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _videoCard(int index) {
//    final video = uploadvidsname[index];
    return RaisedButton(
      onPressed: () => initializeandplay(index),
      padding: EdgeInsets.all(1.0),
      child: Icon(
        Icons.play_arrow,
      ),
    );
  }

  initializeandplay(int index) async {
    final video = urls[index];
    final controller = VideoPlayerController.network(video.path);
    final old = _controller;
    _controller = controller;

    await controller
      ..initialize().then((_) {
        old?.dispose();
        controller.play();
        controller.setLooping(true);
        setState(() {});
      });
    return _showVideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final picker = ImagePicker();
  String pictureName = "";
  final uuid = Uuid().v1();
  int count;
  List<File> uploadpicsname = [];
  List<File> uploadvidsname = [];
  List urls;
  int imageorder;
  bool imagecheck, videocheck, camera, gallery;

  Future<List<File>> getVideo() async {
    try {
      imageorder = 0;
      //true = camera, false = gallery
      PickedFile video;
      if (camera) {
        video = await picker.getVideo(source: ImageSource.camera);
      } else {
        if (gallery) {
          video = await picker.getVideo(source: ImageSource.gallery);
        }
      }
      setState(() {
        uploadvidsname.add(File(video.path));
        print(" uploadvidsname[$imageorder].path = " +
            uploadvidsname[imageorder].toString());
        imageorder++;
      });
      return uploadvidsname;
    } catch (err) {
      print(err);
    }
  }

  Future<List<File>> getImage() async {
    try {
      imageorder = 0;
      PickedFile image;
      if (camera) {
        image = await picker.getImage(source: ImageSource.camera);
      } else {
        if (gallery) {
          image = await picker.getImage(source: ImageSource.gallery);
        }
      }
      setState(() {
        uploadpicsname.add(File(image.path));
        print("uploadpicsname[$imageorder].path = " +
            uploadpicsname[imageorder].toString());
        imageorder++;
      });
      return uploadpicsname;
    } catch (err) {
      print(err);
    }
  }

  List<String> vidsurl;
  Future<List<String>> uploadVideo(List<File> list) async {
    count = 0;
    vidsurl = [];
    while (count < list.length) {
      print("video list[$count] = " + list[count].toString());
      StorageReference refer =
          FirebaseStorage.instance.ref().child('${uuid}$count.mp4');
      StorageUploadTask tasks = refer.putFile(
        (list[count]),
        StorageMetadata(
          contentLanguage: 'en',
          customMetadata: <String, String>{'activity': 'videotest'},
        ),
      );
      StorageTaskSnapshot snap = await tasks.onComplete;
      String downloadURL = await snap.ref.getDownloadURL();

      setState(() {
        vidsurl.add(downloadURL);
        print("videourl[$count] = " + vidsurl[count]);
      });
      count++;
    }
    return vidsurl;
  }

  List<String> imageurls;
  Future<List<String>> uploadPicture(List<File> list) async {
    // try {
    count = 0;
    imageurls = [];
    while (count < list.length) {
      print("list[$count] = " + list[count].toString());
      StorageReference refer =
          FirebaseStorage.instance.ref().child('${uuid}$count.jpg');
      StorageUploadTask tasks = refer.putFile(
        (list[count]),
        StorageMetadata(
          contentLanguage: 'en',
          customMetadata: <String, String>{'activity': 'testupload'},
        ),
      );
      StorageTaskSnapshot snap = await tasks.onComplete;
      String downloadURL = await snap.ref.getDownloadURL();

      setState(() {
        imageurls.add(downloadURL);
        print("imageurls[$count] = " + imageurls[count]);
      });
      count++;
    }
    return imageurls;
  }

  Widget showAlertDialog() {
    // set up the buttons
    ProgressDialog pr;

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Waiting...',
        padding: EdgeInsets.all(5.0),
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Archivo-Regular'),
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 19.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Archivo-Regular'));
    Widget noButton = FlatButton(
        child: Text("Stay"),
        onPressed: () {
          Navigator.of(context).pop();
        });

    Widget exitButton = FlatButton(
      child: Text("Discard"),
      onPressed: () {
        pr.show();
        Future.delayed(Duration(seconds: 1)).then((value) {
          pr.hide().whenComplete(() {
            Navigator.of(context).pop();
            // Navigator.push(context, SlideRightRoute(page: CrimepostPage()));
            Navigator.of(context).pop();
          });
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Discard this post?"),
      content: Text("It will not be generated."),
      actions: [
        noButton,
        exitButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, width: 720, height: 1600, allowFontScaling: true);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: cTextNavy));

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Uploading...',
        padding: EdgeInsets.all(5.0),
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Archivo-Regular'),
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 19.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Archivo-Regular'));

    return new WillPopScope(
      onWillPop: () async {
        showAlertDialog();
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xffdff7fd),
        appBar: AppBar(
          backgroundColor: Color(0xFF012148),
          title: Text("Add New Post"),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
          child: Column(
            children: <Widget>[
              _PostDetails(),
              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.only(left: 15.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  constraints: BoxConstraints(
                    minWidth: 230.0,
                  ),
                  child: TextField(
                    onChanged: (value) => post_model.crimeDetail = value.trim(),
                    maxLength: 250,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: new EdgeInsets.only(
                          left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                      disabledBorder: OutlineInputBorder(),
                      hintText: "Share Experience Here",
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: 8.0,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(2.0),
                  itemCount:
                      (uploadpicsname.length + uploadvidsname.length <= 0)
                          ? 0
                          : uploadpicsname.length + uploadvidsname.length,
                  itemBuilder: (context, int index) {
                    urls = [uploadvidsname, uploadpicsname]
                        .expand((element) => element)
                        .toList();
                    print(urls);
                    if (urls == null) {
                      return CircularProgressIndicator();
                    } else if (index >= 0 && index < uploadvidsname.length) {
                      return _videoCard(index);
                    }
                    return Image.file(urls[index]);
                  },
                ),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          imagecheck = true;
                          videocheck = false;
                        });
                        _cameraOrGallery();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add_a_photo,
                            size: 30.0,
                            color: cTextNavy,
                          ),
                          SizedBox(width: 10.0),
                          AutoSizeText(
                            'Add image',
                            style: TextStyle(
                                fontFamily: 'Archivo-Regular',
                                fontSize: 16.0,
                                color: cTextNavy),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          videocheck = true;
                          imagecheck = false;
                        });
                        _cameraOrGallery();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.video_call,
                            size: 30.0,
                            color: cTextNavy,
                          ),
                          SizedBox(width: 10.0),
                          AutoSizeText(
                            'Add video',
                            style: TextStyle(
                                fontFamily: 'Archivo-Regular',
                                fontSize: 16.0,
                                color: cTextNavy),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: RaisedButton(
                  onPressed: () async {
                    post_model.addCrimeReport(
                        user_model.user_id, uuid, DateTime.now());
                    await uploadPicture(uploadpicsname).then((value) {
                      print("ima value = ");
                      print(value);
                      for (int i = 0; i < value.length; i++) {
                        post_model.addpictureToCrimeRecs(uuid, i, value[i]);
                      }
                    });
                    await uploadVideo(uploadvidsname).then((value) {
                      print("im video value = ");
                      print(value);
                      for (int i = 0; i < value.length; i++) {
                        post_model.addVideoToCrimeRecs(uuid, i, value[i]);
                      }
                    });
                    setState(() {
                      count = 0;
                      uploadpicsname = [];
                      urls = [];
                      uploadvidsname = [];
                      imageorder = 0;
                      vidsurl = [];
                    });
                    pr.show();
                    Future.delayed(Duration(seconds: 3)).then((value) {
                      pr.hide().whenComplete(() {
                        Navigator.of(context).pop();
                      });
                    });
                  },
                  splashColor: cTextNavy,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [cTextNavy, Color(0xFF1976D2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      constraints:
                          BoxConstraints(maxWidth: 100.0, minHeight: 40.0),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        'Submit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'Archivo-Regular'),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cameraOrGallery() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('From ...'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    camera = true;
                    gallery = false;
                  });
                  if (imagecheck) {
                    getImage();
                  } else if (videocheck) {
                    getVideo();
                  }
                  Navigator.pop(context);
                },
                child: const Text('Camera'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    gallery = true;
                    camera = false;
                  });
                  if (imagecheck) {
                    getImage();
                  } else if (videocheck) {
                    getVideo();
                  }
                  Navigator.pop(context);
                },
                child: const Text('Gallery'),
              ),
            ],
          );
        });
  }
}

class _PostDetails extends StatelessWidget {
  const _PostDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _UserImage(),
        _UserName(),
      ],
    );
  }
}

class _UserImage extends StatelessWidget {
  const _UserImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(100.0),
              child: Image(
                image: AssetImage('assets/img/profile_anonymous.jpg'),
                width: MediaQuery.of(context).size.width * 0.13,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ));
  }
}

class _UserName extends StatelessWidget {
  const _UserName({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              user_model.email,
              style: TextStyle(
                fontFamily: 'Archivo-SemiBold',
                fontSize: 18.0,
                color: cTextNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
