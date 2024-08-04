import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PayloadViewModel()
    
    var body: some View {
        List(viewModel.payloads) { payload in
            PayloadRow(payload: payload)
                .onAppear {
                    print("Appear: \(payload.id)")
                }
                .onDisappear {
                    print("Disappear: \(payload.id)")
                }
        }
    }
}

struct PayloadRow: View {
    let payload: Payload
    
    var body: some View {
        HStack {
            
            
            Image(payload.imagePath, bundle: .main)
                .resizable()
                .frame(width: 100, height: 100)
            Text("Payload \(payload.id)")
        }
    }
}
	
