import SwiftUI

/// A label/value row used inside the "Payment details" card on PaymentDetailView.
struct DetailRowView: View {
    let label: String
    let value: String
    /// Allow values to wrap to multiple lines (e.g. the address).
    var allowsMultilineValue: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(label)
                .font(.csClarity(.regular, size: 14))
                .foregroundColor(.appSecondaryText)
            Spacer()
            Text(value)
                .font(.csClarity(.bold, size: 14))
                .foregroundColor(.appPrimaryText)
                .multilineTextAlignment(.trailing)
                .fixedSize(horizontal: false, vertical: allowsMultilineValue)
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    VStack {
        DetailRowView(label: "Payment amount", value: "£1,250")
        Divider()
        DetailRowView(label: "Address", value: "1-45 Durham Street\nSE11 5JH", allowsMultilineValue: true)
    }
    .padding()
    .background(Color.white)
}
