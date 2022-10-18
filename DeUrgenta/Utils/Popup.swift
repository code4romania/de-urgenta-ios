import SwiftUI

struct Popup<T: View>: ViewModifier {
    var popup: T
    var isPresented: Binding<Bool>
    let alignment: Alignment
    let direction: Direction

    @State var timeRemaining = 4
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(isPresented: Binding<Bool>, alignment: Alignment, direction: Direction, @ViewBuilder popupContent: () -> T) {
        self.isPresented = isPresented
        self.alignment = alignment
        self.direction = direction
        popup = popupContent()
    }

    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    @ViewBuilder private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented.wrappedValue {
                popup
                    .animation(.spring())
                    .transition(.offset(x: 0, y: direction.offset(popupFrame: geometry.frame(in: .global))))
                    .cornerRadius(8)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        } else {
                            isPresented.wrappedValue = false
                        }
                    }
            }
        }
    }
}

extension Popup {
    enum Direction {
        case top, bottom

        func offset(popupFrame: CGRect) -> CGFloat {
            switch self {
            case .top:
                let aboveScreenEdge = -popupFrame.maxY
                return aboveScreenEdge
            case .bottom:
                let belowScreenEdge = UIScreen.main.bounds.height - popupFrame.minY
                return belowScreenEdge
            }
        }
    }
}
