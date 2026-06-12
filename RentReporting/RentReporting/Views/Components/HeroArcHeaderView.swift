import SwiftUI

struct HeroArcHeaderView: View {
    /// Number of milestones that are "complete" (shown in teal). 1, 2, or 3.
    let activeMilestones: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background arc shape
            if let bgImage = UIImage(named: "HeroArcBackground") {
                Image(uiImage: bgImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .clipped()
            } else {
                // Fallback gradient arc
                ZStack(alignment: .top) {
                    Color(hex: "#E5F2F3")
                    LinearGradient(
                        colors: [Color(hex: "#346A6E"), Color(hex: "#E5F2F3")],
                        startPoint: .top, endPoint: .bottom
                    )
                    .mask(
                        VStack(spacing: 0) {
                            Rectangle().frame(height: 120)
                            Spacer()
                        }
                    )
                }
            }

            // Teal arc progress line
            Canvas { context, size in
                let path = Path { p in
                    let cx = size.width / 2
                    let cy = size.height + size.width * 1.35
                    let radius = sqrt(pow(cx, 2) + pow(cy - size.height + 5, 2))
                    let start = Angle(degrees: -180)
                    let end = Angle(degrees: 0)
                    p.addArc(center: CGPoint(x: cx, y: cy), radius: radius, startAngle: start, endAngle: end, clockwise: false)
                }
                context.stroke(path, with: .linearGradient(
                    Gradient(colors: [Color(hex: "#346A6E"), Color(hex: "#18D9BF"), Color(hex: "#408388")]),
                    startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 375, y: 0)
                ), lineWidth: 3)
            }
            .frame(height: 53)

            // Milestone indicators
            HStack(spacing: 8) {
                milestoneIcon(systemName: "link", isActive: activeMilestones >= 1)
                milestoneIcon(systemName: "house.fill", isActive: activeMilestones >= 2)
                milestoneIcon(systemName: "icloud.and.arrow.up", isActive: activeMilestones >= 3)
            }
            .padding(.bottom, 21)
        }
    }

    private func milestoneIcon(systemName: String, isActive: Bool) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(
                    isActive
                    ? AnyShapeStyle(LinearGradient(
                        colors: [Color(hex: "#61AFB5"), Color(hex: "#346A6E")],
                        startPoint: .top, endPoint: .bottom
                    ))
                    : AnyShapeStyle(Color(hex: "#3D4B5A"))
                )
                .frame(width: 48, height: 48)
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
        }
    }
}
