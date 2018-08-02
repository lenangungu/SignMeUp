//
//  Study.swift
//  SignMeUp
//
//  Created by Lena Ngungu on 7/4/18.
//  Copyright © 2018 Lena Ngungu. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Study {
    
    var studyTitle: String
    var personName: String
    var date: String
    var time: String
    var location: String
    var ministry: String
    var people: Int 
    let poster: User
    
    var dictValue: [String: Any]
    {
        let userDict = ["uid" : poster.uid,
                        "firstName" : poster.firstName,
                        "lastName" : poster.lastName]
        return ["studyTitle" : studyTitle,
                "personName" : personName,
                "date" : date,
                "time" : time,
                "location" : location,
                "ministry" : ministry,
                "people" : people,
                "poster" : userDict]
    }
    
    var key: String?
    
    init(studyTitle: String, personName: String, date: String, time: String, location: String, ministry: String, people: Int){
        self.studyTitle = studyTitle
        self.personName = personName
        self.date = date
        self.time = time
        self.location = location
        self.ministry = ministry
        self.poster = User.current
        self.people = people
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
        let studyTitle = dict["studyTitle"] as? String,
        let personName  = dict["personName"] as? String,
        let date = dict["date"] as? String,
        let time = dict["time"] as? String,
        let location = dict["location"] as? String,
        let ministry = dict["ministry"] as? String,
        let people = dict["people"] as? Int,
        let userDict = dict["poster"] as? [String : Any],
        let firstName = userDict["firstName"] as? String,
        let lastName = userDict["lastName"] as? String,
        let uid = userDict["uid"] as? String

        else { return nil }
        
        self.studyTitle = studyTitle
        self.personName = personName
        self.date = date
        self.time = time
        self.location = location
        self.ministry = ministry
        self.people = people
        self.key = snapshot.key
        self.poster = User(uid: uid, firstName: firstName, lastName: lastName)
    }
}

