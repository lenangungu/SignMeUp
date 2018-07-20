
//
//  UserService.swift
//  SignMeUp
//
//  Created by Lena Ngungu on 6/11/18.
//  Copyright © 2018 Lena Ngungu. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

//typealias FIRUser = FirebaseAuth.User

struct UserService {
    static func create(_ firUser: FIRUser, firstName: String, lastName: String, completion: @escaping (User?) -> Void) {
        let names = ["firstName": firstName,"lastName": lastName]
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(names) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
       /*
            ref.setValue(userLName) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
                }
            
          
        }
 */
    
  }
    
    static func followers(for user: User, completion: @escaping ([String]) -> Void) {
        let followersRef = Database.database().reference().child("followers").child(user.uid)
        
        followersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let followersDict = snapshot.value as? [String : Bool] else {
                return completion([])
            }
            
            let followersKeys = Array(followersDict.keys)
            completion(followersKeys)
        })
    }
    
    static func timeline(completion: @escaping ([Study]) -> Void) {
        let currentUser = User.current
        
       // let timelineRef = Database.database().reference().child("timeline").child(currentUser.uid)
        let timelineRef = Database.database().reference().child("timeline").child(currentUser.uid)
        timelineRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            
            let dispatchGroup = DispatchGroup()
            
            var studies = [Study]()
            
            for studySnap in snapshot {
                guard let studyDict = studySnap.value as? [String : Any],
                    let posterUID = studyDict["poster_uid"] as? String
//                let posterDict = studyDict["poster"] as? [String : Any],
//                let posterUID = posterDict["uid"] as? String
                    else { continue }
                
                
                
                dispatchGroup.enter()
                
                StudyService.show(forKey: studySnap.key, posterUID: posterUID ) { (study) in
                    if let study = study {
                        studies.append(study)
                    }
                    
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(studies.reversed())
            })
        })
        
    }
    
    
    static func allUsers(completion: @escaping ([User]) -> Void) {
//        let currentUser = User.current
//        // 1
        let ref = Database.database().reference().child("users")
        
        // 2
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            
            // 3
            let users =
                snapshot
                    .compactMap(User.init)
//                    .filter { $0.uid != currentUser.uid }
            
            // 4
            let dispatchGroup = DispatchGroup()
//            users.forEach { (user) in
//                dispatchGroup.enter()
//
//                // 5
//                FollowService.isUserFollowed(user) { (isFollowed) in
//                    user.isFollowed = isFollowed
//                    dispatchGroup.leave()
//                }
//            }
            
            // 6
            dispatchGroup.notify(queue: .main, execute: {
                completion(users)
            })
        })
    }
    
    
}
