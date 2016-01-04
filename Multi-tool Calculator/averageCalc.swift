import Foundation


class averageCalc {
    
    //MARK: - Variables
    
    var average: Double = 0
    var sumInput: Double = 0
    var input = NSMutableArray()
    
    //MARK: - Properties
    
    func arrayInput(inputArray: Double){
        
        input.addObject(inputArray)
        
    }
    
    
    func calcAverage(){
        
        sumInput = 0
        
        for var x=0; x<input.count; ++x{
            
            sumInput = sumInput + (input.objectAtIndex(x)).doubleValue
            
            
        }
        
        if input.count==0{
            
            average=0
        }
        else{
            
            
            average = sumInput / Double(input.count)
            
            
        }
        
        
    }
    
    
    func clearArray(){
        
        input.removeAllObjects()
        
        sumInput=0
        average=0
        
        
    }
    
    func getArray() -> NSMutableArray{
        return input
    }
    
}