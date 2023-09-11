//
//  AddNoticeView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 26/8/2023.
//

import SwiftUI

struct AddNoticeView: View {

    @ObservedObject var viewModel: NoticePageViewModel

    // View displayed as sheet to add notice
    var body: some View {
        ZStack {
            Color("ButtonBackground")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                menuBar
                ScrollView {
                        titleTextField
                        Text("Description")
                            .font(.callout)
                            .padding(.horizontal)
                            .foregroundColor(Color("PrimaryText"))
                        descriptionTextField
                        DatePicker(selection: $viewModel.noticeDate, displayedComponents: .date) {
                            Text("Notice Date")
                        }
                        .datePickerStyle(.graphical)
                        .foregroundColor(Color("PrimaryText"))
                        .padding()
                        Stepper(value: $viewModel.noticeImportance, in: 1...4) {
                            HStack {
                                Text("Importance")
                                ImportanceView(importance: viewModel.noticeImportance)
                            }
                        }
                        .padding(.horizontal)
                        Spacer()
                }
            }

        }
    }
    
    var menuBar: some View {
        HStack {
            Button {
                viewModel.showAddNoticeSheet.toggle()
            } label: {
                Text("Cancel")
                    .foregroundColor(.red)
                    .padding()
            }
            Spacer()
            Text("New Notice")
                .font(.headline)
                .foregroundColor(Color("PrimaryText"))
                .padding()
            Spacer()
            Button {
                viewModel.addNotice()
            } label: {
                Text("Add")
                    .font(.headline)
                    .foregroundColor(Color("PrimaryText"))
                    .padding()
            }

        }
    }
    
    var titleTextField: some View {
        TextField("Title", text: $viewModel.noticeTitle)
            .padding()
            .frame(maxWidth: .infinity)
            .background()
            .cornerRadius(10)
            .padding(.horizontal)
    }
    
    var descriptionTextField: some View {
        TextEditor(text: $viewModel.noticeDescription)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background()
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

struct AddNoticeView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoticeView(viewModel: NoticePageViewModel())
    }
}