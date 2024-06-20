//
//  LoginView.swift
//  Formula
//
//  Created by Chikinov Maxim on 20.06.2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                    .onTapGesture {
                        endEditing()
                    }
                
                VStack {
                    Text("Создать аккаунт")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding(.bottom, 30)
                    
                    // Login field
                    FormField(fieldName: "Логин", fieldValue: $viewModel.userLogin)
                    RequirementText(
                        iconColor: viewModel.isLoginLengthValid ? Color.secondary
                        : Color(red: 251/255, green: 128/255, blue: 128/255),
                        text: "Минимум 4 символа",
                        isStrikeThrough: viewModel.isLoginLengthValid
                    )
                    .padding()
                    
                    // Password field
                    FormField(fieldName: "Пароль", fieldValue: $viewModel.password, isSecure: true)
                    VStack {
                        RequirementText(
                            iconName: "lock.open",
                            iconColor: viewModel.isPasswordLengthValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255),
                            text: "Минимум 8 символов",
                            isStrikeThrough: viewModel.isPasswordLengthValid
                        )
                        
                        RequirementText(
                            iconName: "lock.open",
                            iconColor: viewModel.isPasswordCapitalLetter ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255),
                            text: "Один символ с большой буквы",
                            isStrikeThrough: viewModel.isPasswordCapitalLetter
                        )
                    }
                    .padding()
                    
                    // Confirm password field
                    FormField(fieldName: "Подтвердите пароль", fieldValue: $viewModel.passwordConfirm, isSecure: true)
                    RequirementText(text: "Пароль должен совпадать с введенным ранее", isStrikeThrough: viewModel.isPasswordConfirmValid)
                        .padding()
                        .padding(.bottom, 20)
                    
                    // Buttons
                    VStack(spacing: 20) {
                        Button(action: {
                            // Нажатие на кнопку регистрации
                            endEditing()
                        }) {
                            Text("Зарегистрироваться")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(10)
                        }
                        
                        HStack {
                            Text("Уже есть аккаунт?")
                                .font(.system(.body, design: .rounded))
                                .bold()
                            Button(action: {
                                // Нажатие на кнопку войти
                                endEditing()
                            }) {
                                Text("Войти")
                                    .font(.system(.body, design: .rounded))
                                    .bold()
                                    .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding()
            }
        }
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    LoginView()
}
