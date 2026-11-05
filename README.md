# GTA MOD : weather_and_time

Changer la météo et l'heure du jeu, ou afficher l'heure actuelle, avec des commandes saisies dans la console.

## Démo

<video controls src="weather_and_time.mp4" title="Démo du mod weather_and_time"></video>

## Fonctionnalités

- Menu (touche **F12**) : slider météo et curseurs heure / minute, avec aperçu immédiat
- `weather <type>` : change la météo (10 types disponibles)
- `time` : affiche l'heure actuelle du jeu
- `time <heure> <minute>` : définit l'heure du jeu

## Prérequis

- Serveur FiveM à jour
- Ressource [MenuV](https://github.com/MenuV/MenuV) installée et démarrée avant ce mod

## Installation

1. Télécharger le dossier `weather_and_time`
2. Copier le dossier `weather_and_time` dans `resources/`
3. Ajouter `ensure menuv` puis `ensure weather_and_time` dans ton `server.cfg`
4. Redémarrer le serveur

## Utilisation

Les commandes se saisissent dans la console du jeu (touche F8). Les retours s'affichent dans cette même console.

### Météo

```
> weather <type>
```

Types disponibles :

| Commande | Météo |
|---|---|
| `clear` | Dégagé |
| `extrasunny` | Grand soleil |
| `clouds` | Nuageux |
| `overcast` | Couvert |
| `rain` | Pluie |
| `thunder` | Orage |
| `fog` | Brouillard |
| `smog` | Smog |
| `snow` | Neige |
| `neutral` | Neutre |

Exemple : `weather rain`

### Heure

```
> time                    -- affiche l'heure actuelle
> time <heure> <minute>   -- définit l'heure (heure de 0 à 23, minutes actuelles)
```

Exemples : `time 12 30` ou `time 22` (la minute vaut 0 par défaut)

## Structure du dossier

```
gtamod-weather-and-time/
├─ weather_and_time/               -- dossier du mod
│  ├─ weather_and_time.lua         -- script principal
│  └─ fxmanifest.lua
└─ README.md
```

## Crédits

Tuto et mod réalisés par :
Alice MASSART, PAD EMD 2026.