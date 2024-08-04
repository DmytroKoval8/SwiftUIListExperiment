import SwiftUI
import Combine

class PayloadViewModel: ObservableObject {
    @Published var payloads: [Payload] = []

    init() {
        generatePayloads()
    }

    func generatePayloads() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            for id in 0..<300 {
                autoreleasepool {
                    
                    let uiImage = self.generateRandomImage(width: 100, height: 100)
                    let image = Image(uiImage: uiImage)
                    let payload = Payload(id: id, image: image)
                    DispatchQueue.main.async {
                        self.payloads.append(payload)
                    }
                    print("Image \(id) generated")
                }
            }
        }
    }

    func generateRandomImage(width: Int, height: Int) -> UIImage {
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!

        for y in 0..<height {
            for x in 0..<width {
                let color = UIColor(
                    red: CGFloat(arc4random_uniform(256)) / 255.0,
                    green: CGFloat(arc4random_uniform(256)) / 255.0,
                    blue: CGFloat(arc4random_uniform(256)) / 255.0,
                    alpha: 1.0
                )
                context.setFillColor(color.cgColor)
                context.fill(CGRect(x: x, y: y, width: 1, height: 1))
            }
        }

        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
