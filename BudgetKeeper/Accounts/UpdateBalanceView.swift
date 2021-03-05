import SwiftUI

struct UpdateBalanceView: View {
  var onBalanceUpdated: (Decimal) -> Void

  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  @State private var input: String = ""

  var body: some View {
    NavigationView {
      VStack {
        TextField("0.00", text: $input)
          .keyboardType(.numbersAndPunctuation)
          .lineLimit(1)
          .font(.largeTitle)
          .padding()
          .multilineTextAlignment(.center)
        Button(action: save) {
          Text(NSLocalizedString("Save", comment: ""))
        }.accessibility(identifier: "save")
        Spacer()
      }
    }
    .accentColor(Color.init("violet"))
    .navigationBarTitle("Update Balance")
  }

  private func save() {
    let sum = AmountFormatter.decimal(from: input)
    onBalanceUpdated(sum ?? 0)
    presentationMode.wrappedValue.dismiss()
  }
}

struct UpdateBalanceView_Previews: PreviewProvider {
  static var previews: some View {
    UpdateBalanceView {
      print($0)
    }
  }
}
