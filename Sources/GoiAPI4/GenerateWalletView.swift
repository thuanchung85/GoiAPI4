
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers


public struct GenerateWalletView: View {
   
  
   
    @State var addressWallet:String = ""
   
    @State var isStillLoadingWallet = true
    
    public init() {
        
    }
    
    public var body: some View{
        NavigationView {
            VStack{
                if(isStillLoadingWallet == true){
                    LoadingView(addressWallet: $addressWallet,
                                isStillLoadingWallet: $isStillLoadingWallet, isShowing:  $isStillLoadingWallet)
                    {
                        //Choose View
                        VStack(alignment: .center) {
                            Text("THIS IS YOUR WALLET").font(.title)
                        }
                        
                    }
                    
                }
                //nếu load 12 từ xong thì show ra 12 từ đó, và chuẫn bị view "cho user nhập lại 12 từ"
                else{
                    //Choose View
                    VStack(alignment: .center) {
                        Text("THIS IS YOUR WALLET").font(.title)
                        
                    }
                    
                }
                
            }
        }//end navigation view
          
    }//end body
    
    
    
    
}//end struct


