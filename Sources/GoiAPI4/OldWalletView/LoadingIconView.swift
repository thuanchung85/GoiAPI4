
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

//==========LOADING VIEW========///
struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
struct LoadingView<Content>: View where Content: View {

    @Binding var addressWallet: String
    @Binding var isStillLoadingWallet:Bool
    @State var string12SeedText:String
    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                ZStack(alignment: .center) {
                    
                    self.content()
                        .disabled(self.isShowing)
                        .blur(radius: self.isShowing ? 3 : 0)
                        .padding(.horizontal)
                    VStack(alignment: .center) {
                        Text("Making Wallet...")
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }
                    .frame(width: geometry.size.width / 2,
                           height: geometry.size.height / 5)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .opacity(self.isShowing ? 1 : 0)
                    .padding(.horizontal)
                    
                }
                //genegater 12 từ
                .onAppear(){
                    
                    DispatchQueue.global().async {
                        let myWallet = Wallet()
                        var recoverString = self.string12SeedText
                        if (recoverString.last == " ")
                        {
                            recoverString.removeLast()
                        }
                        let HDWallet_1_recover_Data = myWallet.recover_HDWallet_BIP32_with12Words(with12Words: recoverString, newName: "KhoiPhuc_CHUNGWALLET")
                        
                       
                        self.addressWallet = HDWallet_1_recover_Data.first ?? ""
                        self.isStillLoadingWallet = false
                        
                        
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

}
