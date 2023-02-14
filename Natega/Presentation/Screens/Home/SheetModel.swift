//
//  SheetModel.swift
//  Natega
//
//  Created by Daniel Kamel on 12/02/2023.
//

import SwiftUI

struct SheetModel: View {
    
    @State var showSheet: Bool? = nil
    
    var body: some View {
        Button(action: {
            
            showSheet = true
            
        }, label:{Text("Tap me to pull up sheet")})
        .halfSheet(showSheet: $showSheet) {
            
            ZStack {
                
                Color.white
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack (spacing: 10) {
                        
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .frame(width: 40, height: 5)
                            .foregroundColor(.black.opacity(0.3))
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        
                        HStack {
                            
                            Button(action: { showSheet = false }) {
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .background(.gray)
                                    .mask(Circle())
                                    .padding(.leading, -4)
                                    
                            }
                            
                            Spacer()
                            
                            Text("Matins Gospel")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .padding(.leading, -15)
                            
                            Spacer()
                            
                        }
                        .padding(.bottom, 10)
                        
                        Text("Psalms 11:12 - 14:9")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                        
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .padding(.bottom, 10)
                        
                        Text("Matt 14: 22 - 23:19")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                        
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                        
                    }
                    .frame(width: 350) //this should be done via geometry reader to take width of screen and divide by a certain amount to give user space on edges of VStack to pull up manipulate sheet up and down.
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        } onDismiss: {
            print("sheet dismissed")
        }
        
    }
}

struct SheetModel_Previews: PreviewProvider {
    static var previews: some View {
        SheetModel()
    }
}

extension View {
    //binding show bariable...
    func halfSheet<Content: View>(
        showSheet: Binding<Bool?>,
        @ViewBuilder content: @escaping () -> Content,
        onDismiss: @escaping () -> Void
    ) -> some View {
        return self
            .background(
                HalfSheetHelper(sheetView: content(), showSheet: showSheet, onDismiss: onDismiss)
            )
    }
}

// UIKit integration
struct HalfSheetHelper<Content: View>: UIViewControllerRepresentable {
    
    var sheetView: Content
    let controller: UIViewController = UIViewController()
    @Binding var showSheet: Bool?
    var onDismiss: () -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let showSheet: Bool = showSheet {
            if showSheet {
                let sheetController = CustomHostingController(rootView: sheetView)
                sheetController.presentationController?.delegate = context.coordinator
                uiViewController.present(sheetController, animated: true)
            } else {
                uiViewController.dismiss(animated: true, completion: onDismiss)
            }
        }
    }
    
    //on dismiss...
    final class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
        }
    }
}

// Custom UIHostingController for halfSheet...
final class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        view.backgroundColor = .clear
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            
            //MARK: - sheet grabber visbility:
            presentationController.prefersGrabberVisible = false
            
            // i added the code below so that you can scroll when you have medium view
            // here is good article for customising sheet in UIKit - https://sarunw.com/posts/bottom-sheet-in-ios-15-with-uisheetpresentationcontroller/#scrolling
            presentationController.prefersScrollingExpandsWhenScrolledToEdge = true
            
            //MARK: - sheet corner radius:
            presentationController.preferredCornerRadius = 30
        }
    }
}

public struct LazyView<Content: View>: View {
    private let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    public var body: Content {
        build()
    }
}
