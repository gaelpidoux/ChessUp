# ♟️ ChessUp – Jeu d’échecs augmenté avec IA locale et effets spéciaux

ChessUp est une application Flutter de jeu d’échecs en local, contre un joueur ou une IA, intégrant des mécaniques de buffs/débuffs pour rendre les parties plus ludiques et imprévisibles.

---

## 📽️ Vidéo de démonstration

👉 Voir la vidéo de démo video_demo.mp4
👉 Présentation en pdf ChessFunPrez.pdf

---

## 🚀 Fonctionnalités principales

- 🧠 Jouer contre une **IA locale légère en Dart**
- 🧍 Jouer contre un **autre joueur en local**
- ⚡️ Buffs/Débuffs dynamiques :
    - Inversion du plateau si un cavalier est capturé
    - Boost de pion s’il capture une pièce
- 🎨 Interface simple avec design cohérent
- 🔁 Orientation dynamique de l’échiquier
- 💾 Aucune dépendance à un backend ou à une API externe

---

## 🧱 Technologies utilisées

- **Flutter 3.x**
- `flutter_chess_board` v1.0.1
- `chess` v0.7.0 (moteur de logique échiquéenne)
- IA codée en **pur Dart** (mini moteur de choix de coups)
- Android Emulator (compatible ARM64 recommandé)

---

## 🧪 Test et exécution

```bash
flutter pub get
flutter run
