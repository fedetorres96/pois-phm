package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.List
import java.util.Set
import javax.persistence.CollectionTable
import javax.persistence.Column
import javax.persistence.ElementCollection
import javax.persistence.Entity
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.LazyCollection
import org.joda.time.DateTime
import poi.utils.Punto
import poi.utils.RangoHorario

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
class Banco extends POI {
	
	@JsonIgnore
	@LazyCollection(FALSE)
	@OneToMany(cascade=ALL)
	List<RangoHorario> horario

	@ManyToOne(cascade=ALL)
	Punto ubicacion

	@ElementCollection
	@CollectionTable(name="servicios_banco", joinColumns=@JoinColumn(name="id_banco"))
	@LazyCollection(FALSE)
	@Column(name="servicio")
	Set<String> servicios = newHashSet

	@Column(length=200)
	String barrio

	@Column(length=200)
	String compania

	override estaCerca(Punto coordenada) {
		ubicacion.estaCerca(coordenada, 5)
	}

	override coincideBusqueda(String string) {
		compania.comienzaCon(string) || (compania + " " + barrio).coincideCon(string)
	}

	override estaDisponible(DateTime momento, String string) {
		estaDisponible(momento) && servicios.contiene(string)
	}

	override boolean estaDisponible(DateTime momento) {
		horario.exists[estaDisponible(momento)]
	}

	override getNombre() {
		"Banco " + compania + " - " + barrio
	}

	override getDistancia(Punto coordenada) {
		ubicacion.distance(coordenada)
	}
	
	@JsonProperty("horario")
	def getHorarioJSON(){
		horario.map[ asJson ]
	}
}
