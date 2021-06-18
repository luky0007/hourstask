//
//
//var str = "Hello, playground"
//
////: [Next](@next)
//Given four digits, count how many valid times can be displayed on a digital clock (in 24-hour format) using those digits. The earliest time is 00:00 and the latest time is 23:59.
//
//Write a function:
//
//class Solution { public int solution(int A, int B, int C, int D); }
//
//that, given four integers A, B, C and D (describing the four digits), returns the number of valid times that can be displayed on a digital clock.
//
//Examples:
//
//1. Given A = 1, B = 8, C = 3, D = 2, the function should return 6. The valid times are: 12:38, 13:28, 18:23, 18:32, 21:38 and 23:18.
//
//2. Given A = 2, B = 3, C = 3, D = 2, the function should return 3. The valid times are: 22:33, 23:23 and 23:32.
//
//3. Given A = 6, B = 2, C = 4, D = 7, the function should return 0. It is not possible to display any valid time using the given digits.
//
//Assume that:
//
//A, B, C and D are integers within the range [0..9].
//In your solution, focus on correctness. The performance of your solution will not be the focus of the assessment.

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

