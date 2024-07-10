import SwiftUI

struct ContentView: View {
    @State private var cost = 0.0
    @State private var numberOfPeople = 2
    @State private var tip = 15
    @FocusState private var amountFocus: Bool
    @State private var redText = false
    let tipSelector = [10, 15, 20, 0]
    var totalPerPerson: Double {
        let peopleNumPlusTwo = Double(numberOfPeople + 2)
        let tipSelector_ = Double(tip)
        let tipValue = cost/100 * tipSelector_
        let total = cost + tipValue
        let costPerPerson = total/peopleNumPlusTwo
        return costPerPerson
    }
     var amountPlusTip: Double {
         let tipSelector_ = Double(tip)
         let tipValue = cost/100 * tipSelector_
         let total = cost + tipValue
         return total
    }
    var body: some View {
        NavigationView {
            Form {
                Section("Amount:") {
                    TextField("Amount:", value: $cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountFocus)
                    Picker("Number of People:", selection: $numberOfPeople) {
                        ForEach(2..<10) {
                            Text("\($0) People")
                        }
                    }
                }
                
                
                Section ("How much tip do you want to leave?"){
                    Picker ("Tip:" , selection: $tip) {
                        ForEach (tipSelector , id: \.self) {
                            Text($0 , format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Original Amount + Tip"){
                    Text(amountPlusTip , format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tip == 0 ? .red : .black)
                }
                
                Section("Total per person:") {
                    Text(totalPerPerson , format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .toolbar() {
                if amountFocus {
                    Button("Done !") {
                        amountFocus = false
                    }
                }
            }
            
            .navigationTitle("Qattah")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
