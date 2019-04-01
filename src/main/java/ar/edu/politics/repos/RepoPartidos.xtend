package ar.edu.politics.repos

import ar.edu.politics.domain.Partido
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException

class RepoPartidos {

	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Politics")

	static RepoPartidos instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoPartidos()
		}
		return instance
	}

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}

	def protected getCriterio(Partido example) {
		[Partido partido|partido.nombre.equalsIgnoreCase(example.nombre)]
	}

	def createExample() {
		new Partido
	}

	def getEntityType() {
		typeof(Partido)
	}

	def create(Partido partido) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				persist(partido)
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

	def searchByExample(Partido partido) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			if (partido.nombre !== null) {
				query.where(criteria.equal(from.get("nombre"), partido.nombre))
			}
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}

	def update(Partido partido) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				merge(partido)
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

}
