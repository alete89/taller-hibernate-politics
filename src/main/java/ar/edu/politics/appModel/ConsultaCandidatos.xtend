package ar.edu.politics.appModel

import ar.edu.politics.domain.Candidato
import ar.edu.politics.domain.Zona
import ar.edu.politics.repos.RepoZonas
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class ConsultaCandidatos {
	
	Zona zonaSeleccionada
	Candidato candidatoSeleccionado
	
	def getZonasDeVotacion() {
		RepoZonas.instance.allInstances
	}
	
	new() {
		//zonaSeleccionada = zonasDeVotacion.head
	}
	
	def void setZonaSeleccionada(Zona zona){
		zonaSeleccionada = RepoZonas.instance.searchById(zona.id)
	}
	
	@Dependencies("candidatoSeleccionado")
	def boolean getPuedeVerFicha() {
		candidatoSeleccionado !== null
	}
	
}