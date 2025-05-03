
## 📄 `CONCLUSION.md`

```markdown
# 🤖 Conclusion : Réflexion critique sur l’IA embarquée dans ChessUp

## 💡 Choix technologique

Initialement, mon objectif était d'intégrer **Stockfish**, moteur d'échecs open-source ultra-performant.  
Cependant, les contraintes techniques (architecture x86_64 incompatible avec les binaires ARM) ont motivé un changement de cap vers une IA **entièrement codée en Dart**.

---

## ✅ Avantages de l’IA embarquée

- **Indépendance** : pas besoin de connexion Internet ni d’appel API
- **Contrôle total** : j’ai pu ajouter des règles spéciales comme des buffs ou pénalités
- **Apprentissage** : forcer à comprendre l’évaluation de coups a renforcé ma maîtrise des structures FEN, du moteur d’échecs, etc.

---

## ⚠️ Limites techniques

- IA simple : pas d’algorithme de profondeur type Minimax / Alpha-Beta
- Les coups joués restent faibles comparés à un moteur réel comme Stockfish
- Manque d’apprentissage ou de stratégie long terme

---

## 🧠 Éthique et responsabilité

Je pense que l’**IA embarquée** est un bon compromis entre performance et sobriété numérique.  
Dans un jeu comme les échecs, elle permet une expérience fun, fluide, **sans espionnage ni dépendance à des services distants**.

> Elle est donc cohérente avec une démarche de **tech éthique, maîtrisable, et locale.**

---

## 🔮 Améliorations possibles

- Ajouter une **IA plus évoluée** via un algorithme Minimax avec élagage
- Créer un **système de buffs personnalisables**
- Proposer un **mode réseau** ou un leaderboard offline

---

## 🎯 Bilan

Malgré des blocages techniques et beaucoup de debug, le projet est fonctionnel et intéressant.  
Je suis **fier** de l’avoir mené à bout.
