package ar.edu.politics.repos

import ar.edu.politics.domain.Zona
import java.util.List
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException

class RepoZonas {

	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Politics")

	static RepoZonas instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoZonas()
		}
		return instance
	}

	def protected getCriterio(Zona example) {
		[Zona zona|zona.descripcion.equalsIgnoreCase(example.descripcion)]
	}

	def createExample() {
		new Zona
	}

	def getEntityType() {
		Zona
	}

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}

	def List<Zona> allInstances() {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}

	def searchByExample(Zona zona) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			if (zona.descripcion !== null) {
				query.where(criteria.equal(from.get("descripcion"), zona.descripcion))
			}
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}
	
	def create(Zona zona) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				persist(zona)
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
	
	def update(Zona zona) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				merge(zona)
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
