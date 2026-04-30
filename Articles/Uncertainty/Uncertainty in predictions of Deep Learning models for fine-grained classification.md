---
title: "Uncertainty in predictions of Deep Learning models for fine-grained classification"
source: "https://theses.hal.science/tel-03040683/"
author:
  - "[[Titouan Lorieul]]"
published:
created: 2026-04-24
description: "Deep neural networks have shown dramatic improvements in a lot of supervised classification tasks. Such models are usually trained with the objective to ultimately minimize the top-1 error rate. Although this approach is very powerful, it averages out the uncertainty of individual samples and does not capture if on a given data point this prediction is reliable or not and why.In real-world scenarios, it can actually be impossible - even for an oracle - to determine the exact label of a given data item because it does not, by itself, contain sufficient evidence to decide between several similar classes. Unlike multi-task classification where each data sample is associated with several labels, here, each item corresponds to exactly one label but this latter is uncertain. For instance, an image of a plant leaf might not be enough to distinguish between several possible species sharing the same leaf morphology. In fine-grained classification problems, most data samples intrinsically contain a certain amount of such label ambiguity even if they are associated with a single hard label. Furthermore, the model itself introduces additional uncertainty in the prediction because it is learned using a finite training dataset.This uncertainty is expected to be progressively reduced by increasing the training set size contrary to the intrinsic ambiguity of the data items which is theoretically irreducible.The goal of this PhD is to study these two types of uncertainties in a decision-theoretic framework. To do so, we propose to move away from the classic top-1 prediction error rate which solely requires to estimate the most probable class. Instead, we pick decision frameworks that force the model to learn more structure about the existing uncertainty. In particular, we focus on two frameworks: (i) adding the opportunity for the classifier to refuse to answer, usually referred to as classification with reject option, and (ii) allowing the classifier to output a set of possible labels rather than a single one, which is known as set-valued classification.We first study how uncertainty information can be exploited to tackle classification with reject option. In this framework, the predictor is a pair containing a classifier and a rejector. By fixing the classifier and focusing on the rejector, we can study how uncertainty information about the classifier can be leveraged to hopefully build a better rejection criterion. Unfortunately, we empirically show that it is difficult to separate both forms of uncertainty and recombine them properly. Based on this observation, we then focus on the first form of uncertainty, task ambiguity, and study natural frameworks to handle it: set-valued classification. There are several ways to predict sets. The most naive approach is to predict the K most probable classes. However, this assumes that all the samples have the same level of ambiguity which is known to be wrong in most cases. Instead, we propose to use average-K: the predictor can output sets of different sizes but on average their size must be equal to K. We then generalize to other adaptive set-valued classification approaches and propose a framework unifying most of them. In particular, we show several ways to construct such classifiers depending on the constraints on the error rate and on the set size and study their relative advantages and weaknesses."
tags:
  - "clippings"
---
## Incertitude des prédictions dans les modèles d'apprentissage profonds appliqués à la classification fine

(1, 2, 3)

1  
2  
3

[Titouan Lorieul](https://theses.hal.science/search/index/q/*/authIdHal_s/titouan-lorieul)
- Fonction: **Auteur**
- PersonId: **170849**
- IdHAL: [**titouan-lorieul**](https://theses.hal.science/search/index/q/*/authIdHal_s/titouan-lorieul "Consulter les publications")
- ORCID: **[0000-0001-5228-9238](https://orcid.org/0000-0001-5228-9238 "ORCID")**
- IdRef: **[253127262](https://www.idref.fr/253127262 "IdRef")**

[ZENITH - Scientific Data Management](https://theses.hal.science/search/index/q/*/structId_i/141072)

[LIRMM - Laboratoire d'Informatique de Robotique et de Microélectronique de Montpellier](https://theses.hal.science/search/index/q/*/structId_i/181)

[UM - Université de Montpellier](https://theses.hal.science/search/index/q/*/structId_i/410122)

[CV](https://cv.hal.science/titouan-lorieul "CV HAL")

#### Résumé

Deep neural networks have shown dramatic improvements in a lot of supervised classification tasks. Such models are usually trained with the objective to ultimately minimize the top-1 error rate. Although this approach is very powerful, it averages out the uncertainty of individual samples and does not capture if on a given data point this prediction is reliable or not and why.In real-world scenarios, it can actually be impossible - even for an oracle - to determine the exact label of a given data item because it does not, by itself, contain sufficient evidence to decide between several similar classes. Unlike multi-task classification where each data sample is associated with several labels, here, each item corresponds to exactly one label but this latter is uncertain. For instance, an image of a plant leaf might not be enough to distinguish between several possible species sharing the same leaf morphology. In fine-grained classification problems, most data samples intrinsically contain a certain amount of such label ambiguity even if they are associated with a single hard label. Furthermore, the model itself introduces additional uncertainty in the prediction because it is learned using a finite training dataset.This uncertainty is expected to be progressively reduced by increasing the training set size contrary to the intrinsic ambiguity of the data items which is theoretically irreducible.The goal of this PhD is to study these two types of uncertainties in a decision-theoretic framework. To do so, we propose to move away from the classic top-1 prediction error rate which solely requires to estimate the most probable class. Instead, we pick decision frameworks that force the model to learn more structure about the existing uncertainty. In particular, we focus on two frameworks: (i) adding the opportunity for the classifier to refuse to answer, usually referred to as classification with reject option, and (ii) allowing the classifier to output a set of possible labels rather than a single one, which is known as set-valued classification.We first study how uncertainty information can be exploited to tackle classification with reject option. In this framework, the predictor is a pair containing a classifier and a rejector. By fixing the classifier and focusing on the rejector, we can study how uncertainty information about the classifier can be leveraged to hopefully build a better rejection criterion. Unfortunately, we empirically show that it is difficult to separate both forms of uncertainty and recombine them properly. Based on this observation, we then focus on the first form of uncertainty, task ambiguity, and study natural frameworks to handle it: set-valued classification. There are several ways to predict sets. The most naive approach is to predict the K most probable classes. However, this assumes that all the samples have the same level of ambiguity which is known to be wrong in most cases. Instead, we propose to use average-K: the predictor can output sets of different sizes but on average their size must be equal to K. We then generalize to other adaptive set-valued classification approaches and propose a framework unifying most of them. In particular, we show several ways to construct such classifiers depending on the constraints on the error rate and on the set size and study their relative advantages and weaknesses.

Les réseaux neuronaux profonds ont permis des améliorations spectaculaires dans de nombreuses tâches de classification supervisées. Ces modèles sont généralement entraînés avec pour objectif final de minimiser le taux d’erreur en top 1. Bien que cette approche soit très puissante, elle moyenne l’incertitude des échantillons individuels et ne permet pas de savoir si, sur un point de données donné, cette prévision est fiable ou non et pourquoi. Dans des cas réels, il peut être impossible (même pour un oracle) de déterminer l’étiquette exacte d’un échantillon donné car il ne contient pas, en soi, de preuves suffisantes pour trancher entre plusieurs classes similaires. Contrairement à la classification multitâche où chaque échantillon de données est associé à plusieurs étiquettes, ici, chaque donnée correspond exactement à une classe, mais cette dernière est incertaine. Par exemple, une image d’une feuille de plante peut ne pas suffire à distinguer plusieurs espèces possibles partageant la même morphologie de feuille. Dans les problèmes de classification à grain fin, la plupart des échantillons de données contiennent intrinsèquement un certain niveau de cette ambiguïté sur l’étiquette, même s’ils sont associés à une seule vraie étiquette. En outre, le modèle lui-même introduit une incertitude supplémentaire dans ses prédictions car il est entraîné à l’aide d’un jeu de données d’apprentissage fini. Cette incertitude devrait être progressivement réduite en augmentant la taille de cette ensemble d’apprentissage, contrairement à l’ambiguïté intrinsèque des données qui est théoriquement irréductible. L’objectif de ce doctorat est d’étudier ces deux types d’incertitudes dans le cadre de la théorie de la décision. Pour ce faire, nous proposons de mettre de côté le taux d’erreur de prédiction en top 1 classique qui ne nécessite que l’estimation de la classe la plus probable. Nous proposons plutôt de nous intéresser à des cadres décisionnels qui forcent le modèle à mieux apprendre la structure de l’incertitude existante. En particulier, nous nous concentrons sur deux cadres: (i) ajouter la possibilité pour le classifieur de refuser de répondre, généralement appelé classification avec option de rejet, et (ii) en autorisant au classifieur de produire un ensemble d’étiquettes possibles plutôt qu’une seule, ce qui est connu sous le nom de prédiction d’ensembles.Nous étudions d’abord comment l’information d’incertitude peut être exploitée pour traiter la classification avec option de rejet. Dans cette configuration, le prédicteur est une paire comprenant un classifieur et un rejeteur. En fixant le classifieur et en étudiant le rejeteur, nous pouvons étudier comment l’information d’incertitude concernant le classifieur peut être exploitée pour éventuellement construire un meilleur critère de rejet. Malheureusement, nous montrons empiriquement qu’il est difficile de séparer les deux formes d’incertitude et de les recombiner correctement. Sur la base de cette observation, nous nous concentrons ensuite sur la première forme d’incertitude, l’ambiguïté de la tâche, et étudions un cadre naturel pour la gérer: la prédiction d’ensemble. Il existe plusieurs façons de prédire des ensembles. L’approche la plus naïve consiste à prédire les K classes les plus probables. Toutefois, cela suppose que tous les échantillons présentent le même niveau d’ambiguïté, ce qui est connu pour être faux dans la plupart des cas. Nous proposons plutôt d’utiliser une approche moyenne-K: le prédicteur peut produire des ensembles de taille différente, mais en moyenne leur taille doit être égale à K. Nous généralisons ensuite à d’autres approches adaptatives de prédiction d’ensembles et proposons un cadre unifiant la plupart d’entre elles. En particulier, nous montrons plusieurs façons de construire de tels classifieurs en fonction des contraintes sur le taux d’erreur et sur la taille de l’ensemble et étudions leurs avantages et faiblesses relatifs.

#### Mots clés

- [Predictive uncertainty](https://theses.hal.science/search/index/q/*/keyword_t/Predictive%20uncertainty)
- [Classification with reject option](https://theses.hal.science/search/index/q/*/keyword_t/Classification%20with%20reject%20option)
- [Set-Valued classification](https://theses.hal.science/search/index/q/*/keyword_t/Set-Valued%20classification)

- [Incertitude de prédiction](https://theses.hal.science/search/index/q/*/keyword_t/Incertitude%20de%20pr%C3%A9diction)
- [Classification avec option de rejet](https://theses.hal.science/search/index/q/*/keyword_t/Classification%20avec%20option%20de%20rejet)
- [Prédiction d'ensembles](https://theses.hal.science/search/index/q/*/keyword_t/Pr%C3%A9diction%20d'ensembles)

#### Domaines

- [Apprentissage \[cs.LG\]](https://theses.hal.science/search/index/q/*/level1_domain_s/info.info-lg)

Fichier principal ![Vignette du fichier](https://thumb.ccsd.cnrs.fr//8880107/medium) LORIEUL\_2020\_archivage.pdf (7.21 Mo)

<iframe title="Visualiseur du document" src="https://theses.hal.science/tel-03040683v2/preview/LORIEUL_2020_archivage.pdf#page=2" allowfullscreen=""></iframe>

| Origine | Version validée par le jury (STAR) |
| --- | --- |
| Licence | [Autorisation HAL](https://about.hal.science/hal-authorisation-v1/) |

[Contact](https://www.theses.fr/2020MONTS087 "Les dépôts ABES sont des dépôts institutionnels qui proviennent de l'application nationale STAR, placée sous la responsabilité des établissements de soutenance.
Pour toute demande d'information/modification, merci de contacter le correspondant STAR de cet établissement en cliquant sur le bouton «signaler une erreur» depuis ce lien")

https://theses.hal.science/tel-03040683

Soumis le: vendredi 1 octobre 2021-14:34:32

Dernière modification le: samedi 4 avril 2026-09:40:16[Télécharger pour visualiser](https://theses.hal.science/tel-03040683v2/document)### Dates et versions

tel-03040683, [version 1](https://theses.hal.science/tel-03040683v1) (04-12-2020)

tel-03040683, [version 2](https://theses.hal.science/tel-03040683v2) (01-10-2021)

### Licence

[Autorisation HAL](https://about.hal.science/hal-authorisation-v1/)

### Identifiants

- HAL Id: tel-03040683, version 2

### Citer

Titouan Lorieul. Uncertainty in predictions of Deep Learning models for fine-grained classification. Machine Learning \[cs.LG\]. Université Montpellier, 2020. English. [⟨NNT: 2020MONTS087⟩](https://www.theses.fr/2020MONTS087). [⟨tel-03040683v2⟩](https://theses.hal.science/tel-03040683v2)

### Exporter

- [BibTeX](https://theses.hal.science/tel-03040683v2/bibtex)
- [XML-TEI](https://theses.hal.science/tel-03040683v2/tei)
- [Dublin Core](https://theses.hal.science/tel-03040683v2/dc)
- [DC Terms](https://theses.hal.science/tel-03040683v2/dcterms)
- [EndNote](https://theses.hal.science/tel-03040683v2/endnote)
- [DataCite](https://theses.hal.science/tel-03040683v2/datacite)

### Collections

- [CNRS](https://theses.hal.science/CNRS)
- [INRIA](https://theses.hal.science/INRIA)
- [STAR](https://theses.hal.science/STAR)
- [ZENITH](https://theses.hal.science/ZENITH)
- [LIRMM](https://theses.hal.science/LIRMM)
- [INRIA2](https://theses.hal.science/INRIA2)
- [MIPS](https://theses.hal.science/MIPS)
- [UNIV-MONTPELLIER](https://theses.hal.science/UNIV-MONTPELLIER)
- [UNIV-COTEDAZUR](https://theses.hal.science/UNIV-COTEDAZUR)

929 Consultations

1285 Téléchargements