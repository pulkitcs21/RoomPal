//
//  User.swift
//  RoomPal
//


import Foundation
import UIKit

public class User: NSObject, NSCoding{
    
    var name = ""
    var uid: String!
    var livedPreviously: Bool!
    var guestsPreference: Int!
    var morningPerson: Bool!
    var smoking: Bool!
    var drinking: Bool!
    var bedtime: Int!
    var wakeup: Int!
    var neatness: Int!
    var overnight: Int!
    var parties: Bool!
    
    init(_ name: String, _ uid: String, _ livedPreviously: Bool, _ guestsPreference: Int, _ morningPerson: Bool, _ smoking: Bool, _ drinking: Bool, _ bedtime: Int, _ wakeup: Int, _ neatness: Int, _ overnight: Int, _ parties: Bool)
    {
        self.name = name
        self.uid = uid
        self.livedPreviously = livedPreviously
        self.guestsPreference = guestsPreference
        self.morningPerson = morningPerson
        self.smoking = smoking
        self.drinking = drinking
        self.bedtime = bedtime
        self.wakeup = wakeup
        self.neatness = neatness
        self.overnight = overnight
        self.parties = parties
    }
    
    func compare(other: User) -> Int{
        var compatibility = 0
        
        if(livedPreviously == other.livedPreviously){
            compatibility = compatibility + 1
        }
        
        compatibility = compatibility - (abs(guestsPreference - other.guestsPreference))
        
        if(morningPerson == other.morningPerson){
            compatibility = compatibility + 1
        }
        
        if(drinking == other.drinking){
            compatibility = compatibility + 1
        }
        
        if(smoking == other.smoking){
            compatibility = compatibility + 1
        }
        
        compatibility = compatibility - (abs(bedtime - other.bedtime))
        compatibility = compatibility - (abs(wakeup - other.wakeup))
        compatibility = compatibility - (abs(neatness - other.neatness))
        compatibility = compatibility - (abs(overnight - other.overnight))
        
        if(parties == other.parties){
            compatibility = compatibility + 1
        }
        
        return compatibility
    }
    
    public required init?(coder aDecoder: NSCoder) {
        if let username = aDecoder.decodeObject(forKey:"name") as? String{
            name = username
        }
        
        if let userID = aDecoder.decodeObject(forKey:"uid") as? String{
            uid = userID
        }
        
        if let livedValue = aDecoder.decodeObject(forKey:"livedPreviously") as? Bool{
            livedPreviously = livedValue
        }
        else{
            livedPreviously = false
        }
        
        if let guestsValue = aDecoder.decodeObject(forKey:"guestsPreference") as? Int{
            guestsPreference = guestsValue
        }
        
        if let morningValue = aDecoder.decodeObject(forKey:"morningPerson") as? Bool{
            morningPerson = morningValue
        }
        else{
            morningPerson = false
        }
        
        if let smokingValue = aDecoder.decodeObject(forKey:"smoking") as? Bool{
            smoking = smokingValue
        }
        else{
            smoking = false
        }
        
        if let drinkingValue = aDecoder.decodeObject(forKey:"drinking") as? Bool{
            drinking = drinkingValue
        }
        else{
            drinking = false
        }
        
        if let bedtimeValue = aDecoder.decodeObject(forKey:"bedtime") as? Int{
            bedtime = bedtimeValue
        }
        
        if let wakeupValue = aDecoder.decodeObject(forKey:"wakeup") as? Int{
            wakeup = wakeupValue
        }
        
        if let neatnessValue = aDecoder.decodeObject(forKey:"neatness") as? Int{
            neatness = neatnessValue
        }
        
        if let overnightValue = aDecoder.decodeObject(forKey:"overnight") as? Int{
            overnight = overnightValue
        }
        
        if let partiesValue = aDecoder.decodeObject(forKey:"parties") as? Bool{
            parties = partiesValue
        }
        else{
            parties = false
        }
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(livedPreviously, forKey: "livedPreviously")
        aCoder.encode(guestsPreference, forKey: "guestsPreference")
        aCoder.encode(morningPerson, forKey: "morningPerson")
        aCoder.encode(smoking, forKey: "smoking")
        aCoder.encode(drinking, forKey: "drinking")
        aCoder.encode(bedtime, forKey: "bedtime")
        aCoder.encode(wakeup, forKey: "wakeup")
        aCoder.encode(neatness, forKey: "neatness")
        aCoder.encode(overnight, forKey: "overnight")
        aCoder.encode(parties, forKey: "parties")
    }
    
    var getName: String{
        get{
            return name
        }
    }
    
    var getUID: String{
        get{
            return uid
        }
    }
    

    public override var description: String{
        return "\(name)"
    }
}

