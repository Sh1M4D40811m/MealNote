import SwiftUI

struct DiaryEntrySelectDateView: View {
    @Binding private var selectedDate: Date
    @Binding private var isShowDatePicker: Bool
    
    init(selectedDate: Binding<Date>, isShowDatePicker: Binding<Bool>) {
        self._selectedDate = selectedDate
        self._isShowDatePicker = isShowDatePicker
    }

    var body: some View {
        VStack {
            HStack(spacing: 4) {
                Text("日時を選択")
                    .font(.system(size: 16))
                Spacer()
                TextButton(title: selectedDate.toString(.dateTimeJp)) {
                    isShowDatePicker.toggle()
                }
            }

            if isShowDatePicker {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 5)
            }
        }
    }
}
