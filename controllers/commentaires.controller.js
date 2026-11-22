// CONTROLEUR des commentaires.
// A ECRIRE : une fonction (req, res, next) par route de CONTRAT.md, comme dans
// controllers/articles.controller.js :
//   1. lire req.params, req.query, req.body ;
//   2. verifier la forme : 400 si un champ obligatoire manque ;
//   3. appeler le service (services/commentaires.service.js) ;
//   4. choisir le code (200, 201 ou 204). Toute erreur part vers next(err).
// Le controleur ne parle JAMAIS a la base : pas de pool ici, seulement le service.

// const service = require('../services/commentaires.service');
// const ErreurHttp = require('../utils/erreur-http');

const service = require('../services/commentaires.service');
const ErreurHttp = require('../utils/erreur-http');

async function lister(req, res, next) {
  try {
    const articleId = Number(req.params.id);
    const commentaires = await service.lister(articleId);
    res.status(200).json(commentaires);
  } catch (err) {
    next(err);
  }
}

async function trouver(req, res, next) {
  try {
    const id = Number(req.params.id);
    const commentaire = await service.trouver(id);
    res.status(200).json(commentaire);
  } catch (err) {
    next(err);
  }
}

async function parVisiteur(req, res, next) {
  try {
    const nom = req.query.nom;
    if (!nom || nom.trim() === '') {
      throw new ErreurHttp(400, 'NOM_MANQUANT', 'Le nom est obligatoire.');
    }
    const commentaires = await service.parVisiteur(nom);
    res.status(200).json(commentaires);
  } catch (err) {
    next(err);
  }
}

async function creer(req, res, next) {
  try {
    const articleId = Number(req.params.id);
    const nom = req.body ? req.body.nom : undefined;
    const texte = req.body ? req.body.texte : undefined;

    if (!nom || !texte || nom.trim() === '' || texte.trim() === '') {
      throw new ErreurHttp(400, 'CHAMP_MANQUANT', 'Le nom et le texte sont obligatoires.');
    }

    const commentaire = await service.creer(articleId, { nom: nom, texte: texte });
    res.status(201).json(commentaire);
  } catch (err) {
    next(err);
  }
}

async function modifier(req, res, next) {
  try {
    const id = Number(req.params.id);
    const texte = req.body ? req.body.texte : undefined;

    if (!texte || texte.trim() === '') {
      throw new ErreurHttp(400, 'TEXTE_MANQUANT', 'Le texte est obligatoire.');
    }

    const commentaire = await service.modifier(id, { texte: texte });
    res.status(200).json(commentaire);
  } catch (err) {
    next(err);
  }
}

async function supprimer(req, res, next) {
  try {
    const id = Number(req.params.id);
    await service.supprimer(id);
    res.status(204).end();
  } catch (err) {
    next(err);
  }
}

module.exports = {
  lister,
  trouver,
  parVisiteur,
  creer,
  modifier,
  supprimer
};
