
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct RecoveryWalletView: View {
   
  
   
    @State var string12SeedText = ""
   @State var isPassInput12Seed = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @State var data12Words = (1...12).map { "\($0). item" }
    
    public init() {
        
    }
    
    public var body: some View{
     
            //Choose View
            VStack(alignment: .center) {
                Text("Recovery Your Wallet").font(.title)
              
                Text("Enter your 12 seeds separated by spaces:")
                
                //text editor cho phep user nhập 12 từ và che dấu khi cần
                HStack{
                    TextEditorInput12SeedsView(isPassInput12Seed: $isPassInput12Seed,text: $string12SeedText, textHide: "", bkt: "", titleKey: "Enter your 12 seeds separated by spaces")
                    
                }
               
                
                //12 từ trong khung
                ScrollView {
                    LazyVGrid(columns: columns,alignment: .center, spacing: 10) {
                        ForEach(data12Words, id: \.self) { item in
                            Text(item)
                                .frame(width: 130)
                                .font(.body)
                                .foregroundColor(.blue)
                                .padding()
                                .border(.blue)
                                .cornerRadius(5)
                            
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: 500)
                
                //nut next tơi view tiếp theo genegate lại ví củ theo 12 từ
                //===nút đi tới recovery wallet view của gói API 4===//
                if(isPassInput12Seed == true){
                    NavigationLink(destination:  Re_GenerateWalletView(string12SeedText: $string12SeedText))
                    {
                        Text("Get Wallet")
                            .foregroundColor(.white)
                            .padding(12)
                        
                    }
                    .background(Color.black)
                    .cornerRadius(12)
                }
            }
            .padding(.bottom,10)
            
       
    }
    
    
    
    
}//end struct


