import SwiftUI

struct AccountView: View {
  let account: Account

  private var balanceString: String {
    let amount = AmountFormatter.string(from: abs(account.balance)) ?? ""
    let balance = currencySymbol + amount
    return account.balance < 0 ? "-" + balance : balance
  }

  private var currencySymbol: String {
    return Locale.current.currencySymbol ?? ""
  }

  private let gradient = LinearGradient(
    gradient: Gradient(colors: [Color.init("violet"), Color.init("purple")]),
    startPoint: .leading,
    endPoint: .trailing)

  var body: some View {
    HStack {
      Text(account.name)
        .font(.headline)
        .padding()
        .foregroundColor(Color.white)
      Spacer()
      Text(balanceString)
        .font(.title)
        .foregroundColor(Color.white)
        .padding()
        .lineLimit(1)
    }
    .background(gradient)
    .cornerRadius(10)
    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
  }
}

struct AccountView_Previews: PreviewProvider {
  static var previews: some View {
    AccountView(account: Account(name: "Savings"))
  }
}
