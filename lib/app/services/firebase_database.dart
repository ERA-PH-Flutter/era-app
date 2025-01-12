import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';

class Database {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Database();
  initialize() async {
    try {
      return await db.collection("settings").doc('appSettings').get();
    } catch (error) {
      return "Error: $error";
    }
  }

  Future<bool> doDocumentExist(id, {target = 'listings'}) async {
    try {
      var docRef = db.collection(target).doc(id);
      var doc = await docRef.get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  //LISTING
  Future<List<Listing>> searchListingsByUserId(String id,
      {isApprove = true}) async {
    if (isApprove) {
      return (await db
              .collection("listings")
              .where('is_approve', isEqualTo: true)
              .where('by', isEqualTo: id)
              .get())
          .docs
          .map((data) {
        return Listing.fromJSON(data.data());
      }).toList();
    } else {
      return (await db.collection("listings").where('by', isEqualTo: id).get())
          .docs
          .map((data) {
        return Listing.fromJSON(data.data());
      }).toList();
    }
  }

  searchListing({
    location,
    price,
    property,
  }) async {
    Query query = FirebaseFirestore.instance.collection('listings');
    var searchData = [];
    if (location != "") {
      query = query
          .where('location', isGreaterThanOrEqualTo: location)
          .where('location', isLessThanOrEqualTo: location + '\uf8ff');
    } else if (price != "") {
      query = query.where('price', isLessThanOrEqualTo: price);
    } else if (property != "") {
      query = query
          .where('property', isGreaterThanOrEqualTo: property)
          .where('property', isLessThanOrEqualTo: property + '\uf8ff');
    }
    await query.get().then((snapshot) {
      var a = snapshot.docs;
      for (var b in a) {
        searchData.add(b.data());
      }
    });
    return searchData;
  }

  getForSaleListing() async {
    return (await db
            .collection('listings')
            .where('status', isEqualTo: 'For Sale')
            .get())
        .docs
        .map((doc) {
      return doc.data();
    }).toList();
  }

  getForRentListing() async {
    return (await db
            .collection('listings')
            .where('status', isEqualTo: 'For Rent')
            .get())
        .docs
        .map((doc) {
      return doc.data();
    }).toList();
  }

  getAllListing() async {
    try {
      return await db.collection("listings").get();
    } catch (error) {
      return "Error: $error";
    }
  }

  addLeads(id) async {
    await db.collection('listings').doc(id).update({
      'leads': FieldValue.increment(1),
    });
  }

  addViews(id) async {
    await db.collection('listings').doc(id).update({
      'views': FieldValue.increment(1),
    });
  }

  listingMarkAsSold(id) async {
    await db.collection('listings').doc(id).update({
      'is_sold': true,
    });
  }

  // USER
  getAllUser() async {
    return await db.collection('users').get();
  }

  searchUser({searchParam = "full_name", searchQuery}) async {
    var users = [];
    var docs = (await db
            .collection('users')
            .where(searchParam, isGreaterThanOrEqualTo: searchQuery)
            .where(searchParam, isLessThanOrEqualTo: searchQuery + '\uf8ff')
            .get())
        .docs;
    for (int i = 0; i < docs.length; i++) {
      if (docs[i].data()['status'] == 'approved') {
        users.add(EraUser.fromJSON(docs[i].data()));
      }
    }
    return users;
  }

  // PROJECTS
  getAllProjects() async {
    try {
      return await db.collection("projects").get();
    } catch (error) {
      return "Error: $error";
    }
  }

  // SETTINGS
  getSettings() async {
    return (await db.collection('settings').doc('main').get()).data();
  }
  // FAQ

  //CRUD NEWS

  getAboutUsData() async {
    return (await db.collection('cms').doc('about_us').get()).data();
    // note para magets mo this will return map photo and description property
  }

  getFindAgentsData() async {
    return (await db.collection('cms').doc('find_agents').get()).data();
    // note para magets mo this will return map photo and video_link property
  }

  getJoinEraData() async {
    return (await db.collection('cms').doc('join_era').get()).data();
    // note para magets mo this will return map photo, description and video_link  property
  }
}
