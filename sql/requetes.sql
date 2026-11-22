-- =============================================================================
-- PARTIE A · Question 3 · Six requetes
-- Sous chaque question : votre requete, puis le resultat obtenu, en commentaire.
-- =============================================================================

-- R1. Les commentaires de l'article 2, du plus recent au plus ancien : nom, texte.

SELECT nom, texte
FROM commentaires
WHERE article_id = 2
ORDER BY cree_le DESC;

-- resultat R1 :
-- nom  | texte
-- -----+---------------------------------------------------------------
-- Inès | Des photos de la pose seraient les bienvenues.
-- Hugo | Le noyer est magnifique. Combien de temps pour le séchage ?

-- R2. Le nombre de commentaires de CHAQUE article, y compris ceux qui n'en ont aucun :
--     id, titre, nb_commentaires.

SELECT a.id, a.titre, COUNT(c.id) AS nb_commentaires
FROM articles a
LEFT JOIN commentaires c ON a.id = c.article_id
GROUP BY a.id, a.titre;

-- resultat R2 :
-- id | titre                                       | nb_commentaires
-- ---+---------------------------------------------+----------------
--  1 | Choisir son bois pour une table de jardin   | 3
--  2 | Une bibliothèque sur mesure à Besançon      | 2
--  3 | Huile ou vernis : ce qui protège vraiment  | 0
--  4 | Restaurer une chaise paillée               | 1
--  5 | Une cuisine en chêne massif à Dole          | 2
--  6 | Affûter ses ciseaux à bois                  | 0

-- R3. Les articles qui n'ont aucun commentaire : id, titre.

SELECT a.id, a.titre
FROM articles a
LEFT JOIN commentaires c ON a.id = c.article_id
WHERE c.id IS NULL;

-- resultat R3 :
-- id | titre
-- ---+----------------------------------------
--  3 | Huile ou vernis : ce qui protège vraiment
--  6 | Affûter ses ciseaux à bois


-- R4. Pour chaque auteur, le nombre total de commentaires recus sur ses articles,
--     du plus commente au moins commente.

SELECT au.prenom AS auteur, COUNT(c.id) AS nb_commentaires
FROM auteurs au
JOIN articles a ON au.id = a.auteur_id
LEFT JOIN commentaires c ON a.id = c.article_id
GROUP BY au.prenom
ORDER BY nb_commentaires DESC;

-- resultat R4 :
-- auteur | nb_commentaires
-- -------+-----------------
-- Marc   | 5
-- Théo   | 2
-- Sophie | 1


-- R5. Les visiteurs (nom) qui ont commente plus d'un article.

SELECT nom
FROM commentaires
GROUP BY nom
HAVING COUNT(DISTINCT article_id) > 1;

-- resultat R5 :
-- nom
-- -------
-- Claire

-- R6. Les trois commentaires les plus recents, avec le titre de leur article.

SELECT c.texte, a.titre
FROM commentaires c
JOIN articles a ON c.article_id = a.id
ORDER BY c.cree_le DESC
LIMIT 3;

-- resultat R6 :
-- texte                                        | titre
-- ----------------------------------------------+-----------------------------------------
-- Superbe travail.                             | Une cuisine en chêne massif à Dole
-- Aucune vis visible : comment sont fixés les caissons ? | Une cuisine en chêne massif à Dole
-- J ai une chaise à faire refaire, vous prenez les commandes ? | Restaurer une chaise paillée
