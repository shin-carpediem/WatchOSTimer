import SwiftUI

struct ProgressCircleBar: View {
    let initial: Int
    let progress: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15)
                .opacity(0.3)
                .foregroundStyle(Colors.primary)
            Circle()
                .trim(from: 0,
                      to: CGFloat(min(Float(progress) / Float(initial),
                                      1)))
                .stroke(style: .init(lineWidth: 15,
                                     lineCap: .round,
                                     lineJoin: .round))
                .foregroundStyle(Colors.primary)
                .rotationEffect(.init(degrees: 270))
                .animation(.linear, value: progress)
        }
    }
}

// MARk: - Preview

#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 20) {
            ProgressCircleBar(initial: 10, progress: 1)
            ProgressCircleBar(initial: 10, progress: 2)
        }
        HStack(spacing: 20) {
            ProgressCircleBar(initial: 10, progress: 5)
            ProgressCircleBar(initial: 10, progress: 10)
        }
    }
}
