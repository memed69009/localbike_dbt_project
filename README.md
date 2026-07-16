# Local Bike — Définition des axes d'analyse

**Projet :** Cas Final Analytics Engineer — Local Bike

**Auteur :** Mohammed Mokeddem

**Objectif du document :** Identifier les axes d'analyse prioritaires permettant à l'équipe des opérations de Local Bike d'optimiser les ventes et de maximiser le revenu de l'entreprise, en s'appuyant sur le dataset `sales` / `production`.

---

## 1. Contexte et démarche

Local Bike souhaite se lancer dans l'exploitation de données pour piloter son activité de manière data-driven, à l'image de la rigueur analytique qu'Alexander Anthony appliquait durant sa carrière de cycliste professionnel.

La démarche retenue part des **enjeux business** (optimisation des ventes, maximisation du revenu) plutôt que d'une simple description des tables disponibles. Chaque axe ci-dessous est formulé sous forme de questions concrètes, adossées à des KPIs mesurables et aux tables sources du modèle de données.

---

## 2. Axes d'analyse retenus

### Axe 1 — Performance commerciale par magasin

**Problématique :** Quels magasins performent le mieux, et pourquoi ?

| Question business | KPI associé |
|---|---|
| Quel magasin génère le plus de chiffre d'affaires ? | CA total par `store_id` |
| Existe-t-il une saisonnalité différente selon la localisation (Santa Cruz, Baldwin, Rowlett) ? | CA mensuel par magasin |
| Quel est le panier moyen par magasin ? | CA / nombre de commandes par magasin |

**Tables sources :** `orders`, `order_items`, `stores`

**Intérêt business :** allocation des ressources, arbitrage sur de futures ouvertures de points de vente.

---

### Axe 2 — Analyse produit (catégories, marques, prix)

**Problématique :** Quels produits et catégories créent le plus de valeur ?

| Question business | KPI associé |
|---|---|
| Quelles catégories/marques génèrent le plus de CA et de marge ? | CA et marge par `category_id` / `brand_id` |
| Quel est l'effet des remises sur le volume vendu et la marge réelle ? | Taux de remise moyen, marge nette après remise |
| Quels produits sont sous-performants (peu vendus) ? | Volume de ventes par `product_id` |

**Tables sources :** `products`, `categories`, `brands`, `order_items`

**Intérêt business :** optimisation du catalogue, stratégie de pricing, négociation fournisseurs.

---

### Axe 3 — Gestion des stocks

**Problématique :** Le stock est-il aligné avec la demande réelle ?

| Question business | KPI associé |
|---|---|
| Quels produits sont fréquemment en rupture ? | Quantité en stock vs quantité vendue par période |
| Le stock est-il bien réparti entre les 3 magasins par rapport à la demande locale ? | Stock par magasin vs ventes par magasin |
| Peut-on estimer les ventes potentiellement perdues liées aux ruptures ? | Écart entre demande estimée et stock disponible |

**Tables sources :** `stocks`, `products`, `order_items`

**Intérêt business :** réduire les ventes perdues, optimiser les réassorts.

---

### Axe 4 — Comportement et valeur client

**Problématique :** Qui sont les clients à forte valeur, et comment les fidéliser ?

| Question business | KPI associé |
|---|---|
| Quel est le panier moyen par client ? | CA moyen par commande et par client |
| Quels clients sont récurrents vs ponctuels ? | Nombre de commandes par `customer_id` |
| Peut-on segmenter les clients selon leur valeur ? | Segmentation CA cumulé / fréquence d'achat |

**Tables sources :** `customers`, `orders`, `order_items`

**Intérêt business :** actions de fidélisation, cohérent avec l'ADN "communauté" de Local Bike.

---

## 4. De la définition des axes à la modélisation dbt

Chaque axe retenu sera traduit en un ou plusieurs modèles **marts** dans le projet dbt, construits sur une base de modèles **staging** et **intermediate** communs :

| Axe | Mart dbt envisagé |
|---|---|
| Performance par magasin | `mrt_sales_by_store` |
| Analyse produit | `mrt_sales_by_product` |
| Gestion des stocks | `mrt_stock_analysis` |
| Comportement client | `mrt_customers`  |

---

## 5. Datavisualisation

Rapport PowerBi :  https://app.fabric.microsoft.com/links/TTFSwsnDCu?ctid=559aa8ea-1a23-4071-874d-0aa9b1794341&pbi_source=linkShare
