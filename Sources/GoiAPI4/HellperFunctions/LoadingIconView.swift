
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
    
    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Making Wallet...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
            //genegater 12 từ
            .onAppear(){
                
                DispatchQueue.global().async {
                    var myWallet = Wallet()
                    let recoverString = "salt multiply enemy burger exit machine apart science agree foot often absent buddy zoo comfort fantasy dune hip night pride reveal tide neither civil"
                    let HDWallet_1_recover_Data = myWallet.recover_HDWallet_BIP32_with12Words(with12Words: recoverString, newName: "KhoiPhuc_CHUNGWALLET")
                   
                    self.isStillLoadingWallet = false
                    //let retestWalletby12Words = myWallet.recover_HDWallet_BIP32_with12Words(with12Words: HDWallet_1_Data[1], newName: "newname")
                    
                    //print("[reset] wallet address recover by 12 words: ", retestWalletby12Words)
                }
                
            }
        }
    }

}
