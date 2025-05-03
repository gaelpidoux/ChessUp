# ♟️ ChessUp - Projet Flutter d'échecs

## 🎯 Objectif
Application d'échecs Flutter en local ou contre une IA (Stockfish), avec un systéme de buffs/débuffs.

---

## ✅ Fonctionnalités
- Mode Joueur vs Joueur (local)
- Mode Joueur vs IA (Stockfish intégré)
- Gestion du thème sombre violet/doré

---

## ⚠️ Notes importantes sur l'intégration de Stockfish (Android)

### 📉 Problème
Stockfish est un exécutable natif, donc il doit **correspondre à l'architecture CPU de l'appareil Android**.

---

### 🧨 Bug rencontré

> ❌ `ProcessException: Permission denied`  
> ❌ IA ne répond pas après le coup  
> ❌ Stockfish ne démarre jamais

Ces erreurs surviennent quand :
- Exécutes un **binaire ARM64** (`armv8`) sur un **émulateur x86_64**
- Android bloque l'exécution silencieusement

---

### ✅ Solution

#### 🛠️ Option 1 : Changer d'émulateur
Créer un émulateur **ARM64 compatible** dans Android Studio :

1. Ouvre **Tools > Device Manager**
2. Clique sur **Create Device**
3. Choisis un téléphone (Pixel 6, etc.)
4. Choisis une **Image système ABI = arm64-v8a**
5. Lance cet émulateur pour que Stockfish ARM fonctionne

#### 🛠️ Option 2 : Pas compatible