//
//  BD.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 24/03/26.
//

import Foundation
import SwiftData
import Foundation

@Model
final class Categoria{
    @Attribute(.unique) var id: UUID
    var nombre: String
    var descripcionTexto: String
    
    @Relationship(deleteRule: .cascade, inverse: \SenalTransito.categoria)
    var senales: [SenalTransito] = []
    
    init(
        id: UUID = UUID(),
        nombre: String,
        descripcionTexto: String
    ){
        self.id = id
        self.nombre = nombre
        self.descripcionTexto = descripcionTexto
    }
}

@Model
final class SenalTransito{
    @Attribute(.unique) var id: UUID
    var nombre: String
    var descripcionTexto: String
    var imagenData: Data?
    
    var categoria: Categoria?
    
    @Relationship(deleteRule: .nullify, inverse: \Pregunta.senal)
    var preguntas: [Pregunta] = []
    
    init(
        id: UUID = UUID(),
        nombre: String,
        descripcionTexto: String,
        imagenData: Data? = nil,
        categoria: Categoria? = nil
    ){
        self.id = id
        self.nombre = nombre
        self.descripcionTexto = descripcionTexto
        self.imagenData = imagenData
        self.categoria = categoria
    }
}

@Model
final class Evaluacion{
    @Attribute(.unique) var id: UUID
    var titulo: String
    var puntajeMax: Int
    
    @Relationship(deleteRule: .cascade, inverse: \Pregunta.evaluacion)
    var preguntas: [Pregunta] = []
    
    @Relationship(deleteRule: .cascade, inverse: \ResultadoEvaluacion.evaluacion)
    var resultados: [ResultadoEvaluacion] = []
    
    init(
        id: UUID = UUID(),
        titulo: String,
        puntajeMax: Int
    ){
        self.id = id
        self.titulo = titulo
        self.puntajeMax = puntajeMax
    }
}

@Model
final class Pregunta{
    @Attribute(.unique) var id: UUID
    var textoPregunta: String
    var evaluacion: Evaluacion?
    var senal: SenalTransito?
    
    @Relationship(deleteRule: .cascade, inverse: \OpcionPregunta.pregunta)
    var opciones: [OpcionPregunta] = []
    
    init(
        id: UUID = UUID(),
        textoPregunta: String,
        evaluacion: Evaluacion? = nil,
        senal: SenalTransito? = nil
    ){
        self.id = id
        self.textoPregunta = textoPregunta
        self.evaluacion = evaluacion
        self.senal = senal
        
    }
}

@Model
final class OpcionPregunta{
    @Attribute(.unique) var id: UUID
    var textoOpcion: String
    var esCorrecta: Bool
    
    var pregunta: Pregunta?
    
    init(
        id: UUID = UUID(),
        textoOpcion: String,
        esCorrecta: Bool,
        pregunta: Pregunta? = nil
    ){
        self.id = id
        self.textoOpcion = textoOpcion
        self.esCorrecta = esCorrecta
        self.pregunta = pregunta
    }
}

@Model
final class Usuario{
    @Attribute(.unique) var id: UUID
    var nombre: String
    var apellido: String
    var correo: String
    var rol: String
    
    @Relationship(deleteRule: .cascade, inverse: \ResultadoEvaluacion.usuario)
    var resultados: [ResultadoEvaluacion] = []
    
    @Relationship(deleteRule: .cascade, inverse: \ReporteCiudadano.usuario)
    var reportesRealizados: [ReporteCiudadano] = []
    
//    @Relationship(deleteRule: .nullify, inverse: \ReporteCiudadano.usuario)
//    var reportesAsignados: [ReporteCiudadano] = []
    
    init(
        id: UUID = UUID(),
        nombre: String,
        apellido: String,
        correo: String,
        rol: String
    ){
        self.id = id
        self.nombre = nombre
        self.apellido = apellido
        self.correo = correo
        self.rol = rol
    }
}


@Model
final class ResultadoEvaluacion{
    @Attribute(.unique) var id: UUID
    var puntajeObtenido: Int
    var fecha: Date
    
    var usuario: Usuario?
    var evaluacion: Evaluacion?
    
    init(
        id: UUID = UUID(),
        puntajeObtenido: Int,
        fecha: Date,
        usuario: Usuario? = nil,
        evaluacion: Evaluacion? = nil
    ){
        self.id = id
        self.puntajeObtenido = puntajeObtenido
        self.fecha = fecha
        self.usuario = usuario
        self.evaluacion = evaluacion
    }
}


@Model
final class ReporteCiudadano{
    @Attribute(.unique) var id: UUID
    var descripcionProblema: String
    var ubicacion: String
    var fecha: Date
    var estado: String
    
    var usuario: Usuario?
    
    init(
        id: UUID = UUID(),
        descripcionProblema: String,
        ubicacion: String,
        fecha: Date,
        estado: String,
        usuario: Usuario? = nil
    ){
        self.id = id
        self.descripcionProblema = descripcionProblema
        self.ubicacion = ubicacion
        self.fecha = fecha
        self.estado = estado
        self.usuario = usuario
    }
}
