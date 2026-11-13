-- =============================================================================
-- PARTIE A · Question 3 · Six requetes
-- Sous chaque question : votre requete, puis le resultat obtenu, en commentaire.
-- =============================================================================

-- R1. Les commentaires de l'article 2, du plus recent au plus ancien : nom, texte.

SELECT nom, texte
FROM commentaires
WHERE article_id = 2
ORDER BY cree_le DESC;

-- R2. Le nombre de commentaires de CHAQUE article, y compris ceux qui n'en ont aucun :
--     id, titre, nb_commentaires.

SELECT a.id, a.titre, COUNT(c.id) AS nb_commentaires
FROM articles a
LEFT JOIN commentaires c ON a.id = c.article_id
GROUP BY a.id, a.titre;

-- R3. Les articles qui n'ont aucun commentaire : id, titre.

SELECT a.id, a.titre
FROM articles a
LEFT JOIN commentaires c ON a.id = c.article_id
WHERE c.id IS NULL;


-- R4. Pour chaque auteur, le nombre total de commentaires recus sur ses articles,
--     du plus commente au moins commente.

SELECT au.prenom AS auteur, COUNT(c.id) AS nb_commentaires
FROM auteurs au
JOIN articles a ON au.id = a.auteur_id
LEFT JOIN commentaires c ON a.id = c.article_id
GROUP BY au.prenom
ORDER BY nb_commentaires DESC;


-- R5. Les visiteurs (nom) qui ont commente plus d'un article.

SELECT nom
FROM commentaires
GROUP BY nom
HAVING COUNT(DISTINCT article_id) > 1;


-- R6. Les trois commentaires les plus recents, avec le titre de leur article.

SELECT c.texte, a.titre
FROM commentaires c
JOIN articles a ON c.article_id = a.id
ORDER BY c.cree_le DESC
LIMIT 3;
