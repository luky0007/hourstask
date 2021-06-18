import Foundation

class Solution {
   
    func solution(A:Int, B:Int, C:Int, D:Int) -> Int{
        var set:Set = Set<[Int]>()
        let array0 = [A, B, C, D]
        permuteAndFillSet(array0, array0.count-1, setRef: &set)
        
        let arrayOfBools = set.compactMap ({
            correctTimeFrom(array: $0)
        })
        
        let correctnessCounter = arrayOfBools.filter({$0 == true}).count
        print(correctnessCounter)
        return correctnessCounter
    }
    
    private func permuteAndFillSet(_ a: [Int], _ n: Int,  setRef: inout Set<[Int]> ) {
      if n == 0 {
        if correctTimeFrom(array: a){
            if !setRef.contains(a){
                print(a)
                setRef.insert(a)
            }
        }
      } else {
        var a = a
        permuteAndFillSet(a, n - 1, setRef: &setRef)
        for i in 0..<n {
            a.swapAt(i, n)
            permuteAndFillSet(a, n - 1, setRef: &setRef)
            a.swapAt(i, n)
        }
      }
    }
    
    private func correctHour(A:Int, B:Int) -> Bool{
        let merged = String(A) + String(B)
        if let mergedInt = Int(merged), mergedInt < 24{
            //print(mergedInt)
            return true
        }
        return false
    }
    
    private func correctMinute(C:Int, D:Int) -> Bool{
        let merged = String(C) + String(D)
        if let mergedInt = Int(merged), mergedInt < 60{
            return true
        }
        return false
    }
    
    private func correctTimeFrom(array: [Int]) -> Bool{
        let hour = self.correctHour(A: array[0], B: array[1])
        let minute = self.correctMinute(C: array[2], D: array[3])
        return hour && minute
    }
    
}

let s = Solution()
s.solution(A: 2, B: 3, C: 3, D: 2)
print("------------------------")
s.solution(A: 1, B: 8, C: 3, D: 2)
print("------------------------")
s.solution(A: 6, B: 2, C: 4, D: 7)

