    //
    //  ContentView.swift
    //  quiz
    //
    //  Created by Ng Qi An on 27/5/23.
    //

import SwiftUI

struct ContentView: View {
    @State private var bigsize = false
    @State private var finishedSelection = false
    @State private var selected = -1
    @State private var changeColor = false
    @State private var showAnswer = false
    @State private var showAnswerBackground = false
    @State private var currentQuestion = 0
    @State private var showEnd = false
    @State private var score = 0
    @State private var progress = 0.0
    @State private var showEndText = false
    @State private var showSheet = true
    var questions = [
        Question(text: "When is WWDC23?", options: [
            Option(text: "June 1", correct: false),
            Option(text: "June 2", correct: false),
            Option(text: "June 4", correct: false),
            Option(text: "June 5", correct: true)
        ]),
        Question(text: "How much does a Suzuki Swift cost", options: [
            Option(text: "$1", correct: false),
            Option(text: "$128,800", correct: true),
            Option(text: "$127,865", correct: false),
            Option(text: "$75,000", correct: false)
        ]),
        Question(text: "Which song is in Taylor Swift Midnight 3AM Edition", options: [
            Option(text: "Farlight Rain", correct: false),
            Option(text: "Criminalmind", correct: false),
            Option(text: "Anti-Hero", correct: true),
            Option(text: "Sand on the beach", correct: false)
        ]),
        Question(text: "What is the best color", options: [
            Option(text: "Red", correct: false),
            Option(text: "Blue", correct: true),
            Option(text: "Yellow", correct: false),
            Option(text: "Green", correct: false)
        ])
    ]
    func setSelected(index:Int ){
        Alamofire.request("https://httpbin.org/get").response { response in
            debugPrint(response)
        }
        withAnimation(Animation.easeInOut(duration: 0.2)) {
            finishedSelection = true
            selected = index
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(Animation.easeInOut){
                bigsize = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) {
                withAnimation(Animation.easeInOut){
                    changeColor = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(Animation.easeInOut){
                        if questions[currentQuestion].options[index].correct {
                            score += 1
                        }
                        showAnswerBackground = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(Animation.easeInOut){
                            if currentQuestion >= questions.count - 1 {
                                showEnd = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation(Animation.easeInOut(duration: 1)){
                                        print(Double(score) * 0.25)
                                        progress = Double(score) * 0.25
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                        withAnimation(Animation.easeInOut){
                                            showEndText = true
                                        }
                                    }
                                }
                            } else {
                                currentQuestion += 1
                                showAnswerBackground = false
                                bigsize = false
                                changeColor = false
                                selected = -1
                                finishedSelection = false
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    var animation: Animation {
        Animation.interpolatingSpring(stiffness: 250, damping: 15)
    }
    var body: some View {
        VStack {
            if showEnd == false {
                VStack {
                    if finishedSelection == false {
                        Text(questions[currentQuestion].text)
                            .font(.largeTitle)
                    }
                    
                    HStack {
                        if finishedSelection == false || selected == 0 {
                            VStack {
                                if changeColor == false {
                                    Text("\(questions[currentQuestion].options[0].text)")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            .onTapGesture {
                                if finishedSelection == false {
                                    setSelected(index: 0)
                                }
                            }
                            .frame(maxWidth: bigsize ? .infinity : .infinity, maxHeight: bigsize ? .infinity : 100)
                            .background(showAnswerBackground ? questions[currentQuestion].options[0].correct ? Color.green : Color.red : changeColor ? Color.black : Color.red)
                            .cornerRadius(bigsize ? 0 : 10)
                        }
                        if finishedSelection == false || selected == 1 {
                            VStack {
                                if changeColor == false {
                                    Text("\(questions[currentQuestion].options[1].text)")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            .onTapGesture {
                                if finishedSelection == false {
                                    setSelected(index: 1)
                                }
                            }
                            .frame(maxWidth: bigsize ? .infinity : .infinity, maxHeight: bigsize ? .infinity : 100)
                            .background(showAnswerBackground ? questions[currentQuestion].options[1].correct ? Color.green : Color.red : changeColor ? Color.black : Color.blue)
                            .cornerRadius(bigsize ? 0 : 10)
                            
                        }
                    }
                    HStack {
                        if finishedSelection == false || selected == 2 {
                            VStack {
                                if changeColor == false {
                                    Text("\(questions[currentQuestion].options[2].text)")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            .onTapGesture {
                                if finishedSelection == false {
                                    setSelected(index: 2)
                                }
                            }
                            .frame(maxWidth: bigsize ? .infinity : .infinity, maxHeight: bigsize ? .infinity : 100)
                            .background(showAnswerBackground ? questions[currentQuestion].options[2].correct ? Color.green : Color.red : changeColor ? Color.black : Color.orange)
                            .cornerRadius(bigsize ? 0 : 10)
                            
                            
                        }
                        if finishedSelection == false || selected == 3 {
                            VStack {
                                if changeColor == false {
                                    Text("\(questions[currentQuestion].options[3].text)")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            .onTapGesture {
                                if finishedSelection == false {
                                    setSelected(index: 3)
                                }
                            }
                            .frame(maxWidth: bigsize ? .infinity : .infinity, maxHeight: bigsize ? .infinity : 100)
                            .background(showAnswerBackground ? questions[currentQuestion].options[3].correct ? Color.green : Color.red : changeColor ? Color.black : Color.green)
                            .cornerRadius(bigsize ? 0 : 10)
                            
                            
                        }
                    }
                }
            } else {
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .frame(width: 150, height: 150)
                        
                        Circle()
                            .trim(from: 0.0, to: progress)
                            .stroke(score <= 1 ? Color.red : score >= 4 ? Color.green : Color.blue, style: StrokeStyle(lineWidth: showEndText ? 0 : 10, lineCap: .round))
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90))
                        Circle()
                            .frame(width: 150, height: 150)
                            .foregroundColor(showEndText ? score <= 1 ? Color.red : score >= 4 ? Color.green : Color.blue : Color.clear)
                        VStack {
                            Text("\(score) / \(questions.count)")
                                .font(.largeTitle)
                        }.opacity(showEndText ? 1.0 : 0.0)
                    }
                    if showEndText {
                        Text("You scored \(score) out of \(questions.count)!")
                            .font(.title)
                    }
                }
            }
        }
        .padding(bigsize ? 0 : 10)
        .ignoresSafeArea(.all)
        .sheet(isPresented: $showSheet) {
            ZStack {
                Color.blue
                VStack {
                    Rectangle()
                        .frame(height: 10)
                        .foregroundColor(Color.clear)
                    HStack {
                        Image(systemName: "star.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Instructions")
                            .font(.largeTitle)
                            .bold()
                    }
                    Rectangle()
                        .frame(height: 5)
                        .foregroundColor(Color.clear)
                    Text("Click on one of the multi-colored options to answer the question.")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                    Rectangle()
                        .frame(height: 5)
                        .foregroundColor(Color.clear)
                    Text("If your option is correct, it will show a green background. Else, it will show a red background.")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                    Rectangle()
                        .frame(height: 5)
                        .foregroundColor(Color.clear)
                    Text("You can see your score at the end")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Button{
                        showSheet = false
                    } label: {
                        Text("OK!")
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .background(.white)
                            .cornerRadius(10)
                            .padding()
                            .foregroundColor(.black)
                    }
                }
                .padding(20)
                .foregroundColor(.white)
            }.ignoresSafeArea(.all)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
    
}
