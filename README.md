# GTA MOD : weather_and_time

Change la météo et l'heure du jeu depuis un menu ou avec des commandes, et affiche l'heure actuelle.

## Démo

<video controls src="weather_and_time.mp4" title="Démo du mod weather_and_time"></video>

## Fonctionnalités

- Menu (touche **F12**) : sélecteur de météo et curseur d'heure (0 à 23), appliqués immédiatement
- `weather <type>` : change la météo (10 types disponibles)
- `time` : affiche l'heure actuelle du jeu
- `time <heure> <minute>` : définit l'heure du jeu

## Prérequis

- Serveur FiveM à jour
- Ressource [MenuV](https://github.com/MenuV/MenuV) installée et démarrée avant ce mod

## Installation

1. Télécharge ce dépôt et renomme le dossier `gtamod-weather-time` en `weather_and_time`
2. Copie le dossier `weather_and_time` dans `resources/`
3. Ajoute `ensure menuv` puis `ensure weather_and_time` dans ton `server.cfg`
4. Redémarre le serveur

## Utilisation

### Menu

Appuie sur **F12** pour ouvrir le menu (en secours : commande `weather_and_time` dans la console F8). Utilise les flèches gauche / droite pour changer la météo ou l'heure.

### Commandes

Les commandes se saisissent dans la console du jeu (touche F8). Les retours s'affichent dans cette même console.

#### Météo

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

#### Heure

```
> time                    -- affiche l'heure actuelle
> time <heure> <minute>   -- définit l'heure (heure de 0 à 23, minute de 0 à 59)
```

Exemples : `time 12 30` ou `time 22` (la minute vaut 0 par défaut)

## Structure du dossier

```
weather_and_time/
├─ client.lua               -- script principal (menu MenuV, commandes weather et time)
├─ fxmanifest.lua
├─ weather_and_time.mp4     -- vidéo de la démo
└─ README.md
```

## Crédits

Tuto et mod réalisés par :
Alice MASSART, PAD EMD 2026.
