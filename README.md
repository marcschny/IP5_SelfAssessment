# ip5_selbsteinschaetzung

Digitale Tools zur ressourcenorientierten Selbsteinschätzung für jugendliche Klient_innen der Sozialen Arbeit.

## Setup

### Aufsetzen von Flutter und IDE

Um Flutter auf dem Rechner zu installieren und die Entwicklungsumgebung anzupassen, folgen Sie den Anweisungen auf [dieser Website](https://flutter.dev/docs/get-started/install).

### Starten der Applikation

Sobald Flutter auf dem Rechner installiert und in der Entwicklungsumgebung integriert ist, können Sie das Projekt in der Entwicklungsumgebung öffnen:
Klicken Sie dazu oben links auf "File" und anschliessend auf "Open..." und wählen Sie das Projekt zum Öffnen aus.

Bevor das Projekt gestartet werden kann müssen noch einige Befehle ausgeführt werden.
Öffnen Sie dazu die Kommandozeile und navigieren Sie zum Verzeichnis des Projekts (oder nutzen Sie das integrierte Terminal in der IDE).
Führen Sie nun folgende Befehle aus:

1. Build Cache leeren
```bash
flutter clean
```

2. Package dependencies holen
```bash
flutter pub get
```

3. Datenbank aufbauen:
Löschen Sie dazu zuerst die Datei "database.g.dart" (falls vorhanden) im Verzeichnis "lib/database", und führen Sie dann den Befehl aus:
```bash
flutter packages pub run build_runner build
```

Nun kann die Applikation entweder mit angeschlossenem Android-Smartphone oder einem Emulator gestartet werden!