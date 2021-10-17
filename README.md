# Todo List App para Flutter
A continuación se detallarán los pasos para desplegar el proyecto. Se dispondrá de dos formas: desplegando el código o instalando el apk adjunto en el carpeta del proyecto.

## Requisitos
- Dispositivo móvil.
- Flutter (Mi versión es la 2.5.3)
- Dart
- Visual Studio Code o Android Studio

## Despliegue desde el código
1. Clonar el proyecto.
```sh
git clone https://github.com/Dreamyproud/todo-list-app-flutter.git
```
2. Abrir proyecto clonado desde Visual Studio Code. Conectar nuestro dispositivo móvil y crear una nueva terminal donde ejecutaremos el siguiente comando.
```sh
flutter pub get
```
3. En caso de tener problemas con las dependencias. Ejecutar el comando.
```sh
flutter pub upgrade
```
4. Ahora ya solo nos queda iniciar la app.
```sh
flutter pub run
```
5. ¡Disfrutar de nuestro Todo List App!

## Despliegue desde el apk generado
1. Clonar el proyecto
```sh
git clone https://github.com/Dreamyproud/todo-list-app-flutter.git
```
2. Agregar en tu dispositivo móvil el apk ubicado en la siguiente dirección del proyecto.
```sh
todo-list-app-flutter\apk\app-release.apk
```
3. Desde tu dispositivo, acceder al apk e instalarlo.
4. ¡Disfrutar de nuestro Todo List App!