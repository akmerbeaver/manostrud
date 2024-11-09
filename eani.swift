import SwiftUI

// Define a custom shape with animatable corner radii
struct AnimatableRectangle: Shape {
    // The animatable data typealias from your code
    public typealias AnimatableData = AnimatablePair<AnimatablePair<CGFloat, CGFloat>, AnimatablePair<CGFloat, CGFloat>>

    var topLeftRadius: CGFloat
    var topRightRadius: CGFloat
    var bottomLeftRadius: CGFloat
    var bottomRightRadius: CGFloat

    // Implement the animatableData property
    var animatableData: AnimatableData {
        get {
            AnimatablePair(
                AnimatablePair(topLeftRadius, topRightRadius),
                AnimatablePair(bottomLeftRadius, bottomRightRadius)
            )
        }
        set {
            topLeftRadius = newValue.first.first
            topRightRadius = newValue.first.second
            bottomLeftRadius = newValue.second.first
            bottomRightRadius = newValue.second.second
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Create a rectangle path with rounded corners based on the animatable radii
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius),
                    radius: topRightRadius,
                    startAngle: .degrees(-90),
                    endAngle: .degrees(0),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius))
        path.addArc(center: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY - bottomRightRadius),
                    radius: bottomRightRadius,
                    startAngle: .degrees(0),
                    endAngle: .degrees(90),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius),
                    radius: bottomLeftRadius,
                    startAngle: .degrees(90),
                    endAngle: .degrees(180),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        path.addArc(center: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius),
                    radius: topLeftRadius,
                    startAngle: .degrees(180),
                    endAngle: .degrees(270),
                    clockwise: false)

        return path
    }
}

struct ContentView: View {
    @State private var animate = false

    var body: some View {
        VStack {
            AnimatableRectangle(
                topLeftRadius: animate ? 50 : 0,
                topRightRadius: animate ? 50 : 0,
                bottomLeftRadius: animate ? 50 : 0,
                bottomRightRadius: animate ? 50 : 0
            )
            .fill(Color.blue)
            .frame(width: 200, height: 200)
            .animation(.linear(duration: 2), value: animate)
            
            Button("Animate") {
                animate.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
