//
//  LeccionView.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 17/04/26.
//

import SwiftUI

struct LeccionView: View {
    @State private var selectedLessonID: UUID?
    @State private var currentQuestionIndex = 0
    @State private var selectedOptionID: UUID?
    @State private var submittedQuestionIDs: Set<UUID> = []
    @State private var answersByQuestion: [UUID: UUID] = [:]

    private let lessons: [Lesson] = [
        Lesson(
            title: "Señales fundamentales",
            subtitle: "Base para identificar señales reglamentarias y preventivas.",
            accent: Color(red: 0.41, green: 0.60, blue: 0.99),
            icon: "triangle",
            isLocked: false,
            questions: [
                LessonQuestion(
                    prompt: "¿Qué significa esta señal?",
                    sign: .yield,
                    tag: "Señal preventiva",
                    options: [
                        LessonOption(text: "Pare total del vehículo", isCorrect: false),
                        LessonOption(text: "Ceda el paso", isCorrect: true),
                        LessonOption(text: "Prohibido girar", isCorrect: false),
                        LessonOption(text: "Velocidad máxima", isCorrect: false)
                    ]
                ),
                LessonQuestion(
                    prompt: "¿Cuál es la acción correcta al ver una señal de ALTO?",
                    sign: .stop,
                    tag: "Señal reglamentaria",
                    options: [
                        LessonOption(text: "Reducir un poco la velocidad", isCorrect: false),
                        LessonOption(text: "Detenerse completamente", isCorrect: true),
                        LessonOption(text: "Tocar el claxon y seguir", isCorrect: false),
                        LessonOption(text: "Cambiar de carril", isCorrect: false)
                    ]
                )
            ]
        ),
        Lesson(
            title: "Normas de seguridad",
            subtitle: "Decisiones clave para proteger peatones y conductores.",
            accent: Color(red: 0.95, green: 0.77, blue: 0.33),
            icon: "shield.lefthalf.filled",
            isLocked: false,
            questions: [
                LessonQuestion(
                    prompt: "¿Qué indica esta señal escolar?",
                    sign: .school,
                    tag: "Zona escolar",
                    options: [
                        LessonOption(text: "Cruce ferroviario", isCorrect: false),
                        LessonOption(text: "Reducir velocidad por zona escolar", isCorrect: true),
                        LessonOption(text: "Zona de carga", isCorrect: false),
                        LessonOption(text: "Obras en construcción", isCorrect: false)
                    ]
                ),
                LessonQuestion(
                    prompt: "Antes de girar a la derecha, debes:",
                    sign: .turnRight,
                    tag: "Buenas prácticas",
                    options: [
                        LessonOption(text: "Acelerar para pasar rápido", isCorrect: false),
                        LessonOption(text: "Revisar peatones y usar direccional", isCorrect: true),
                        LessonOption(text: "Invadir el carril contrario", isCorrect: false),
                        LessonOption(text: "Ignorar el cruce si está libre", isCorrect: false)
                    ]
                )
            ]
        ),
        Lesson(
            title: "Situaciones avanzadas",
            subtitle: "Escenarios de riesgo y lectura del entorno vial.",
            accent: Color(red: 0.82, green: 0.61, blue: 0.44),
            icon: "steeringwheel",
            isLocked: true,
            questions: [
                LessonQuestion(
                    prompt: "¿Qué representa esta señal?",
                    sign: .curve,
                    tag: "Precaución",
                    options: [
                        LessonOption(text: "Curva peligrosa más adelante", isCorrect: true),
                        LessonOption(text: "Fin de doble sentido", isCorrect: false),
                        LessonOption(text: "Retorno obligatorio", isCorrect: false),
                        LessonOption(text: "Prohibido estacionarse", isCorrect: false)
                    ]
                )
            ]
        )
    ]

    private let optionPrefixes = ["A", "B", "C", "D", "E"]

    private var selectedLesson: Lesson? {
        guard let selectedLessonID else { return nil }
        return lessons.first(where: { $0.id == selectedLessonID })
    }

    private var activeQuestion: LessonQuestion? {
        guard let selectedLesson, selectedLesson.questions.indices.contains(currentQuestionIndex) else {
            return nil
        }
        return selectedLesson.questions[currentQuestionIndex]
    }

    private var totalAnsweredQuestions: Int {
        submittedQuestionIDs.count
    }

    private var totalAvailableQuestions: Int {
        lessons
            .filter { !$0.isLocked }
            .reduce(0) { $0 + $1.questions.count }
    }

    private var weeklyProgress: Double {
        guard totalAvailableQuestions > 0 else { return 0 }
        return min(Double(submittedQuestionIDs.count) / Double(totalAvailableQuestions), 1)
    }

    var body: some View {
        ZStack {
            backgroundView

            if let lesson = selectedLesson, let question = activeQuestion {
                lessonDetailView(lesson: lesson, question: question)
            } else {
                lessonsOverview
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var backgroundView: some View {
        Color(Color.background)
        .ignoresSafeArea()
    }

    private var lessonsOverview: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                heroCard
                lessonSection
                statsSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 14)
            .padding(.bottom, 32)
        }
    }

    private var heroCard: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.08),
                            Color.white.opacity(0.03)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    lessonHeroArtwork
                }
                .overlay(alignment: .topLeading) {
                    Text("META SEMANAL \(Int(weeklyProgress * 100))%")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white.opacity(0.82))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.white.opacity(0.08))
                        .clipShape(Capsule())
                        .padding(18)
                }

            VStack(alignment: .leading, spacing: 8) {
                Text("Progreso total: \(Int(weeklyProgress * 100))%")
                    .font(.system(size: 19, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("Has respondido \(totalAnsweredQuestions) preguntas de \(totalAvailableQuestions).")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.7))

                ProgressView(value: weeklyProgress)
                    .tint(Color(red: 0.35, green: 0.57, blue: 0.98))
                    .scaleEffect(x: 1, y: 1.4, anchor: .center)
                    .padding(.top, 4)
            }
            .padding(18)
        }
        .frame(height: 215)
    }

    private var lessonHeroArtwork: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.clear,
                    Color.black.opacity(0.18)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack {
                Spacer()

                HStack(spacing: 18) {
                    Rectangle()
                        .fill(Color.white.opacity(0.16))
                        .frame(width: 5, height: 120)
                        .blur(radius: 0.5)

                    lessonRoadArrow
                        .offset(y: -4)

                    Rectangle()
                        .fill(Color.white.opacity(0.12))
                        .frame(width: 3, height: 92)
                }
                .padding(.bottom, 30)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }

    private var lessonRoadArrow: some View {
        Path { path in
            path.move(to: CGPoint(x: 60, y: 0))
            path.addLine(to: CGPoint(x: 115, y: 52))
            path.addLine(to: CGPoint(x: 82, y: 52))
            path.addLine(to: CGPoint(x: 82, y: 130))
            path.addLine(to: CGPoint(x: 38, y: 130))
            path.addLine(to: CGPoint(x: 38, y: 52))
            path.addLine(to: CGPoint(x: 5, y: 52))
            path.closeSubpath()
        }
        .fill(Color.white.opacity(0.82))
        .frame(width: 120, height: 130)
        .blur(radius: 0.4)
    }

    private var lessonSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Lesson Explorer")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Spacer()

                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.white.opacity(0.72))
            }

            VStack(spacing: 14) {
                ForEach(lessons) { lesson in
                    Button {
                        openLesson(lesson)
                    } label: {
                        LessonCardView(lesson: lesson, progress: progress(for: lesson))
                    }
                    .buttonStyle(.plain)
                    .disabled(lesson.isLocked)
                }
            }
        }
    }

    private var statsSection: some View {
        HStack(spacing: 14) {
            ProgressMetricCard(
                icon: "clock",
                title: "Tiempo de estudio",
                value: studyTimeText,
                accent: Color(red: 0.67, green: 0.77, blue: 0.98)
            )

            ProgressMetricCard(
                icon: "sparkles",
                title: "Precisión",
                value: accuracyText,
                accent: Color(red: 0.98, green: 0.83, blue: 0.33)
            )
        }
    }

    private func lessonDetailView(lesson: Lesson, question: LessonQuestion) -> some View {
        VStack(spacing: 0) {
            detailHeader(for: lesson)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    questionProgressCard(for: lesson)
                    questionCard(question: question, lesson: lesson)
                    optionsList(question: question)
                    submitButton(for: question)
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 28)
            }
        }
    }

    private func detailHeader(for lesson: Lesson) -> some View {
        HStack {
            Button {
                selectedLessonID = nil
                currentQuestionIndex = 0
                selectedOptionID = nil
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 38, height: 38)
                    .background(Color.white.opacity(0.06))
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)

            Spacer()

            VStack(spacing: 3) {
                Text(lesson.title)
                    .font(.system(size: 19, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("Pregunta \(currentQuestionIndex + 1) de \(lesson.questions.count)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.6))
            }

            Spacer()

            Circle()
                .fill(lesson.accent.opacity(0.22))
                .frame(width: 38, height: 38)
                .overlay {
                    Image(systemName: lesson.icon)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(lesson.accent)
                }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }

    private func questionProgressCard(for lesson: Lesson) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Avance de la lección")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Color.white.opacity(0.72))

            Text("\(Int((Double(currentQuestionIndex) / Double(max(lesson.questions.count, 1))) * 100))% completado")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            ProgressView(value: Double(currentQuestionIndex), total: Double(max(lesson.questions.count, 1)))
                .tint(lesson.accent)
                .scaleEffect(x: 1, y: 1.35, anchor: .center)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                )
        )
    }

    private func questionCard(question: LessonQuestion, lesson: Lesson) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(question.prompt)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            SignQuestionArtwork(sign: question.sign, accent: lesson.accent, tag: question.tag)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                )
        )
    }

    private func optionsList(question: LessonQuestion) -> some View {
        VStack(spacing: 14) {
            ForEach(Array(question.options.enumerated()), id: \.element.id) { index, option in
                Button {
                    guard !submittedQuestionIDs.contains(question.id) else { return }
                    selectedOptionID = option.id
                } label: {
                    LessonOptionRow(
                        option: option,
                        prefix: optionPrefixes[index],
                        isSelected: selectedOptionID == option.id,
                        isSubmitted: submittedQuestionIDs.contains(question.id),
                        selectedOptionID: answersByQuestion[question.id]
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func submitButton(for question: LessonQuestion) -> some View {
        Button {
            handleSubmission(for: question)
        } label: {
            HStack {
                Spacer()
                Text(submittedQuestionIDs.contains(question.id) ? nextButtonTitle : "Responder")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                Image(systemName: submittedQuestionIDs.contains(question.id) ? "arrow.right" : "checkmark")
                    .font(.system(size: 17, weight: .bold))
                Spacer()
            }
            .foregroundStyle(Color(red: 0.06, green: 0.09, blue: 0.14))
            .frame(height: 58)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(canSubmit(question: question) ? Color(red: 0.35, green: 0.57, blue: 0.98) : Color.white.opacity(0.16))
                    .shadow(color: Color(red: 0.35, green: 0.57, blue: 0.98).opacity(0.35), radius: 18, y: 10)
            )
        }
        .buttonStyle(.plain)
        .disabled(!canSubmit(question: question))
    }

    private var accuracyText: String {
        guard !submittedQuestionIDs.isEmpty else { return "0%" }

        let allQuestions = lessons.flatMap(\.questions)
        let correctAnswers = allQuestions.filter { question in
            guard
                submittedQuestionIDs.contains(question.id),
                let selectedAnswer = answersByQuestion[question.id]
            else {
                return false
            }

            return question.options.contains(where: { $0.id == selectedAnswer && $0.isCorrect })
        }.count

        let percentage = Int((Double(correctAnswers) / Double(submittedQuestionIDs.count)) * 100)
        return "\(percentage)%"
    }

    private var nextButtonTitle: String {
        guard let selectedLesson else { return "Continuar" }
        return currentQuestionIndex < selectedLesson.questions.count - 1 ? "Siguiente pregunta" : "Volver a lecciones"
    }

    private func openLesson(_ lesson: Lesson) {
        guard !lesson.isLocked else { return }
        selectedLessonID = lesson.id
        currentQuestionIndex = 0
        selectedOptionID = nil
    }

    private func canSubmit(question: LessonQuestion) -> Bool {
        if submittedQuestionIDs.contains(question.id) {
            return true
        }

        return selectedOptionID != nil
    }

    private func handleSubmission(for question: LessonQuestion) {
        if submittedQuestionIDs.contains(question.id) {
            goToNextQuestion()
            return
        }

        guard let selectedOptionID else { return }
        answersByQuestion[question.id] = selectedOptionID
        submittedQuestionIDs.insert(question.id)
    }

    private func goToNextQuestion() {
        guard let selectedLesson else { return }

        if currentQuestionIndex < selectedLesson.questions.count - 1 {
            currentQuestionIndex += 1
            selectedOptionID = nil
        } else {
            selectedLessonID = nil
            currentQuestionIndex = 0
            selectedOptionID = nil
        }
    }
    
    private func progress(for lesson: Lesson) -> Double{
        guard !lesson.questions.isEmpty else { return 0 }
        
        let answeredCount = lesson.questions.filter{ question in
            submittedQuestionIDs.contains(question.id)
        }.count
        
        return Double(answeredCount) / Double(lesson.questions.count)
    }
    
    private var studyTimeText: String {
        let minutesPerQuestion = 2
        return "\(submittedQuestionIDs.count * minutesPerQuestion) min"
    }
}

private struct LessonCardView: View {
    let lesson: Lesson
    let progress: Double

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.08), lineWidth: 10)
                    .frame(width: 58, height: 58)

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(lesson.accent, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .frame(width: 58, height: 58)
                    .rotationEffect(.degrees(-90))

                Image(systemName: lesson.icon)
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(lesson.accent.opacity(lesson.isLocked ? 0.45 : 1))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(lesson.title)
                    .font(.system(size: 12.5, weight: .bold, design: .rounded))
                    .foregroundStyle(lesson.isLocked ? Color.white.opacity(0.45) : .white)

                Text("\(Int(progress * 100))% completado")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.white.opacity(lesson.isLocked ? 0.28 : 0.55))
            }

            Spacer()

            ZStack {
                Circle()
                    .fill(lesson.isLocked ? Color.white.opacity(0.08) : lesson.accent)
                    .frame(width: 42, height: 42)
                    .shadow(color: lesson.isLocked ? .clear : lesson.accent.opacity(0.35), radius: 10, y: 4)

                Image(systemName: lesson.isLocked ? "lock.fill" : "play.fill")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(lesson.isLocked ? Color.white.opacity(0.36) : Color(red: 0.06, green: 0.09, blue: 0.14))
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
        )
    }
}

private struct ProgressMetricCard: View {
    let icon: String
    let title: String
    let value: String
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 25, weight: .medium))
                .foregroundStyle(accent)

            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(Color.white.opacity(0.52))

            Text(value)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, minHeight: 110, alignment: .topLeading)
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
        )
    }
}

private struct SignQuestionArtwork: View {
    let sign: LessonSign
    let accent: Color
    let tag: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(
                    RadialGradient(
                        colors: [
                            Color(red: 0.12, green: 0.17, blue: 0.23),
                            Color(red: 0.03, green: 0.04, blue: 0.07)
                        ],
                        center: .center,
                        startRadius: 10,
                        endRadius: 180
                    )
                )
                .frame(height: 176)
                .overlay {
                    signGraphic
                }

            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 11, weight: .bold))

                Text(tag.uppercased())
                    .font(.system(size: 10, weight: .bold))
            }
            .foregroundStyle(accent)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(red: 0.16, green: 0.19, blue: 0.24).opacity(0.95))
            .clipShape(Capsule())
            .padding(14)
        }
    }

    @ViewBuilder
    private var signGraphic: some View {
        switch sign {
        case .yield:
            TriangleShape()
                .fill(Color.white)
                .overlay(
                    TriangleShape()
                        .stroke(Color(red: 0.78, green: 0.20, blue: 0.18), lineWidth: 10)
                )
                .frame(width: 120, height: 102)
                .shadow(color: .black.opacity(0.35), radius: 16, y: 10)
        case .stop:
            OctagonShape()
                .fill(Color(red: 0.82, green: 0.16, blue: 0.14))
                .frame(width: 108, height: 108)
                .overlay(
                    Text("ALTO")
                        .font(.system(size: 23, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                )
        case .school:
            DiamondShape()
                .fill(Color(red: 0.95, green: 0.81, blue: 0.28))
                .frame(width: 108, height: 108)
                .overlay(
                    Image(systemName: "figure.and.child.holdinghands")
                        .font(.system(size: 30, weight: .black))
                        .foregroundStyle(Color.black.opacity(0.8))
                )
        case .turnRight:
            DiamondShape()
                .fill(Color(red: 0.95, green: 0.81, blue: 0.28))
                .frame(width: 108, height: 108)
                .overlay(
                    Image(systemName: "arrow.turn.up.right")
                        .font(.system(size: 34, weight: .black))
                        .foregroundStyle(Color.black.opacity(0.8))
                )
        case .curve:
            DiamondShape()
                .fill(Color(red: 0.95, green: 0.81, blue: 0.28))
                .frame(width: 108, height: 108)
                .overlay(
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .font(.system(size: 28, weight: .black))
                        .foregroundStyle(Color.black.opacity(0.8))
                )
        }
    }
}

private struct LessonOptionRow: View {
    let option: LessonOption
    let prefix: String
    let isSelected: Bool
    let isSubmitted: Bool
    let selectedOptionID: UUID?

    private var showsCorrectIndicator: Bool {
        isSubmitted && option.isCorrect
    }

    private var isIncorrectSelection: Bool {
        isSubmitted && selectedOptionID == option.id && !option.isCorrect
    }

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(isSelected ? Color(red: 0.35, green: 0.57, blue: 0.98) : Color.white.opacity(0.08))
                    .frame(width: 30, height: 30)

                Text(prefix)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(isSelected ? Color(red: 0.08, green: 0.10, blue: 0.15) : Color.white.opacity(0.8))
            }

            Text(option.text)
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)

            Spacer()

            if showsCorrectIndicator {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color(red: 0.72, green: 0.84, blue: 1))
            } else if isIncorrectSelection {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color(red: 0.95, green: 0.45, blue: 0.40))
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 68)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(isSelected ? Color(red: 0.20, green: 0.30, blue: 0.49) : Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(borderColor, lineWidth: 1.5)
                )
        )
    }

    private var borderColor: Color {
        if showsCorrectIndicator {
            return Color(red: 0.72, green: 0.84, blue: 1)
        }

        if isIncorrectSelection {
            return Color(red: 0.95, green: 0.45, blue: 0.40)
        }

        if isSelected {
            return Color(red: 0.35, green: 0.57, blue: 0.98)
        }

        return Color.white.opacity(0.08)
    }
}

private struct Lesson: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let accent: Color
    let icon: String
    let isLocked: Bool
    let questions: [LessonQuestion]
}

private struct LessonQuestion: Identifiable {
    let id = UUID()
    let prompt: String
    let sign: LessonSign
    let tag: String
    let options: [LessonOption]
}

private struct LessonOption: Identifiable {
    let id = UUID()
    let text: String
    let isCorrect: Bool
}

private enum LessonSign {
    case yield
    case stop
    case school
    case turnRight
    case curve
}

private struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

private struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

private struct OctagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let insetX = width * 0.28
        let insetY = height * 0.28

        var path = Path()
        path.move(to: CGPoint(x: insetX, y: 0))
        path.addLine(to: CGPoint(x: width - insetX, y: 0))
        path.addLine(to: CGPoint(x: width, y: insetY))
        path.addLine(to: CGPoint(x: width, y: height - insetY))
        path.addLine(to: CGPoint(x: width - insetX, y: height))
        path.addLine(to: CGPoint(x: insetX, y: height))
        path.addLine(to: CGPoint(x: 0, y: height - insetY))
        path.addLine(to: CGPoint(x: 0, y: insetY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    NavigationStack {
        LeccionView()
    }
}
