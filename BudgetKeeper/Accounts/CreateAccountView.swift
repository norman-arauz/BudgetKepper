import SwiftUI

struct CreateAccountView: View {
  var onAccountCreated: (String) -> Void

  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  @State private var input: String = ""

  var body: some View {
    NavigationView {
      VStack {
        TextField(NSLocalizedString("Enter the name", comment: ""), text: $input)
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
    .navigationBarTitle("New Account")
  }

  private func save() {
    onAccountCreated(input)
    presentationMode.wrappedValue.dismiss()
  }
}

struct CreateAccountView_Previews: PreviewProvider {
  static var previews: some View {
    CreateAccountView {
      print($0)
    }
  }
}
