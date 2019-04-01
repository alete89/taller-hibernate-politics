package ar.edu.politics.repos

import ar.edu.politics.domain.Partido
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class RepoPartidos extends RepoDefault<Partido> {

	static RepoPartidos instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoPartidos()
		}
		return instance
	}

	override getEntityType() {
		Partido
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Partido> query, Root<Partido> camposPartido,
		Partido partido) {
		if (partido.nombre !== null) {
			query.where(criteria.equal(camposPartido.get("nombre"), partido.nombre))
		}
	}

}
