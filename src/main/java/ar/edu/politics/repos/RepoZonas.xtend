package ar.edu.politics.repos

import ar.edu.politics.domain.Zona
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class RepoZonas extends RepoDefault<Zona> {

	static RepoZonas instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoZonas()
		}
		return instance
	}

	override getEntityType() {
		Zona
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Zona> query, Root<Zona> camposZona, Zona zona) {
		if (zona.descripcion !== null) {
			query.where(criteria.equal(camposZona.get("descripcion"), zona.descripcion))
		}
	}

	def Zona searchById(Long id) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val camposZona = query.from(entityType)
			camposZona.fetch("candidatos")
			query.select(camposZona)
			query.where(criteria.equal(camposZona.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager.close
		}
	}

}
