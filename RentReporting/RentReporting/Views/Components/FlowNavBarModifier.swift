import SwiftUI

/// Reusable toolbar content for the "Start reporting your rent" multi-step flow.
/// Usage: `.toolbar { FlowNavBar(title: "Start reporting your rent") }`
struct FlowNavBar: ToolbarContent {
    let title: String
    @Environment(\.dismiss) private var dismiss

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { dismiss() }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                    Text("Back")
                        .font(.csClarity(.regular, size: 14))
                }
                .foregroundColor(.appPrimaryText)
            }
        }
        ToolbarItem(placement: .principal) {
            Text(title)
                .font(.csClarity(.bold, size: 16))
                .foregroundColor(.appPrimaryText)
        }
    }
}
