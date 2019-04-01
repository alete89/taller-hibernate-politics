package ar.edu.politics.repos

import ar.edu.politics.domain.Candidato
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class RepoCandidatos extends RepoDefault<Candidato> {

	static RepoCandidatos instance
	
	static def getInstance() {
		if (instance === null) {
			instance = new RepoCandidatos()
		}
		return instance
	}
	
	override getEntityType() {
		Candidato
	}
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Candidato> query, Root<Candidato> camposCandidato, Candidato candidato) {
		if (candidato.nombre !== null) {
			query.where(criteria.equal(camposCandidato.get("nombre"), candidato.nombre))
		}
	}

}

