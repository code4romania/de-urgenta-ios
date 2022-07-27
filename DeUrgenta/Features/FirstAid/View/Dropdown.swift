import SwiftUI

struct DropdownOption: Hashable {
    let key: String
    let value: String

    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        lhs.key == rhs.key
    }
}

struct DropdownRow: View {
    var option: DropdownOption
    var imageIcon: String
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?

    var body: some View {
        Button(action: {
            if let onOptionSelected = self.onOptionSelected {
                onOptionSelected(self.option)
            }
        }) {
            HStack {
                Image(systemName: imageIcon)
                    .foregroundColor(.darkText)

                Text(self.option.value)
                    .modifier(SecondaryTextStyle())
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
    }
}

struct Dropdown: View {
    var options: [DropdownOption]
    var imageIcon: String
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(self.options, id: \.self) { option in
                    DropdownRow(option: option, imageIcon: imageIcon, onOptionSelected: self.onOptionSelected)
                }
            }
        }
        .frame(minHeight: CGFloat(options.count) * 30, maxHeight: 250)
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.fieldBorder, lineWidth: 1)
        )
        .shadow(color: Color.fieldBorder, radius: 10, x: 0, y: 0)
    }
}

struct DropdownSelector: View {
    @ObservedObject var locationManager: LocationViewModel
    @State private var shouldShowDropdown = false
    @State private var selectedOption: DropdownOption? = nil

    var type: DropdownType
    var options: [DropdownOption]
    var imageIcon: String
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    private let buttonHeight: CGFloat = 45

    var body: some View {
        Button(action: {
            self.shouldShowDropdown.toggle()
        }) {
            HStack {
                Image(systemName: imageIcon)
                    .foregroundColor(.darkText)

                Text(selectedOption == nil ? options.first!.value : selectedOption!.value)
                    .modifier(PrimaryTextStyle())
                    .foregroundColor(Color.black)

                Spacer()

                Image(systemName: self.shouldShowDropdown ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 9, height: 5)
                    .font(Font.system(size: 9, weight: .medium))
                    .foregroundColor(Color.black)
            }
        }
        .padding(.horizontal)
        .cornerRadius(5)
        .frame(height: self.buttonHeight)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.fieldBorder, lineWidth: 1)
        )
        .overlay(
            VStack {
                if self.shouldShowDropdown {
                    Spacer(minLength: buttonHeight + 10)
                    Dropdown(options: self.options, imageIcon: imageIcon, onOptionSelected: { option in
                        shouldShowDropdown = false
                        selectedOption = option
                        self.onOptionSelected?(option)
                    })
                }
            }, alignment: .topLeading
        )
        .background(
            RoundedRectangle(cornerRadius: 5).fill(Color.white)
        )
        .onReceive(locationManager.$currentCity, perform: { newValue in
            if type == .location, !newValue.isEmpty {
                self.selectedOption = DropdownOption(key: UUID().uuidString, value: newValue)
            }
        })
    }
}
