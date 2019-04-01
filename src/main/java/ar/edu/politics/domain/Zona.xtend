package ar.edu.politics.domain

import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import javax.persistence.FetchType
import javax.persistence.OneToMany

@Entity
@Observable
@Accessors
class Zona{
	
	@Id
	@GeneratedValue
	Long id
	@Column(length=150)
	String descripcion
	@OneToMany(fetch=FetchType.LAZY)	
	Set<Candidato> candidatos = newHashSet
		
	new() {
		
	}
	
	def void validar() {
		if (descripcion === null) {
			throw new UserException("Debe ingresar descripcion")
		}
		if (candidatos.isEmpty) {
			throw new UserException("Debe haber al menos un candidato en la zona")
		}
	}
	
	override toString() {
		descripcion
	}
	
}
