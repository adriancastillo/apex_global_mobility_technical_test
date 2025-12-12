# Gestor de Tareas Avanzado

**Aplicación Flutter** para gestionar tareas, creada como prueba técnica para demostrar buenas prácticas de desarrollo, arquitectura limpia y consumo de APIs.

---

## 📝 Descripción

Esta aplicación permite gestionar tareas de manera avanzada, con funcionalidades de:

- Listado de tareas con filtro por estado (completadas / pendientes).  
- Marcar tareas como completadas.  
- Visualizar detalle de cada tarea.  
- Crear y editar tareas.  
- Persistencia local usando **Hive** (o **sqflite**).  
- Consumo de **API REST** para obtener tareas iniciales (`https://jsonplaceholder.typicode.com/todos`).  
- Consumo de **API GraphQL** para mostrar una lista de países (`https://countries.trevorblades.com/`).  

El proyecto sigue la **arquitectura limpia** con separación de capas y utiliza buenas prácticas de Flutter.

---

## 📂 Arquitectura

La aplicación se estructura en:

- **Presentación:** Widgets y pantallas UI (Flutter + Riverpod para manejo de estado).  
- **Dominio:** Lógica de negocio y entidades.  
- **Datos:** Repositorios, fuentes de datos (REST / GraphQL / Local), mappers.  

**Patrones y librerías principales:**

- **Estado:** Riverpod  
- **Modelos inmutables:** Freezed  
- **Persistencia local:** Hive (o sqflite)  
- **HTTP:** Retrofit, Dio  
- **GraphQL:** graphql_flutter  
- **Testing:** test (unitarios y widget)  

---

## ⚡ Funcionalidades

1. **Pantalla de tareas**
   - Listado de tareas.  
   - Filtrado por completadas / pendientes.  
   - Marcar tareas como completadas.  

2. **Pantalla de detalle**
   - Visualización de información de la tarea.  

3. **Crear / Editar tareas**
   - Formularios validados para ingresar nueva tarea o actualizar existente.  

4. **Persistencia local**
   - Hive (o sqflite) para guardar tareas localmente.  

5. **Consumo de APIs**
   - REST: Trae tareas iniciales desde jsonplaceholder.  
   - GraphQL: Lista de países desde una API pública.  

6. **Manejo de estados**
   - Loading, error y éxito correctamente implementados.  

---

## 🛠 Tecnologías y Dependencias

- **Flutter** >= 3.35.4  
- **Dart** >= 3.9.2  
- **Estado:** Riverpod, Flutter Riverpod  
- **Modelos inmutables:** Freezed, Freezed Annotation  
- **Persistencia local:** Hive, sqflite  
- **Navegación:** go_router  
- **HTTP / APIs REST:** Dio, Retrofit, Pretty Dio Logger, Logger  
- **GraphQL:** graphql_flutter, graphql  
- **Internacionalización:** intl, flutter_localizations  
- **Testing:** flutter_test, mocktail  
- **Generadores y serialización:** build_runner, json_serializable, retrofit_generator, injectable_generator, injectable, freezed  
- **UI / Iconos:** phosphor_flutter  

---

## 🧪 Testing

Se incluyen pruebas básicas para validar:

1. **Test unitario:** Lógica de negocio del gestor de tareas y listado de paises.  
2. **Test widget:** Validación de UI en la pantalla de listado de tareas y listado de paises.  

---

## 🚀 Instalación

## Clonar el repositorio
git clone https://github.com/adriancastillo/apex_global_mobility_test.git
cd apex_global_mobility_test

## Instalar dependencias
flutter pub get

## Ejecutar la app
flutter run

## Ejecutar tests
flutter test

## 📌 Buenas prácticas implementadas

- Clean Architecture con separación de capas.
- Uso de widget fondations, styles, components
- Uso de internacionalización.
- Manejo de navegación con Go Router.
- Manejo de estado con Riverpod.
- Modelos inmutables con Freezed.
- Manejo de errores y estados de carga en UI.
- Uso eficiente de APIs REST y GraphQL.
- Tests unitarios y de widgets para validar lógica y UI.
- Código limpio siguiendo principios SOLID.