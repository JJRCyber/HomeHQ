//
//  AddNoticeView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 26/8/2023.
//

import SwiftUI

struct AddNoticeView: View {

    @ObservedObject var viewModel: NoticeBoardViewModel

    var body: some View {
        ZStack {
            Color("ButtonBackground")
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading) {
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
                    TextField("Title", text: $viewModel.noticeTitle)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background()
                        .cornerRadius(10)
                        .padding(.horizontal)
                    Text("Description")
                        .font(.callout)
                        .padding(.horizontal)
                        .foregroundColor(Color("PrimaryText"))
                    TextEditor(text: $viewModel.noticeDescription)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .background()
                        .cornerRadius(10)
                        .padding(.horizontal)
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
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct AddNoticeView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoticeView(viewModel: NoticeBoardViewModel())
    }
}
