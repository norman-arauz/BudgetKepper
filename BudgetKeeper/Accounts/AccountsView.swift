import SwiftUI

struct AccountsView: View {
  @ObservedObject private var viewModel = AccountsViewModel()

  init() {
    UITableView.appearance().separatorStyle = .none
  }

  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.accounts.indices, id: \.self) { index in
          // swiftlint:disable:next multiline_arguments
          NavigationLink(destination: UpdateBalanceView {
            self.viewModel.updateBalance(at: index, by: $0)
          }) {
            AccountView(account: self.viewModel.accounts[index])
          }
        }
        .onDelete(perform: delete)
      }
      .navigationBarTitle("BudgetKeeper")
      // swiftlint:disable:next multiple_closures_with_trailing_closure
      .navigationBarItems(trailing: Button(action: {}) {
        // swiftlint:disable:next multiline_arguments
        NavigationLink(destination: CreateAccountView {
          self.viewModel.create(account: $0)
        }) {
          Image("add")
        }
      }.accessibility(identifier: "add_account"))
    }
    .accentColor(Color.init("violet"))
  }

  private func delete(at offsets: IndexSet) {
    viewModel.delete(at: offsets)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    AccountsView()
  }
}
