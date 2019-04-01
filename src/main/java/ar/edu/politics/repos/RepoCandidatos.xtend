package ar.edu.politics.repos

import ar.edu.politics.domain.Candidato
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException

class RepoCandidatos {

	static RepoCandidatos instance

	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Politics")

	static def getInstance() {
		if (instance === null) {
			instance = new RepoCandidatos()
		}
		return instance
	}

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}

	def protected getCriterio(Candidato example) {
		[Candidato candidato|candidato.nombre.equals(example.nombre)]
	}

	def createExample() {
		new Candidato
	}

	def getEntityType() {
		typeof(Candidato)
	}

	def create(Candidato candidato) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				persist(candidato)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager.close
		}
	}

	def update(Candidato candidato) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				merge(candidato)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager.close
		}
	}

	def searchByExample(Candidato candidato) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			if (candidato.nombre !== null) {
				query.where(criteria.equal(from.get("nombre"), candidato.nombre))
			}
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}

}
