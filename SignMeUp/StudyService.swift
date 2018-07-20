//
//  StudyService.swift
//  SignMeUp
//
//  Created by Lena Ngungu on 7/4/18.
//  Copyright © 2018 Lena Ngungu. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

struct StudyService {
    static func create(personName: String, date: String, time: String,location: String, ministry: String, people: Int) {
        let currentUser = User.current
        let study = Study(personName: personName, date: date, time: time, location: location, ministry: ministry, people: people)
        
        let rootRef = Database.database().reference()
        let newStudy = rootRef.child("studies").child(currentUser.uid).childByAutoId()
        let newStudyKey = newStudy.key

        
        // 2
        UserService.followers(for: currentUser) { (followerUIDs) in
            // 3
            let timelinePostDict = ["poster_uid" : currentUser.uid]
            
            // 4
            var updatedData: [String : Any] = ["timeline/\(currentUser.uid)/\(newStudyKey)" : timelinePostDict]
            
            // 5
            for uid in followerUIDs {
                updatedData["timeline/\(uid)/\(newStudyKey)"] = timelinePostDict
            }
            
            // 6
            let postDict = study.dictValue
            updatedData["studies/\(currentUser.uid)/\(newStudyKey)"] = postDict
            
            // 7
            rootRef.updateChildValues(updatedData)
        }
    }
    
    static func show(forKey studyKey: String, posterUID: String, completion: @escaping (Study?) -> Void) {
        let ref = Database.database().reference().child("studies").child(posterUID).child(studyKey)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let study = Study(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(study) 
//            LikeService.isPostLiked(post) { (isLiked) in
//                post.isLiked = isLiked
//                completion(post)
//            }
        })
    }

}

