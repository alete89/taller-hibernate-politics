package ar.edu.politics.domain

import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.commons.model.utils.ObservableUtils

@Observable
@Accessors
@Entity
class Candidato{
	
	@Id
	@GeneratedValue
	Long id
	
	@Column(length=100)
	String nombre
	
	@ManyToOne
	Partido partido
	
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)	
	List<Promesa> promesas = newArrayList 
	
	new() {
		
	}
	
	def void validar() {
		if (nombre === null) {
			throw new UserException("Debe ingresar descripcion")
		}
		if (partido === null) {
			throw new UserException("El candidato debe estar participando en un partido político")
		}
	}
	
	override toString() {
		nombre
	}
	
	def agregarPromesa(String nuevaPromesa) {
		promesas.add(new Promesa(nuevaPromesa))
		ObservableUtils.firePropertyChanged(this, "promesas", promesas)
	}

}