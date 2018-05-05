//
//  Results.swift
//  RoomPal


import Foundation
class Results{
    var strings: [User]
    var scores: [Int]
    init(){
        scores = [0]
        strings = [User("", "", true, 1, true,true, true,1,1,1,1,true)]
    }
    func add(score: Int, user: User){
        scores.append(score)
        strings.append(user)
        var pos: Int = scores.count - 1
        while pos > 1 && score > scores[pos/2] {
            scores[pos] = scores[pos/2]
            strings[pos] = strings[pos/2]
            pos = pos/2
        }
        scores[pos] = score
        strings[pos] = user
    }
    func deleteMax() -> (score: Int, user: User){
        if isEmpty() {
            return (score: 0, user: User("", "", true, 1, true,true, true,1,1,1, 1,true))
        }
        let max = scores[1]
        let maxuser = strings[1]
        if scores.count == 2 {
            scores.remove(at: scores.count - 1)
            strings.remove(at: strings.count - 1)
            return (score: max, user: maxuser)
        }
        let newpos = pred(hole: 1, score: scores[scores.count-1])
        scores[newpos] = scores[scores.count - 1]
        strings[newpos] = strings[strings.count - 1]
        scores.remove(at: scores.count - 1)
        strings.remove(at: strings.count - 1)
        return (score: max, user: maxuser)
    }
    func pred(hole: Int, score: Int) -> Int{
        var index = hole
        while 2 * index <= scores.count-1{
            let left = 2 * index
            let right = left + 1
            var target = 0
            if right < scores.count && scores[right] > scores[left]{
                target = right
            }else{
                target = left
            }
            if scores[target] > score{
                scores[index] = scores[target]
                strings[index] = strings[target]
                index = target
            }else {
                break
            }
        }
        return index
    }
    func isEmpty() -> Bool{
        if scores.count > 1{
            return false
        }else{
            return true
        }
    }
}
